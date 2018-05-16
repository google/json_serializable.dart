// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'json_key_helpers.dart';
import 'json_serializable_generator.dart';
import 'type_helper.dart';

class TypeHelperContext implements SerializeContext, DeserializeContext {
  final JsonSerializableGenerator _generator;

  @override
  bool get useWrappers => _generator.useWrappers;

  @override
  final List<ElementAnnotation> metadata;

  @override
  final bool nullable;

  final ConvertData fromJsonData;
  final ConvertData toJsonData;

  // This is effectively private to TypeHelpers outside this package.
  // Consider exposing it if there is interest
  bool get anyMap => _generator.anyMap;

  TypeHelperContext(this._generator, this.metadata, this.nullable,
      this.fromJsonData, this.toJsonData);

  @override
  String serialize(DartType targetType, String expression) => _run(
      targetType,
      expression,
      (TypeHelper th) => th.serialize(targetType, expression, this));

  @override
  String deserialize(DartType targetType, String expression) => _run(
      targetType,
      expression,
      (TypeHelper th) => th.deserialize(targetType, expression, this));

  String _run(DartType targetType, String expression,
          String invoke(TypeHelper instance)) =>
      allHelpersImpl(_generator).map(invoke).firstWhere((r) => r != null,
          orElse: () => throw new UnsupportedTypeError(
              targetType, expression, _notSupportedWithTypeHelpersMsg));
}

final _notSupportedWithTypeHelpersMsg =
    'None of the provided `TypeHelper` instances support the defined type.';
