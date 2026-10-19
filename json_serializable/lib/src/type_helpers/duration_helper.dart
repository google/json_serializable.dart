// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import 'package:source_helper/source_helper.dart';

import '../default_container.dart';
import '../type_helper.dart';

class DurationHelper extends TypeHelper {
  const DurationHelper();

  @override
  Expression? serialize(
    DartType targetType,
    Expression expression,
    TypeHelperContext context,
  ) {
    if (!_matchesType(targetType)) {
      return null;
    }

    return targetType.isNullableType
        ? expression.nullSafeProperty('inMicroseconds')
        : expression.property('inMicroseconds');
  }

  @override
  DefaultContainer? deserialize(
    DartType targetType,
    Expression expression,
    TypeHelperContext context,
    bool defaultProvided,
  ) {
    if (!_matchesType(targetType)) {
      return null;
    }

    // Duration(microseconds: ($expression as num).toInt())
    final output = refer('Duration').newInstance([], {
      'microseconds': expression.asA(refer('num')).property('toInt').call([]),
    });

    return DefaultContainer(expression, output);
  }
}

bool _matchesType(DartType type) =>
    const TypeChecker.fromUrl('dart:core#Duration').isExactlyType(type);
