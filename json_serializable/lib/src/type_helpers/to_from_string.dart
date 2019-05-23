// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

import '../type_helper.dart';

const bigIntString = ToFromStringHelper(
  'BigInt.parse',
  'toString()',
  TypeChecker.fromUrl('dart:core#BigInt'),
);

const dateTimeString = ToFromStringHelper(
  'DateTime.parse',
  'toIso8601String()',
  TypeChecker.fromUrl('dart:core#DateTime'),
);

const uriString = ToFromStringHelper(
  'Uri.parse',
  'toString()',
  TypeChecker.fromUrl('dart:core#Uri'),
);

/// Package-internal helper that unifies implementations of [Type]s that convert
/// trivially to-from [String].
class ToFromStringHelper {
  /// The function or constructor to call when creating the associated type.
  ///
  /// Assumed to have one parameter of type [String].
  ///
  /// Example: `MyClass.parse`
  final String _parse;

  /// Represents an invocation – property access or function call – on an
  /// instance of the target type that returns [String].
  ///
  /// Examples: `toString()` for a function or `stringValue` for a property.
  final String _toString;
  final TypeChecker _checker;

  const ToFromStringHelper(this._parse, this._toString, this._checker);

  bool matches(DartType type) => _checker.isExactlyType(type);

  String serialize(DartType type, String expression, bool nullable) {
    if (!matches(type)) {
      return null;
    }

    if (nullable) {
      expression = '$expression?';
    }

    return '$expression.$_toString';
  }

  String deserialize(
      DartType type, String expression, bool nullable, bool isString) {
    if (!matches(type)) {
      return null;
    }

    final parseParam = isString ? expression : '$expression as String';

    return commonNullPrefix(nullable, expression, '$_parse($parseParam)')
        .toString();
  }
}
