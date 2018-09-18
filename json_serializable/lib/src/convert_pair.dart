// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:json_annotation/json_annotation.dart';

import 'type_helpers/convert_helper.dart';
import 'utils.dart';

class ConvertPair {
  static final _expando = Expando<ConvertPair>();
  static ConvertPair fromJsonKey(JsonKey key) => _expando[key];

  final ConvertData fromJson, toJson;

  ConvertPair._(this.fromJson, this.toJson);

  factory ConvertPair(DartObject obj, FieldElement element) {
    var toJson = _convertData(obj, element, false);
    var fromJson = _convertData(obj, element, true);

    return ConvertPair._(fromJson, toJson);
  }

  void populate(JsonKey key) {
    _expando[key] = this;
  }
}

ConvertData _convertData(
    DartObject obj, FieldElement element, bool isFrom) {
  var paramName = isFrom ? 'fromJson' : 'toJson';
  var objectValue = obj.getField(paramName);

  if (objectValue.isNull) {
    return null;
  }

  var type = objectValue.type as FunctionType;

  var executableElement = type.element as ExecutableElement;

  if (executableElement.parameters.isEmpty ||
      executableElement.parameters.first.isNamed ||
      executableElement.parameters.where((pe) => !pe.isOptional).length > 1) {
    throwUnsupported(
        element,
        'The `$paramName` function `${executableElement.name}` must have one '
        'positional paramater.');
  }

  var argType = executableElement.parameters.first.type;
  if (isFrom) {
    var returnType = executableElement.returnType;

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
