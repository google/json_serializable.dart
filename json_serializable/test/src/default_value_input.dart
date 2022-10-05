// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '_json_serializable_test_input.dart';

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. '
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

@ShouldGenerate(
  r'''
DefaultWithFunction _$DefaultWithFunctionFromJson(Map<String, dynamic> json) =>
    DefaultWithFunction()..field = json['field'] ?? _function();

Map<String, dynamic> _$DefaultWithFunctionToJson(
        DefaultWithFunction instance) =>
    <String, dynamic>{
      'field': instance.field,
    };
''',
)
@JsonSerializable()
class DefaultWithFunction {
  @JsonKey(defaultValue: _function)
  Object? field;

  DefaultWithFunction();
}

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. '
  '`defaultValue` is `List > Function`, it must be a literal.',
  element: 'field',
)
@JsonSerializable()
class DefaultWithFunctionInList {
  @JsonKey(defaultValue: [_function])
  Object? field;

  DefaultWithFunctionInList();
}

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. '
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
  'Error with `@JsonKey` on the `field` field. '
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
  'Error with `@JsonKey` on the `field` field. '
  '`defaultValue` is `List > Enum`, it must be a literal.',
  element: 'field',
)
@JsonSerializable()
class DefaultWithNestedEnum {
  @JsonKey(defaultValue: [Enum.value])
  late Object field;

  DefaultWithNestedEnum();
}

@ShouldThrow(
  '`JsonKey.nullForUndefinedEnumValue` cannot be used with '
  '`JsonKey.defaultValue`.',
  element: 'enumValue',
)
@JsonSerializable()
class BadEnumDefaultValue {
  @JsonKey(defaultValue: JsonKey.nullForUndefinedEnumValue)
  Enum? enumValue;

  BadEnumDefaultValue();
}

@ShouldGenerate(
  r'''
DefaultWithToJsonClass _$DefaultWithToJsonClassFromJson(
        Map<String, dynamic> json) =>
    DefaultWithToJsonClass()
      ..fieldDefaultValueToJson = json['fieldDefaultValueToJson'] == null
          ? 7
          : DefaultWithToJsonClass._fromJson(
              json['fieldDefaultValueToJson'] as String);
''',
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
  $checkKeys(
    json,
    requiredKeys: const ['theField'],
    disallowNullValues: const ['theField'],
  );
  return DefaultWithDisallowNullRequiredClass()
    ..theField = json['theField'] as int? ?? 7;
}
''',
  expectedLogItems: [
    'The `defaultValue` on field `theField` will have no effect because both '
        '`disallowNullValue` and `required` are set to `true`.',
  ],
)
@JsonSerializable(createToJson: false)
class DefaultWithDisallowNullRequiredClass {
  @JsonKey(defaultValue: 7, disallowNullValue: true, required: true)
  int? theField;

  DefaultWithDisallowNullRequiredClass();
}

@ShouldGenerate(
  r'''
CtorDefaultValueAndJsonKeyDefaultValue
    _$CtorDefaultValueAndJsonKeyDefaultValueFromJson(
            Map<String, dynamic> json) =>
        CtorDefaultValueAndJsonKeyDefaultValue(
          json['theField'] as int? ?? 7,
        );
''',
  expectedLogItems: [
    'The constructor parameter for `theField` has a default value `6`, but the '
        '`JsonKey.defaultValue` value `7` will be used for missing or `null` '
        'values in JSON decoding.',
  ],
)
@JsonSerializable(createToJson: false)
class CtorDefaultValueAndJsonKeyDefaultValue {
  @JsonKey(defaultValue: 7)
  final int theField;

  CtorDefaultValueAndJsonKeyDefaultValue([this.theField = 6]);
}

@ShouldGenerate(
  r'''
SameCtorAndJsonKeyDefaultValue _$SameCtorAndJsonKeyDefaultValueFromJson(
        Map<String, dynamic> json) =>
    SameCtorAndJsonKeyDefaultValue(
      json['theField'] as int? ?? 3,
    );
''',
  expectedLogItems: [
    'The default value `3` for `theField` is defined twice '
        'in the constructor and in the `JsonKey.defaultValue`.',
  ],
)
@JsonSerializable(createToJson: false)
class SameCtorAndJsonKeyDefaultValue {
  @JsonKey(defaultValue: 3)
  final int theField;

  SameCtorAndJsonKeyDefaultValue([this.theField = 3]);
}

@ShouldGenerate(r'''
DefaultDoubleConstants _$DefaultDoubleConstantsFromJson(
        Map<String, dynamic> json) =>
    DefaultDoubleConstants()
      ..defaultNan = (json['defaultNan'] as num?)?.toDouble() ?? double.nan
      ..defaultNegativeInfinity =
          (json['defaultNegativeInfinity'] as num?)?.toDouble() ??
              double.negativeInfinity
      ..defaultInfinity =
          (json['defaultInfinity'] as num?)?.toDouble() ?? double.infinity
      ..defaultMinPositive =
          (json['defaultMinPositive'] as num?)?.toDouble() ?? 5e-324
      ..defaultMaxFinite = (json['defaultMaxFinite'] as num?)?.toDouble() ??
          1.7976931348623157e+308;
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
