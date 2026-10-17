// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../constants.dart';
import '../enum_utils.dart';
import '../json_key_utils.dart';
import '../type_helper.dart';

final simpleExpression = RegExp('^[a-zA-Z_]+\$');

class EnumHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const EnumHelper();

  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) {
    final memberContent = enumValueMapFromType(targetType);

    if (memberContent == null) {
      return null;
    }

    context.addMember(memberContent);

    if (targetType.isNullableType ||
        enumFieldWithNullInEncodeMap(targetType) == true) {
      return '${constMapName(targetType)}[$expression]';
    } else {
      return '${constMapName(targetType)}[$expression]!';
    }
  }

  @override
  String? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    final memberContent = enumValueMapFromType(targetType);

    if (memberContent == null) {
      return null;
    }

    final isMapKey = expression == keyParam;
    final jsonKey = jsonKeyForField(context.fieldElement, context.config);
    final unknownEnumValue = isMapKey ? null : jsonKey.unknownEnumValue;

    if (!targetType.isNullableType &&
        unknownEnumValue == jsonKeyNullForUndefinedEnumValueFieldName) {
      // If the target is not nullable,
      throw InvalidGenerationSourceError(
        '`$jsonKeyNullForUndefinedEnumValueFieldName` cannot be used with '
        '`JsonKey.unknownEnumValue` unless the field is nullable.',
        element: context.fieldElement,
      );
    }

    if (isMapKey) {
      final encodedValues = enumEncodedValues(targetType);
      if (encodedValues != null && encodedValues.any((v) => v is int)) {
        final keyString = context.config.anyMap
            ? '$expression as String'
            : expression;
        if (encodedValues.every((v) => v is int || v == null)) {
          expression = 'int.parse($keyString)';
        } else {
          expression = 'int.tryParse($keyString) ?? $keyString';
        }
      }
    }

    final nullEnumValue = enumValueForNull(targetType);

    String functionName;
    if (targetType.isNullableType || defaultProvided || nullEnumValue != null) {
      functionName = r'$enumDecodeNullable';
    } else {
      functionName = r'$enumDecode';
    }

    context.addMember(memberContent);

    final args = [
      constMapName(targetType),
      expression,
      if (unknownEnumValue != null) 'unknownValue: $unknownEnumValue',
    ];

    final decoded = '$functionName(${args.join(', ')})';
    if (!targetType.isNullableType &&
        !defaultProvided &&
        nullEnumValue != null) {
      return '$decoded ?? $nullEnumValue';
    }
    return decoded;
  }
}
