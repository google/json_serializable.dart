// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

import '../shared_checkers.dart';
import '../type_helper.dart';
import '../type_helper_context.dart';
import '../utils.dart';

class ConvertHelper extends TypeHelper {
  const ConvertHelper();

  @override
  String serialize(
      DartType targetType, String expression, SerializeContext context) {
    var toJsonData = (context as TypeHelperContext).toJsonData;
    if (toJsonData != null) {
      assert(targetType.isAssignableTo(toJsonData.paramType));

      var result = '${toJsonData.name}($expression)';
      return commonNullPrefix(context.nullable, expression, result);
    }
    return null;
  }

  @override
  String deserialize(
      DartType targetType, String expression, DeserializeContext context) {
    var fromJsonData = (context as TypeHelperContext).fromJsonData;
    if (fromJsonData != null) {
      var asContent = _asContent(fromJsonData.paramType);
      var result = '${fromJsonData.name}($expression$asContent)';
      return commonNullPrefix(context.nullable, expression, result);
    }
    return null;
  }
}

String _asContent(DartType type) {
  if (type.isDynamic || type.isObject) {
    return '';
  }

  if (coreIterableTypeChecker.isAssignableFromType(type)) {
    var itemType = coreIterableGenericType(type);
    if (itemType.isDynamic || itemType.isObject) {
      return ' as List';
    }
  }

  if (coreMapTypeChecker.isAssignableFromType(type)) {
    var args = typeArgumentsOf(type, coreMapTypeChecker);
    assert(args.length == 2);

    if (args.every((dt) => dt.isDynamic || dt.isObject)) {
      return ' as Map';
    }
  }

  return ' as $type';
}
