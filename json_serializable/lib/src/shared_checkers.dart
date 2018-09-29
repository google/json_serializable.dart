// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;

/// A [TypeChecker] for [Iterable].
const coreIterableTypeChecker = TypeChecker.fromUrl('dart:core#Iterable');

const coreStringTypeChecker = TypeChecker.fromRuntime(String);

const coreMapTypeChecker = TypeChecker.fromUrl('dart:core#Map');

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
  final implementation = _getImplementationType(type, checker) as InterfaceType;

  return implementation?.typeArguments;
}

/// A [TypeChecker] for [String], [bool] and [num].
const simpleJsonTypeChecker = TypeChecker.any([
  coreStringTypeChecker,
  TypeChecker.fromRuntime(bool),
  TypeChecker.fromRuntime(num)
]);

String asStatement(DartType type) {
  if (type.isDynamic || type.isObject) {
    return '';
  }

  if (coreIterableTypeChecker.isAssignableFromType(type)) {
    final itemType = coreIterableGenericType(type);
    if (itemType.isDynamic || itemType.isObject) {
      return ' as List';
    }
  }

  if (coreMapTypeChecker.isAssignableFromType(type)) {
    final args = typeArgumentsOf(type, coreMapTypeChecker);
    assert(args.length == 2);

    if (args.every((dt) => dt.isDynamic || dt.isObject)) {
      return ' as Map';
    }
  }

  return ' as $type';
}

/// Returns all of the [DartType] types that [type] implements, mixes-in, and
/// extends, starting with [type] itself.
Iterable<DartType> typeImplementations(DartType type) sync* {
  yield type;

  if (type is InterfaceType) {
    yield* type.interfaces.expand(typeImplementations);
    yield* type.mixins.expand(typeImplementations);

    if (type.superclass != null) {
      yield* typeImplementations(type.superclass);
    }
  }
}

DartType _getImplementationType(DartType type, TypeChecker checker) =>
    typeImplementations(type)
        .firstWhere(checker.isExactlyType, orElse: () => null);
