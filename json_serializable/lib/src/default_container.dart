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
      value = '$value ?? $defaultValue';
    }
    return value;
  }

  @override
  String toString() => deserialize(this).toString();
}
