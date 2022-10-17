// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import '../lambda_result.dart';
import '../shared_checkers.dart';
import '../type_helper.dart';

/// Information used by [ConvertHelper] when handling `JsonKey`-annotated
/// fields with `toJson` or `fromJson` values set.
class ConvertData {
  final String name;
  final DartType paramType;
  final DartType returnType;

  ConvertData(this.name, this.paramType, this.returnType);
}

abstract class TypeHelperContextWithConvert extends TypeHelperContext {
  ConvertData? get serializeConvertData;

  ConvertData? get deserializeConvertData;
}

/// Handles `JsonKey`-annotated fields with `toJson` or `fromJson` values set.
class ConvertHelper extends TypeHelper<TypeHelperContextWithConvert> {
  const ConvertHelper();

  @override
  Object? serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConvert context,
  ) {
    final toJsonData = context.serializeConvertData;
    if (toJsonData == null) {
      return null;
    }

    assert(toJsonData.paramType is TypeParameterType ||
        targetType.isAssignableTo(toJsonData.paramType));
    return LambdaResult(expression, toJsonData.name);
  }

  @override
  Object? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConvert context,
    bool defaultProvided,
  ) {
    final fromJsonData = context.deserializeConvertData;
    if (fromJsonData == null) {
      return null;
    }

    final asContent = asStatement(fromJsonData.paramType);
    return LambdaResult(expression, fromJsonData.name, asContent: asContent);
  }
}
