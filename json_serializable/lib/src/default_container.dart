// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'lambda_result.dart';

/// Represents an expression that may be represented differently if there is
/// a default value available to replace it if `null`.
class DefaultContainer {
  final bool nullable;
  final String expression;
  final String output;

  DefaultContainer(this.nullable, this.expression, this.output);

  String _result([Object? defaultValue]) {
    if (defaultValue != null || nullable) {
      return '$expression == null ? $defaultValue : $output';
    }

    if (defaultValue == null) {
      return output;
    }
    return '$output ?? $defaultValue';
  }

  static String encode(Object input, {Object? defaultValue}) {
    if (input is DefaultContainer) {
      return input._result(defaultValue);
    }

    if (input is LambdaResult && defaultValue != null) {
      return '${input.expression} == null ? $defaultValue : $input';
    }

    var result = input.toString();

    if (defaultValue != null) {
      result = '$result ?? $defaultValue';
    }
    return result;
  }

  @override
  String toString() => _result();
}
