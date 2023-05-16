// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'json_literal_generator.dart';
import 'utils.dart';

String constMapName(DartType targetType) =>
    '_\$${targetType.element!.name}EnumMap';

/// If [targetType] is not an enum, return `null`.
///
/// Otherwise, returns `true` if [targetType] is nullable OR if one of the
/// encoded values of the enum is `null`.
bool? enumFieldWithNullInEncodeMap(DartType targetType) {
  final enumMap = _enumMap(targetType);

  if (enumMap == null) return null;

  if (targetType.isNullableType) {
    return true;
  }

  return enumMap.values.contains(null);
}

String? enumValueMapFromType(
  DartType targetType, {
  bool nullWithNoAnnotation = false,
}) {
  final enumMap =
      _enumMap(targetType, nullWithNoAnnotation: nullWithNoAnnotation);

  if (enumMap == null) return null;

  final items = enumMap.entries
      .map((e) => '  ${targetType.element!.name}.${e.key.name}: '
          '${jsonLiteralAsDart(e.value)},')
      .join();

  return 'const ${constMapName(targetType)} = {\n$items\n};';
}

Map<FieldElement, Object?>? _enumMap(
  DartType targetType, {
  bool nullWithNoAnnotation = false,
}) {
  final targetTypeElement = targetType.element;
  if (targetTypeElement == null) return null;
  final annotation = _jsonEnumChecker.firstAnnotationOf(targetTypeElement);
  final jsonEnum = _fromAnnotation(annotation);

  final enumFields = iterateEnumFields(targetType);

  if (enumFields == null || (nullWithNoAnnotation && !jsonEnum.alwaysCreate)) {
    return null;
  }

  return {
    for (var field in enumFields)
      field: _generateEntry(
        field: field,
        jsonEnum: jsonEnum,
        targetType: targetType,
      ),
  };
}

Object? _generateEntry({
  required FieldElement field,
  required JsonEnum jsonEnum,
  required DartType targetType,
}) {
  final annotation =
      const TypeChecker.fromRuntime(JsonValue).firstAnnotationOfExact(field);

  if (annotation == null) {
    final valueField = jsonEnum.valueField;
    if (valueField != null) {
      // TODO: fieldRename is pointless here!!! At least log a warning!

      final fieldElementType = field.type.element as EnumElement;

      final e = fieldElementType.getField(valueField);

      if (e == null && valueField == 'index') {
        return fieldElementType.fields
            .where((element) => element.isEnumConstant)
            .toList(growable: false)
            .indexOf(field);
      }

      if (e == null || e.isStatic) {
        throw InvalidGenerationSourceError(
          '`JsonEnum.valueField` was set to "$valueField", but '
          'that is not a valid, instance field on '
          '`${typeToCode(targetType)}`.',
          element: targetType.element,
        );
      }

      final reader = ConstantReader(field.computeConstantValue());
      final valueReader = reader.read(valueField);
      if (valueReader.validValueType) {
        return valueReader.literalValue;
      } else {
        throw InvalidGenerationSourceError(
          '`JsonEnum.valueField` was set to "$valueField", but '
          'that field does not have a type of String, int, or null.',
          element: targetType.element,
        );
      }
    } else {
      return encodedFieldName(jsonEnum.fieldRename, field.name);
    }
  } else {
    final reader = ConstantReader(annotation);

    final valueReader = reader.read('value');

    if (valueReader.validValueType) {
      return valueReader.literalValue;
    } else {
      final targetTypeCode = typeToCode(targetType);
      throw InvalidGenerationSourceError(
        'The `JsonValue` annotation on `$targetTypeCode.${field.name}` does '
        'not have a value of type String, int, or null.',
        element: field,
      );
    }
  }
}

const _jsonEnumChecker = TypeChecker.fromRuntime(JsonEnum);

JsonEnum _fromAnnotation(DartObject? dartObject) {
  if (dartObject == null) {
    return const JsonEnum();
  }
  final reader = ConstantReader(dartObject);
  return JsonEnum(
    alwaysCreate: reader.read('alwaysCreate').literalValue as bool,
    fieldRename: readEnum(reader.read('fieldRename'), FieldRename.values)!,
    valueField: reader.read('valueField').literalValue as String?,
  );
}

extension on ConstantReader {
  bool get validValueType => isString || isNull || isInt;
}
