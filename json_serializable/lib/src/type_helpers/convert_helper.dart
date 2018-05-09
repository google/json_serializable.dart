// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

import '../type_helper.dart';
import '../type_helper_context.dart';
import '../utils.dart';

class ConvertHelper extends TypeHelper {
  const ConvertHelper();

  @override
  String serialize(
      DartType targetType, String expression, SerializeContext context) {
    var jsonKey = (context as TypeHelperContext).jsonKey;
    if (jsonKey.toJsonData != null) {
      assert(targetType.isAssignableTo(jsonKey.toJsonData.paramType));

      var result = '${jsonKey.toJsonData.name}($expression)';
      return commonNullPrefix(context.nullable, expression, result);
    }
    return null;
  }

  @override
  String deserialize(
      DartType targetType, String expression, DeserializeContext context) {
    var jsonKey = (context as TypeHelperContext).jsonKey;
    if (jsonKey.fromJsonData != null) {
      var asContent = '';
      var paramType = jsonKey.fromJsonData.paramType;
      if (!(paramType.isDynamic || paramType.isObject)) {
        asContent = ' as $paramType';
      }
      var result = '${jsonKey.fromJsonData.name}($expression$asContent)';
      return commonNullPrefix(context.nullable, expression, result);
    }
    return null;
  }
}
