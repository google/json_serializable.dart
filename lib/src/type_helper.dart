// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;

/// If [type] is the [Type] or implements the [Type] represented by [checker],
/// returns the generic arguments to the [checker] [Type] if there are any.
///
/// If the [checker] [Type] doesn't have generic arguments, `null` is returned.
List<DartType> typeArgumentsOf(DartType type, TypeChecker checker) {
  var implementation = _getImplementationType(type, checker) as InterfaceType;

  return implementation?.typeArguments;
}

typedef String TypeHelperGenerator(
    DartType fieldType, String expression, bool nullable);

abstract class TypeHelper {
  const TypeHelper();

  /// Returns Dart code that serializes an [expression] representing a Dart
  /// object of type [targetType].
  ///
  /// If [targetType] is not supported, returns `null`.
  ///
  /// Let's say you want to serialize a class `Foo` as just its `id` property
  /// of type `int`.
  ///
  /// Treating [expression] as a opaque Dart expression, the [serialize]
  /// implementation could be a simple as:
  ///
  /// ```dart
  /// String serialize(DartType targetType, String expression) =>
  ///   "$expression.id";
  /// ```.
  // TODO(kevmoo) – document `serializeNested`
  String serialize(DartType targetType, String expression, bool nullable,
      TypeHelperGenerator serializeNested);

  /// Returns Dart code that deserializes an [expression] representing a JSON
  /// literal to into [targetType].
  ///
  /// If [targetType] is not supported, returns `null`.
  ///
  /// Let's say you want to deserialize a class `Foo` by taking an `int` stored
  /// in a JSON literal and calling the `Foo.fromInt` constructor.
  ///
  /// Treating [expression] as a opaque Dart expression representing a JSON
  /// literal, the [deserialize] implementation could be a simple as:
  ///
  /// ```dart
  /// String deserialize(DartType targetType, String expression) =>
  ///   "new Foo.fromInt($expression)";
  /// ```.
  ///
  /// Note that [targetType] is not used here. If you wanted to support many
  /// types of [targetType] you could write:
  ///
  /// ```dart
  /// String deserialize(DartType targetType, String expression) =>
  ///   "new ${targetType.name}.fromInt($expression)";
  /// ```.
  // TODO(kevmoo) – document `deserializeNested`
  String deserialize(DartType targetType, String expression, bool nullable,
      TypeHelperGenerator deserializeNested);
}

/// A [TypeChecker] for [String], [bool] and [num].
const simpleJsonTypeChecker = const TypeChecker.any(const [
  const TypeChecker.fromRuntime(String),
  const TypeChecker.fromRuntime(bool),
  const TypeChecker.fromRuntime(num)
]);

class UnsupportedTypeError extends Error {
  final String expression;
  final DartType type;

  UnsupportedTypeError(this.type, this.expression);
}

DartType _getImplementationType(DartType type, TypeChecker checker) {
  if (checker.isExactlyType(type)) return type;

  if (type is InterfaceType) {
    var match = [type.interfaces, type.mixins]
        .expand((e) => e)
        .map((type) => _getImplementationType(type, checker))
        .firstWhere((value) => value != null, orElse: () => null);

    if (match != null) {
      return match;
    }

    if (type.superclass != null) {
      return _getImplementationType(type.superclass, checker);
    }
  }
  return null;
}
