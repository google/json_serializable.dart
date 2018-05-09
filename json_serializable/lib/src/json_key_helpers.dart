// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/constant/value.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@alwaysThrows
T _throwUnsupported<T>(FieldElement element, String message) =>
    throw new InvalidGenerationSourceError(
        'Error with `@JsonKey` on `${element.displayName}`. $message',
        element: element);

final _jsonKeyExpando = new Expando<JsonKeyWithConversion>();

final _jsonKeyChecker = const TypeChecker.fromRuntime(JsonKey);

JsonKeyWithConversion jsonKeyFor(FieldElement element) {
  var key = _jsonKeyExpando[element];

  if (key == null) {
    // If an annotation exists on `element` the source is a 'real' field.
    // If the result is `null`, check the getter – it is a property.
    // TODO(kevmoo) setters: github.com/dart-lang/json_serializable/issues/24
    var obj = _jsonKeyChecker.firstAnnotationOfExact(element) ??
        _jsonKeyChecker.firstAnnotationOfExact(element.getter);

    _jsonKeyExpando[element] = key = _from(element, obj);
  }

  return key;
}

JsonKeyWithConversion _from(FieldElement element, DartObject obj) {
  if (obj == null) {
    return const JsonKeyWithConversion._empty();
  }
  var fromJsonName = _getFunctionName(obj, element, true);
  var toJsonName = _getFunctionName(obj, element, false);

  return new JsonKeyWithConversion._(
      obj.getField('name').toStringValue(),
      obj.getField('nullable').toBoolValue(),
      obj.getField('includeIfNull').toBoolValue(),
      obj.getField('ignore').toBoolValue(),
      fromJsonName,
      toJsonName);
}

class ConvertData {
  final String name;
  final DartType paramType;

  ConvertData._(this.name, this.paramType);
}

class JsonKeyWithConversion extends JsonKey {
  final ConvertData fromJsonData;
  final ConvertData toJsonData;

  const JsonKeyWithConversion._empty()
      : fromJsonData = null,
        toJsonData = null,
        super();

  JsonKeyWithConversion._(String name, bool nullable, bool includeIfNull,
      bool ignore, this.fromJsonData, this.toJsonData)
      : super(
            name: name,
            nullable: nullable,
            includeIfNull: includeIfNull,
            ignore: ignore);
}

ConvertData _getFunctionName(
    DartObject obj, FieldElement element, bool isFrom) {
  var paramName = isFrom ? 'fromJson' : 'toJson';
  var objectValue = obj.getField(paramName);

  if (objectValue.isNull) {
    return null;
  }

  var type = objectValue.type as FunctionType;

  if (type.element is MethodElement) {
    _throwUnsupported(
        element,
        'The function provided for `$paramName` must be top-level. '
        'Static class methods (`${type.element.name}`) are not supported.');
  }
  var functionElement = type.element as FunctionElement;

  var positionalParams = functionElement.parameters
      .where((pe) => pe.parameterKind == ParameterKind.REQUIRED)
      .toList();

  if (positionalParams.length != 1) {
    _throwUnsupported(
        element,
        'The `$paramName` function `${functionElement.name}` must have one '
        'positional paramater.');
  }

  if (isFrom) {
    var returnType = functionElement.returnType;
    if (!returnType.isAssignableTo(element.type)) {
      _throwUnsupported(
          element,
          'The `$paramName` function `${functionElement.name}` return type '
          '`$returnType` is not compatible with field type `${element.type}`.');
    }
  } else {
    var argType = positionalParams.single.type;
    if (!element.type.isAssignableTo(argType)) {
      _throwUnsupported(
          element,
          'The `$paramName` function `${functionElement.name}` argument type '
          '`$argType` is not compatible with field type'
          ' `${element.type}`.');
    }
  }
  return new ConvertData._(functionElement.name, positionalParams.single.type);
}
