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
  final bool checkKeyPresence;

  DefaultContainer(
    this.expression,
    this.output, {
    this.checkKeyPresence = false,
  });

  @override
  R accept<R>(ExpressionVisitor<R> visitor, [R? context]) =>
      output.accept(visitor, context);

  static Expression deserialize(
    Expression value, {
    bool nullable = false,
    String? defaultValue,
  }) {
    if (value is DefaultContainer) {
      final exprStr = toCodeString(value.expression).trim();
      final indexMatch = RegExp(
        r'^json\s*\[\s*(.*?)\s*\]$',
        dotAll: true,
      ).firstMatch(exprStr);
      if (value.checkKeyPresence &&
          defaultValue != null &&
          indexMatch != null) {
        final keyExpr = indexMatch.group(1)!;
        return refer('json')
            .property('containsKey')
            .call([CodeExpression(Code(keyExpr))])
            .conditional(
              value.output.parenthesized,
              CodeExpression(Code(defaultValue)),
            );
      }
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
      return value.ifNullThen(
        CodeExpression(Code(wrapDefaultValue(defaultValue))),
      );
    }
    return value;
  }

  static String wrapDefaultValue(String defaultValue) =>
      _isTopLevelConditional(defaultValue) ? '($defaultValue)' : defaultValue;

  @override
  String toString() => toCodeString(deserialize(this));
}

final _stringLiteralPattern = RegExp(
  r'''r?('''
  "'''"
  r'''[\s\S]*?'''
  "'''"
  r'''|"""[\s\S]*?"""|'[^'\\]*(?:\\.[^'\\]*)*'|"[^"\\]*(?:\\.[^"\\]*)*")''',
);
final _bracketsPattern = RegExp(r'\([^()]*\)|\[[^\[\]]*\]|\{[^{}]*\}');

String _stripNestedAndStrings(String expression) {
  var current = expression.replaceAll(_stringLiteralPattern, '');
  while (true) {
    final next = current.replaceAll(_bracketsPattern, '');
    if (next == current) return current;
    current = next;
  }
}

bool _isTopLevelConditional(String expression) {
  final topLevel = _stripNestedAndStrings(expression);
  return topLevel.contains('?') && topLevel.contains(':');
}
