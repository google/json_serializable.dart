// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../shared_checkers.dart';
import '../type_helper.dart';
import '../type_helper_context.dart';

/// A [TypeHelper] that supports classes annotated with implementations of
/// [JsonConverter].
class JsonConverterHelper extends TypeHelper {
  const JsonConverterHelper();

  @override
  LambdaResult serialize(
      DartType targetType, String expression, SerializeContext context) {
    var converter = _typeConverter(targetType, context as TypeHelperContext);

    if (converter == null) {
      return null;
    }

    return LambdaResult(expression, '${converter.accessString}.toJson');
  }

  @override
  Object deserialize(
      DartType targetType, String expression, DeserializeContext context) {
    var converter = _typeConverter(targetType, context as TypeHelperContext);
    if (converter == null) {
      return null;
    }

    var asContent = asStatement(converter.jsonType);

    return LambdaResult(
        '$expression$asContent', '${converter.accessString}.fromJson');
  }
}

class _JsonConvertData {
  final String accessString;
  final DartType jsonType;

  _JsonConvertData.className(String className, String accessor, this.jsonType)
      : this.accessString = 'const $className${_withAccessor(accessor)}()';

  _JsonConvertData.genericClass(
      String className, String genericTypeArg, String accessor, this.jsonType)
      : this.accessString =
            '$className<$genericTypeArg>${_withAccessor(accessor)}()';

  _JsonConvertData.propertyAccess(this.accessString, this.jsonType);

  static String _withAccessor(String accessor) =>
      accessor.isEmpty ? '' : '.$accessor';
}

_JsonConvertData _typeConverter(DartType targetType, TypeHelperContext ctx) {
  var matchingAnnotations = ctx.classElement.metadata
      .map((annotation) => _compatibleMatch(targetType, annotation))
      .where((dt) => dt != null)
      .toList();

  if (matchingAnnotations.isEmpty) {
    return null;
  }

  if (matchingAnnotations.length > 1) {
    throw InvalidGenerationSourceError(
        'Found more than one matching converter for `$targetType`.',
        element: matchingAnnotations[1].elementAnnotation.element);
  }

  var match = matchingAnnotations.single;

  var annotationElement = match.elementAnnotation.element;
  if (annotationElement is PropertyAccessorElement) {
    var enclosing = annotationElement.enclosingElement;

    var accessString = annotationElement.name;

    if (enclosing is ClassElement) {
      accessString = '${enclosing.name}.$accessString';
    }

    return _JsonConvertData.propertyAccess(accessString, match.jsonType);
  }

  var reviver = ConstantReader(match.annotation).revive();

  if (reviver.namedArguments.isNotEmpty ||
      reviver.positionalArguments.isNotEmpty) {
    throw InvalidGenerationSourceError(
        'Generators with constructor arguments are not supported.',
        element: match.elementAnnotation.element);
  }

  if (match.genericTypeArg != null) {
    return _JsonConvertData.genericClass(match.annotation.type.name,
        match.genericTypeArg, reviver.accessor, match.jsonType);
  }

  return _JsonConvertData.className(
      match.annotation.type.name, reviver.accessor, match.jsonType);
}

class _ConverterMatch {
  final DartObject annotation;
  final DartType jsonType;
  final ElementAnnotation elementAnnotation;
  final String genericTypeArg;

  _ConverterMatch(this.elementAnnotation, this.annotation, this.jsonType,
      this.genericTypeArg);
}

_ConverterMatch _compatibleMatch(
    DartType targetType, ElementAnnotation annotation) {
  var constantValue = annotation.computeConstantValue();

  var converterClassElement = constantValue.type.element as ClassElement;

  var jsonConverterSuper = converterClassElement.allSupertypes.singleWhere(
      (e) => e is InterfaceType && _jsonConverterChecker.isExactly(e.element),
      orElse: () => null);

  if (jsonConverterSuper == null) {
    return null;
  }

  assert(jsonConverterSuper.typeParameters.length == 2);
  assert(jsonConverterSuper.typeArguments.length == 2);

  var fieldType = jsonConverterSuper.typeArguments[0];

  if (fieldType.isEquivalentTo(targetType)) {
    return _ConverterMatch(
        annotation, constantValue, jsonConverterSuper.typeArguments[1], null);
  }

  if (fieldType is TypeParameterType && targetType is TypeParameterType) {
    assert(annotation.element is! PropertyAccessorElement);
    assert(converterClassElement.typeParameters.isNotEmpty);
    if (converterClassElement.typeParameters.length > 1) {
      throw InvalidGenerationSourceError(
          '`JsonConverter` implementations can have no more than one type '
          'argument. `${converterClassElement.name}` has '
          '${converterClassElement.typeParameters.length}.',
          element: converterClassElement);
    }

    return _ConverterMatch(annotation, constantValue,
        jsonConverterSuper.typeArguments[1], targetType.name);
  }

  return null;
}

const _jsonConverterChecker = TypeChecker.fromRuntime(JsonConverter);
