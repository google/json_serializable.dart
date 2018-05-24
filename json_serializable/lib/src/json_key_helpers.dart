// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/constant/value.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart' show alwaysThrows;
import 'package:source_gen/source_gen.dart';

import 'json_literal_generator.dart';

@alwaysThrows
T _throwUnsupported<T>(FieldElement element, String message) =>
    throw new InvalidGenerationSourceError(
        'Error with `@JsonKey` on `${element.name}`. $message',
        element: element);

final _jsonKeyExpando = new Expando<JsonKeyWithConversion>();

final _jsonKeyChecker = const TypeChecker.fromRuntime(JsonKey);

JsonKeyWithConversion jsonKeyFor(FieldElement element) {
  var key = _jsonKeyExpando[element];

  if (key == null) {
    _jsonKeyExpando[element] = key = _from(element);
  }

  return key;
}

JsonKeyWithConversion _from(FieldElement element) {
  // If an annotation exists on `element` the source is a 'real' field.
  // If the result is `null`, check the getter – it is a property.
  // TODO(kevmoo) setters: github.com/dart-lang/json_serializable/issues/24
  var obj = _jsonKeyChecker.firstAnnotationOfExact(element) ??
      _jsonKeyChecker.firstAnnotationOfExact(element.getter);

  if (obj == null) {
    return const JsonKeyWithConversion._empty();
  }
  var fromJsonName = _getFunctionName(obj, element, true);
  var toJsonName = _getFunctionName(obj, element, false);

  Object _getLiteral(DartObject dartObject) {
    if (dartObject.isNull) {
      return null;
    }

    var reader = new ConstantReader(dartObject);

    if (reader.isSymbol) {
      _throwUnsupported(element,
          'Values of type `Symbol` are not supported for `defaultValue`.');
    } else if (reader.isType) {
      _throwUnsupported(element,
          'Values of type `Type` are not supported for `defaultValue`.');
    } else if (!reader.isLiteral) {
      _throwUnsupported(
          element, 'The provided `defaultValue` is not a literal: $dartObject');
    }

    var literal = reader.literalValue;
    if (literal is num || literal is String || literal is bool) {
      return literal;
    } else if (literal is List<DartObject>) {
      return literal.map(_getLiteral).toList();
    } else if (literal is Map<DartObject, DartObject>) {
      return literal
          .map((k, v) => new MapEntry(_getLiteral(k), _getLiteral(v)));
    }
    _throwUnsupported(
        element, 'The provided value is not supported: $dartObject');
  }

  var defaultValueLiteral = _getLiteral(obj.getField('defaultValue'));

  if (defaultValueLiteral != null) {
    defaultValueLiteral = jsonLiteralAsDart(defaultValueLiteral, false);
  }

  return new JsonKeyWithConversion._(
      obj.getField('name').toStringValue(),
      obj.getField('nullable').toBoolValue(),
      obj.getField('includeIfNull').toBoolValue(),
      obj.getField('ignore').toBoolValue(),
      defaultValueLiteral,
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
      bool ignore, Object defaultValue, this.fromJsonData, this.toJsonData)
      : super(
            name: name,
            nullable: nullable,
            includeIfNull: includeIfNull,
            ignore: ignore,
            defaultValue: defaultValue);
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

  if (functionElement.parameters.isEmpty ||
      functionElement.parameters.first.isNamed ||
      functionElement.parameters.where((pe) => !pe.isOptional).length > 1) {
    _throwUnsupported(
        element,
        'The `$paramName` function `${functionElement.name}` must have one '
        'positional paramater.');
  }

  var argType = functionElement.parameters.first.type;
  if (isFrom) {
    var returnType = functionElement.returnType;

    if (returnType is TypeParameterType) {
      // We keep things simple in this case. We rely on inferred type arguments
      // to the `fromJson` function.
      // TODO: consider adding error checking here if there is confusion.
    } else if (!returnType.isAssignableTo(element.type)) {
      _throwUnsupported(
          element,
          'The `$paramName` function `${functionElement.name}` return type '
          '`$returnType` is not compatible with field type `${element.type}`.');
    }
  } else {
    if (argType is TypeParameterType) {
      // We keep things simple in this case. We rely on inferred type arguments
      // to the `fromJson` function.
      // TODO: consider adding error checking here if there is confusion.
    } else if (!element.type.isAssignableTo(argType)) {
      _throwUnsupported(
          element,
          'The `$paramName` function `${functionElement.name}` argument type '
          '`$argType` is not compatible with field type'
          ' `${element.type}`.');
    }
  }
  return new ConvertData._(functionElement.name, argType);
}
