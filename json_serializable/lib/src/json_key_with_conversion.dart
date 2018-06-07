// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/constant/value.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'json_literal_generator.dart';
import 'utils.dart';

final _jsonKeyChecker = const TypeChecker.fromRuntime(JsonKey);

JsonKeyWithConversion _from(
    FieldElement element, JsonSerializable classAnnotation) {
  // If an annotation exists on `element` the source is a 'real' field.
  // If the result is `null`, check the getter – it is a property.
  // TODO(kevmoo) setters: github.com/dart-lang/json_serializable/issues/24
  var obj = _jsonKeyChecker.firstAnnotationOfExact(element) ??
      _jsonKeyChecker.firstAnnotationOfExact(element.getter);

  if (obj == null) {
    return new JsonKeyWithConversion._(classAnnotation);
  }
  var fromJsonName = _getFunctionName(obj, element, true);
  var toJsonName = _getFunctionName(obj, element, false);

  Object _getLiteral(DartObject dartObject, Iterable<String> things) {
    if (dartObject.isNull) {
      return null;
    }

    var reader = new ConstantReader(dartObject);

    String badType;
    if (reader.isSymbol) {
      badType = 'Symbol';
    } else if (reader.isType) {
      badType = 'Type';
    } else if (dartObject.type is FunctionType) {
      // TODO(kevmoo): Support calling function for the default value?
      badType = 'Function';
    } else if (!reader.isLiteral) {
      badType = dartObject.type.name;
    }

    if (badType != null) {
      badType = things.followedBy([badType]).join(' > ');
      throwUnsupported(
          element, '`defaultValue` is `$badType`, it must be a literal.');
    }

    var literal = reader.literalValue;

    if (literal is num || literal is String || literal is bool) {
      return literal;
    } else if (literal is List<DartObject>) {
      return literal
          .map((e) => _getLiteral(e, things.followedBy(['List'])))
          .toList();
    } else if (literal is Map<DartObject, DartObject>) {
      var mapThings = things.followedBy(['Map']);
      return literal.map((k, v) =>
          new MapEntry(_getLiteral(k, mapThings), _getLiteral(v, mapThings)));
    }

    badType = things.followedBy(['$dartObject']).join(' > ');

    throwUnsupported(
        element,
        'The provided value is not supported: $badType. '
        'This may be an error in package:json_serializable. '
        'Please rerun your build with `--verbose` and file an issue.');
  }

  var defaultValueObject = obj.getField('defaultValue');

  Object defaultValueLiteral;
  if (isEnum(defaultValueObject.type)) {
    var interfaceType = defaultValueObject.type as InterfaceType;
    var allowedValues = interfaceType.element.fields
        .where((p) => !p.isSynthetic)
        .map((p) => p.name)
        .toList();
    var enumValueIndex = defaultValueObject.getField('index').toIntValue();
    defaultValueLiteral =
        '${interfaceType.name}.${allowedValues[enumValueIndex]}';
  } else {
    defaultValueLiteral = _getLiteral(defaultValueObject, []);
    if (defaultValueLiteral != null) {
      defaultValueLiteral = jsonLiteralAsDart(defaultValueLiteral, false);
    }
  }

  var disallowNullValue = obj.getField('disallowNullValue').toBoolValue();
  var includeIfNull = obj.getField('includeIfNull').toBoolValue();

  if (disallowNullValue == true) {
    if (includeIfNull == true) {
      throwUnsupported(
          element,
          'Cannot set both `disallowNullvalue` and `includeIfNull` to `true`. '
          'This leads to incompatible `toJson` and `fromJson` behavior.');
    }
  }

  return new JsonKeyWithConversion._(classAnnotation,
      name: obj.getField('name').toStringValue(),
      nullable: obj.getField('nullable').toBoolValue(),
      includeIfNull: includeIfNull,
      ignore: obj.getField('ignore').toBoolValue(),
      defaultValue: defaultValueLiteral,
      required: obj.getField('required').toBoolValue(),
      disallowNullValue: disallowNullValue,
      fromJsonData: fromJsonName,
      toJsonData: toJsonName);
}

class ConvertData {
  final String name;
  final DartType paramType;

  ConvertData._(this.name, this.paramType);
}

class JsonKeyWithConversion extends JsonKey {
  static final _jsonKeyExpando = new Expando<JsonKeyWithConversion>();

  final ConvertData fromJsonData;
  final ConvertData toJsonData;

  factory JsonKeyWithConversion(
          FieldElement element, JsonSerializable classAnnotation) =>
      _jsonKeyExpando[element] ??= _from(element, classAnnotation);

  JsonKeyWithConversion._(
    JsonSerializable classAnnotation, {
    String name,
    bool nullable,
    bool includeIfNull,
    bool ignore,
    Object defaultValue,
    bool required,
    bool disallowNullValue,
    this.fromJsonData,
    this.toJsonData,
  }) : super(
            name: name,
            nullable: nullable ?? classAnnotation.nullable,
            includeIfNull: _includeIfNull(includeIfNull, disallowNullValue,
                classAnnotation.includeIfNull),
            ignore: ignore ?? false,
            defaultValue: defaultValue,
            required: required ?? false,
            disallowNullValue: disallowNullValue ?? false) {
    assert(!this.includeIfNull || !this.disallowNullValue);
  }

  static bool _includeIfNull(bool keyIncludeIfNull, bool keyDisallowNullValue,
      bool classIncludeIfNull) {
    if (keyDisallowNullValue == true) {
      assert(keyIncludeIfNull != true);
      return false;
    }
    return keyIncludeIfNull ?? classIncludeIfNull;
  }
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
    throwUnsupported(
        element,
        'The function provided for `$paramName` must be top-level. '
        'Static class methods (`${type.element.name}`) are not supported.');
  }
  var functionElement = type.element as FunctionElement;

  if (functionElement.parameters.isEmpty ||
      functionElement.parameters.first.isNamed ||
      functionElement.parameters.where((pe) => !pe.isOptional).length > 1) {
    throwUnsupported(
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
      throwUnsupported(
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
      throwUnsupported(
          element,
          'The `$paramName` function `${functionElement.name}` argument type '
          '`$argType` is not compatible with field type'
          ' `${element.type}`.');
    }
  }
  return new ConvertData._(functionElement.name, argType);
}
