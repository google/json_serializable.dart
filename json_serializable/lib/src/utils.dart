// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'field_helpers.dart';
import 'shared_checkers.dart';
import 'type_helpers/config_types.dart';

const _jsonKeyChecker = TypeChecker.typeNamed(
  JsonKey,
  inPackage: 'json_annotation',
);

/// If an annotation exists on `element` the source is a 'real' field.
/// If the result is `null`, check the getter – it is a property.
// TODO: setters: github.com/google/json_serializable.dart/issues/24
DartObject? _jsonKeyAnnotation(FieldElement element) {
  for (final candidate in fieldHierarchyFor(element)) {
    final direct =
        _jsonKeyChecker.firstAnnotationOf(candidate) ??
        (candidate.getter == null
            ? null
            : _jsonKeyChecker.firstAnnotationOf(candidate.getter!));
    if (direct != null) {
      return direct;
    }
  }
  return null;
}

ConstantReader jsonKeyAnnotation(FieldElement element) =>
    ConstantReader(_jsonKeyAnnotation(element));

/// Returns `true` if [element] is annotated with [JsonKey].
bool hasJsonKeyAnnotation(FieldElement element) =>
    _jsonKeyAnnotation(element) != null;

ConstantReader jsonKeyAnnotationForCtorParam(FormalParameterElement element) =>
    ConstantReader(_jsonKeyChecker.firstAnnotationOf(element));

Never throwUnsupported(FieldElement element, String message) =>
    throw InvalidGenerationSourceError(
      'Error with `@JsonKey` on the `${element.name}` field. $message',
      element: element,
    );

T? readEnum<T extends Enum>(ConstantReader reader, List<T> values) =>
    reader.isNull
    ? null
    : enumValueForDartObject<T>(reader.objectValue, values, (f) => f.name);

T enumValueForDartObject<T>(
  DartObject source,
  List<T> items,
  String Function(T) name,
) => items[source.getField('index')!.toIntValue()!];

/// Return an instance of [JsonSerializable] corresponding to the provided
/// [reader].
// #CHANGE WHEN UPDATING json_annotation
JsonSerializable _valueForAnnotation(ConstantReader reader) => JsonSerializable(
  anyMap: reader.read('anyMap').literalValue as bool?,
  checked: reader.read('checked').literalValue as bool?,
  constructor: reader.read('constructor').literalValue as String?,
  createFactory: reader.read('createFactory').literalValue as bool?,
  createToJson: reader.read('createToJson').literalValue as bool?,
  createFieldMap: reader.read('createFieldMap').literalValue as bool?,
  createJsonKeys: reader.read('createJsonKeys').literalValue as bool?,
  createPerFieldToJson:
      reader.read('createPerFieldToJson').literalValue as bool?,
  dateTimeUtc: reader.read('dateTimeUtc').literalValue as bool?,
  disallowUnrecognizedKeys:
      reader.read('disallowUnrecognizedKeys').literalValue as bool?,
  explicitToJson: reader.read('explicitToJson').literalValue as bool?,
  fieldRename: readEnum(reader.read('fieldRename'), FieldRename.values),
  genericArgumentFactories:
      reader.read('genericArgumentFactories').literalValue as bool?,
  ignoreUnannotated: reader.read('ignoreUnannotated').literalValue as bool?,
  includeIfNull: reader.read('includeIfNull').literalValue as bool?,
  createJsonSchema: reader.read('createJsonSchema').literalValue as bool?,
);

/// Returns a [ClassConfig] with values from the [JsonSerializable]
/// instance represented by [reader].
///
/// For fields that are not defined in [JsonSerializable] or `null` in [reader],
/// use the values in [config].
///
/// Note: if [JsonSerializable.genericArgumentFactories] is `false` for [reader]
/// and `true` for [config], the corresponding field in the return value will
/// only be `true` if [classElement] has type parameters.
ClassConfig mergeConfig(
  ClassConfig config,
  ConstantReader reader, {
  required ClassElement classElement,
}) {
  final annotation = _valueForAnnotation(reader);
  assert(config.ctorParams.isEmpty);

  final constructor = annotation.constructor ?? config.constructor;
  final constructorInstance = _constructorByNameOrNull(
    classElement,
    constructor,
  );

  final ctorParams = <FormalParameterElement>[
    ...?constructorInstance?.formalParameters,
  ];

  final converters = reader.read('converters');

  return ClassConfig(
    anyMap: annotation.anyMap ?? config.anyMap,
    checked: annotation.checked ?? config.checked,
    constructor: constructor,
    createFactory: annotation.createFactory ?? config.createFactory,
    createToJson: annotation.createToJson ?? config.createToJson,
    createFieldMap: annotation.createFieldMap ?? config.createFieldMap,
    createJsonKeys: annotation.createJsonKeys ?? config.createJsonKeys,
    createPerFieldToJson:
        annotation.createPerFieldToJson ?? config.createPerFieldToJson,
    disallowUnrecognizedKeys:
        annotation.disallowUnrecognizedKeys ?? config.disallowUnrecognizedKeys,
    explicitToJson: annotation.explicitToJson ?? config.explicitToJson,
    fieldRename: annotation.fieldRename ?? config.fieldRename,
    genericArgumentFactories:
        annotation.genericArgumentFactories ??
        (classElement.typeParameters.isNotEmpty &&
            config.genericArgumentFactories),
    ignoreUnannotated: annotation.ignoreUnannotated ?? config.ignoreUnannotated,
    includeIfNull: annotation.includeIfNull ?? config.includeIfNull,
    ctorParams: ctorParams,
    converters: converters.isNull ? const [] : converters.listValue,
    createJsonSchema: annotation.createJsonSchema ?? config.createJsonSchema,
    dateTimeUtc: annotation.dateTimeUtc ?? config.dateTimeUtc,
  );
}

ConstructorElement? _constructorByNameOrNull(
  ClassElement classElement,
  String name,
) {
  try {
    return constructorByName(classElement, name);
  } on InvalidGenerationSourceError {
    return null;
  }
}

ConstructorElement constructorByName(ClassElement classElement, String name) {
  final className = classElement.name;

  ConstructorElement? ctor;
  if (name.isEmpty) {
    ctor = classElement.unnamedConstructor;
    if (ctor == null) {
      throw InvalidGenerationSourceError(
        'The class `$className` has no default constructor.',
        element: classElement,
      );
    }
  } else {
    ctor = classElement.getNamedConstructor(name);
    if (ctor == null) {
      throw InvalidGenerationSourceError(
        'The class `$className` does not have a constructor with the name '
        '`$name`.',
        element: classElement,
      );
    }
  }

  return ctor;
}

/// If [targetType] is an enum, returns the [FieldElement] instances associated
/// with its values.
///
/// Otherwise, `null`.
Iterable<FieldElement>? iterateEnumFields(DartType targetType) {
  if (targetType.element is EnumElement) {
    return (targetType.element as EnumElement).constants;
  }
  return null;
}

extension DartTypeExtension on DartType {
  DartType promoteNonNullable() => switch (this) {
    final TypeParameterType t => t.element.instantiate(
      nullabilitySuffix: NullabilitySuffix.none,
    ),
    final RecordType r when _typeSystemFor(r) == null => RecordType(
      positional: [for (final f in r.positionalFields) f.type],
      named: {for (final f in r.namedFields) f.name: f.type},
      nullabilitySuffix: NullabilitySuffix.none,
    ),
    _ => _typeSystemFor(this)?.promoteToNonNull(this) ?? this,
  };

  String toStringNonNullable() {
    final val = getDisplayString();
    if (val.endsWith('?')) return val.substring(0, val.length - 1);
    return val;
  }
}

TypeSystem? _typeSystemFor(DartType type) {
  if (type.element?.library?.typeSystem case final ts?) return ts;
  if (type.alias?.element.library.typeSystem case final ts?) return ts;
  if (Zone.current[#_targetLibrary] case final LibraryElement lib) {
    return lib.typeSystem;
  }
  return switch (type) {
    RecordType(:final positionalFields, :final namedFields) =>
      positionalFields
              .map((f) => _typeSystemFor(f.type))
              .nonNulls
              .firstOrNull ??
          namedFields.map((f) => _typeSystemFor(f.type)).nonNulls.firstOrNull,
    FunctionType(
      :final returnType,
      :final normalParameterTypes,
      :final optionalParameterTypes,
      :final namedParameterTypes,
      :final typeParameters,
    ) =>
      _typeSystemFor(returnType) ??
          normalParameterTypes.map(_typeSystemFor).nonNulls.firstOrNull ??
          optionalParameterTypes.map(_typeSystemFor).nonNulls.firstOrNull ??
          namedParameterTypes.values.map(_typeSystemFor).nonNulls.firstOrNull ??
          typeParameters.firstOrNull?.library?.typeSystem,
    _ => null,
  };
}

String ifNullOrElse(String test, String ifNull, String ifNotNull) =>
    '$test == null ? $ifNull : $ifNotNull';

String encodedFieldName(FieldRename fieldRename, String declaredName) =>
    switch (fieldRename) {
      FieldRename.none => declaredName,
      FieldRename.snake => declaredName.snake,
      FieldRename.screamingSnake => declaredName.snake.toUpperCase(),
      FieldRename.kebab => declaredName.kebab,
      FieldRename.pascal => declaredName.pascal,
    };

/// Runs [action] with [library] as the active target library for [typeToCode].
T runWithTargetLibrary<T>(LibraryElement library, T Function() action) =>
    runZoned(action, zoneValues: {#_targetLibrary: library});

bool _isAliasInScope(TypeAliasElement element) {
  if (element.isPrivate) return false;
  final library = Zone.current[#_targetLibrary] as LibraryElement?;
  if (library == null) return true;
  final name = element.name;
  return name != null &&
      library.firstFragment.scope.lookup(name).getter == element;
}

/// Return the Dart code presentation for the given [type].
///
/// This function is intentionally limited, and does not support all possible
/// types. Specifically, it supports [InterfaceType]s, [RecordType]s,
/// [TypeParameterType]s, and [DynamicType]s.
String typeToCode(DartType type, {bool forceNullable = false}) {
  if (type.alias case final alias?) {
    if (alias.element.aliasedType case final TypeParameterType aliasedParam) {
      final index = alias.element.typeParameters.indexOf(aliasedParam.element);
      if (index >= 0) {
        final argType = alias.typeArguments[index];
        return type.isNullableType || forceNullable
            ? typeToCode(argType, forceNullable: true)
            : typeToCode(argType.promoteNonNullable());
      }
    }
    if (_isAliasInScope(alias.element)) {
      return [
        alias.element.name,
        if (alias.typeArguments.isNotEmpty)
          '<${alias.typeArguments.map(typeToCode).join(', ')}>',
        if (!alias.element.aliasedType.isNullableType &&
            (type.isNullableType || forceNullable))
          '?',
      ].join();
    }
  }
  return switch (type) {
    DynamicType() => 'dynamic',
    InterfaceType() => [
      type.element.name,
      if (type.typeArguments.isNotEmpty)
        '<${type.typeArguments.map(typeToCode).join(', ')}>',
      if (type.isNullableType || forceNullable) '?',
    ].join(),
    TypeParameterType() => [
      type.element.name,
      if (type.nullabilitySuffix == NullabilitySuffix.question || forceNullable)
        '?',
    ].join(),
    RecordType() => _recordTypeToCode(type, forceNullable),
    _ => type.getDisplayString(),
  };
}

String _recordTypeToCode(RecordType type, bool forceNullable) {
  final positional = type.positionalFields
      .map((f) => typeToCode(f.type))
      .join(', ');
  final named = type.namedFields
      .map((f) => '${typeToCode(f.type)} ${f.name}')
      .join(', ');

  final buffer = StringBuffer('(');
  if (positional.isNotEmpty) {
    buffer.write(positional);
    if (named.isNotEmpty) buffer.write(', ');
  }
  if (named.isNotEmpty) {
    buffer.write('{$named}');
  }
  if (type.positionalFields.length == 1 && type.namedFields.isEmpty) {
    buffer.write(',');
  }
  buffer.write(')');
  if (type.isNullableType || forceNullable) {
    buffer.write('?');
  }
  return buffer.toString();
}

String? defaultDecodeLogic(
  DartType targetType,
  String expression, {
  bool defaultProvided = false,
}) {
  if (targetType.isDartCoreObject && !targetType.isNullableType) {
    final question = defaultProvided ? '?' : '';
    return '$expression as Object$question';
  } else if (targetType.isDartCoreObject || targetType is DynamicType) {
    // just return it as-is. We'll hope it's safe.
    return expression;
  } else if (targetType.isDartCoreDouble) {
    final targetTypeNullable = defaultProvided || targetType.isNullableType;
    final question = targetTypeNullable ? '?' : '';
    return '($expression as num$question)$question.toDouble()';
  } else if (targetType.isDartCoreInt) {
    final targetTypeNullable = defaultProvided || targetType.isNullableType;
    final question = targetTypeNullable ? '?' : '';
    return '($expression as num$question)$question.toInt()';
  } else if (simpleJsonTypeChecker.isAssignableFromType(targetType)) {
    final typeCode = typeToCode(targetType, forceNullable: defaultProvided);
    final targetTypeNullable = defaultProvided || targetType.isNullableType;
    final question = targetTypeNullable ? '?' : '';
    if (const TypeChecker.fromUrl(
      'dart:core#double',
    ).isAssignableFromType(targetType)) {
      return '($expression as num$question)$question.toDouble() as $typeCode';
    }
    if (const TypeChecker.fromUrl(
      'dart:core#int',
    ).isAssignableFromType(targetType)) {
      return '($expression as num$question)$question.toInt() as $typeCode';
    }
    return '$expression as $typeCode';
  }

  return null;
}

extension ExecutableElementExtension on ExecutableElement {
  /// Returns the name of `this` qualified with the class name if it's a
  /// [MethodElement].
  String get qualifiedName {
    if (this is TopLevelFunctionElement) {
      return name!;
    }

    if (this is MethodElement) {
      return '${enclosingElement!.name}.$name';
    }

    if (this is ConstructorElement) {
      // The default constructor.
      if (name == 'new') {
        return enclosingElement!.name!;
      }
      return '${enclosingElement!.name}.$name';
    }

    throw UnsupportedError('Not sure how to support typeof $runtimeType');
  }
}

const jsonSerializableChecker = TypeChecker.fromUrl(
  'package:json_annotation/src/json_serializable.dart#JsonSerializable',
);
