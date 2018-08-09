// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '_json_serializable_test_input.dart';

@ShouldThrow(
    'default values fail with symbol',
    'Error with `@JsonKey` on `field`. '
    '`defaultValue` is `Symbol`, it must be a literal.')
@JsonSerializable()
class DefaultWithSymbol {
  @JsonKey(defaultValue: #symbol)
  Object field;

  DefaultWithSymbol();
}

int _function() => 42;

@ShouldThrow(
    'default values fail with function',
    'Error with `@JsonKey` on `field`. '
    '`defaultValue` is `Function`, it must be a literal.')
@JsonSerializable()
class DefaultWithFunction {
  @JsonKey(defaultValue: _function)
  Object field;

  DefaultWithFunction();
}

@ShouldThrow(
    'default values fail with Type',
    'Error with `@JsonKey` on `field`. '
    '`defaultValue` is `Type`, it must be a literal.')
@JsonSerializable()
class DefaultWithType {
  @JsonKey(defaultValue: Object)
  Object field;

  DefaultWithType();
}

@ShouldThrow(
    'default values fail with const object',
    'Error with `@JsonKey` on `field`. '
    '`defaultValue` is `Duration`, it must be a literal.')
@JsonSerializable()
class DefaultWithConstObject {
  @JsonKey(defaultValue: Duration())
  Object field;

  DefaultWithConstObject();
}

enum Enum { value }

@ShouldThrow(
    'default values fail with nested enum',
    'Error with `@JsonKey` on `field`. '
    '`defaultValue` is `List > Enum`, it must be a literal.')
@JsonSerializable()
class DefaultWithNestedEnum {
  @JsonKey(defaultValue: [Enum.value])
  Object field;

  DefaultWithNestedEnum();
}

@ShouldThrow(
    'default values fail with non-nullable field',
    'Error with `@JsonKey` on `field`. '
    'Cannot use `defaultValue` on a field with `nullable` false.')
@JsonSerializable()
class DefaultWithNonNullableField {
  @JsonKey(defaultValue: 42, nullable: false)
  Object field;

  DefaultWithNonNullableField();
}

@ShouldThrow(
    'default values fail with non-nullable class',
    'Error with `@JsonKey` on `field`. '
    'Cannot use `defaultValue` on a field with `nullable` false.')
@JsonSerializable(nullable: false)
class DefaultWithNonNullableClass {
  @JsonKey(defaultValue: 42)
  Object field;

  DefaultWithNonNullableClass();
}
