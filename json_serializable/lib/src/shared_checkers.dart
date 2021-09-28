// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import 'package:source_helper/source_helper.dart';

import 'utils.dart';

/// A [TypeChecker] for [Iterable].
const coreIterableTypeChecker = TypeChecker.fromUrl('dart:core#Iterable');

const coreStringTypeChecker = TypeChecker.fromUrl('dart:core#String');

const coreMapTypeChecker = TypeChecker.fromUrl('dart:core#Map');

/// Returns the generic type of the [Iterable] represented by [type].
///
/// If [type] does not extend [Iterable], an error is thrown.
DartType coreIterableGenericType(DartType type) =>
    type.typeArgumentsOf(coreIterableTypeChecker)!.single;

/// A [TypeChecker] for [String], [bool] and [num].
const simpleJsonTypeChecker = TypeChecker.any([
  coreStringTypeChecker,
  TypeChecker.fromUrl('dart:core#bool'),
  TypeChecker.fromUrl('dart:core#num')
]);

String asStatement(DartType type) {
  if (type.isLikeDynamic) {
    return '';
  }

  final nullableSuffix = type.isNullableType ? '?' : '';

  if (coreIterableTypeChecker.isAssignableFromType(type)) {
    final itemType = coreIterableGenericType(type);
    if (itemType.isLikeDynamic) {
      return ' as List$nullableSuffix';
    }
  }

  if (coreMapTypeChecker.isAssignableFromType(type)) {
    final args = type.typeArgumentsOf(coreMapTypeChecker)!;
    assert(args.length == 2);

    if (args.every((e) => e.isLikeDynamic)) {
      return ' as Map$nullableSuffix';
    }
  }

  final typeCode = typeToCode(type);
  return ' as $typeCode';
}
