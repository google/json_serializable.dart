// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import '../type_helper.dart';

class UriHelper extends TypeHelper {
  const UriHelper();

  @override
  String serialize(
      DartType targetType, String expression, SerializeContext context) {
    if (!_matchesType(targetType)) {
      return null;
    }

    var buffer = new StringBuffer(expression);

    if (context.nullable) {
      buffer.write('?');
    }

    buffer.write('.toString()');

    return buffer.toString();
  }

  @override
  String deserialize(
      DartType targetType, String expression, DeserializeContext context) {
    if (!_matchesType(targetType)) {
      return null;
    }

    return commonNullPrefix(
        context.nullable, expression, 'Uri.parse($expression as String)');
  }
}

bool _matchesType(DartType type) =>
    const TypeChecker.fromUrl('dart:core#Uri').isExactlyType(type);
