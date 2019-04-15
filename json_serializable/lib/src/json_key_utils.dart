// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'json_literal_generator.dart';
import 'utils.dart';

final _jsonKeyExpando = Expando<JsonKey>();

JsonKey jsonKeyForField(FieldElement field, JsonSerializable classAnnotation) =>
    _jsonKeyExpando[field] ??= _from(field, classAnnotation);

/// Will log "info" if [element] has an explicit value for [JsonKey.nullable]
/// telling the programmer that it will be ignored.
void logFieldWithConversionFunction(FieldElement element) {
  final jsonKey = _jsonKeyExpando[element];
  if (_explicitNullableExpando[jsonKey]) {
    log.info(
      'The `JsonKey.nullable` value on '
      '`${element.enclosingElement.name}.${element.name}` will be ignored '
      'because a custom conversion function is being used.',
    );

    _explicitNullableExpando[jsonKey] = null;
  }
}

JsonKey _from(FieldElement element, JsonSerializable classAnnotation) {
  // If an annotation exists on `element` the source is a 'real' field.
  // If the result is `null`, check the getter – it is a property.
  // TODO(kevmoo) setters: github.com/dart-lang/json_serializable/issues/24
  final obj = jsonKeyAnnotation(element);

  if (obj == null) {
    return _populateJsonKey(classAnnotation, element);
  }

  Object _getLiteral(DartObject dartObject, Iterable<String> things) {
    if (dartObject.isNull) {
      return null;
    }

    final reader = ConstantReader(dartObject);

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

    final literal = reader.literalValue;

    if (literal is num || literal is String || literal is bool) {
      return literal;
    } else if (literal is List<DartObject>) {
      return literal
          .map((e) => _getLiteral(e, things.followedBy(['List'])))
          .toList();
    } else if (literal is Map<DartObject, DartObject>) {
      final mapThings = things.followedBy(['Map']);
      return literal.map((k, v) =>
          MapEntry(_getLiteral(k, mapThings), _getLiteral(v, mapThings)));
    }

    badType = things.followedBy(['$dartObject']).join(' > ');

    throwUnsupported(
        element,
        'The provided value is not supported: $badType. '
        'This may be an error in package:json_serializable. '
        'Please rerun your build with `--verbose` and file an issue.');
  }

  final defaultValueObject = obj.getField('defaultValue');

  Object defaultValueLiteral;

  final enumFields = iterateEnumFields(defaultValueObject.type);
  if (enumFields != null) {
    final enumValueNames =
        enumFields.map((p) => p.name).toList(growable: false);

    final enumValueName = enumValueForDartObject<String>(
        defaultValueObject, enumValueNames, (n) => n);

    defaultValueLiteral = '${defaultValueObject.type.name}.$enumValueName';
  } else {
    defaultValueLiteral = _getLiteral(defaultValueObject, []);
    if (defaultValueLiteral != null) {
      defaultValueLiteral = jsonLiteralAsDart(defaultValueLiteral);
    }
  }

  return _populateJsonKey(
    classAnnotation,
    element,
    defaultValue: defaultValueLiteral,
    disallowNullValue: obj.getField('disallowNullValue').toBoolValue(),
    ignore: obj.getField('ignore').toBoolValue(),
    includeIfNull: obj.getField('includeIfNull').toBoolValue(),
    name: obj.getField('name').toStringValue(),
    nullable: obj.getField('nullable').toBoolValue(),
    required: obj.getField('required').toBoolValue(),
  );
}

JsonKey _populateJsonKey(
  JsonSerializable classAnnotation,
  FieldElement element, {
  Object defaultValue,
  bool disallowNullValue,
  bool ignore,
  bool includeIfNull,
  String name,
  bool nullable,
  bool required,
}) {
  if (disallowNullValue == true) {
    if (includeIfNull == true) {
      throwUnsupported(
          element,
          'Cannot set both `disallowNullvalue` and `includeIfNull` to `true`. '
          'This leads to incompatible `toJson` and `fromJson` behavior.');
    }
  }

  final jsonKey = JsonKey(
    defaultValue: defaultValue,
    disallowNullValue: disallowNullValue ?? false,
    ignore: ignore ?? false,
    includeIfNull: _includeIfNull(
        includeIfNull, disallowNullValue, classAnnotation.includeIfNull),
    name: _encodedFieldName(classAnnotation, name, element),
    nullable: nullable ?? classAnnotation.nullable,
    required: required ?? false,
  );

  _explicitNullableExpando[jsonKey] = nullable != null;

  return jsonKey;
}

final _explicitNullableExpando = Expando<bool>('explicit nullable');

String _encodedFieldName(JsonSerializable classAnnotation,
    String jsonKeyNameValue, FieldElement fieldElement) {
  if (jsonKeyNameValue != null) {
    return jsonKeyNameValue;
  }

  switch (classAnnotation.fieldRename) {
    case FieldRename.none:
      return fieldElement.name;
    case FieldRename.snake:
      return snakeCase(fieldElement.name);
    case FieldRename.kebab:
      return kebabCase(fieldElement.name);
    default:
      throw FallThroughError();
  }
}

bool _includeIfNull(
    bool keyIncludeIfNull, bool keyDisallowNullValue, bool classIncludeIfNull) {
  if (keyDisallowNullValue == true) {
    assert(keyIncludeIfNull != true);
    return false;
  }
  return keyIncludeIfNull ?? classIncludeIfNull;
}
