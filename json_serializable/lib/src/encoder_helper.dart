// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:source_helper/source_helper.dart';

import 'enum_utils.dart';
import 'helper_core.dart';
import 'type_helpers/generic_factory_helper.dart';
import 'type_helpers/json_converter_helper.dart';
import 'unsupported_type_error.dart';

mixin EncodeHelper implements HelperCore {
  String _fieldAccess(FieldElement2 field) =>
      '$_toJsonParamName.${field.name3!}';

  String createPerFieldToJson(Set<FieldElement2> accessibleFieldSet) {
    final buffer = StringBuffer()
      ..writeln('// ignore: unused_element')
      ..writeln(
        'abstract class _\$${element.name3!.nonPrivate}PerFieldToJson {',
      );

    for (final field in accessibleFieldSet) {
      buffer
        ..writeln('  // ignore: unused_element')
        ..write(
          'static Object? ${field.name3!}'
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
  String createFieldMap(Set<FieldElement2> accessibleFieldSet) {
    assert(config.createFieldMap);

    final buffer = StringBuffer(
      'const _\$${element.name3!.nonPrivate}FieldMap = <String, String> {',
    );

    for (final field in accessibleFieldSet) {
      buffer.writeln(
        '${escapeDartString(field.name3!)}: '
        '${escapeDartString(nameAccess(field))},',
      );
    }

    buffer.write('};');

    return buffer.toString();
  }

  /// Generates an object containing metadatas related to the encoding,
  /// destined to be used by other code-generators.
  String createJsonKeys(Set<FieldElement2> accessibleFieldSet) {
    assert(config.createJsonKeys);

    final buffer = StringBuffer(
      'abstract final class _\$${element.name3!.nonPrivate}JsonKeys {',
    );
    // ..write('static const _\$${element.name.nonPrivate}JsonKeys();');

    for (final field in accessibleFieldSet) {
      buffer.writeln(
        'static const String ${field.name3} = '
        '${escapeDartString(nameAccess(field))};',
      );
    }

    buffer.write('}');

    return buffer.toString();
  }

  Iterable<String> createToJson(Set<FieldElement2> accessibleFields) sync* {
    assert(config.createToJson);

    final buffer = StringBuffer();

    final functionName =
        '${prefix}ToJson${genericClassArgumentsImpl(withConstraints: true)}';
    buffer.write(
      'Map<String, dynamic> '
      '$functionName($targetClassReference $_toJsonParamName',
    );

    if (config.genericArgumentFactories) _writeGenericArgumentFactories(buffer);

    buffer
      ..write(') ')
      ..writeln('=> <String, dynamic>{')
      ..writeAll(
        accessibleFields.map((field) {
          final access = _fieldAccess(field);

          final keyExpression = safeNameAccess(field);
          final valueExpression = _serializeField(field, access);

          final maybeQuestion = _canWriteJsonWithoutNullCheck(field) ? '' : '?';

          final keyValuePair = '$keyExpression: $maybeQuestion$valueExpression';
          return '        $keyValuePair,\n';
        }),
      )
      ..writeln('};');

    yield buffer.toString();
  }

  void _writeGenericArgumentFactories(StringBuffer buffer) {
    for (var arg in element.typeParameters2) {
      final helperName = toJsonForType(
        arg.instantiate(nullabilitySuffix: NullabilitySuffix.none),
      );
      buffer.write(',Object? Function(${arg.name3} value) $helperName');
    }
    if (element.typeParameters2.isNotEmpty) {
      buffer.write(',');
    }
  }

  static const _toJsonParamName = 'instance';

  String _serializeField(FieldElement2 field, String accessExpression) {
    try {
      return getHelperContext(
        field,
      ).serialize(field.type, accessExpression).toString();
    } on UnsupportedTypeError catch (e) // ignore: avoid_catching_errors
    {
      throw createInvalidGenerationError('toJson', field, e);
    }
  }

  /// Returns `true` if the field can be written to JSON 'naively' – meaning
  /// we can avoid checking for `null`.
  bool _canWriteJsonWithoutNullCheck(FieldElement2 field) {
    final jsonKey = jsonKeyFor(field);

    if (jsonKey.includeIfNull) {
      return true;
    }

    final helperContext = getHelperContext(field);

    final serializeConvertData = helperContext.serializeConvertData;
    if (serializeConvertData != null) {
      return !serializeConvertData.returnType.isNullableType;
    }

    final nullableEncodeConverter = hasConverterNullEncode(
      field.type,
      helperContext,
    );

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
