// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:json_annotation/json_annotation.dart';

import 'convert_pair.dart';
import 'helper_core.dart';
import 'json_serializable_generator.dart';
import 'type_helper.dart';
import 'type_helpers/convert_helper.dart';

TypeHelperContext typeHelperContext(
        HelperCore helperCore, FieldElement fieldElement, JsonKey key) =>
    _TypeHelperCtx(helperCore, fieldElement, key);

class _TypeHelperCtx
    implements TypeHelperContextWithConfig, TypeHelperContextWithConvert {
  final HelperCore _helperCore;
  final JsonKey _key;

  @override
  final FieldElement fieldElement;

  @override
  bool get nullable => _key.nullable;

  @override
  ClassElement get classElement => _helperCore.element;

  @override
  bool get useWrappers => _helperCore.generator.useWrappers;

  @override
  bool get anyMap => _helperCore.generator.anyMap;

  @override
  bool get explicitToJson => _helperCore.generator.explicitToJson;

  _TypeHelperCtx(this._helperCore, this.fieldElement, this._key);

  @override
  ConvertData get serializeConvertData => _pairFromContext?.toJson;

  @override
  ConvertData get deserializeConvertData => _pairFromContext?.fromJson;

  ConvertPair get _pairFromContext => ConvertPair.fromJsonKey(_key);

  @override
  void addMember(String memberContent) {
    _helperCore.addMember(memberContent);
  }

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
      allHelpersImpl(_helperCore.generator).map(invoke).firstWhere(
          (r) => r != null,
          orElse: () => throw UnsupportedTypeError(
              targetType, expression, _notSupportedWithTypeHelpersMsg));
}

final _notSupportedWithTypeHelpersMsg =
    'None of the provided `TypeHelper` instances support the defined type.';
