// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'lambda_result.dart';
import 'utils.dart';

/// Represents an expression that may be represented differently if there is
/// a default value available to replace it if `null`.
class DefaultContainer {
  final String expression;
  final Object output;

  DefaultContainer(this.expression, this.output);

  static Object deserialize(
    Object value, {
    bool nullable = false,
    String? defaultValue,
  }) {
    if (value is DefaultContainer) {
      if (defaultValue != null || nullable) {
        return ifNullOrElse(
          value.expression,
          defaultValue ?? 'null',
          value.output.toString(),
        );
      }
      value = value.output;
    }

    if (value is LambdaResult && defaultValue != null) {
      return ifNullOrElse(value.expression, defaultValue, value.toString());
    }

    if (defaultValue != null) {
      value = '$value ?? ${wrapDefaultValue(defaultValue)}';
    }
    return value;
  }

  static String wrapDefaultValue(String defaultValue) =>
      _isTopLevelConditional(defaultValue) ? '($defaultValue)' : defaultValue;

  @override
  String toString() => deserialize(this).toString();
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
