// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

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
  ) =>
      defaultDecodeLogic(targetType, expression,
          defaultProvided: defaultProvided);
}
