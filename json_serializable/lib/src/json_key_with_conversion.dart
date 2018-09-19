// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'convert_pair.dart';
import 'json_literal_generator.dart';
import 'utils.dart';

final _jsonKeyChecker = const TypeChecker.fromRuntime(JsonKey);

DartObject _jsonKeyAnnotation(FieldElement element) =>
    _jsonKeyChecker.firstAnnotationOfExact(element) ??
    (element.getter == null
        ? null
        : _jsonKeyChecker.firstAnnotationOfExact(element.getter));

/// Returns `true` if [element] is annotated with [JsonKey].
bool hasJsonKeyAnnotation(FieldElement element) =>
    _jsonKeyAnnotation(element) != null;

final _jsonKeyExpando = Expando<JsonKey>();

JsonKey jsonKeyForField(FieldElement field, JsonSerializable classAnnotation) =>
    _jsonKeyExpando[field] ??= _from(field, classAnnotation);

JsonKey _from(FieldElement element, JsonSerializable classAnnotation) {
  // If an annotation exists on `element` the source is a 'real' field.
  // If the result is `null`, check the getter – it is a property.
  // TODO(kevmoo) setters: github.com/dart-lang/json_serializable/issues/24
  var obj = _jsonKeyAnnotation(element);

  if (obj == null) {
    return _populateJsonKey(classAnnotation, element);
  }

  Object _getLiteral(DartObject dartObject, Iterable<String> things) {
    if (dartObject.isNull) {
      return null;
    }

    var reader = ConstantReader(dartObject);

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

    var literal = reader.literalValue;

    if (literal is num || literal is String || literal is bool) {
      return literal;
    } else if (literal is List<DartObject>) {
      return literal
          .map((e) => _getLiteral(e, things.followedBy(['List'])))
          .toList();
    } else if (literal is Map<DartObject, DartObject>) {
      var mapThings = things.followedBy(['Map']);
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

  var defaultValueObject = obj.getField('defaultValue');

  Object defaultValueLiteral;

  var enumFields = iterateEnumFields(defaultValueObject.type);
  if (enumFields != null) {
    var allowedValues = enumFields.map((p) => p.name).toList();
    var enumValueIndex = defaultValueObject.getField('index').toIntValue();
    defaultValueLiteral =
        '${defaultValueObject.type.name}.${allowedValues[enumValueIndex]}';
  } else {
    defaultValueLiteral = _getLiteral(defaultValueObject, []);
    if (defaultValueLiteral != null) {
      defaultValueLiteral = jsonLiteralAsDart(defaultValueLiteral);
    }
  }

  var disallowNullValue = obj.getField('disallowNullValue').toBoolValue();
  var includeIfNull = obj.getField('includeIfNull').toBoolValue();

  if (disallowNullValue == true) {
    if (includeIfNull == true) {
      throwUnsupported(
          element,
          'Cannot set both `disallowNullvalue` and `includeIfNull` to `true`. '
          'This leads to incompatible `toJson` and `fromJson` behavior.');
    }
  }

  return _populateJsonKey(
    classAnnotation,
    element,
    name: obj.getField('name').toStringValue(),
    nullable: obj.getField('nullable').toBoolValue(),
    includeIfNull: includeIfNull,
    ignore: obj.getField('ignore').toBoolValue(),
    defaultValue: defaultValueLiteral,
    required: obj.getField('required').toBoolValue(),
    disallowNullValue: disallowNullValue,
    jsonConvertPair: ConvertPair(obj, element),
  );
}

JsonKey _populateJsonKey(
    JsonSerializable classAnnotation, FieldElement fieldElement,
    {String name,
    bool nullable,
    bool includeIfNull,
    bool ignore,
    Object defaultValue,
    bool required,
    bool disallowNullValue,
    ConvertPair jsonConvertPair}) {
  var jsonKey = JsonKey(
      name: _encodedFieldName(classAnnotation, name, fieldElement),
      nullable: nullable ?? classAnnotation.nullable,
      includeIfNull: _includeIfNull(
          includeIfNull, disallowNullValue, classAnnotation.includeIfNull),
      ignore: ignore ?? false,
      defaultValue: defaultValue,
      required: required ?? false,
      disallowNullValue: disallowNullValue ?? false);

  jsonConvertPair?.populate(jsonKey);

  return jsonKey;
}

String _encodedFieldName(JsonSerializable classAnnotation,
    String jsonKeyNameValue, FieldElement fieldElement) {
  if (jsonKeyNameValue != null) {
    return jsonKeyNameValue;
  }

  switch (classAnnotation.fieldRename) {
    case FieldRename.none:
      // noop
      break;
    case FieldRename.snake:
      return snakeCase(fieldElement.name);
    case FieldRename.kebab:
      return kebabCase(fieldElement.name);
  }

  return fieldElement.name;
}

bool _includeIfNull(
    bool keyIncludeIfNull, bool keyDisallowNullValue, bool classIncludeIfNull) {
  if (keyDisallowNullValue == true) {
    assert(keyIncludeIfNull != true);
    return false;
  }
  return keyIncludeIfNull ?? classIncludeIfNull;
}
