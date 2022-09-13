// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'json_literal_generator.dart';
import 'utils.dart';

String constMapName(DartType targetType) =>
    '_\$${targetType.element2!.name}EnumMap';

String? enumValueMapFromType(
  DartType targetType, {
  bool nullWithNoAnnotation = false,
}) {
  final annotation = _jsonEnumChecker.firstAnnotationOf(targetType.element2!);
  final jsonEnum = _fromAnnotation(annotation);

  final enumFields = iterateEnumFields(targetType);

  if (enumFields == null || (nullWithNoAnnotation && !jsonEnum.alwaysCreate)) {
    return null;
  }

  MapEntry<FieldElement, dynamic> generateEntry(FieldElement fe) {
    final annotation =
        const TypeChecker.fromRuntime(JsonValue).firstAnnotationOfExact(fe);

    dynamic fieldValue;
    if (annotation == null) {
      fieldValue = encodedFieldName(jsonEnum.fieldRename, fe.name);
    } else {
      final reader = ConstantReader(annotation);

      final valueReader = reader.read('value');

      if (valueReader.isString || valueReader.isNull || valueReader.isInt) {
        fieldValue = valueReader.literalValue;
      } else {
        final targetTypeCode = typeToCode(targetType);
        throw InvalidGenerationSourceError(
            'The `JsonValue` annotation on `$targetTypeCode.${fe.name}` does '
            'not have a value of type String, int, or null.',
            element: fe);
      }
    }

    final entry = MapEntry(fe, fieldValue);

    return entry;
  }

  final enumMap =
      Map<FieldElement, dynamic>.fromEntries(enumFields.map(generateEntry));

  final items = enumMap.entries
      .map((e) => '  ${targetType.element2!.name}.${e.key.name}: '
          '${jsonLiteralAsDart(e.value)},')
      .join();

  return 'const ${constMapName(targetType)} = {\n$items\n};';
}

const _jsonEnumChecker = TypeChecker.fromRuntime(JsonEnum);

JsonEnum _fromAnnotation(DartObject? dartObject) {
  if (dartObject == null) {
    return const JsonEnum();
  }
  final reader = ConstantReader(dartObject);
  return JsonEnum(
      alwaysCreate: reader.read('alwaysCreate').literalValue as bool,
      fieldRename: enumValueForDartObject(
        reader.read('fieldRename').objectValue,
        FieldRename.values,
        (f) => f.toString().split('.')[1],
      ));
}
