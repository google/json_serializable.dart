// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;

/// A [TypeChecker] for [Iterable].
const coreIterableTypeChecker = const TypeChecker.fromUrl('dart:core#Iterable');

const coreStringTypeChecker = const TypeChecker.fromRuntime(String);

const coreMapTypeChecker = const TypeChecker.fromUrl('dart:core#Map');

/// Returns the generic type of the [Iterable] represented by [type].
///
/// If [type] does not extend [Iterable], an error is thrown.
DartType coreIterableGenericType(DartType type) =>
    typeArgumentsOf(type, coreIterableTypeChecker).single;

/// If [type] is the [Type] or implements the [Type] represented by [checker],
/// returns the generic arguments to the [checker] [Type] if there are any.
///
/// If the [checker] [Type] doesn't have generic arguments, `null` is returned.
List<DartType> typeArgumentsOf(DartType type, TypeChecker checker) {
  var implementation = _getImplementationType(type, checker) as InterfaceType;

  return implementation?.typeArguments;
}

/// A [TypeChecker] for [String], [bool] and [num].
const simpleJsonTypeChecker = const TypeChecker.any(const [
  coreStringTypeChecker,
  const TypeChecker.fromRuntime(bool),
  const TypeChecker.fromRuntime(num)
]);

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
