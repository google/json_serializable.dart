// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart';

import 'constants.dart';
import 'helper_core.dart';
import 'type_helper.dart';
import 'type_helpers/convert_helper.dart';
import 'type_helpers/json_converter_helper.dart';

abstract class EncodeHelper implements HelperCore {
  String _fieldAccess(FieldElement field) {
    var fieldAccess = field.name;
    if (config.generateToJsonFunction) {
      fieldAccess = '$_toJsonParamName.$fieldAccess';
    }
    return fieldAccess;
  }

  String _mixinClassName(bool withConstraints) =>
      '${prefix}SerializerMixin${genericClassArgumentsImpl(withConstraints)}';

  String _wrapperClassName([bool withConstraints]) =>
      '${prefix}JsonMapWrapper${genericClassArgumentsImpl(withConstraints)}';

  Iterable<String> createToJson(Set<FieldElement> accessibleFields) sync* {
    assert(config.createToJson);

    final buffer = StringBuffer();

    if (config.generateToJsonFunction) {
      final functionName = '${prefix}ToJson${genericClassArgumentsImpl(true)}';
      buffer.write('Map<String, dynamic> $functionName'
          '($targetClassReference $_toJsonParamName) ');
    } else {
      //
      // Generate the mixin class
      //
      buffer.writeln('abstract class ${_mixinClassName(true)} {');

      // write copies of the fields - this allows the toJson method to access
      // the fields of the target class
      for (final field in accessibleFields) {
        //TODO - handle aliased imports
        buffer.writeln('  ${field.type} get ${field.name};');
      }

      buffer.write('  Map<String, dynamic> toJson() ');
    }

    final writeNaive = accessibleFields.every(_writeJsonValueNaive);

    if (config.useWrappers) {
      final param = config.generateToJsonFunction ? _toJsonParamName : 'this';
      buffer.writeln('=> ${_wrapperClassName(false)}($param);');
    } else {
      if (writeNaive) {
        // write simple `toJson` method that includes all keys...
        _writeToJsonSimple(buffer, accessibleFields);
      } else {
        // At least one field should be excluded if null
        _writeToJsonWithNullChecks(buffer, accessibleFields);
      }
    }

    if (!config.generateToJsonFunction) {
      // end of the mixin class
      buffer.writeln('}');
    }

    yield buffer.toString();

    if (config.useWrappers) {
      yield _createWrapperClass(accessibleFields);
    }
  }

  String _createWrapperClass(Iterable<FieldElement> fields) {
    final buffer = StringBuffer();
    buffer.writeln();
    // TODO(kevmoo): write JsonMapWrapper if annotation lib is prefix-imported

    final fieldType = config.generateToJsonFunction
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
      final jsonKeys = fields.map(safeNameAccess).join(', ');

      // TODO(kevmoo): maybe put this in a static field instead?
      //               const lists have unfortunate overhead
      buffer.writeln('''
  @override
  Iterable<String> get keys => const [$jsonKeys];
''');
    } else {
      // At least one field should be excluded if null
      buffer.writeln('  @override\n  Iterable<String> get keys sync* {');

      for (final field in fields) {
        String check;

        if (!_writeJsonValueNaive(field)) {
          final expression = _wrapCustomEncoder('_v.${field.name}', field);
          check = '$expression != null';

          if (!jsonKeyFor(field).encodeEmptyCollection) {
            assert(!jsonKeyFor(field).includeIfNull);
            if (jsonKeyFor(field).nullable) {
              check = '_v.${field.name}?.isNotEmpty ?? false';
            } else {
              check = '_v.${field.name}.isNotEmpty';
            }
          }
        }
        if (check != null) {
          buffer.writeln('    if ($check) {\n  ');
        }
        buffer.writeln('    yield ${safeNameAccess(field)};');
        if (check != null) {
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

    for (final field in fields) {
      final valueAccess = '_v.${field.name}';
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
      final access = _fieldAccess(field);
      final value =
          '${safeNameAccess(field)}: ${_serializeField(field, access)}';
      return '        $value';
    }), ',\n');

    if (fields.isNotEmpty) {
      buffer.write('\n      ');
    }

    buffer.writeln('};');
  }

  /// Name of the parameter used when generating top-level `toJson` functions
  /// if [JsonSerializable.generateToJsonFunction] is `true`.
  static const _toJsonParamName = 'instance';

  void _writeToJsonWithNullChecks(
      StringBuffer buffer, Iterable<FieldElement> fields) {
    buffer.writeln('{');

    buffer.writeln('    final $generatedLocalVarName = <String, dynamic>{');

    // Note that the map literal is left open above. As long as target fields
    // don't need to be intercepted by the `only if null` logic, write them
    // to the map literal directly. In theory, should allow more efficient
    // serialization.
    var directWrite = true;

    for (final field in fields) {
      var safeFieldAccess = _fieldAccess(field);
      final safeJsonKeyString = safeNameAccess(field);

      // If `fieldName` collides with one of the local helpers, prefix
      // access with `this.`.
      if (safeFieldAccess == generatedLocalVarName ||
          safeFieldAccess == toJsonMapHelperName) {
        assert(!config.generateToJsonFunction,
            'This code path should only be hit during the mixin codepath.');
        safeFieldAccess = 'this.$safeFieldAccess';
      }

      final expression = _serializeField(field, safeFieldAccess);
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
      return getHelperContext(field)
          .serialize(field.type, accessExpression)
          .toString();
    } on UnsupportedTypeError catch (e) {
      throw createInvalidGenerationError('toJson', field, e);
    }
  }

  /// Returns `true` if the field can be written to JSON 'naively' – meaning
  /// we can avoid checking for `null`.
  bool _writeJsonValueNaive(FieldElement field) {
    final jsonKey = jsonKeyFor(field);

    if (jsonKey.includeIfNull) {
      return true;
    }

    if (!jsonKey.nullable &&
        jsonKey.encodeEmptyCollection &&
        !_fieldHasCustomEncoder(field)) {
      return true;
    }

    return false;
  }

  /// Returns `true` if [field] has a user-defined encoder.
  ///
  /// This can be either a `toJson` function in [JsonKey] or a [JsonConverter]
  /// annotation.
  bool _fieldHasCustomEncoder(FieldElement field) {
    final helperContext = getHelperContext(field);

    if (helperContext.serializeConvertData != null) {
      return true;
    }

    final output = const JsonConverterHelper()
        .serialize(field.type, 'test', helperContext);

    if (output != null) {
      return true;
    }
    return false;
  }

  /// If [field] has a user-defined encoder, return [expression] wrapped in
  /// the corresponding conversion logic so we can do a correct `null` check.
  ///
  /// This can be either a `toJson` function in [JsonKey] or a [JsonConverter]
  /// annotation.
  ///
  /// If there is no user-defined encoder, just return [expression] as-is.
  String _wrapCustomEncoder(String expression, FieldElement field) {
    final helperContext = getHelperContext(field);

    final convertData = helperContext.serializeConvertData;

    var result = expression;
    if (convertData != null) {
      result = toJsonSerializeImpl(
        getHelperContext(field).serializeConvertData.name,
        expression,
        jsonKeyFor(field).nullable,
      );
    } else {
      final output = const JsonConverterHelper()
          .serialize(field.type, expression, helperContext);

      if (output != null) {
        result = output.toString();
      }
    }

    assert(
      (result != expression) == _fieldHasCustomEncoder(field),
      'If the output expression is different, then it should map to a field '
      'with a custom encoder',
    );

    if (result == expression) {
      // No conversion
      return expression;
    }

    if (jsonKeyFor(field).nullable) {
      // If there was a conversion and the field is nullable, wrap the output
      // in () – there will be null checks that will break the comparison
      // in the caller
      result = '($result)';
    }

    return result;
  }
}
