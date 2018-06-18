// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';

import 'constants.dart';
import 'helper_core.dart';
import 'json_serializable_generator.dart';
import 'type_helper.dart';

abstract class EncodeHelper implements HelperCore {
  String _fieldAccess(FieldElement field) {
    var fieldAccess = field.name;
    if (generator.generateToJsonFunction) {
      fieldAccess = '$_toJsonParamName.$fieldAccess';
    }
    return fieldAccess;
  }

  String _mixinClassName(bool withConstraints) =>
      '${prefix}SerializerMixin${genericClassArgumentsImpl(withConstraints)}';

  String _wrapperClassName([bool withConstraints]) =>
      '${prefix}JsonMapWrapper${genericClassArgumentsImpl(withConstraints)}';

  Iterable<String> writeToJson(Set<FieldElement> accessibleFields) sync* {
    assert(annotation.createToJson);

    var buffer = new StringBuffer();

    if (generator.generateToJsonFunction) {
      var functionName = '${prefix}ToJson${genericClassArgumentsImpl(true)}';
      buffer.write('Map<String, dynamic> $functionName'
          '($targetClassReference $_toJsonParamName) ');
    } else {
      //
      // Generate the mixin class
      //
      buffer.writeln('abstract class ${_mixinClassName(true)} {');

      // write copies of the fields - this allows the toJson method to access
      // the fields of the target class
      for (var field in accessibleFields) {
        //TODO - handle aliased imports
        buffer.writeln('  ${field.type} get ${field.name};');
      }

      buffer.write('  Map<String, dynamic> toJson() ');
    }

    var writeNaive = accessibleFields.every(_writeJsonValueNaive);

    if (generator.useWrappers) {
      var param = generator.generateToJsonFunction ? _toJsonParamName : 'this';
      buffer.writeln('=> new ${_wrapperClassName(false)}($param);');
    } else {
      if (writeNaive) {
        // write simple `toJson` method that includes all keys...
        _writeToJsonSimple(buffer, accessibleFields);
      } else {
        // At least one field should be excluded if null
        _writeToJsonWithNullChecks(buffer, accessibleFields);
      }
    }

    if (!generator.generateToJsonFunction) {
      // end of the mixin class
      buffer.writeln('}');
    }

    yield buffer.toString();

    if (generator.useWrappers) {
      yield _writeWrapper(accessibleFields);
    }
  }

  String _writeWrapper(Iterable<FieldElement> fields) {
    var buffer = new StringBuffer();
    buffer.writeln();
    // TODO(kevmoo): write JsonMapWrapper if annotation lib is prefix-imported

    var fieldType = generator.generateToJsonFunction
        ? targetClassReference
        : _mixinClassName(false);

    buffer.writeln('''
class ${_wrapperClassName(true)} extends \$JsonMapWrapper {
  final $fieldType _v;
  ${_wrapperClassName()}(this._v);
''');

    if (fields.every(_writeJsonValueNaive)) {
      // TODO(kevmoo): consider just doing one code path – if it's fast
      //               enough
      var jsonKeys = fields.map(safeNameAccess).join(', ');

      // TODO(kevmoo): maybe put this in a static field instead?
      //               const lists have unfortunate overhead
      buffer.writeln('''
  @override
  Iterable<String> get keys => const [$jsonKeys];
''');
    } else {
      // At least one field should be excluded if null
      buffer.writeln('  @override\n  Iterable<String> get keys sync* {');

      for (var field in fields) {
        var nullCheck = !_writeJsonValueNaive(field);
        if (nullCheck) {
          buffer.write('    if (_v.${field.name} != null) {\n  ');
        }
        buffer.writeln('    yield ${safeNameAccess(field)};');
        if (nullCheck) {
          buffer.writeln('    }');
        }
      }

      buffer.writeln('  }\n');
    }

    buffer.writeln('''
  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {''');

    for (var field in fields) {
      var valueAccess = '_v.${field.name}';
      buffer.writeln('''
        case ${safeNameAccess(field)}:
          return ${_serializeField(field, valueAccess)};''');
    }

    buffer.writeln('''
      }
    }
    return null;
  }''');

    buffer.writeln('}');
    return buffer.toString();
  }

  void _writeToJsonSimple(StringBuffer buffer, Iterable<FieldElement> fields) {
    buffer.writeln('=> <String, dynamic>{');

    buffer.writeAll(fields.map((field) {
      var access = _fieldAccess(field);
      var value = '${safeNameAccess(field)}: ${_serializeField(field, access)}';
      return '        $value';
    }), ',\n');

    if (fields.isNotEmpty) {
      buffer.write('\n      ');
    }

    buffer.writeln('};');
  }

  /// Name of the parameter used when generating top-level `toJson` functions
  /// if [JsonSerializableGenerator.generateToJsonFunction] is `true`.
  static const _toJsonParamName = 'instance';

  void _writeToJsonWithNullChecks(
      StringBuffer buffer, Iterable<FieldElement> fields) {
    buffer.writeln('{');

    buffer.writeln('    var $generatedLocalVarName = <String, dynamic>{');

    // Note that the map literal is left open above. As long as target fields
    // don't need to be intercepted by the `only if null` logic, write them
    // to the map literal directly. In theory, should allow more efficient
    // serialization.
    var directWrite = true;

    for (var field in fields) {
      var safeFieldAccess = _fieldAccess(field);
      var safeJsonKeyString = safeNameAccess(field);

      // If `fieldName` collides with one of the local helpers, prefix
      // access with `this.`.
      if (safeFieldAccess == generatedLocalVarName ||
          safeFieldAccess == toJsonMapHelperName) {
        assert(!generator.generateToJsonFunction,
            'This code path should only be hit during the mixin codepath.');
        safeFieldAccess = 'this.$safeFieldAccess';
      }

      var expression = _serializeField(field, safeFieldAccess);
      if (_writeJsonValueNaive(field)) {
        if (directWrite) {
          buffer.writeln('      $safeJsonKeyString: $expression,');
        } else {
          buffer.writeln(
              '    $generatedLocalVarName[$safeJsonKeyString] = $expression;');
        }
      } else {
        if (directWrite) {
          // close the still-open map literal
          buffer.writeln('    };');
          buffer.writeln();

          // write the helper to be used by all following null-excluding
          // fields
          buffer.writeln('''
    void $toJsonMapHelperName(String key, dynamic value) {
      if (value != null) {
        $generatedLocalVarName[key] = value;
      }
    }
''');
          directWrite = false;
        }
        buffer.writeln(
            '    $toJsonMapHelperName($safeJsonKeyString, $expression);');
      }
    }

    buffer.writeln('    return $generatedLocalVarName;');
    buffer.writeln('  }');
  }

  String _serializeField(FieldElement field, String accessExpression) {
    try {
      return getHelperContext(field).serialize(field.type, accessExpression);
    } on UnsupportedTypeError catch (e) {
      throw createInvalidGenerationError('toJson', field, e);
    }
  }

  /// Returns `true` if the field can be written to JSON 'naively' – meaning
  /// we can avoid checking for `null`.
  ///
  /// `true` if either:
  ///   `includeIfNull` is `true`
  ///   or
  ///   `nullable` is `false`.
  bool _writeJsonValueNaive(FieldElement field) =>
      jsonKeyFor(field).includeIfNull || !jsonKeyFor(field).nullable;
}
