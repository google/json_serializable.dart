// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

import '../type_helper.dart';
import '../utils.dart';

final simpleExpression = new RegExp('^[a-zA-Z_]+\$');

class EnumHelper extends TypeHelper {
  const EnumHelper();

  @override
  String serialize(
      DartType targetType, String expression, SerializeContext context) {
    if (!isEnum(targetType)) {
      return null;
    }

    var nullableLiteral = context.nullable ? '?' : '';

    return '$expression$nullableLiteral.toString()'
        "$nullableLiteral.split('.')$nullableLiteral.last";
  }

  @override
  String deserialize(
      DartType targetType, String expression, DeserializeContext context) {
    if (!isEnum(targetType)) {
      return null;
    }

    var functionName =
        context.nullable ? r'$enumDecodeNullable' : r'$enumDecode';
    return "$functionName('$targetType', $targetType.values, "
        '$expression as String)';
  }
}
