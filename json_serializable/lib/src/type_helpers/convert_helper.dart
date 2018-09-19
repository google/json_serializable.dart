// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

import '../shared_checkers.dart';
import '../type_helper.dart';

class ConvertData {
  final String name;
  final DartType paramType;

  ConvertData(this.name, this.paramType);
}

class ConvertHelper extends TypeHelper {
  final ConvertData Function(SerializeContext) serializeConvertData;
  final ConvertData Function(DeserializeContext) deserializeConvertData;

  const ConvertHelper(this.serializeConvertData, this.deserializeConvertData);

  @override
  String serialize(
      DartType targetType, String expression, SerializeContext context) {
    var toJsonData = serializeConvertData(context);
    if (toJsonData != null) {
      assert(toJsonData.paramType is TypeParameterType ||
          targetType.isAssignableTo(toJsonData.paramType));
      var result = '${toJsonData.name}($expression)';
      return commonNullPrefix(context.nullable, expression, result);
    }
    return null;
  }

  @override
  String deserialize(
      DartType targetType, String expression, DeserializeContext context) {
    var fromJsonData = deserializeConvertData(context);
    if (fromJsonData != null) {
      var asContent = asStatement(fromJsonData.paramType);
      var result = '${fromJsonData.name}($expression$asContent)';
      return commonNullPrefix(context.nullable, expression, result);
    }
    return null;
  }
}
