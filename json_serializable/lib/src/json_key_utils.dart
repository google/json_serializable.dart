// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'json_literal_generator.dart';
import 'shared_checkers.dart';
import 'type_helpers/config_types.dart';
import 'utils.dart';

final _jsonKeyExpando = Expando<Map<ClassConfig, KeyConfig>>();

KeyConfig jsonKeyForField(FieldElement field, ClassConfig classAnnotation) =>
    (_jsonKeyExpando[field] ??= Map.identity())[classAnnotation] ??=
        _from(field, classAnnotation);

KeyConfig _from(FieldElement element, ClassConfig classAnnotation) {
  // If an annotation exists on `element` the source is a 'real' field.
  // If the result is `null`, check the getter – it is a property.
  // TODO: setters: github.com/google/json_serializable.dart/issues/24
  final obj = jsonKeyAnnotation(element);

  final ctorParamDefault = classAnnotation.ctorParamDefaults[element.name];

  if (obj.isNull) {
    return _populateJsonKey(
      classAnnotation,
      element,
      defaultValue: ctorParamDefault,
      ignore: classAnnotation.ignoreUnannotated,
    );
  }

  /// Returns a literal value for [dartObject] if possible, otherwise throws
  /// an [InvalidGenerationSourceError] using [typeInformation] to describe
  /// the unsupported type.
  Object? literalForObject(
    String fieldName,
    DartObject dartObject,
    Iterable<String> typeInformation,
  ) {
    if (dartObject.isNull) {
      return null;
    }

    final reader = ConstantReader(dartObject);

    String? badType;
    if (reader.isSymbol) {
      badType = 'Symbol';
    } else if (reader.isType) {
      badType = 'Type';
    } else if (dartObject.type is FunctionType) {
      // TODO: Support calling function for the default value?
      badType = 'Function';
    } else if (!reader.isLiteral) {
      badType = dartObject.type!.element2!.name;
    }

    if (badType != null) {
      badType = typeInformation.followedBy([badType]).join(' > ');
      throwUnsupported(
        element,
        '`$fieldName` is `$badType`, it must be a literal.',
      );
    }

    if (reader.isDouble || reader.isInt || reader.isString || reader.isBool) {
      return reader.literalValue;
    }

    if (reader.isList) {
      return [
        for (var e in reader.listValue)
          literalForObject(fieldName, e, [
            ...typeInformation,
            'List',
          ])
      ];
    }

    if (reader.isSet) {
      return {
        for (var e in reader.setValue)
          literalForObject(fieldName, e, [
            ...typeInformation,
            'Set',
          ])
      };
    }

    if (reader.isMap) {
      final mapTypeInformation = [
        ...typeInformation,
        'Map',
      ];
      return reader.mapValue.map(
        (k, v) => MapEntry(
          literalForObject(fieldName, k!, mapTypeInformation),
          literalForObject(fieldName, v!, mapTypeInformation),
        ),
      );
    }

    badType = typeInformation.followedBy(['$dartObject']).join(' > ');

    throwUnsupported(
      element,
      'The provided value is not supported: $badType. '
      'This may be an error in package:json_serializable. '
      'Please rerun your build with `--verbose` and file an issue.',
    );
  }

  /// Returns a literal object representing the value of [fieldName] in [obj].
  ///
  /// If [mustBeEnum] is `true`, throws an [InvalidGenerationSourceError] if
  /// either the annotated field is not an `enum` or `List` or if the value in
  /// [fieldName] is not an `enum` value.
  String? createAnnotationValue(String fieldName, {bool mustBeEnum = false}) {
    final annotationValue = obj.read(fieldName);
    late final DartType annotationType;

    final enumFields = annotationValue.isNull
        ? null
        : iterateEnumFields(annotationType = annotationValue.objectValue.type!);
    if (enumFields != null) {
      if (mustBeEnum) {
        late DartType targetEnumType;
        if (element.type.isEnum) {
          targetEnumType = element.type;
        } else if (coreIterableTypeChecker.isAssignableFromType(element.type)) {
          targetEnumType = coreIterableGenericType(element.type);
        } else {
          throwUnsupported(
            element,
            '`$fieldName` can only be set on fields of type enum or on '
            'Iterable, List, or Set instances of an enum type.',
          );
        }

        if (_nullAsUnknownChecker.isExactlyType(annotationType)) {
          return jsonKeyNullForUndefinedEnumValueFieldName;
        } else if (!_interfaceTypesEqual(annotationType, targetEnumType)) {
          throwUnsupported(
            element,
            '`$fieldName` has type '
            '`${targetEnumType.getDisplayString(withNullability: false)}`, but '
            'the provided unknownEnumValue is of type '
            '`${annotationType.getDisplayString(withNullability: false)}`.',
          );
        }
      }

      if (_nullAsUnknownChecker.isExactlyType(annotationType)) {
        throw InvalidGenerationSourceError(
          '`$jsonKeyNullForUndefinedEnumValueFieldName` cannot be used with '
          '`JsonKey.defaultValue`.',
          element: element,
        );
      }

      final enumValueNames =
          enumFields.map((p) => p.name).toList(growable: false);

      final enumValueName = enumValueForDartObject<String>(
          annotationValue.objectValue, enumValueNames, (n) => n);

      return '${annotationType.element2!.name}'
          '.$enumValueName';
    } else {
      final defaultValueLiteral = annotationValue.isNull
          ? null
          : literalForObject(fieldName, annotationValue.objectValue, []);
      if (defaultValueLiteral == null) {
        return null;
      }
      if (mustBeEnum) {
        throwUnsupported(
          element,
          'The value provided for `$fieldName` must be a matching enum.',
        );
      }
      return jsonLiteralAsDart(defaultValueLiteral);
    }
  }

  final defaultValue = createAnnotationValue('defaultValue');
  if (defaultValue != null && ctorParamDefault != null) {
    if (defaultValue == ctorParamDefault) {
      log.info(
        'The default value `$defaultValue` for `${element.name}` is defined '
        'twice in the constructor and in the `JsonKey.defaultValue`.',
      );
    } else {
      log.warning(
        'The constructor parameter for `${element.name}` has a default value '
        '`$ctorParamDefault`, but the `JsonKey.defaultValue` value '
        '`$defaultValue` will be used for missing or `null` values in JSON '
        'decoding.',
      );
    }
  }

  String? readValueFunctionName;
  final readValue = obj.read('readValue');
  if (!readValue.isNull) {
    readValueFunctionName =
        readValue.objectValue.toFunctionValue()!.qualifiedName;
  }

  return _populateJsonKey(
    classAnnotation,
    element,
    defaultValue: defaultValue ?? ctorParamDefault,
    disallowNullValue: obj.read('disallowNullValue').literalValue as bool?,
    ignore: obj.read('ignore').literalValue as bool?,
    includeIfNull: obj.read('includeIfNull').literalValue as bool?,
    name: obj.read('name').literalValue as String?,
    readValueFunctionName: readValueFunctionName,
    required: obj.read('required').literalValue as bool?,
    unknownEnumValue:
        createAnnotationValue('unknownEnumValue', mustBeEnum: true),
  );
}

KeyConfig _populateJsonKey(
  ClassConfig classAnnotation,
  FieldElement element, {
  required String? defaultValue,
  bool? disallowNullValue,
  bool? ignore,
  bool? includeIfNull,
  String? name,
  String? readValueFunctionName,
  bool? required,
  String? unknownEnumValue,
}) {
  if (disallowNullValue == true) {
    if (includeIfNull == true) {
      throwUnsupported(
          element,
          'Cannot set both `disallowNullValue` and `includeIfNull` to `true`. '
          'This leads to incompatible `toJson` and `fromJson` behavior.');
    }
  }

  return KeyConfig(
    defaultValue: defaultValue,
    disallowNullValue: disallowNullValue ?? false,
    ignore: ignore ?? false,
    includeIfNull: _includeIfNull(
        includeIfNull, disallowNullValue, classAnnotation.includeIfNull),
    name: name ?? encodedFieldName(classAnnotation.fieldRename, element.name),
    readValueFunctionName: readValueFunctionName,
    required: required ?? false,
    unknownEnumValue: unknownEnumValue,
  );
}

bool _includeIfNull(
  bool? keyIncludeIfNull,
  bool? keyDisallowNullValue,
  bool classIncludeIfNull,
) {
  if (keyDisallowNullValue == true) {
    assert(keyIncludeIfNull != true);
    return false;
  }
  return keyIncludeIfNull ?? classIncludeIfNull;
}

bool _interfaceTypesEqual(DartType a, DartType b) {
  if (a is InterfaceType && b is InterfaceType) {
    // Handle nullability case. Pretty sure this is fine for enums.
    return a.element2 == b.element2;
  }
  return a == b;
}

const jsonKeyNullForUndefinedEnumValueFieldName =
    'JsonKey.nullForUndefinedEnumValue';

final _nullAsUnknownChecker =
    TypeChecker.fromRuntime(JsonKey.nullForUndefinedEnumValue.runtimeType);
