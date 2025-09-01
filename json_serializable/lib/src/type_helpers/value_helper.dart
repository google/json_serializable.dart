// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import '../shared_checkers.dart';
import '../type_helper.dart';
import '../utils.dart';

/// Handles the types corresponding to [simpleJsonTypeChecker], namely
/// [String], [bool], [num], [int], [double].
class ValueHelper extends TypeHelper {
  const ValueHelper();

  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
  ) {
    if (targetType.isDartCoreObject ||
        targetType is DynamicType ||
        simpleJsonTypeChecker.isAssignableFromType(targetType)) {
      return expression;
    }

    return null;
  }

  @override
  String? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
    bool defaultProvided,
  ) {
    if (targetType.isDartCoreObject && !targetType.isNullableType) {
      final question = defaultProvided ? '?' : '';
      return '$expression as Object$question';
    } else if (targetType.isDartCoreObject || targetType is DynamicType) {
      // just return it as-is. We'll hope it's safe.
      return expression;
    }
//  else if (targetType.isDartCoreDouble) {
//   final targetTypeNullable = defaultProvided || targetType.isNullableType;
//   final question = targetTypeNullable ? '?' : '';
//   return '($expression as num$question)$question.toDouble()';
// }
    else if (simpleJsonTypeChecker.isAssignableFromType(targetType)) {
      final typeCode = typeToCode(targetType, forceNullable: defaultProvided);
      switch (typeCode) {
        case 'int?':
          return 'double.tryParse($expression.toString())?.toInt()';
        case 'double?':
          return 'double.tryParse($expression.toString())';
        case 'String?':
          return '$expression?.toString()';
        case 'bool?':
          return 'bool.tryParse($expression.toString())';
        default:
          return '$expression as $typeCode';
      }
    }

    return null;
  }
}
