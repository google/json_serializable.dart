// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../enum_utils.dart';
import '../json_key_utils.dart';
import '../type_helper.dart';

final simpleExpression = RegExp(r'^[a-zA-Z_]+$');

class EnumHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const EnumHelper();

  @override
  Expression? serialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
  ) {
    final memberContent = enumValueMapFromType(targetType);

    if (memberContent == null) {
      return null;
    }

    context.addMember(memberContent);

    final map = refer(constMapName(targetType)).index(expression);

    if (targetType.isNullableType ||
        enumFieldWithNullInEncodeMap(targetType) == true) {
      return map;
    } else {
      return map.nullChecked;
    }
  }

  @override
  Expression? deserialize(
    DartType targetType,
    Expression expression,
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

    final functionName = (targetType.isNullableType || defaultProvided)
        ? r'$enumDecodeNullable'
        : r'$enumDecode';

    context.addMember(memberContent);

    final namedArgs = <String, Expression>{
      if (jsonKey.unknownEnumValue != null)
        'unknownValue': CodeExpression(Code(jsonKey.unknownEnumValue!)),
    };

    return refer(
      functionName,
    ).call([refer(constMapName(targetType)), expression], namedArgs);
  }
}
