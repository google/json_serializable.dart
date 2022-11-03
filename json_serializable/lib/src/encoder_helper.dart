// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:source_helper/source_helper.dart';

import 'constants.dart';
import 'enum_utils.dart';
import 'helper_core.dart';
import 'type_helpers/generic_factory_helper.dart';
import 'type_helpers/json_converter_helper.dart';
import 'unsupported_type_error.dart';

abstract class EncodeHelper implements HelperCore {
  String _fieldAccess(FieldElement field) => '$_toJsonParamName.${field.name}';

  String createPerFieldToJson(Set<FieldElement> accessibleFieldSet) {
    final buffer = StringBuffer()
      ..writeln('// ignore: unused_element')
      ..writeln('abstract class _\$${element.name.nonPrivate}PerFieldToJson {');

    for (final field in accessibleFieldSet) {
      buffer
        ..writeln('  // ignore: unused_element')
        ..write(
          'static Object? ${field.name}'
          '${genericClassArgumentsImpl(withConstraints: true)}'
          '(${field.type} $_toJsonParamName',
        );

      if (config.genericArgumentFactories) {
        _writeGenericArgumentFactories(buffer);
      }

      buffer.writeln(') => ${_serializeField(field, _toJsonParamName)};');
    }

    buffer.writeln('}');

    return buffer.toString();
  }

  /// Generates an object containing metadatas related to the encoding,
  /// destined to be used by other code-generators.
  String createFieldMap(Set<FieldElement> accessibleFieldSet) {
    assert(config.createFieldMap);

    final buffer = StringBuffer(
      'const _\$${element.name.nonPrivate}FieldMap = <String, String> {',
    );

    for (final field in accessibleFieldSet) {
      buffer.writeln(
        '${escapeDartString(field.name)}: '
        '${escapeDartString(nameAccess(field))},',
      );
    }

    buffer.write('};');

    return buffer.toString();
  }

  Iterable<String> createToJson(Set<FieldElement> accessibleFields) sync* {
    assert(config.createToJson);

    final buffer = StringBuffer();

    final functionName =
        '${prefix}ToJson${genericClassArgumentsImpl(withConstraints: true)}';
    buffer.write('Map<String, dynamic> '
        '$functionName($targetClassReference $_toJsonParamName');

    if (config.genericArgumentFactories) _writeGenericArgumentFactories(buffer);

    buffer.write(') ');

    final canWriteAllJsonValuesWithoutNullCheck =
        accessibleFields.every(_canWriteJsonWithoutNullCheck);

    if (canWriteAllJsonValuesWithoutNullCheck) {
      // write simple `toJson` method that includes all keys...
      _writeToJsonSimple(buffer, accessibleFields);
    } else {
      // At least one field should be excluded if null
      _writeToJsonWithNullChecks(buffer, accessibleFields);
    }

    yield buffer.toString();
  }

  void _writeGenericArgumentFactories(StringBuffer buffer) {
    for (var arg in element.typeParameters) {
      final helperName = toJsonForType(
        arg.instantiate(nullabilitySuffix: NullabilitySuffix.none),
      );
      buffer.write(',Object? Function(${arg.name} value) $helperName');
    }
    if (element.typeParameters.isNotEmpty) {
      buffer.write(',');
    }
  }

  void _writeToJsonSimple(StringBuffer buffer, Iterable<FieldElement> fields) {
    buffer
      ..writeln('=> <String, dynamic>{')
      ..writeAll(fields.map((field) {
        final access = _fieldAccess(field);
        final value =
            '${safeNameAccess(field)}: ${_serializeField(field, access)}';
        return '        $value,\n';
      }))
      ..writeln('};');
  }

  static const _toJsonParamName = 'instance';

  void _writeToJsonWithNullChecks(
    StringBuffer buffer,
    Iterable<FieldElement> fields,
  ) {
    buffer
      ..writeln('{')
      ..writeln('    final $generatedLocalVarName = <String, dynamic>{');

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
        safeFieldAccess = 'this.$safeFieldAccess';
      }

      final expression = _serializeField(field, safeFieldAccess);
      if (_canWriteJsonWithoutNullCheck(field)) {
        if (directWrite) {
          buffer.writeln('      $safeJsonKeyString: $expression,');
        } else {
          buffer.writeln(
              '    $generatedLocalVarName[$safeJsonKeyString] = $expression;');
        }
      } else {
        if (directWrite) {
          // close the still-open map literal
          buffer
            ..writeln('    };')
            ..writeln()

            // write the helper to be used by all following null-excluding
            // fields
            ..writeln('''
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

    buffer
      ..writeln('    return $generatedLocalVarName;')
      ..writeln('  }');
  }

  String _serializeField(FieldElement field, String accessExpression) {
    try {
      return getHelperContext(field)
          .serialize(field.type, accessExpression)
          .toString();
    } on UnsupportedTypeError catch (e) // ignore: avoid_catching_errors
    {
      throw createInvalidGenerationError('toJson', field, e);
    }
  }

  /// Returns `true` if the field can be written to JSON 'naively' – meaning
  /// we can avoid checking for `null`.
  bool _canWriteJsonWithoutNullCheck(FieldElement field) {
    final jsonKey = jsonKeyFor(field);

    if (jsonKey.includeIfNull) {
      return true;
    }

    final helperContext = getHelperContext(field);

    final serializeConvertData = helperContext.serializeConvertData;
    if (serializeConvertData != null) {
      return !serializeConvertData.returnType.isNullableType;
    }

    final nullableEncodeConverter =
        hasConverterNullEncode(field.type, helperContext);

    if (nullableEncodeConverter != null) {
      return !nullableEncodeConverter && !field.type.isNullableType;
    }

    // We can consider enums as kinda like having custom converters
    // same rules apply. If `null` is in the set of encoded values, we
    // should not write naive
    final enumWithNullValue = enumFieldWithNullInEncodeMap(field.type);
    if (enumWithNullValue != null) {
      return !enumWithNullValue;
    }

    return !field.type.isNullableType;
  }
}
