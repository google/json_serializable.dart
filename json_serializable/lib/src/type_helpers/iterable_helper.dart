// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:source_gen/source_gen.dart' show TypeChecker;
import 'package:source_helper/source_helper.dart';

import '../constants.dart';
import '../lambda_result.dart';
import '../shared_checkers.dart';
import '../type_helper.dart';
import '../utils.dart';

class IterableHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const IterableHelper();

  @override
  Expression? serialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
  ) {
    if (!coreIterableTypeChecker.isAssignableFromType(targetType)) {
      return null;
    }

    final itemType = coreIterableGenericType(targetType);

    // This block will yield a regular list, which works fine for JSON
    // Although it's possible that child elements may be marked unsafe

    var isList = _coreListChecker.isAssignableFromType(targetType);
    final subField = context.serialize(itemType, refer(closureArg))!;
    final subFieldStr = toCodeString(subField);

    var optionalQuestion = targetType.isNullableType;

    var expr = expression;

    // In the case of trivial JSON types (int, String, etc), `subField`
    // will be identical to `substitute` – so no explicit mapping is needed.
    // If they are not equal, then we to write out the substitution.
    if (subFieldStr != closureArg) {
      final lambda = LambdaResult.process(subField);

      expr = optionalQuestion
          ? expr.nullSafeProperty('map').call([lambda])
          : expr.property('map').call([lambda]);

      // expression now represents an Iterable (even if it started as a List
      // ...resetting `isList` to `false`.
      isList = false;

      // No need to include the optional question below – it was used here!
      optionalQuestion = false;
    }

    if (!isList) {
      // If the static type is not a List, generate one.
      expr = optionalQuestion
          ? expr.nullSafeProperty('toList').call([])
          : expr.property('toList').call([]);
    }

    return expr;
  }

  @override
  Expression? deserialize(
    DartType targetType,
    Expression expression,
    TypeHelperContext context,
    bool defaultProvided,
  ) {
    if (!(coreIterableTypeChecker.isExactlyType(targetType) ||
        _coreListChecker.isExactlyType(targetType) ||
        _coreSetChecker.isExactlyType(targetType))) {
      return null;
    }

    final iterableGenericType = coreIterableGenericType(targetType);

    final itemSubVal = context.deserialize(
      iterableGenericType,
      refer(closureArg),
    )!;
    final itemSubValStr = toCodeString(itemSubVal);

    final targetTypeIsNullable = defaultProvided || targetType.isNullableType;
    final exprStr = toCodeString(expression);

    // If `itemSubVal` is the same and it's not a Set, then we don't need to do
    // anything fancy
    if (closureArg == itemSubValStr &&
        !_coreSetChecker.isExactlyType(targetType)) {
      final castType = 'List<dynamic>${targetTypeIsNullable ? '?' : ''}';
      // TODO: https://github.com/dart-lang/tools/issues/1140 - using CodeExpression
      // for unparenthesized argument cast.
      return CodeExpression(Code('$exprStr as $castType'));
    }

    final castType = refer('List<dynamic>${targetTypeIsNullable ? '?' : ''}');
    var output = expression.asA(castType);

    var optionalQuestion = targetTypeIsNullable;

    if (closureArg != itemSubValStr) {
      final lambda = LambdaResult.process(itemSubVal);
      output = optionalQuestion
          ? output.nullSafeProperty('map').call([lambda])
          : output.property('map').call([lambda]);
      // No need to include the optional question below – it was used here!
      optionalQuestion = false;
    }

    if (_coreListChecker.isExactlyType(targetType)) {
      output = optionalQuestion
          ? output.nullSafeProperty('toList').call([])
          : output.property('toList').call([]);
    } else if (_coreSetChecker.isExactlyType(targetType)) {
      output = optionalQuestion
          ? output.nullSafeProperty('toSet').call([])
          : output.property('toSet').call([]);
    }

    return output;
  }
}

const _coreListChecker = TypeChecker.fromUrl('dart:core#List');
const _coreSetChecker = TypeChecker.fromUrl('dart:core#Set');
