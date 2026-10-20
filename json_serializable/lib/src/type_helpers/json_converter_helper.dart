// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../field_helpers.dart';
import '../lambda_result.dart';
import '../shared_checkers.dart';
import '../type_helper.dart';
import '../utils.dart';

/// A [TypeHelper] that supports classes annotated with implementations of
/// [JsonConverter].
class JsonConverterHelper extends TypeHelper<TypeHelperContextWithConfig> {
  final bool forMapKey;

  const JsonConverterHelper({this.forMapKey = false});

  @override
  Expression? serialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
  ) {
    final converter = typeConverter(targetType, context);

    if (converter == null) {
      return null;
    }

    if (forMapKey &&
        (!coreStringTypeChecker.isExactlyType(converter.jsonType) ||
            converter.jsonType.isNullableType)) {
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
  Expression? deserialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    final converter = typeConverter(targetType, context);
    if (converter == null) {
      return null;
    }

    if (forMapKey &&
        (!coreStringTypeChecker.isExactlyType(converter.jsonType) ||
            converter.jsonType.isNullableType)) {
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
        expression: converter.jsonType.isDartCoreDouble
            ? expression
                  .asA(refer('num?'))
                  .nullSafeProperty('toDouble')
                  .call([])
            : expression,
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

Expression _nullableJsonConverterLambdaResult(
  JsonConvertData converter, {
  required String name,
  required DartType targetType,
  required Expression expression,
  required String callback,
}) {
  final jsonDisplayString = typeToCode(converter.jsonType);
  final fieldTypeDisplayString = converter.isGeneric
      ? typeToCode(targetType.promoteNonNullable())
      : typeToCode(converter.fieldType.promoteNonNullable());

  return refer(name).call(
    [expression, refer(callback)],
    {},
    [refer(jsonDisplayString), refer(fieldTypeDisplayString)],
  );
}

class JsonConvertData {
  final String accessString;
  final DartType jsonType;
  final DartType fieldType;
  final bool isGeneric;

  JsonConvertData.className(
    String className,
    String accessor,
    this.jsonType,
    this.fieldType,
  ) : accessString = 'const $className${_withAccessor(accessor)}()',
      isGeneric = false;

  JsonConvertData.genericClass(
    String className,
    String genericTypeArg,
    String accessor,
    this.jsonType,
    this.fieldType,
  ) : accessString = '$className<$genericTypeArg>${_withAccessor(accessor)}()',
      isGeneric = true;

  JsonConvertData.propertyAccess(
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
  TypeHelperContextWithConfig ctx, {
  bool forNullCheck = false,
}) {
  final data = typeConverter(targetType, ctx);

  if (data == null) {
    return null;
  }

  return data.jsonType.isNullableType ||
      (forNullCheck &&
          !data.fieldType.isNullableType &&
          targetType.isNullableType);
}

JsonConvertData? typeConverter(
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

  var matchingAnnotations = <_ConverterMatch>[];
  for (final field in fieldHierarchyFor(ctx.fieldElement)) {
    matchingAnnotations = converterMatches(
      field.getter?.metadata.annotations ?? [],
    );
    if (matchingAnnotations.isNotEmpty) break;
    matchingAnnotations = converterMatches(field.metadata.annotations);
    if (matchingAnnotations.isNotEmpty) break;
  }

  if (matchingAnnotations.isEmpty) {
    matchingAnnotations = converterMatches(
      ctx.classElement.metadata.annotations,
    );

    if (matchingAnnotations.isEmpty) {
      matchingAnnotations = ctx.config.converters
          .map((e) => _compatibleMatch(targetType, null, e))
          .whereType<_ConverterMatch>()
          .toList();
    }
  }

  return _typeConverterFrom(matchingAnnotations, targetType);
}

JsonConvertData? _typeConverterFrom(
  List<_ConverterMatch> matchingAnnotations,
  DartType targetType,
) {
  if (matchingAnnotations.isEmpty) {
    return null;
  }

  if (matchingAnnotations.length > 1) {
    final exactMatches = matchingAnnotations
        .where((e) => e.fieldType.isNullableType == targetType.isNullableType)
        .toList();
    if (exactMatches.isNotEmpty) {
      matchingAnnotations = exactMatches;
    }

    if (matchingAnnotations.length > 1) {
      final targetTypeCode = typeToCode(targetType);
      throw InvalidGenerationSourceError(
        'Found more than one matching converter for `$targetTypeCode`.',
        element: matchingAnnotations[1].elementAnnotation?.element,
      );
    }
  }

  final match = matchingAnnotations.single;

  final annotationElement = match.elementAnnotation?.element;
  if (annotationElement is PropertyAccessorElement &&
      match.genericTypeArg == null) {
    final enclosing = annotationElement.enclosingElement;

    var accessString = annotationElement.name;

    if (enclosing is ClassElement) {
      accessString = '${enclosing.name}.$accessString';
    }

    return JsonConvertData.propertyAccess(
      accessString!,
      match.jsonType,
      match.fieldType,
    );
  }

  final reviver = ConstantReader(match.annotation).revive();

  if (reviver.namedArguments.isNotEmpty ||
      reviver.positionalArguments.isNotEmpty) {
    throw InvalidGenerationSourceError(
      'Generators with constructor arguments are not supported.',
      element: match.elementAnnotation?.element,
    );
  }

  if (match.genericTypeArg != null) {
    return JsonConvertData.genericClass(
      match.annotation.type!.element!.name!,
      match.genericTypeArg!,
      reviver.accessor,
      match.jsonType,
      match.fieldType,
    );
  }

  return JsonConvertData.className(
    typeToCode(match.annotation.type!),
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
  final constantType = constantValue.type;
  if (constantType is! InterfaceType) {
    return null;
  }
  final converterClassElement = constantType.element as ClassElement;

  final jsonConverterSuper = converterClassElement.allSupertypes
      .where((e) => _jsonConverterChecker.isExactly(e.element))
      .singleOrNull;

  if (jsonConverterSuper == null) {
    return null;
  }

  assert(jsonConverterSuper.element.typeParameters.length == 2);
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

  if (converterClassElement.typeParameters.isNotEmpty) {
    final hasExplicitTypeArgs = annotation == null
        ? constantType.typeArguments.every((t) => t is! DynamicType)
        : annotation.element is PropertyAccessorElement
        ? constantType.typeArguments.every((t) => t is! DynamicType)
        : annotation.toSource().contains('<');
    if (hasExplicitTypeArgs) {
      final instantiatedSuper = constantType.allSupertypes
          .where((e) => _jsonConverterChecker.isExactly(e.element))
          .singleOrNull;
      if (instantiatedSuper != null) {
        final instantiatedFieldType = instantiatedSuper.typeArguments[0];
        if (instantiatedFieldType == targetType ||
            instantiatedFieldType == targetType.promoteNonNullable()) {
          return _ConverterMatch(
            annotation,
            constantValue,
            instantiatedSuper.typeArguments[1],
            null,
            instantiatedFieldType,
          );
        }
      }
    }
  }

  final matchedTargetParam = _matchGenericTypeParam(fieldType, targetType);
  if (matchedTargetParam != null &&
      (!fieldType.isNullableType || targetType.isNullableType)) {
    assert(converterClassElement.typeParameters.isNotEmpty);
    if (converterClassElement.typeParameters.length > 1) {
      throw InvalidGenerationSourceError(
        '`JsonConverter` implementations can have no more than one type '
        'argument. `${converterClassElement.name}` has '
        '${converterClassElement.typeParameters.length}.',
        element: converterClassElement,
      );
    }

    final converterTypeParam = converterClassElement.typeParameters.single;
    final canBeNullable = converterTypeParam.bound?.isNullableType ?? true;
    final nullableSuffix =
        matchedTargetParam.isNullableType &&
            !fieldType.isNullableType &&
            canBeNullable
        ? '?'
        : '';

    final instantiatedConverter = converterClassElement.instantiate(
      typeArguments: [matchedTargetParam.promoteNonNullable()],
      nullabilitySuffix: constantType.nullabilitySuffix,
    );
    final instantiatedSuper = instantiatedConverter.allSupertypes
        .where((e) => _jsonConverterChecker.isExactly(e.element))
        .single;
    final substitutedFieldType = fieldType.isNullableType
        ? instantiatedSuper.typeArguments[0]
        : instantiatedSuper.typeArguments[0].promoteNonNullable();

    return _ConverterMatch(
      annotation,
      constantValue,
      instantiatedSuper.typeArguments[1],
      '${matchedTargetParam.element.name}$nullableSuffix',
      substitutedFieldType,
    );
  }

  return null;
}

TypeParameterType? _matchGenericTypeParam(
  DartType rawFieldType,
  DartType targetType,
) {
  if (rawFieldType is TypeParameterType && targetType is TypeParameterType) {
    return targetType;
  }
  if (rawFieldType is InterfaceType &&
      targetType is InterfaceType &&
      rawFieldType.element == targetType.element &&
      rawFieldType.typeArguments.length == targetType.typeArguments.length) {
    TypeParameterType? found;
    for (var i = 0; i < rawFieldType.typeArguments.length; i++) {
      final rawArg = rawFieldType.typeArguments[i];
      final targetArg = targetType.typeArguments[i];
      if (rawArg == targetArg) continue;
      final sub = _matchGenericTypeParam(rawArg, targetArg);
      if (sub == null) return null;
      if (found != null && found.element != sub.element) return null;
      found = sub;
    }
    return found;
  }
  return null;
}

const _jsonConverterChecker = TypeChecker.typeNamed(
  JsonConverter,
  inPackage: 'json_annotation',
);
