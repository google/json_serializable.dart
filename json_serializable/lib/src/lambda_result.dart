// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'constants.dart';

class LambdaResult {
  final String expression;
  final String lambda;
  final String? asContent;

  String get _fullExpression => '$expression${asContent ?? ''}';

  LambdaResult(this.expression, this.lambda, {this.asContent});

  @override
  String toString() => '$lambda($_fullExpression)';

  static String process(Object subField) {
    return (subField is LambdaResult && closureArg == subField._fullExpression)
        ? subField.lambda
        : '($closureArg) => $subField';
  }
}
