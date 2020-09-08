// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

import '../lambda_result.dart';
import '../type_helper.dart';

class GenericFactoryHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const GenericFactoryHelper();

  @override
  Object serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) =>
      deserialize(targetType, expression, context);

  @override
  Object deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) {
    if (targetType is TypeParameterType) {
      if (context.config.genericArgumentFactories) {
        return LambdaResult(expression, helperForType(targetType));
      }
    }

    return null;
  }
}

String helperForType(TypeParameterType type) =>
    helperForName(type.getDisplayString());

String helperForName(String genericType) => 'helperFor$genericType';
