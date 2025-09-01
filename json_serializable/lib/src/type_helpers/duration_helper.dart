// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import 'package:source_helper/source_helper.dart';

import '../default_container.dart';
import '../type_helper.dart';

class DurationHelper extends TypeHelper {
  const DurationHelper();

  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
  ) {
    if (!_matchesType(targetType)) {
      return null;
    }

    final buffer = StringBuffer(expression);

    if (targetType.isNullableType) {
      buffer.write('?');
    }

    buffer.write('.inMicroseconds');

    return buffer.toString();
  }

  @override
  Object? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
    bool defaultProvided,
  ) {
    if (!_matchesType(targetType)) {
      return null;
    }

    return DefaultContainer(
      expression,
      'Duration(microseconds: $expression as int)',
    );
  }
}

bool _matchesType(DartType type) =>
    const TypeChecker.fromUrl('dart:core#Duration').isExactlyType(type);
