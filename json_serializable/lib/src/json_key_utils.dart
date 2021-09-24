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

final _jsonKeyExpando = Expando<KeyConfig>();

KeyConfig jsonKeyForField(FieldElement field, ClassConfig classAnnotation) =>
    _jsonKeyExpando[field] ??= _from(field, classAnnotation);

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
      badType = dartObject.type!.element!.name;
    }

    if (badType != null) {
      badType = typeInformation.followedBy([badType]).join(' > ');
      throwUnsupported(
          element, '`defaultValue` is `$badType`, it must be a literal.');
    }

    if (reader.isDouble || reader.isInt || reader.isString || reader.isBool) {
      return reader.literalValue;
    }

    if (reader.isList) {
      return [
        for (var e in reader.listValue)
          literalForObject(e, [
            ...typeInformation,
            'List',
          ])
      ];
    }

    if (reader.isSet) {
      return {
        for (var e in reader.setValue)
          literalForObject(e, [
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
          literalForObject(k!, mapTypeInformation),
          literalForObject(v!, mapTypeInformation),
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
  String? _annotationValue(String fieldName, {bool mustBeEnum = false}) {
    final annotationValue = obj.read(fieldName);

    final enumFields = annotationValue.isNull
        ? null
        : iterateEnumFields(annotationValue.objectValue.type!);
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
        final annotatedEnumType = annotationValue.objectValue.type!;
        if (!_interfaceTypesEqual(annotatedEnumType, targetEnumType)) {
          throwUnsupported(
            element,
            '`$fieldName` has type '
            '`${targetEnumType.getDisplayString(withNullability: false)}`, but '
            'the provided unknownEnumValue is of type '
            '`${annotatedEnumType.getDisplayString(withNullability: false)}`.',
          );
        }
      }

      final enumValueNames =
          enumFields.map((p) => p.name).toList(growable: false);

      final enumValueName = enumValueForDartObject<String>(
          annotationValue.objectValue, enumValueNames, (n) => n);

      return '${annotationValue.objectValue.type!.element!.name}'
          '.$enumValueName';
    } else {
      final defaultValueLiteral = annotationValue.isNull
          ? null
          : literalForObject(annotationValue.objectValue, []);
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

  final defaultValue = _annotationValue('defaultValue');
  if (defaultValue != null && ctorParamDefault != null) {
    log.warning(
      'The constructor parameter for `${element.name}` has a default value '
      '`$ctorParamDefault`, but the `JsonKey.defaultValue` value '
      '`$defaultValue` will be used for missing or `null` values in JSON '
      'decoding.',
    );
  }

  return _populateJsonKey(
    classAnnotation,
    element,
    defaultValue: defaultValue ?? ctorParamDefault,
    disallowNullValue: obj.read('disallowNullValue').literalValue as bool?,
    ignore: obj.read('ignore').literalValue as bool?,
    includeIfNull: obj.read('includeIfNull').literalValue as bool?,
    name: obj.read('name').literalValue as String?,
    required: obj.read('required').literalValue as bool?,
    unknownEnumValue: _annotationValue('unknownEnumValue', mustBeEnum: true),
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
  bool? required,
  Object? unknownEnumValue,
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
    name: _encodedFieldName(classAnnotation, name, element),
    required: required ?? false,
    unknownEnumValue: unknownEnumValue,
  );
}

String _encodedFieldName(
  JsonSerializable classAnnotation,
  String? jsonKeyNameValue,
  FieldElement fieldElement,
) {
  if (jsonKeyNameValue != null) {
    return jsonKeyNameValue;
  }

  switch (classAnnotation.fieldRename) {
    case FieldRename.none:
      return fieldElement.name;
    case FieldRename.snake:
      return fieldElement.name.snake;
    case FieldRename.kebab:
      return fieldElement.name.kebab;
    case FieldRename.pascal:
      return fieldElement.name.pascal;
    default:
      throw ArgumentError.value(
        classAnnotation,
        'classAnnotation',
        'The provided `fieldRename` (${classAnnotation.fieldRename}) is not '
            'supported.',
      );
  }
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
    return a.element == b.element;
  }
  return a == b;
}
