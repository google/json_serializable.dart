// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../type_helper_ctx.dart';
import '../utils.dart';
import 'config_types.dart';
import 'json_converter_helper.dart';

/// Whether [jsonKey] enables PATCH-style tri-state serialization.
bool usesExplicitJsonNullWhenNonNullField(KeyConfig jsonKey) =>
    jsonKey.explicitJsonNullWhenNonNullField;

/// Validates that explicit JSON `null` can be passed through deserialization.
void validateExplicitJsonNullDeserialize(
  FieldElement field,
  TypeHelperCtx context,
  DartType targetType,
) {
  final fromJsonData = context.deserializeConvertData;
  if (fromJsonData != null) {
    if (!_acceptsNullableJsonInput(fromJsonData.paramType)) {
      throwUnsupported(
        field,
        'Fields with `explicitJsonNullWhenNonNullField` require `fromJson` to '
        'accept a nullable JSON input (for example `Object?`), but '
        '`${fromJsonData.name}` has a non-nullable parameter type '
        '`${typeToCode(fromJsonData.paramType)}`.',
      );
    }
    return;
  }

  final nullableConverterEncode = hasConverterNullEncode(targetType, context);
  if (nullableConverterEncode != null) {
    if (!nullableConverterEncode) {
      throwUnsupported(
        field,
        'Fields with `explicitJsonNullWhenNonNullField` require the '
        '`JsonConverter` `fromJson` input type to be nullable when the field '
        'type is nullable.',
      );
    }
    return;
  }

  if (targetType is! InterfaceType) {
    return;
  }

  final fromJsonCtor = targetType.element.constructors
      .where((ce) => ce.name == 'fromJson')
      .singleOrNull;

  if (fromJsonCtor == null) {
    return;
  }

  final positionalParams = fromJsonCtor.formalParameters
      .where((element) => element.isPositional)
      .toList();

  if (positionalParams.isEmpty) {
    return;
  }

  final paramType = positionalParams.first.type;
  if (!_acceptsNullableJsonInput(paramType)) {
    throw InvalidGenerationSourceError(
      'Fields with `explicitJsonNullWhenNonNullField` cannot deserialize '
      'explicit JSON `null` through `${targetType.element.name}.fromJson` '
      'because its first parameter is non-nullable '
      '`${typeToCode(paramType)}`. Use a nullable parameter (for example '
      '`Object?`) or provide a custom `@JsonKey(fromJson: ...)` that accepts '
      'nullable input.',
      element: field,
    );
  }
}

bool _acceptsNullableJsonInput(DartType type) =>
    type is DynamicType || type.isNullableType;

/// Wraps [presentExpression] with `containsKey` logic for `fromJson`.
///
/// When the key is present, [presentExpression] must deserialize the JSON
/// value (including JSON `null`) without treating it as a missing key.
String wrapPatchTriStateFromJson({
  required String mapExpression,
  required String jsonKeyName,
  required String absentExpression,
  required String presentExpression,
}) =>
    '!$mapExpression.containsKey($jsonKeyName) '
    '? $absentExpression '
    ': $presentExpression';

/// Wraps checked-mode `$checkedConvert` callback with the same logic.
String wrapPatchTriStateCheckedConvert({
  required String mapExpression,
  required String jsonKeyName,
  required String absentExpression,
  required String presentExpression,
}) =>
    '!$mapExpression.containsKey($jsonKeyName) '
    '? $absentExpression '
    ': $presentExpression';
