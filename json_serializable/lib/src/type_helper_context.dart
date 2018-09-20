// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'helper_core.dart';
import 'json_key_with_conversion.dart';
import 'json_serializable_generator.dart';
import 'type_helper.dart';

class TypeHelperContext implements SerializeContext, DeserializeContext {
  final HelperCore _helperCore;

  @override
  final List<ElementAnnotation> metadata;

  final JsonKeyWithConversion _key;

  @override
  bool get useWrappers => _helperCore.generator.useWrappers;

  bool get anyMap => _helperCore.generator.anyMap;

  bool get explicitToJson => _helperCore.generator.explicitToJson;

  ClassElement get classElement => _helperCore.element;

  @override
  bool get nullable => _key.nullable;

  ConvertData get fromJsonData => _key.fromJsonData;
  ConvertData get toJsonData => _key.toJsonData;

  TypeHelperContext(this._helperCore, this.metadata, this._key);

  @override
  void addMember(String memberContent) {
    _helperCore.addMember(memberContent);
  }

  @override
  Object serialize(DartType targetType, String expression) => _run(
      targetType,
      expression,
      (TypeHelper th) => th.serialize(targetType, expression, this));

  @override
  Object deserialize(DartType targetType, String expression) => _run(
      targetType,
      expression,
      (TypeHelper th) => th.deserialize(targetType, expression, this));

  Object _run(DartType targetType, String expression,
          Object invoke(TypeHelper instance)) =>
      allHelpersImpl(_helperCore.generator).map(invoke).firstWhere(
          (r) => r != null,
          orElse: () => throw UnsupportedTypeError(
              targetType, expression, _notSupportedWithTypeHelpersMsg));
}

final _notSupportedWithTypeHelpersMsg =
    'None of the provided `TypeHelper` instances support the defined type.';
