// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import 'constants.dart' show closureArg;
import 'shared_checkers.dart';
import 'utils.dart';

/// Represents a lambda that can be used as a tear-off depending on the context
/// in which it is used.
///
/// Allows generated code to support the
/// https://dart-lang.github.io/linter/lints/unnecessary_lambdas.html
/// lint.
class LambdaResult {
  final String expression;
  final String lambda;
  final DartType? asContent;

  String get _fullExpression =>
      asContent != null ? _cast(expression, asContent!) : expression;

  LambdaResult(this.expression, this.lambda, {this.asContent});

  @override
  String toString() => '$lambda($_fullExpression)';

  static String process(Object subField) =>
      (subField is LambdaResult && closureArg == subField._fullExpression)
          ? subField.lambda
          : '($closureArg) => $subField';
}

String _cast(String expression, DartType targetType) {
  if (targetType.isLikeDynamic) {
    return expression;
  }

  final nullableSuffix = targetType.isNullableType ? '?' : '';

  if (coreIterableTypeChecker.isAssignableFromType(targetType)) {
    final itemType = coreIterableGenericType(targetType);
    if (itemType.isLikeDynamic) {
      return '$expression as List$nullableSuffix';
    }
  }

  if (coreMapTypeChecker.isAssignableFromType(targetType)) {
    final args = targetType.typeArgumentsOf(coreMapTypeChecker)!;
    assert(args.length == 2);

    if (args.every((e) => e.isLikeDynamic)) {
      return '$expression as Map$nullableSuffix';
    }
  }

  final defaultDecodeValue = defaultDecodeLogic(targetType, expression);

  if (defaultDecodeValue != null) {
    return defaultDecodeValue;
  }

  final typeCode = typeToCode(targetType);
  return '$expression as $typeCode';
}
