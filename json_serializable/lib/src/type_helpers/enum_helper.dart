// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

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

    final jsonKey = jsonKeyForField(context.fieldElement, context.config);

    if (!targetType.isNullableType &&
        jsonKey.unknownEnumValue == jsonKeyNullForUndefinedEnumValueFieldName) {
      // If the target is not nullable,
      throw InvalidGenerationSourceError(
        '`$jsonKeyNullForUndefinedEnumValueFieldName` cannot be used with '
        '`JsonKey.unknownEnumValue` unless the field is nullable.',
        element: context.fieldElement,
      );
    }

    String functionName;
    if (targetType.isNullableType || defaultProvided) {
      functionName = r'$enumDecodeNullable';
    } else {
      functionName = r'$enumDecode';
    }

    context.addMember(memberContent);

    final args = [
      constMapName(targetType),
      expression,
      if (jsonKey.unknownEnumValue != null)
        'unknownValue: ${jsonKey.unknownEnumValue}',
    ];

    return '$functionName(${args.join(', ')})';
  }
}
