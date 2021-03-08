// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.12

part of '_json_serializable_test_input.dart';

@ShouldThrow(
  'Error with `@JsonKey` on `field`. '
  '`defaultValue` is `Symbol`, it must be a literal.',
  element: 'field',
)
@JsonSerializable()
class DefaultWithSymbol {
  @JsonKey(defaultValue: #symbol)
  late Object field;

  DefaultWithSymbol();
}

int _function() => 42;

@ShouldThrow(
  'Error with `@JsonKey` on `field`. '
  '`defaultValue` is `Function`, it must be a literal.',
  element: 'field',
)
@JsonSerializable()
class DefaultWithFunction {
  @JsonKey(defaultValue: _function)
  Object? field;

  DefaultWithFunction();
}

@ShouldThrow(
  'Error with `@JsonKey` on `field`. '
  '`defaultValue` is `Type`, it must be a literal.',
  element: 'field',
)
@JsonSerializable()
class DefaultWithType {
  @JsonKey(defaultValue: Object)
  late Object field;

  DefaultWithType();
}

@ShouldThrow(
  'Error with `@JsonKey` on `field`. '
  '`defaultValue` is `Duration`, it must be a literal.',
  element: 'field',
)
@JsonSerializable()
class DefaultWithConstObject {
  @JsonKey(defaultValue: Duration())
  late Object field;

  DefaultWithConstObject();
}

enum Enum { value }

@ShouldThrow(
  'Error with `@JsonKey` on `field`. '
  '`defaultValue` is `List > Enum`, it must be a literal.',
  element: 'field',
)
@JsonSerializable()
class DefaultWithNestedEnum {
  @JsonKey(defaultValue: [Enum.value])
  late Object field;

  DefaultWithNestedEnum();
}

@ShouldGenerate(
  r'''
DefaultWithToJsonClass _$DefaultWithToJsonClassFromJson(
    Map<String, dynamic> json) {
  return DefaultWithToJsonClass()
    ..fieldDefaultValueToJson = DefaultWithToJsonClass._fromJson(
        json['fieldDefaultValueToJson'] == null
            ? 7
            : json['fieldDefaultValueToJson'] as String);
}
''',
  expectedLogItems: [],
)
@JsonSerializable(createToJson: false)
class DefaultWithToJsonClass {
  @JsonKey(defaultValue: 7, fromJson: _fromJson)
  late int fieldDefaultValueToJson;

  DefaultWithToJsonClass();

  static int _fromJson(String input) => 41;
}

@ShouldGenerate(
  r'''
DefaultWithDisallowNullRequiredClass
    _$DefaultWithDisallowNullRequiredClassFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['theField'], disallowNullValues: const ['theField']);
  return DefaultWithDisallowNullRequiredClass()
    ..theField = json['theField'] == null ? 7 : json['theField'] as int;
}
''',
  expectedLogItems: [],
)
@JsonSerializable(createToJson: false)
class DefaultWithDisallowNullRequiredClass {
  @JsonKey(defaultValue: 7, disallowNullValue: true, required: true)
  int? theField;

  DefaultWithDisallowNullRequiredClass();
}

@ShouldGenerate(r'''
DefaultDoubleConstants _$DefaultDoubleConstantsFromJson(
    Map<String, dynamic> json) {
  return DefaultDoubleConstants()
    ..defaultNan =
        (json['defaultNan'] == null ? double.nan : json['defaultNan'] as num)
            .toDouble()
    ..defaultNegativeInfinity = (json['defaultNegativeInfinity'] == null
            ? double.negativeInfinity
            : json['defaultNegativeInfinity'] as num)
        .toDouble()
    ..defaultInfinity = (json['defaultInfinity'] == null
            ? double.infinity
            : json['defaultInfinity'] as num)
        .toDouble()
    ..defaultMinPositive = (json['defaultMinPositive'] == null
            ? 5e-324
            : json['defaultMinPositive'] as num)
        .toDouble()
    ..defaultMaxFinite = (json['defaultMaxFinite'] == null
            ? 1.7976931348623157e+308
            : json['defaultMaxFinite'] as num)
        .toDouble();
}
''')
@JsonSerializable(createToJson: false)
class DefaultDoubleConstants {
  @JsonKey(defaultValue: double.nan)
  late double defaultNan;
  @JsonKey(defaultValue: double.negativeInfinity)
  late double defaultNegativeInfinity;
  @JsonKey(defaultValue: double.infinity)
  late double defaultInfinity;

  // Since these values can be represented as number literals, there is no
  // special handling. Including them here for completeness, though.
  @JsonKey(defaultValue: double.minPositive)
  late double defaultMinPositive;
  @JsonKey(defaultValue: double.maxFinite)
  late double defaultMaxFinite;

  DefaultDoubleConstants();
}
