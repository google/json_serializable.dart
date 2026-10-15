// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';

import 'lambda_result.dart';
import 'utils.dart';

/// Represents an expression that may be represented differently if there is
/// a default value available to replace it if `null`.
class DefaultContainer extends Expression {
  @override
  final Expression expression;
  final Expression output;

  DefaultContainer(this.expression, this.output);

  @override
  R accept<R>(ExpressionVisitor<R> visitor, [R? context]) =>
      output.accept(visitor, context);

  static Expression deserialize(
    Expression value, {
    bool nullable = false,
    String? defaultValue,
  }) {
    if (value is DefaultContainer) {
      if (defaultValue != null || nullable) {
        final ifNull = defaultValue != null
            ? CodeExpression(Code(defaultValue))
            : literalNull;
        return value.expression
            .equalTo(literalNull)
            .conditional(ifNull, value.output);
      }
      value = value.output;
    }

    if (value is LambdaResult && defaultValue != null) {
      return value.expression
          .equalTo(literalNull)
          .conditional(CodeExpression(Code(defaultValue)), value.asInvocation);
    }

    if (defaultValue != null) {
      return value.ifNullThen(CodeExpression(Code(defaultValue)));
    }
    return value;
  }

  @override
  String toString() => toCodeString(deserialize(this));
}
