// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import '../type_helper.dart';

Duration durationFromString(String d) {
  final split = d.split(':').map((v) => int.tryParse(v) ?? 0).toList();
  return Duration(
    days: split[0],
    hours: split[1],
    minutes: split[2],
    seconds: split[3],
    milliseconds: split[4],
    microseconds: split[5],
  );
}

class DurationHelper extends TypeHelper {
  const DurationHelper();

  @override
  String serialize(
      DartType targetType, String expression, TypeHelperContext context) {
    if (!_matchesType(targetType)) {
      return null;
    }

    final buffer = StringBuffer(expression);

    if (context.nullable) {
      buffer.write('?');
    }

    buffer.write('.toString()');

    return buffer.toString();
  }

  @override
  String deserialize(
      DartType targetType, String expression, TypeHelperContext context) {
    if (!_matchesType(targetType)) {
      return null;
    }

    return commonNullPrefix(
        context.nullable, expression, '\$parseDuration($expression as String)');
  }
}

bool _matchesType(DartType type) =>
    const TypeChecker.fromUrl('dart:core#Duration').isExactlyType(type);