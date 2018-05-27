// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'json_key_with_conversion.dart';
import 'json_serializable_generator.dart';
import 'type_helper.dart';

class TypeHelperContext implements SerializeContext, DeserializeContext {
  @override
  final List<ElementAnnotation> metadata;

  final JsonSerializableGenerator _generator;
  final JsonKeyWithConversion _key;

  @override
  bool get useWrappers => _generator.useWrappers;

  bool get anyMap => _generator.anyMap;

  bool get explicitToJson => _generator.explicitToJson;

  @override
  bool get nullable => _key.nullable;

  ConvertData get fromJsonData => _key.fromJsonData;
  ConvertData get toJsonData => _key.toJsonData;

  TypeHelperContext(this._generator, this.metadata, this._key);

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
