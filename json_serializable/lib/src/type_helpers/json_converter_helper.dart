// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../lambda_result.dart';
import '../type_helper.dart';
import '../utils.dart';

/// A [TypeHelper] that supports classes annotated with implementations of
/// [JsonConverter].
class JsonConverterHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const JsonConverterHelper();

  @override
  Object? serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) {
    final converter = _typeConverter(targetType, context);

    if (converter == null) {
      return null;
    }

    if (!converter.fieldType.isNullableType && targetType.isNullableType) {
      const converterToJsonName = r'_$JsonConverterToJson';
      context.addMember('''
Json? $converterToJsonName<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => ${ifNullOrElse('value', 'null', 'toJson(value)')};
''');

      return _nullableJsonConverterLambdaResult(
        converter,
        name: converterToJsonName,
        targetType: targetType,
        expression: expression,
        callback: '${converter.accessString}.toJson',
      );
    }

    return LambdaResult(expression, '${converter.accessString}.toJson');
  }

  @override
  Object? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    final converter = _typeConverter(targetType, context);
    if (converter == null) {
      return null;
    }

    if (!converter.jsonType.isNullableType && targetType.isNullableType) {
      const converterFromJsonName = r'_$JsonConverterFromJson';
      context.addMember('''
Value? $converterFromJsonName<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => ${ifNullOrElse('json', 'null', 'fromJson(json as Json)')};
''');

      return _nullableJsonConverterLambdaResult(
        converter,
        name: converterFromJsonName,
        targetType: targetType,
        expression: expression,
        callback: '${converter.accessString}.fromJson',
      );
    }

    return LambdaResult(
      expression,
      '${converter.accessString}.fromJson',
      asContent: converter.jsonType,
    );
  }
}

String _nullableJsonConverterLambdaResult(
  _JsonConvertData converter, {
  required String name,
  required DartType targetType,
  required String expression,
  required String callback,
}) {
  final jsonDisplayString = typeToCode(converter.jsonType);
  final fieldTypeDisplayString = converter.isGeneric
      ? typeToCode(targetType)
      : typeToCode(converter.fieldType);

  return '$name<$jsonDisplayString, $fieldTypeDisplayString>('
      '$expression, $callback)';
}

class _JsonConvertData {
  final String accessString;
  final DartType jsonType;
  final DartType fieldType;
  final bool isGeneric;

  _JsonConvertData.className(
    String className,
    String accessor,
    this.jsonType,
    this.fieldType,
  ) : accessString = 'const $className${_withAccessor(accessor)}()',
      isGeneric = false;

  _JsonConvertData.genericClass(
    String className,
    String genericTypeArg,
    String accessor,
    this.jsonType,
    this.fieldType,
  ) : accessString = '$className<$genericTypeArg>${_withAccessor(accessor)}()',
      isGeneric = true;

  _JsonConvertData.propertyAccess(
    this.accessString,
    this.jsonType,
    this.fieldType,
  ) : isGeneric = false;

  static String _withAccessor(String accessor) =>
      accessor.isEmpty ? '' : '.$accessor';
}

/// If there is no converter for the params, return `null`.
///
/// Otherwise, returns `true` if the converter has a null return value.
///
/// Used to make sure we create a smart encoding function.
bool? hasConverterNullEncode(
  DartType targetType,
  TypeHelperContextWithConfig ctx,
) {
  final data = _typeConverter(targetType, ctx);

  if (data == null) {
    return null;
  }

  return data.jsonType.isNullableType;
}

_JsonConvertData? _typeConverter(
  DartType targetType,
  TypeHelperContextWithConfig ctx,
) {
  List<_ConverterMatch> converterMatches(List<ElementAnnotation> items) => items
      .map(
        (annotation) => _compatibleMatch(
          targetType,
          annotation,
          annotation.computeConstantValue()!,
        ),
      )
      .whereType<_ConverterMatch>()
      .toList();

  var matchingAnnotations = converterMatches(
    ctx.fieldElement.getter2?.metadata2.annotations ?? [],
  );

  if (matchingAnnotations.isEmpty) {
    matchingAnnotations = converterMatches(
      ctx.fieldElement.metadata2.annotations,
    );

    if (matchingAnnotations.isEmpty) {
      matchingAnnotations = converterMatches(
        ctx.classElement.metadata2.annotations,
      );

      if (matchingAnnotations.isEmpty) {
        matchingAnnotations = ctx.config.converters
            .map((e) => _compatibleMatch(targetType, null, e))
            .whereType<_ConverterMatch>()
            .toList();
      }
    }
  }

  return _typeConverterFrom(matchingAnnotations, targetType);
}

_JsonConvertData? _typeConverterFrom(
  List<_ConverterMatch> matchingAnnotations,
  DartType targetType,
) {
  if (matchingAnnotations.isEmpty) {
    return null;
  }

  if (matchingAnnotations.length > 1) {
    final targetTypeCode = typeToCode(targetType);
    throw InvalidGenerationSourceError(
      'Found more than one matching converter for `$targetTypeCode`.',
      element: matchingAnnotations[1].elementAnnotation?.element2,
    );
  }

  final match = matchingAnnotations.single;

  final annotationElement = match.elementAnnotation?.element2;
  if (annotationElement is PropertyAccessorElement2) {
    final enclosing = annotationElement.enclosingElement2;

    var accessString = annotationElement.name3!;

    if (enclosing is ClassElement2) {
      accessString = '${enclosing.name3}.$accessString';
    }

    return _JsonConvertData.propertyAccess(
      accessString,
      match.jsonType,
      match.fieldType,
    );
  }

  final reviver = ConstantReader(match.annotation).revive();

  if (reviver.namedArguments.isNotEmpty ||
      reviver.positionalArguments.isNotEmpty) {
    throw InvalidGenerationSourceError(
      'Generators with constructor arguments are not supported.',
      element: match.elementAnnotation?.element2,
    );
  }

  if (match.genericTypeArg != null) {
    return _JsonConvertData.genericClass(
      match.annotation.type!.element3!.name3!,
      match.genericTypeArg!,
      reviver.accessor,
      match.jsonType,
      match.fieldType,
    );
  }

  return _JsonConvertData.className(
    match.annotation.type!.element3!.name3!,
    reviver.accessor,
    match.jsonType,
    match.fieldType,
  );
}

class _ConverterMatch {
  final DartObject annotation;
  final DartType fieldType;
  final DartType jsonType;
  final ElementAnnotation? elementAnnotation;
  final String? genericTypeArg;

  _ConverterMatch(
    this.elementAnnotation,
    this.annotation,
    this.jsonType,
    this.genericTypeArg,
    this.fieldType,
  );
}

_ConverterMatch? _compatibleMatch(
  DartType targetType,
  ElementAnnotation? annotation,
  DartObject constantValue,
) {
  final converterClassElement = constantValue.type!.element3 as ClassElement2;

  final jsonConverterSuper = converterClassElement.allSupertypes
      .where((e) => _jsonConverterChecker.isExactly(e.element3))
      .singleOrNull;

  if (jsonConverterSuper == null) {
    return null;
  }

  assert(jsonConverterSuper.element3.typeParameters2.length == 2);
  assert(jsonConverterSuper.typeArguments.length == 2);

  final fieldType = jsonConverterSuper.typeArguments[0];

  // Allow assigning T to T?
  if (fieldType == targetType || fieldType == targetType.promoteNonNullable()) {
    return _ConverterMatch(
      annotation,
      constantValue,
      jsonConverterSuper.typeArguments[1],
      null,
      fieldType,
    );
  }

  if (fieldType is TypeParameterType && targetType is TypeParameterType) {
    assert(annotation?.element2 is! PropertyAccessorElement2);
    assert(converterClassElement.typeParameters2.isNotEmpty);
    if (converterClassElement.typeParameters2.length > 1) {
      throw InvalidGenerationSourceError(
        '`JsonConverter` implementations can have no more than one type '
        'argument. `${converterClassElement.name3}` has '
        '${converterClassElement.typeParameters2.length}.',
        element: converterClassElement,
      );
    }

    return _ConverterMatch(
      annotation,
      constantValue,
      jsonConverterSuper.typeArguments[1],
      '${targetType.element3.name3}${targetType.isNullableType ? '?' : ''}',
      fieldType,
    );
  }

  return null;
}

const _jsonConverterChecker = TypeChecker.fromRuntime(JsonConverter);
