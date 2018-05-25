// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'constants.dart';
import 'json_key_helpers.dart';
import 'json_literal_generator.dart';
import 'json_serializable_generator.dart';
import 'type_helper.dart';
import 'type_helper_context.dart';
import 'utils.dart';

Future<String> generate(JsonSerializableGenerator generator, Element element,
    ConstantReader annotation) {
  if (element is! ClassElement) {
    var name = element.name;
    throw new InvalidGenerationSourceError('Generator cannot target `$name`.',
        todo: 'Remove the JsonSerializable annotation from `$name`.',
        element: element);
  }

  var classElement = element as ClassElement;
  var classAnnotation = valueForAnnotation(annotation);
  var helper = new _GeneratorHelper(generator, classElement, classAnnotation);
  return helper._generate();
}

class _GeneratorHelper {
  final ClassElement _element;
  final JsonSerializable _annotation;
  final JsonSerializableGenerator _generator;
  final StringBuffer _buffer = new StringBuffer();

  String get _prefix => '_\$${_element.name}';

  String _mixinClassName(bool withConstraints) =>
      '${_prefix}SerializerMixin${_genericClassArguments(withConstraints)}';

  String _wrapperClassName([bool withConstraints]) =>
      '${_prefix}JsonMapWrapper${_genericClassArguments(withConstraints)}';

  /// Returns a [String] representing the type arguments that exist on
  /// [_element].
  ///
  /// Returns the output of calling [genericClassArguments] with [_element].
  String _genericClassArguments(bool withConstraints) =>
      genericClassArguments(_element, withConstraints);

  String get _targetClassReference =>
      '${_element.name}${_genericClassArguments(false)}';

  _GeneratorHelper(this._generator, this._element, this._annotation);

  Future<String> _generate() async {
    assert(_buffer.isEmpty);
    var accessibleFields = _writeCtor();

    // Check for duplicate JSON keys due to colliding annotations.
    // We do this now, since we have a final field list after any pruning done
    // by `_writeCtor`.
    accessibleFields.fold(new Set<String>(), (Set<String> set, fe) {
      var jsonKey = _nameAccess(fe);
      if (!set.add(jsonKey)) {
        throw new InvalidGenerationSourceError(
            'More than one field has the JSON key `$jsonKey`.',
            todo: 'Check the `JsonKey` annotations on fields.',
            element: fe);
      }
      return set;
    });

    if (_annotation.createToJson) {
      //
      // Generate the mixin class
      //
      _buffer.writeln('abstract class ${_mixinClassName(true)} {');

      // write copies of the fields - this allows the toJson method to access
      // the fields of the target class
      for (var field in accessibleFields) {
        //TODO - handle aliased imports
        _buffer.writeln('  ${field.type} get ${field.name};');
      }

      _buffer.write('  Map<String, dynamic> toJson() ');

      var writeNaive = accessibleFields.every(_writeJsonValueNaive);

      if (_generator.useWrappers) {
        _buffer.writeln('=> new ${_wrapperClassName(false)}(this);');
      } else {
        if (writeNaive) {
          // write simple `toJson` method that includes all keys...
          _writeToJsonSimple(accessibleFields);
        } else {
          // At least one field should be excluded if null
          _writeToJsonWithNullChecks(accessibleFields);
        }
      }

      // end of the mixin class
      _buffer.writeln('}');

      if (_generator.useWrappers) {
        _writeWrapper(accessibleFields);
      }
    }

    return _buffer.toString();
  }

  Set<FieldElement> _writeCtor() {
    // Used to keep track of why a field is ignored. Useful for providing
    // helpful errors when generating constructor calls that try to use one of
    // these fields.
    var unavailableReasons = <String, String>{};

    var sortedFields = createSortedFieldSet(_element);

    var accessibleFields = sortedFields.fold<Map<String, FieldElement>>(
        <String, FieldElement>{}, (map, field) {
      if (!field.isPublic) {
        unavailableReasons[field.name] = 'It is assigned to a private field.';
      } else if (jsonKeyFor(field).ignore == true) {
        unavailableReasons[field.name] = 'It is assigned to an ignored field.';
      } else {
        map[field.name] = field;
      }

      return map;
    });

    if (_annotation.createFactory) {
      var mapType = _generator.anyMap ? 'Map' : 'Map<String, dynamic>';
      _buffer.write('$_targetClassReference '
          '${_prefix}FromJson${_genericClassArguments(true)}'
          '($mapType json) =>');

      String deserializeFun(String paramOrFieldName,
              {ParameterElement ctorParam}) =>
          _deserializeForField(accessibleFields[paramOrFieldName],
              ctorParam: ctorParam);

      Set<String> fieldsSetByFactory;
      if (_generator.checked) {
        var classLiteral = escapeDartString(_element.name);

        _buffer.write(''' \$checkedNew(
    $classLiteral,
    json,
    ()''');

        var data = writeConstructorInvocation(
            _element,
            accessibleFields.keys,
            accessibleFields.values
                .where((fe) => !fe.isFinal)
                .map((fe) => fe.name)
                .toList(),
            unavailableReasons,
            deserializeFun);

        fieldsSetByFactory = data.usedCtorParamsAndFields;

        if (data.fieldsToSet.isEmpty) {
          // Use simple arrow syntax for the constructor invocation.
          // There are no fields to set
          _buffer.write(' => ${data.content}');
        } else {
          // If there are fields to set, create a full function body and
          // create a temporary variable to hold the instance so we can make
          // wrapped calls to all of the fields value assignments.
          _buffer.write(''' {
      var val = ''');
          _buffer.write(data.content);
          _buffer.writeln(';');

          for (var field in data.fieldsToSet) {
            _buffer.writeln();
            var safeName = _safeNameAccess(accessibleFields[field]);
            _buffer.write('''
      \$checkedConvert(json, $safeName, (v) => ''');
            _buffer.write('val.$field = ');
            _buffer.write(_deserializeForField(accessibleFields[field],
                checkedProperty: true));
            _buffer.write(');');
          }
          _buffer.writeln('return val; }');
        }
        var fieldKeyMap = new Map.fromEntries(fieldsSetByFactory
            .map((k) => new MapEntry(k, _nameAccess(accessibleFields[k])))
            .where((me) => me.key != me.value));

        String fieldKeyMapArg;
        if (fieldKeyMap.isEmpty) {
          fieldKeyMapArg = '';
        } else {
          var mapLiteral = jsonMapAsDart(fieldKeyMap, true);
          fieldKeyMapArg = ', fieldKeyMap: $mapLiteral';
        }

        _buffer.write('$fieldKeyMapArg)');
      } else {
        var data = writeConstructorInvocation(
            _element,
            accessibleFields.keys,
            accessibleFields.values
                .where((fe) => !fe.isFinal)
                .map((fe) => fe.name)
                .toList(),
            unavailableReasons,
            deserializeFun);

        fieldsSetByFactory = data.usedCtorParamsAndFields;

        _buffer.write(' ${data.content}');
        for (var field in data.fieldsToSet) {
          _buffer.writeln();
          _buffer.write('  ..$field = ');
          _buffer.write(deserializeFun(field));
        }
      }
      _buffer.writeln(';');
      _buffer.writeln();

      // If there are fields that are final – that are not set via the generated
      // constructor, then don't output them when generating the `toJson` call.
      accessibleFields
          .removeWhere((name, fe) => !fieldsSetByFactory.contains(name));
    }
    return accessibleFields.values.toSet();
  }

  void _writeWrapper(Iterable<FieldElement> fields) {
    _buffer.writeln();
    // TODO(kevmoo): write JsonMapWrapper if annotation lib is prefix-imported
    _buffer.writeln('''
class ${_wrapperClassName(true)} extends \$JsonMapWrapper {
  final ${_mixinClassName(false)} _v;
  ${_wrapperClassName()}(this._v);
''');

    if (fields.every(_writeJsonValueNaive)) {
      // TODO(kevmoo): consider just doing one code path – if it's fast
      //               enough
      var jsonKeys = fields.map(_safeNameAccess).join(', ');

      // TODO(kevmoo): maybe put this in a static field instead?
      //               const lists have unfortunate overhead
      _buffer.writeln('''
  @override
  Iterable<String> get keys => const [$jsonKeys];
''');
    } else {
      // At least one field should be excluded if null
      _buffer.writeln('  @override\n  Iterable<String> get keys sync* {');

      for (var field in fields) {
        var nullCheck = !_writeJsonValueNaive(field);
        if (nullCheck) {
          _buffer.write('    if (_v.${field.name} != null) {\n  ');
        }
        _buffer.writeln('    yield ${_safeNameAccess(field)};');
        if (nullCheck) {
          _buffer.writeln('    }');
        }
      }

      _buffer.writeln('  }\n');
    }

    _buffer.writeln('''
  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {''');

    for (var field in fields) {
      var valueAccess = '_v.${field.name}';
      _buffer.writeln('''
        case ${_safeNameAccess(field)}:
          return ${_serializeField(field, accessOverride: valueAccess)};''');
    }

    _buffer.writeln('''
      }
    }
    return null;
  }''');

    _buffer.writeln('}');
  }

  void _writeToJsonWithNullChecks(Iterable<FieldElement> fields) {
    _buffer.writeln('{');

    _buffer.writeln('    var $generatedLocalVarName = <String, dynamic>{');

    // Note that the map literal is left open above. As long as target fields
    // don't need to be intercepted by the `only if null` logic, write them
    // to the map literal directly. In theory, should allow more efficient
    // serialization.
    var directWrite = true;

    for (var field in fields) {
      var safeFieldAccess = field.name;
      var safeJsonKeyString = _safeNameAccess(field);

      // If `fieldName` collides with one of the local helpers, prefix
      // access with `this.`.
      if (safeFieldAccess == generatedLocalVarName ||
          safeFieldAccess == toJsonMapHelperName) {
        safeFieldAccess = 'this.$safeFieldAccess';
      }

      var expression = _serializeField(field, accessOverride: safeFieldAccess);
      if (_writeJsonValueNaive(field)) {
        if (directWrite) {
          _buffer.writeln('      $safeJsonKeyString: $expression,');
        } else {
          _buffer.writeln(
              '    $generatedLocalVarName[$safeJsonKeyString] = $expression;');
        }
      } else {
        if (directWrite) {
          // close the still-open map literal
          _buffer.writeln('    };');
          _buffer.writeln();

          // write the helper to be used by all following null-excluding
          // fields
          _buffer.writeln('''
    void $toJsonMapHelperName(String key, dynamic value) {
      if (value != null) {
        $generatedLocalVarName[key] = value;
      }
    }
''');
          directWrite = false;
        }
        _buffer.writeln(
            '    $toJsonMapHelperName($safeJsonKeyString, $expression);');
      }
    }

    _buffer.writeln('    return $generatedLocalVarName;');
    _buffer.writeln('  }');
  }

  void _writeToJsonSimple(Iterable<FieldElement> fields) {
    _buffer.writeln('=> <String, dynamic>{');

    _buffer.writeAll(fields.map((field) {
      var value = '${_safeNameAccess(field)}: ${_serializeField(field)}';
      return '        $value';
    }), ',\n');

    if (fields.isNotEmpty) {
      _buffer.write('\n      ');
    }

    _buffer.writeln('};');
  }

  String _serializeField(FieldElement field, {String accessOverride}) {
    accessOverride ??= field.name;

    try {
      return _getHelperContext(field).serialize(field.type, accessOverride);
    } on UnsupportedTypeError catch (e) {
      throw _createInvalidGenerationError('toJson', field, e);
    }
  }

  String _deserializeForField(FieldElement field,
      {ParameterElement ctorParam, bool checkedProperty}) {
    checkedProperty ??= false;
    var jsonKeyName = _safeNameAccess(field);
    var targetType = ctorParam?.type ?? field.type;
    var contextHelper = _getHelperContext(field);

    String value;
    try {
      if (_generator.checked) {
        value = contextHelper.deserialize(targetType, 'v');
        if (!checkedProperty) {
          value = '\$checkedConvert(json, $jsonKeyName, (v) => $value)';
        }
      } else {
        assert(!checkedProperty,
            'should only be true if `_generator.checked` is true.');

        value = contextHelper.deserialize(targetType, 'json[$jsonKeyName]');
      }
    } on UnsupportedTypeError catch (e) {
      throw _createInvalidGenerationError('fromJson', field, e);
    }

    var defaultValue = jsonKeyFor(field).defaultValue;
    if (defaultValue != null) {
      if (!contextHelper.nullable) {
        throwUnsupported(field,
            'Cannot use `defaultValue` on a field with `nullable` false.');
      }

      value = '$value ?? $defaultValue';
    }
    return value;
  }

  TypeHelperContext _getHelperContext(FieldElement field) {
    var key = jsonKeyFor(field);
    return new TypeHelperContext(_generator, field.metadata, _nullable(field),
        key.fromJsonData, key.toJsonData);
  }

  /// Returns `true` if the field can be written to JSON 'naively' – meaning
  /// we can avoid checking for `null`.
  ///
  /// `true` if either:
  ///   `includeIfNull` is `true`
  ///   or
  ///   `nullable` is `false`.
  bool _writeJsonValueNaive(FieldElement field) =>
      (jsonKeyFor(field).includeIfNull ?? _annotation.includeIfNull) ||
      !_nullable(field);

  /// Returns `true` if the field should be treated as potentially nullable.
  ///
  /// If no [JsonKey] annotation is present on the field, `true` is returned.
  bool _nullable(FieldElement field) =>
      jsonKeyFor(field).nullable ?? _annotation.nullable;
}

String _nameAccess(FieldElement field) => jsonKeyFor(field).name ?? field.name;

String _safeNameAccess(FieldElement field) =>
    escapeDartString(_nameAccess(field));

InvalidGenerationSourceError _createInvalidGenerationError(
    String targetMember, FieldElement field, UnsupportedTypeError e) {
  var extra = (field.type != e.type) ? ' because of type `${e.type}`' : '';

  var message = 'Could not generate `$targetMember` code for '
      '`${field.name}`$extra.\n${e.reason}';

  return new InvalidGenerationSourceError(message,
      todo: 'Make sure all of the types are serializable.', element: field);
}
