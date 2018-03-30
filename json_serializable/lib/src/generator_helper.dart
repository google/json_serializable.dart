// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'constants.dart';
import 'json_serializable_generator.dart';
import 'type_helper.dart';
import 'utils.dart';

class GeneratorHelper {
  final ClassElement element;
  final JsonSerializable annotation;
  final JsonSerializableGenerator generator;

  String get prefix => '_\$${element.name}';

  GeneratorHelper(this.generator, this.element, this.annotation);

  static Future<String> generate(JsonSerializableGenerator generator,
      Element element, ConstantReader annotation) {
    if (element is! ClassElement) {
      var friendlyName = friendlyNameForElement(element);
      throw new InvalidGenerationSourceError(
          'Generator cannot target `$friendlyName`.',
          todo: 'Remove the JsonSerializable annotation from `$friendlyName`.');
    }

    var classElement = element as ClassElement;

    // Get all of the fields that need to be assigned
    var classAnnotation = _valueForAnnotation(annotation);

    var helper = new GeneratorHelper(generator, classElement, classAnnotation);

    return helper._generate();
  }

  Future<String> _generate() async {
    var buffer = new StringBuffer();
    var accessibleFields = _writeCtor(buffer, annotation, element);

    // Check for duplicate JSON keys due to colliding annotations.
    // We do this now, since we have a final field list after any pruning done
    // by `_writeCtor`.
    accessibleFields.fold(new Set<String>(), (Set<String> set, fe) {
      var jsonKey = _jsonKeyFor(fe).name ?? fe.name;
      if (!set.add(jsonKey)) {
        throw new InvalidGenerationSourceError(
            'More than one field has the JSON key `$jsonKey`.',
            todo: 'Check the `JsonKey` annotations on fields.');
      }
      return set;
    });

    if (annotation.createToJson) {
      var mixClassName = '${prefix}SerializerMixin';
      var helpClassName = '${prefix}JsonMapWrapper';

      //
      // Generate the mixin class
      //
      buffer.writeln('abstract class $mixClassName {');

      // write copies of the fields - this allows the toJson method to access
      // the fields of the target class
      for (var field in accessibleFields) {
        //TODO - handle aliased imports
        buffer.writeln('  ${field.type} get ${field.name};');
      }

      buffer.write('  Map<String, dynamic> toJson() ');

      var writeNaive =
          accessibleFields.every((e) => _writeJsonValueNaive(e, annotation));

      if (generator.useWrappers) {
        buffer.writeln('=> new $helpClassName(this);');
      } else {
        if (writeNaive) {
          // write simple `toJson` method that includes all keys...
          _writeToJsonSimple(buffer, accessibleFields, annotation.nullable);
        } else {
          // At least one field should be excluded if null
          _writeToJsonWithNullChecks(buffer, accessibleFields, annotation);
        }
      }

      // end of the mixin class
      buffer.writeln('}');

      if (generator.useWrappers) {
        _writeWrapper(
            buffer, helpClassName, mixClassName, annotation, accessibleFields);
      }
    }

    return buffer.toString();
  }

  Set<FieldElement> _writeCtor(StringBuffer buffer,
      JsonSerializable classAnnotation, ClassElement classElement) {
    // Used to keep track of why a field is ignored. Useful for providing
    // helpful errors when generating constructor calls that try to use one of
    // these fields.
    var unavailableReasons = <String, String>{};

    var sortedFields = createSortedFieldSet(classElement);

    var accessibleFields = sortedFields.fold<Map<String, FieldElement>>(
        <String, FieldElement>{}, (map, field) {
      if (!field.isPublic) {
        unavailableReasons[field.name] = 'It is assigned to a private field.';
      } else if (_jsonKeyFor(field).ignore == true) {
        unavailableReasons[field.name] = 'It is assigned to an ignored field.';
      } else {
        map[field.name] = field;
      }

      return map;
    });

    if (classAnnotation.createFactory) {
      buffer.writeln();
      buffer.writeln('${classElement.name} '
          '${prefix}FromJson(Map<String, dynamic> json) =>');

      String deserializeFun(String paramOrFieldName,
              {ParameterElement ctorParam}) =>
          _deserializeForField(
              accessibleFields[paramOrFieldName], classAnnotation.nullable,
              ctorParam: ctorParam);

      var fieldsSetByFactory = writeConstructorInvocation(
          buffer,
          classElement,
          accessibleFields.keys,
          accessibleFields.values
              .where((fe) => !fe.isFinal)
              .map((fe) => fe.name)
              .toList(),
          unavailableReasons,
          deserializeFun);

      // If there are fields that are final – that are not set via the generated
      // constructor, then don't output them when generating the `toJson` call.
      accessibleFields
          .removeWhere((name, fe) => !fieldsSetByFactory.contains(name));
    }
    return accessibleFields.values.toSet();
  }

  void _writeWrapper(
      StringBuffer buffer,
      String helpClassName,
      String mixClassName,
      JsonSerializable classAnnotation,
      Iterable<FieldElement> fields) {
    buffer.writeln();
    // TODO(kevmoo): write JsonMapWrapper if annotation lib is prefix-imported
    buffer.writeln('''class $helpClassName extends \$JsonMapWrapper {
      final $mixClassName _v;
      $helpClassName(this._v);
    ''');

    if (fields.every((e) => _writeJsonValueNaive(e, classAnnotation))) {
      // TODO(kevmoo): consider just doing one code path – if it's fast
      //               enough
      var jsonKeys = fields.map(_safeNameAccess).join(', ');

      // TODO(kevmoo): maybe put this in a static field instead?
      //               const lists have unfortunate overhead
      buffer.writeln('''  @override
      Iterable<String> get keys => const [$jsonKeys];
    ''');
    } else {
      // At least one field should be excluded if null
      buffer.writeln('@override\nIterable<String> get keys sync* {');

      for (var field in fields) {
        var nullCheck = !_writeJsonValueNaive(field, classAnnotation);
        if (nullCheck) {
          buffer.writeln('if (_v.${field.name} != null) {');
        }
        buffer.writeln('yield ${_safeNameAccess(field)};');
        if (nullCheck) {
          buffer.writeln('}');
        }
      }

      buffer.writeln('}\n');
    }

    buffer.writeln('''@override
    dynamic operator [](Object key) {
    if (key is String) {
    switch(key) {
    ''');

    for (var field in fields) {
      var valueAccess = '_v.${field.name}';
      buffer.write('''case ${_safeNameAccess(field)}:
        return ${_serializeField(
          field, classAnnotation.nullable, accessOverride: valueAccess)};''');
    }

    buffer.writeln('''
      }}
      return null;
    }''');

    buffer.writeln('}');
  }

  void _writeToJsonWithNullChecks(StringBuffer buffer,
      Iterable<FieldElement> fields, JsonSerializable classAnnotation) {
    buffer.writeln('{');

    buffer.writeln('var $toJsonMapVarName = <String, dynamic>{');

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
      if (safeFieldAccess == toJsonMapVarName ||
          safeFieldAccess == toJsonMapHelperName) {
        safeFieldAccess = 'this.$safeFieldAccess';
      }

      var expression = _serializeField(field, classAnnotation.nullable,
          accessOverride: safeFieldAccess);
      if (_writeJsonValueNaive(field, classAnnotation)) {
        if (directWrite) {
          buffer.writeln('$safeJsonKeyString : $expression,');
        } else {
          buffer
              .writeln('$toJsonMapVarName[$safeJsonKeyString] = $expression;');
        }
      } else {
        if (directWrite) {
          // close the still-open map literal
          buffer.writeln('};');
          buffer.writeln();

          // write the helper to be used by all following null-excluding
          // fields
          buffer.writeln('''
void $toJsonMapHelperName(String key, dynamic value) {
  if (value != null) {
    $toJsonMapVarName[key] = value;
  }
}''');
          directWrite = false;
        }
        buffer
            .writeln('$toJsonMapHelperName($safeJsonKeyString, $expression);');
      }
    }

    buffer.writeln('return $toJsonMapVarName;');

    buffer.writeln('}');
  }

  void _writeToJsonSimple(StringBuffer buffer, Iterable<FieldElement> fields,
      bool classSupportNullable) {
    buffer.writeln('=> <String, dynamic>{');

    var pairs = <String>[];
    for (var field in fields) {
      pairs.add('${_safeNameAccess(field)}: ${_serializeField(
          field, classSupportNullable)}');
    }
    buffer.writeAll(pairs, ',\n');

    buffer.writeln('  };');
  }

  String _serializeField(FieldElement field, bool classIncludeNullable,
      {String accessOverride}) {
    accessOverride ??= field.name;

    try {
      return _getHelperContext(field, _nullable(field, classIncludeNullable))
          .serialize(field.type, accessOverride);
    } on UnsupportedTypeError catch (e) {
      throw _createInvalidGenerationError('toJson', field, e);
    }
  }

  String _deserializeForField(FieldElement field, bool classSupportNullable,
      {ParameterElement ctorParam}) {
    var jsonKey = _safeNameAccess(field);

    var targetType = ctorParam?.type ?? field.type;

    try {
      return _getHelperContext(field, _nullable(field, classSupportNullable))
          .deserialize(targetType, 'json[$jsonKey]');
    } on UnsupportedTypeError catch (e) {
      throw _createInvalidGenerationError('fromJson', field, e);
    }
  }

  _TypeHelperContext _getHelperContext(FieldElement field, bool nullable) =>
      new _TypeHelperContext(generator, field.metadata, nullable);
}

class _TypeHelperContext implements SerializeContext, DeserializeContext {
  final JsonSerializableGenerator _generator;

  @override
  bool get useWrappers => _generator.useWrappers;

  @override
  final List<ElementAnnotation> metadata;

  @override
  final bool nullable;

  _TypeHelperContext(this._generator, this.metadata, this.nullable);

  @override
  String serialize(DartType targetType, String expression) => _run(
      targetType,
      expression,
      (TypeHelper th) => th.serialize(targetType, expression, this));

  @override
  String deserialize(DartType targetType, String expression) => _run(
      targetType,
      expression,
      (TypeHelper th) => th.deserialize(targetType, expression, this));

  String _run(DartType targetType, String expression,
          String invoke(TypeHelper instance)) =>
      _generator.allHelpers.map(invoke).firstWhere((r) => r != null,
          orElse: () => throw new UnsupportedTypeError(
              targetType, expression, _notSupportedWithTypeHelpersMsg));
}

String _safeNameAccess(FieldElement field) {
  var name = _jsonKeyFor(field).name ?? field.name;
  // TODO(kevmoo): JsonKey.name could also have quotes and other silly.
  return name.contains(r'$') ? "r'$name'" : "'$name'";
}

/// Returns `true` if the field should be treated as potentially nullable.
///
/// If no [JsonKey] annotation is present on the field, `true` is returned.
bool _nullable(FieldElement field, bool parentValue) =>
    _jsonKeyFor(field).nullable ?? parentValue;

/// Returns `true` if the field can be written to JSON 'naively' – meaning
/// we can avoid checking for `null`.
///
/// `true` if either:
///   `includeIfNull` is `true`
///   or
///   `nullable` is `false`.
bool _writeJsonValueNaive(
        FieldElement field, JsonSerializable parentAnnotation) =>
    (_jsonKeyFor(field).includeIfNull ?? parentAnnotation.includeIfNull) ||
    !_nullable(field, parentAnnotation.nullable);

JsonKey _jsonKeyFor(FieldElement element) {
  var key = _jsonKeyExpando[element];

  if (key == null) {
    // If an annotation exists on `element` the source is a 'real' field.
    // If the result is `null`, check the getter – it is a property.
    // TODO(kevmoo) setters: github.com/dart-lang/json_serializable/issues/24
    var obj = _jsonKeyChecker.firstAnnotationOfExact(element) ??
        _jsonKeyChecker.firstAnnotationOfExact(element.getter);

    _jsonKeyExpando[element] = key = obj == null
        ? const JsonKey()
        : new JsonKey(
            name: obj.getField('name').toStringValue(),
            nullable: obj.getField('nullable').toBoolValue(),
            includeIfNull: obj.getField('includeIfNull').toBoolValue(),
            ignore: obj.getField('ignore').toBoolValue());
  }

  return key;
}

JsonSerializable _valueForAnnotation(ConstantReader annotation) =>
    new JsonSerializable(
        createToJson: annotation.read('createToJson').boolValue,
        createFactory: annotation.read('createFactory').boolValue,
        nullable: annotation.read('nullable').boolValue,
        includeIfNull: annotation.read('includeIfNull').boolValue);

final _jsonKeyExpando = new Expando<JsonKey>();

final _jsonKeyChecker = const TypeChecker.fromRuntime(JsonKey);

final _notSupportedWithTypeHelpersMsg =
    'None of the provided `TypeHelper` instances support the defined type.';

InvalidGenerationSourceError _createInvalidGenerationError(
    String targetMember, FieldElement field, UnsupportedTypeError e) {
  var extra = (field.type != e.type) ? ' because of type `${e.type}`' : '';

  var message = 'Could not generate `$targetMember` code for '
      '`${friendlyNameForElement(field)}`$extra.\n${e.reason}';

  return new InvalidGenerationSourceError(message,
      todo: 'Make sure all of the types are serializable.');
}
