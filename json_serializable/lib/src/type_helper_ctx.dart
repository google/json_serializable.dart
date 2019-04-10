// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:json_annotation/json_annotation.dart';

import 'helper_core.dart';
import 'type_helper.dart';
import 'type_helpers/convert_helper.dart';
import 'utils.dart';

TypeHelperCtx typeHelperContext(
        HelperCore helperCore, FieldElement fieldElement, JsonKey key) =>
    TypeHelperCtx._(helperCore, fieldElement, key);

class TypeHelperCtx
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
  JsonSerializable get config => _helperCore.config;

  TypeHelperCtx._(this._helperCore, this.fieldElement, this._key);

  @override
  ConvertData get serializeConvertData => _pairFromContext?.toJson;

  @override
  ConvertData get deserializeConvertData => _pairFromContext?.fromJson;

  _ConvertPair get _pairFromContext => _ConvertPair(fieldElement);

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
      _helperCore.allTypeHelpers.map(invoke).firstWhere((r) => r != null,
          orElse: () => throw UnsupportedTypeError(
              targetType, expression, _notSupportedWithTypeHelpersMsg));
}

final _notSupportedWithTypeHelpersMsg =
    'None of the provided `TypeHelper` instances support the defined type.';

class _ConvertPair {
  static final _expando = Expando<_ConvertPair>();

  static _ConvertPair fromJsonKey(JsonKey key) => _expando[key];

  final ConvertData fromJson, toJson;

  _ConvertPair._(this.fromJson, this.toJson);

  factory _ConvertPair(FieldElement element) {
    var pair = _expando[element];

    if (pair == null) {
      final obj = jsonKeyAnnotation(element);
      if (obj == null) {
        pair = _ConvertPair._(null, null);
      } else {
        final toJson = _convertData(obj, element, false);
        final fromJson = _convertData(obj, element, true);
        pair = _ConvertPair._(fromJson, toJson);
      }
      _expando[element] = pair;
    }
    return pair;
  }
}

ConvertData _convertData(DartObject obj, FieldElement element, bool isFrom) {
  final paramName = isFrom ? 'fromJson' : 'toJson';
  final objectValue = obj.getField(paramName);

  if (objectValue.isNull) {
    return null;
  }

  final type = objectValue.type as FunctionType;

  final executableElement = type.element as ExecutableElement;

  if (executableElement.parameters.isEmpty ||
      executableElement.parameters.first.isNamed ||
      executableElement.parameters.where((pe) => !pe.isOptional).length > 1) {
    throwUnsupported(
        element,
        'The `$paramName` function `${executableElement.name}` must have one '
        'positional paramater.');
  }

  final argType = executableElement.parameters.first.type;
  if (isFrom) {
    final returnType = executableElement.returnType;

    if (returnType is TypeParameterType) {
      // We keep things simple in this case. We rely on inferred type arguments
      // to the `fromJson` function.
      // TODO: consider adding error checking here if there is confusion.
    } else if (!returnType.isAssignableTo(element.type)) {
      throwUnsupported(
          element,
          'The `$paramName` function `${executableElement.name}` return type '
          '`$returnType` is not compatible with field type `${element.type}`.');
    }
  } else {
    if (argType is TypeParameterType) {
      // We keep things simple in this case. We rely on inferred type arguments
      // to the `fromJson` function.
      // TODO: consider adding error checking here if there is confusion.
    } else if (!element.type.isAssignableTo(argType)) {
      throwUnsupported(
          element,
          'The `$paramName` function `${executableElement.name}` argument type '
          '`$argType` is not compatible with field type'
          ' `${element.type}`.');
    }
  }

  var name = executableElement.name;

  if (executableElement is MethodElement) {
    name = '${executableElement.enclosingElement.name}.$name';
  }

  return ConvertData(name, argType);
}
