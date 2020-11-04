// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.12

import 'package:json_annotation/json_annotation.dart';
import 'enum_type.dart';

part 'input.type_map.g.dart';

@JsonSerializable()
class SimpleClass {
  final Map value;

  @JsonKey(defaultValue: {'a': 1})
  Map withDefault;

  SimpleClass(
    this.value,
    this.withDefault,
  );

  factory SimpleClass.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassToJson(this);
}

@JsonSerializable()
class SimpleClassNullable {
  final Map? value;

  @JsonKey(defaultValue: {'a': 1})
  Map? withDefault;

  SimpleClassNullable(
    this.value,
    this.withDefault,
  );

  factory SimpleClassNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToBigInt {
  final Map<BigInt, BigInt> value;

  SimpleClassOfBigIntToBigInt(
    this.value,
  );

  factory SimpleClassOfBigIntToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToBigInt {
  final Map<BigInt, BigInt>? value;

  SimpleClassNullableOfBigIntToBigInt(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToBigInt {
  final Map<DateTime, BigInt> value;

  SimpleClassOfDateTimeToBigInt(
    this.value,
  );

  factory SimpleClassOfDateTimeToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToBigInt {
  final Map<DateTime, BigInt>? value;

  SimpleClassNullableOfDateTimeToBigInt(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToBigInt {
  final Map<dynamic, BigInt> value;

  SimpleClassOfDynamicToBigInt(
    this.value,
  );

  factory SimpleClassOfDynamicToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToBigInt {
  final Map<dynamic, BigInt>? value;

  SimpleClassNullableOfDynamicToBigInt(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToBigInt {
  final Map<EnumType, BigInt> value;

  SimpleClassOfEnumTypeToBigInt(
    this.value,
  );

  factory SimpleClassOfEnumTypeToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToBigInt {
  final Map<EnumType, BigInt>? value;

  SimpleClassNullableOfEnumTypeToBigInt(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToBigInt {
  final Map<int, BigInt> value;

  SimpleClassOfIntToBigInt(
    this.value,
  );

  factory SimpleClassOfIntToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToBigInt {
  final Map<int, BigInt>? value;

  SimpleClassNullableOfIntToBigInt(
    this.value,
  );

  factory SimpleClassNullableOfIntToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToBigInt {
  final Map<Object, BigInt> value;

  SimpleClassOfObjectToBigInt(
    this.value,
  );

  factory SimpleClassOfObjectToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToBigInt {
  final Map<Object, BigInt>? value;

  SimpleClassNullableOfObjectToBigInt(
    this.value,
  );

  factory SimpleClassNullableOfObjectToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToBigInt {
  final Map<String, BigInt> value;

  SimpleClassOfStringToBigInt(
    this.value,
  );

  factory SimpleClassOfStringToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToBigInt {
  final Map<String, BigInt>? value;

  SimpleClassNullableOfStringToBigInt(
    this.value,
  );

  factory SimpleClassNullableOfStringToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToBigInt {
  final Map<Uri, BigInt> value;

  SimpleClassOfUriToBigInt(
    this.value,
  );

  factory SimpleClassOfUriToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToBigInt {
  final Map<Uri, BigInt>? value;

  SimpleClassNullableOfUriToBigInt(
    this.value,
  );

  factory SimpleClassNullableOfUriToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToBigIntNullable {
  final Map<BigInt, BigInt?> value;

  SimpleClassOfBigIntToBigIntNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToBigIntNullable {
  final Map<BigInt, BigInt?>? value;

  SimpleClassNullableOfBigIntToBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToBigIntNullable {
  final Map<DateTime, BigInt?> value;

  SimpleClassOfDateTimeToBigIntNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToBigIntNullable {
  final Map<DateTime, BigInt?>? value;

  SimpleClassNullableOfDateTimeToBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToBigIntNullable {
  final Map<dynamic, BigInt?> value;

  SimpleClassOfDynamicToBigIntNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToBigIntNullable {
  final Map<dynamic, BigInt?>? value;

  SimpleClassNullableOfDynamicToBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToBigIntNullable {
  final Map<EnumType, BigInt?> value;

  SimpleClassOfEnumTypeToBigIntNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToBigIntNullable {
  final Map<EnumType, BigInt?>? value;

  SimpleClassNullableOfEnumTypeToBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToBigIntNullable {
  final Map<int, BigInt?> value;

  SimpleClassOfIntToBigIntNullable(
    this.value,
  );

  factory SimpleClassOfIntToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfIntToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfIntToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToBigIntNullable {
  final Map<int, BigInt?>? value;

  SimpleClassNullableOfIntToBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToBigIntNullable {
  final Map<Object, BigInt?> value;

  SimpleClassOfObjectToBigIntNullable(
    this.value,
  );

  factory SimpleClassOfObjectToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToBigIntNullable {
  final Map<Object, BigInt?>? value;

  SimpleClassNullableOfObjectToBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToBigIntNullable {
  final Map<String, BigInt?> value;

  SimpleClassOfStringToBigIntNullable(
    this.value,
  );

  factory SimpleClassOfStringToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToBigIntNullable {
  final Map<String, BigInt?>? value;

  SimpleClassNullableOfStringToBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToBigIntNullable {
  final Map<Uri, BigInt?> value;

  SimpleClassOfUriToBigIntNullable(
    this.value,
  );

  factory SimpleClassOfUriToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfUriToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfUriToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToBigIntNullable {
  final Map<Uri, BigInt?>? value;

  SimpleClassNullableOfUriToBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToBool {
  final Map<BigInt, bool> value;

  SimpleClassOfBigIntToBool(
    this.value,
  );

  factory SimpleClassOfBigIntToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToBool {
  final Map<BigInt, bool>? value;

  SimpleClassNullableOfBigIntToBool(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToBool.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToBoolFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToBool {
  final Map<DateTime, bool> value;

  SimpleClassOfDateTimeToBool(
    this.value,
  );

  factory SimpleClassOfDateTimeToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToBool {
  final Map<DateTime, bool>? value;

  SimpleClassNullableOfDateTimeToBool(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToBool.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToBoolFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToBool {
  final Map<dynamic, bool> value;

  SimpleClassOfDynamicToBool(
    this.value,
  );

  factory SimpleClassOfDynamicToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToBool {
  final Map<dynamic, bool>? value;

  SimpleClassNullableOfDynamicToBool(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToBool.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToBoolFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToBool {
  final Map<EnumType, bool> value;

  SimpleClassOfEnumTypeToBool(
    this.value,
  );

  factory SimpleClassOfEnumTypeToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToBool {
  final Map<EnumType, bool>? value;

  SimpleClassNullableOfEnumTypeToBool(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToBool.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToBoolFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToBool {
  final Map<int, bool> value;

  SimpleClassOfIntToBool(
    this.value,
  );

  factory SimpleClassOfIntToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToBool {
  final Map<int, bool>? value;

  SimpleClassNullableOfIntToBool(
    this.value,
  );

  factory SimpleClassNullableOfIntToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToBool {
  final Map<Object, bool> value;

  SimpleClassOfObjectToBool(
    this.value,
  );

  factory SimpleClassOfObjectToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToBool {
  final Map<Object, bool>? value;

  SimpleClassNullableOfObjectToBool(
    this.value,
  );

  factory SimpleClassNullableOfObjectToBool.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToBoolFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToBool {
  final Map<String, bool> value;

  SimpleClassOfStringToBool(
    this.value,
  );

  factory SimpleClassOfStringToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToBool {
  final Map<String, bool>? value;

  SimpleClassNullableOfStringToBool(
    this.value,
  );

  factory SimpleClassNullableOfStringToBool.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToBoolFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToBool {
  final Map<Uri, bool> value;

  SimpleClassOfUriToBool(
    this.value,
  );

  factory SimpleClassOfUriToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToBool {
  final Map<Uri, bool>? value;

  SimpleClassNullableOfUriToBool(
    this.value,
  );

  factory SimpleClassNullableOfUriToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToBoolNullable {
  final Map<BigInt, bool?> value;

  SimpleClassOfBigIntToBoolNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToBoolNullable {
  final Map<BigInt, bool?>? value;

  SimpleClassNullableOfBigIntToBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToBoolNullable {
  final Map<DateTime, bool?> value;

  SimpleClassOfDateTimeToBoolNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToBoolNullable {
  final Map<DateTime, bool?>? value;

  SimpleClassNullableOfDateTimeToBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToBoolNullable {
  final Map<dynamic, bool?> value;

  SimpleClassOfDynamicToBoolNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToBoolNullable {
  final Map<dynamic, bool?>? value;

  SimpleClassNullableOfDynamicToBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToBoolNullable {
  final Map<EnumType, bool?> value;

  SimpleClassOfEnumTypeToBoolNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToBoolNullable {
  final Map<EnumType, bool?>? value;

  SimpleClassNullableOfEnumTypeToBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToBoolNullable {
  final Map<int, bool?> value;

  SimpleClassOfIntToBoolNullable(
    this.value,
  );

  factory SimpleClassOfIntToBoolNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToBoolNullable {
  final Map<int, bool?>? value;

  SimpleClassNullableOfIntToBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToBoolNullable {
  final Map<Object, bool?> value;

  SimpleClassOfObjectToBoolNullable(
    this.value,
  );

  factory SimpleClassOfObjectToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToBoolNullable {
  final Map<Object, bool?>? value;

  SimpleClassNullableOfObjectToBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToBoolNullable {
  final Map<String, bool?> value;

  SimpleClassOfStringToBoolNullable(
    this.value,
  );

  factory SimpleClassOfStringToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToBoolNullable {
  final Map<String, bool?>? value;

  SimpleClassNullableOfStringToBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToBoolNullable {
  final Map<Uri, bool?> value;

  SimpleClassOfUriToBoolNullable(
    this.value,
  );

  factory SimpleClassOfUriToBoolNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToBoolNullable {
  final Map<Uri, bool?>? value;

  SimpleClassNullableOfUriToBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDateTime {
  final Map<BigInt, DateTime> value;

  SimpleClassOfBigIntToDateTime(
    this.value,
  );

  factory SimpleClassOfBigIntToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDateTime {
  final Map<BigInt, DateTime>? value;

  SimpleClassNullableOfBigIntToDateTime(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToDateTime {
  final Map<DateTime, DateTime> value;

  SimpleClassOfDateTimeToDateTime(
    this.value,
  );

  factory SimpleClassOfDateTimeToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDateTime {
  final Map<DateTime, DateTime>? value;

  SimpleClassNullableOfDateTimeToDateTime(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToDateTime {
  final Map<dynamic, DateTime> value;

  SimpleClassOfDynamicToDateTime(
    this.value,
  );

  factory SimpleClassOfDynamicToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDateTime {
  final Map<dynamic, DateTime>? value;

  SimpleClassNullableOfDynamicToDateTime(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToDateTime {
  final Map<EnumType, DateTime> value;

  SimpleClassOfEnumTypeToDateTime(
    this.value,
  );

  factory SimpleClassOfEnumTypeToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDateTime {
  final Map<EnumType, DateTime>? value;

  SimpleClassNullableOfEnumTypeToDateTime(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToDateTime {
  final Map<int, DateTime> value;

  SimpleClassOfIntToDateTime(
    this.value,
  );

  factory SimpleClassOfIntToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDateTime {
  final Map<int, DateTime>? value;

  SimpleClassNullableOfIntToDateTime(
    this.value,
  );

  factory SimpleClassNullableOfIntToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToDateTime {
  final Map<Object, DateTime> value;

  SimpleClassOfObjectToDateTime(
    this.value,
  );

  factory SimpleClassOfObjectToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDateTime {
  final Map<Object, DateTime>? value;

  SimpleClassNullableOfObjectToDateTime(
    this.value,
  );

  factory SimpleClassNullableOfObjectToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToDateTime {
  final Map<String, DateTime> value;

  SimpleClassOfStringToDateTime(
    this.value,
  );

  factory SimpleClassOfStringToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDateTime {
  final Map<String, DateTime>? value;

  SimpleClassNullableOfStringToDateTime(
    this.value,
  );

  factory SimpleClassNullableOfStringToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToDateTime {
  final Map<Uri, DateTime> value;

  SimpleClassOfUriToDateTime(
    this.value,
  );

  factory SimpleClassOfUriToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDateTime {
  final Map<Uri, DateTime>? value;

  SimpleClassNullableOfUriToDateTime(
    this.value,
  );

  factory SimpleClassNullableOfUriToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDateTimeNullable {
  final Map<BigInt, DateTime?> value;

  SimpleClassOfBigIntToDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDateTimeNullable {
  final Map<BigInt, DateTime?>? value;

  SimpleClassNullableOfBigIntToDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToDateTimeNullable {
  final Map<DateTime, DateTime?> value;

  SimpleClassOfDateTimeToDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDateTimeNullable {
  final Map<DateTime, DateTime?>? value;

  SimpleClassNullableOfDateTimeToDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToDateTimeNullable {
  final Map<dynamic, DateTime?> value;

  SimpleClassOfDynamicToDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDateTimeNullable {
  final Map<dynamic, DateTime?>? value;

  SimpleClassNullableOfDynamicToDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToDateTimeNullable {
  final Map<EnumType, DateTime?> value;

  SimpleClassOfEnumTypeToDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDateTimeNullable {
  final Map<EnumType, DateTime?>? value;

  SimpleClassNullableOfEnumTypeToDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToDateTimeNullable {
  final Map<int, DateTime?> value;

  SimpleClassOfIntToDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfIntToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfIntToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDateTimeNullable {
  final Map<int, DateTime?>? value;

  SimpleClassNullableOfIntToDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToDateTimeNullable {
  final Map<Object, DateTime?> value;

  SimpleClassOfObjectToDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfObjectToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDateTimeNullable {
  final Map<Object, DateTime?>? value;

  SimpleClassNullableOfObjectToDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToDateTimeNullable {
  final Map<String, DateTime?> value;

  SimpleClassOfStringToDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfStringToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDateTimeNullable {
  final Map<String, DateTime?>? value;

  SimpleClassNullableOfStringToDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToDateTimeNullable {
  final Map<Uri, DateTime?> value;

  SimpleClassOfUriToDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfUriToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfUriToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDateTimeNullable {
  final Map<Uri, DateTime?>? value;

  SimpleClassNullableOfUriToDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDouble {
  final Map<BigInt, double> value;

  SimpleClassOfBigIntToDouble(
    this.value,
  );

  factory SimpleClassOfBigIntToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDouble {
  final Map<BigInt, double>? value;

  SimpleClassNullableOfBigIntToDouble(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToDouble {
  final Map<DateTime, double> value;

  SimpleClassOfDateTimeToDouble(
    this.value,
  );

  factory SimpleClassOfDateTimeToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDouble {
  final Map<DateTime, double>? value;

  SimpleClassNullableOfDateTimeToDouble(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToDouble {
  final Map<dynamic, double> value;

  SimpleClassOfDynamicToDouble(
    this.value,
  );

  factory SimpleClassOfDynamicToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDouble {
  final Map<dynamic, double>? value;

  SimpleClassNullableOfDynamicToDouble(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToDouble {
  final Map<EnumType, double> value;

  SimpleClassOfEnumTypeToDouble(
    this.value,
  );

  factory SimpleClassOfEnumTypeToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDouble {
  final Map<EnumType, double>? value;

  SimpleClassNullableOfEnumTypeToDouble(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToDouble {
  final Map<int, double> value;

  SimpleClassOfIntToDouble(
    this.value,
  );

  factory SimpleClassOfIntToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDouble {
  final Map<int, double>? value;

  SimpleClassNullableOfIntToDouble(
    this.value,
  );

  factory SimpleClassNullableOfIntToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToDouble {
  final Map<Object, double> value;

  SimpleClassOfObjectToDouble(
    this.value,
  );

  factory SimpleClassOfObjectToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDouble {
  final Map<Object, double>? value;

  SimpleClassNullableOfObjectToDouble(
    this.value,
  );

  factory SimpleClassNullableOfObjectToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToDouble {
  final Map<String, double> value;

  SimpleClassOfStringToDouble(
    this.value,
  );

  factory SimpleClassOfStringToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDouble {
  final Map<String, double>? value;

  SimpleClassNullableOfStringToDouble(
    this.value,
  );

  factory SimpleClassNullableOfStringToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToDouble {
  final Map<Uri, double> value;

  SimpleClassOfUriToDouble(
    this.value,
  );

  factory SimpleClassOfUriToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDouble {
  final Map<Uri, double>? value;

  SimpleClassNullableOfUriToDouble(
    this.value,
  );

  factory SimpleClassNullableOfUriToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDoubleNullable {
  final Map<BigInt, double?> value;

  SimpleClassOfBigIntToDoubleNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDoubleNullable {
  final Map<BigInt, double?>? value;

  SimpleClassNullableOfBigIntToDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToDoubleNullable {
  final Map<DateTime, double?> value;

  SimpleClassOfDateTimeToDoubleNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDoubleNullable {
  final Map<DateTime, double?>? value;

  SimpleClassNullableOfDateTimeToDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToDoubleNullable {
  final Map<dynamic, double?> value;

  SimpleClassOfDynamicToDoubleNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDoubleNullable {
  final Map<dynamic, double?>? value;

  SimpleClassNullableOfDynamicToDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToDoubleNullable {
  final Map<EnumType, double?> value;

  SimpleClassOfEnumTypeToDoubleNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDoubleNullable {
  final Map<EnumType, double?>? value;

  SimpleClassNullableOfEnumTypeToDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToDoubleNullable {
  final Map<int, double?> value;

  SimpleClassOfIntToDoubleNullable(
    this.value,
  );

  factory SimpleClassOfIntToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfIntToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDoubleNullable {
  final Map<int, double?>? value;

  SimpleClassNullableOfIntToDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToDoubleNullable {
  final Map<Object, double?> value;

  SimpleClassOfObjectToDoubleNullable(
    this.value,
  );

  factory SimpleClassOfObjectToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDoubleNullable {
  final Map<Object, double?>? value;

  SimpleClassNullableOfObjectToDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToDoubleNullable {
  final Map<String, double?> value;

  SimpleClassOfStringToDoubleNullable(
    this.value,
  );

  factory SimpleClassOfStringToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDoubleNullable {
  final Map<String, double?>? value;

  SimpleClassNullableOfStringToDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToDoubleNullable {
  final Map<Uri, double?> value;

  SimpleClassOfUriToDoubleNullable(
    this.value,
  );

  factory SimpleClassOfUriToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfUriToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDoubleNullable {
  final Map<Uri, double?>? value;

  SimpleClassNullableOfUriToDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDuration {
  final Map<BigInt, Duration> value;

  SimpleClassOfBigIntToDuration(
    this.value,
  );

  factory SimpleClassOfBigIntToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDuration {
  final Map<BigInt, Duration>? value;

  SimpleClassNullableOfBigIntToDuration(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToDuration {
  final Map<DateTime, Duration> value;

  SimpleClassOfDateTimeToDuration(
    this.value,
  );

  factory SimpleClassOfDateTimeToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDuration {
  final Map<DateTime, Duration>? value;

  SimpleClassNullableOfDateTimeToDuration(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToDuration {
  final Map<dynamic, Duration> value;

  SimpleClassOfDynamicToDuration(
    this.value,
  );

  factory SimpleClassOfDynamicToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDuration {
  final Map<dynamic, Duration>? value;

  SimpleClassNullableOfDynamicToDuration(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToDuration {
  final Map<EnumType, Duration> value;

  SimpleClassOfEnumTypeToDuration(
    this.value,
  );

  factory SimpleClassOfEnumTypeToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDuration {
  final Map<EnumType, Duration>? value;

  SimpleClassNullableOfEnumTypeToDuration(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToDuration {
  final Map<int, Duration> value;

  SimpleClassOfIntToDuration(
    this.value,
  );

  factory SimpleClassOfIntToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDuration {
  final Map<int, Duration>? value;

  SimpleClassNullableOfIntToDuration(
    this.value,
  );

  factory SimpleClassNullableOfIntToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToDuration {
  final Map<Object, Duration> value;

  SimpleClassOfObjectToDuration(
    this.value,
  );

  factory SimpleClassOfObjectToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDuration {
  final Map<Object, Duration>? value;

  SimpleClassNullableOfObjectToDuration(
    this.value,
  );

  factory SimpleClassNullableOfObjectToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToDuration {
  final Map<String, Duration> value;

  SimpleClassOfStringToDuration(
    this.value,
  );

  factory SimpleClassOfStringToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDuration {
  final Map<String, Duration>? value;

  SimpleClassNullableOfStringToDuration(
    this.value,
  );

  factory SimpleClassNullableOfStringToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToDuration {
  final Map<Uri, Duration> value;

  SimpleClassOfUriToDuration(
    this.value,
  );

  factory SimpleClassOfUriToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDuration {
  final Map<Uri, Duration>? value;

  SimpleClassNullableOfUriToDuration(
    this.value,
  );

  factory SimpleClassNullableOfUriToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDurationNullable {
  final Map<BigInt, Duration?> value;

  SimpleClassOfBigIntToDurationNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDurationNullable {
  final Map<BigInt, Duration?>? value;

  SimpleClassNullableOfBigIntToDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToDurationNullable {
  final Map<DateTime, Duration?> value;

  SimpleClassOfDateTimeToDurationNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDurationNullable {
  final Map<DateTime, Duration?>? value;

  SimpleClassNullableOfDateTimeToDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToDurationNullable {
  final Map<dynamic, Duration?> value;

  SimpleClassOfDynamicToDurationNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDurationNullable {
  final Map<dynamic, Duration?>? value;

  SimpleClassNullableOfDynamicToDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToDurationNullable {
  final Map<EnumType, Duration?> value;

  SimpleClassOfEnumTypeToDurationNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDurationNullable {
  final Map<EnumType, Duration?>? value;

  SimpleClassNullableOfEnumTypeToDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToDurationNullable {
  final Map<int, Duration?> value;

  SimpleClassOfIntToDurationNullable(
    this.value,
  );

  factory SimpleClassOfIntToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfIntToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDurationNullable {
  final Map<int, Duration?>? value;

  SimpleClassNullableOfIntToDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToDurationNullable {
  final Map<Object, Duration?> value;

  SimpleClassOfObjectToDurationNullable(
    this.value,
  );

  factory SimpleClassOfObjectToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDurationNullable {
  final Map<Object, Duration?>? value;

  SimpleClassNullableOfObjectToDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToDurationNullable {
  final Map<String, Duration?> value;

  SimpleClassOfStringToDurationNullable(
    this.value,
  );

  factory SimpleClassOfStringToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDurationNullable {
  final Map<String, Duration?>? value;

  SimpleClassNullableOfStringToDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToDurationNullable {
  final Map<Uri, Duration?> value;

  SimpleClassOfUriToDurationNullable(
    this.value,
  );

  factory SimpleClassOfUriToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfUriToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDurationNullable {
  final Map<Uri, Duration?>? value;

  SimpleClassNullableOfUriToDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDynamic {
  final Map<BigInt, dynamic> value;

  SimpleClassOfBigIntToDynamic(
    this.value,
  );

  factory SimpleClassOfBigIntToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDynamic {
  final Map<BigInt, dynamic>? value;

  SimpleClassNullableOfBigIntToDynamic(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToDynamic.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToDynamicFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToDynamic {
  final Map<DateTime, dynamic> value;

  SimpleClassOfDateTimeToDynamic(
    this.value,
  );

  factory SimpleClassOfDateTimeToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDynamic {
  final Map<DateTime, dynamic>? value;

  SimpleClassNullableOfDateTimeToDynamic(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToDynamic.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToDynamicFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToDynamic {
  final Map<dynamic, dynamic> value;

  SimpleClassOfDynamicToDynamic(
    this.value,
  );

  factory SimpleClassOfDynamicToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDynamic {
  final Map<dynamic, dynamic>? value;

  SimpleClassNullableOfDynamicToDynamic(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToDynamic.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToDynamicFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToDynamic {
  final Map<EnumType, dynamic> value;

  SimpleClassOfEnumTypeToDynamic(
    this.value,
  );

  factory SimpleClassOfEnumTypeToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDynamic {
  final Map<EnumType, dynamic>? value;

  SimpleClassNullableOfEnumTypeToDynamic(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToDynamic.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToDynamicFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToDynamic {
  final Map<int, dynamic> value;

  SimpleClassOfIntToDynamic(
    this.value,
  );

  factory SimpleClassOfIntToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDynamic {
  final Map<int, dynamic>? value;

  SimpleClassNullableOfIntToDynamic(
    this.value,
  );

  factory SimpleClassNullableOfIntToDynamic.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToDynamicFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToDynamic {
  final Map<Object, dynamic> value;

  SimpleClassOfObjectToDynamic(
    this.value,
  );

  factory SimpleClassOfObjectToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDynamic {
  final Map<Object, dynamic>? value;

  SimpleClassNullableOfObjectToDynamic(
    this.value,
  );

  factory SimpleClassNullableOfObjectToDynamic.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToDynamicFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToDynamic {
  final Map<String, dynamic> value;

  SimpleClassOfStringToDynamic(
    this.value,
  );

  factory SimpleClassOfStringToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDynamic {
  final Map<String, dynamic>? value;

  SimpleClassNullableOfStringToDynamic(
    this.value,
  );

  factory SimpleClassNullableOfStringToDynamic.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToDynamicFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToDynamic {
  final Map<Uri, dynamic> value;

  SimpleClassOfUriToDynamic(
    this.value,
  );

  factory SimpleClassOfUriToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDynamic {
  final Map<Uri, dynamic>? value;

  SimpleClassNullableOfUriToDynamic(
    this.value,
  );

  factory SimpleClassNullableOfUriToDynamic.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDynamicFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToEnumType {
  final Map<BigInt, EnumType> value;

  SimpleClassOfBigIntToEnumType(
    this.value,
  );

  factory SimpleClassOfBigIntToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToEnumType {
  final Map<BigInt, EnumType>? value;

  SimpleClassNullableOfBigIntToEnumType(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToEnumType {
  final Map<DateTime, EnumType> value;

  SimpleClassOfDateTimeToEnumType(
    this.value,
  );

  factory SimpleClassOfDateTimeToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToEnumType {
  final Map<DateTime, EnumType>? value;

  SimpleClassNullableOfDateTimeToEnumType(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToEnumType {
  final Map<dynamic, EnumType> value;

  SimpleClassOfDynamicToEnumType(
    this.value,
  );

  factory SimpleClassOfDynamicToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToEnumType {
  final Map<dynamic, EnumType>? value;

  SimpleClassNullableOfDynamicToEnumType(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToEnumType {
  final Map<EnumType, EnumType> value;

  SimpleClassOfEnumTypeToEnumType(
    this.value,
  );

  factory SimpleClassOfEnumTypeToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToEnumType {
  final Map<EnumType, EnumType>? value;

  SimpleClassNullableOfEnumTypeToEnumType(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToEnumType {
  final Map<int, EnumType> value;

  SimpleClassOfIntToEnumType(
    this.value,
  );

  factory SimpleClassOfIntToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToEnumType {
  final Map<int, EnumType>? value;

  SimpleClassNullableOfIntToEnumType(
    this.value,
  );

  factory SimpleClassNullableOfIntToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToEnumType {
  final Map<Object, EnumType> value;

  SimpleClassOfObjectToEnumType(
    this.value,
  );

  factory SimpleClassOfObjectToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToEnumType {
  final Map<Object, EnumType>? value;

  SimpleClassNullableOfObjectToEnumType(
    this.value,
  );

  factory SimpleClassNullableOfObjectToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToEnumType {
  final Map<String, EnumType> value;

  SimpleClassOfStringToEnumType(
    this.value,
  );

  factory SimpleClassOfStringToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToEnumType {
  final Map<String, EnumType>? value;

  SimpleClassNullableOfStringToEnumType(
    this.value,
  );

  factory SimpleClassNullableOfStringToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToEnumType {
  final Map<Uri, EnumType> value;

  SimpleClassOfUriToEnumType(
    this.value,
  );

  factory SimpleClassOfUriToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToEnumType {
  final Map<Uri, EnumType>? value;

  SimpleClassNullableOfUriToEnumType(
    this.value,
  );

  factory SimpleClassNullableOfUriToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToEnumTypeNullable {
  final Map<BigInt, EnumType?> value;

  SimpleClassOfBigIntToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToEnumTypeNullable {
  final Map<BigInt, EnumType?>? value;

  SimpleClassNullableOfBigIntToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToEnumTypeNullable {
  final Map<DateTime, EnumType?> value;

  SimpleClassOfDateTimeToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToEnumTypeNullable {
  final Map<DateTime, EnumType?>? value;

  SimpleClassNullableOfDateTimeToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToEnumTypeNullable {
  final Map<dynamic, EnumType?> value;

  SimpleClassOfDynamicToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToEnumTypeNullable {
  final Map<dynamic, EnumType?>? value;

  SimpleClassNullableOfDynamicToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToEnumTypeNullable {
  final Map<EnumType, EnumType?> value;

  SimpleClassOfEnumTypeToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToEnumTypeNullable {
  final Map<EnumType, EnumType?>? value;

  SimpleClassNullableOfEnumTypeToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToEnumTypeNullable {
  final Map<int, EnumType?> value;

  SimpleClassOfIntToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfIntToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfIntToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfIntToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToEnumTypeNullable {
  final Map<int, EnumType?>? value;

  SimpleClassNullableOfIntToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToEnumTypeNullable {
  final Map<Object, EnumType?> value;

  SimpleClassOfObjectToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfObjectToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToEnumTypeNullable {
  final Map<Object, EnumType?>? value;

  SimpleClassNullableOfObjectToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToEnumTypeNullable {
  final Map<String, EnumType?> value;

  SimpleClassOfStringToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfStringToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToEnumTypeNullable {
  final Map<String, EnumType?>? value;

  SimpleClassNullableOfStringToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToEnumTypeNullable {
  final Map<Uri, EnumType?> value;

  SimpleClassOfUriToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfUriToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfUriToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfUriToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToEnumTypeNullable {
  final Map<Uri, EnumType?>? value;

  SimpleClassNullableOfUriToEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToInt {
  final Map<BigInt, int> value;

  SimpleClassOfBigIntToInt(
    this.value,
  );

  factory SimpleClassOfBigIntToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToInt {
  final Map<BigInt, int>? value;

  SimpleClassNullableOfBigIntToInt(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToInt {
  final Map<DateTime, int> value;

  SimpleClassOfDateTimeToInt(
    this.value,
  );

  factory SimpleClassOfDateTimeToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToInt {
  final Map<DateTime, int>? value;

  SimpleClassNullableOfDateTimeToInt(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToInt {
  final Map<dynamic, int> value;

  SimpleClassOfDynamicToInt(
    this.value,
  );

  factory SimpleClassOfDynamicToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToInt {
  final Map<dynamic, int>? value;

  SimpleClassNullableOfDynamicToInt(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToInt {
  final Map<EnumType, int> value;

  SimpleClassOfEnumTypeToInt(
    this.value,
  );

  factory SimpleClassOfEnumTypeToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToInt {
  final Map<EnumType, int>? value;

  SimpleClassNullableOfEnumTypeToInt(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToInt {
  final Map<int, int> value;

  SimpleClassOfIntToInt(
    this.value,
  );

  factory SimpleClassOfIntToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToInt {
  final Map<int, int>? value;

  SimpleClassNullableOfIntToInt(
    this.value,
  );

  factory SimpleClassNullableOfIntToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToInt {
  final Map<Object, int> value;

  SimpleClassOfObjectToInt(
    this.value,
  );

  factory SimpleClassOfObjectToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToInt {
  final Map<Object, int>? value;

  SimpleClassNullableOfObjectToInt(
    this.value,
  );

  factory SimpleClassNullableOfObjectToInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToInt {
  final Map<String, int> value;

  SimpleClassOfStringToInt(
    this.value,
  );

  factory SimpleClassOfStringToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToInt {
  final Map<String, int>? value;

  SimpleClassNullableOfStringToInt(
    this.value,
  );

  factory SimpleClassNullableOfStringToInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToInt {
  final Map<Uri, int> value;

  SimpleClassOfUriToInt(
    this.value,
  );

  factory SimpleClassOfUriToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToInt {
  final Map<Uri, int>? value;

  SimpleClassNullableOfUriToInt(
    this.value,
  );

  factory SimpleClassNullableOfUriToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToIntNullable {
  final Map<BigInt, int?> value;

  SimpleClassOfBigIntToIntNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToIntNullable {
  final Map<BigInt, int?>? value;

  SimpleClassNullableOfBigIntToIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToIntNullable {
  final Map<DateTime, int?> value;

  SimpleClassOfDateTimeToIntNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToIntNullable {
  final Map<DateTime, int?>? value;

  SimpleClassNullableOfDateTimeToIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToIntNullable {
  final Map<dynamic, int?> value;

  SimpleClassOfDynamicToIntNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToIntNullable {
  final Map<dynamic, int?>? value;

  SimpleClassNullableOfDynamicToIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToIntNullable {
  final Map<EnumType, int?> value;

  SimpleClassOfEnumTypeToIntNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToIntNullable {
  final Map<EnumType, int?>? value;

  SimpleClassNullableOfEnumTypeToIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToIntNullable {
  final Map<int, int?> value;

  SimpleClassOfIntToIntNullable(
    this.value,
  );

  factory SimpleClassOfIntToIntNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToIntNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToIntNullable {
  final Map<int, int?>? value;

  SimpleClassNullableOfIntToIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToIntNullable {
  final Map<Object, int?> value;

  SimpleClassOfObjectToIntNullable(
    this.value,
  );

  factory SimpleClassOfObjectToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToIntNullable {
  final Map<Object, int?>? value;

  SimpleClassNullableOfObjectToIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToIntNullable {
  final Map<String, int?> value;

  SimpleClassOfStringToIntNullable(
    this.value,
  );

  factory SimpleClassOfStringToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToIntNullable {
  final Map<String, int?>? value;

  SimpleClassNullableOfStringToIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToIntNullable {
  final Map<Uri, int?> value;

  SimpleClassOfUriToIntNullable(
    this.value,
  );

  factory SimpleClassOfUriToIntNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToIntNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToIntNullable {
  final Map<Uri, int?>? value;

  SimpleClassNullableOfUriToIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToNum {
  final Map<BigInt, num> value;

  SimpleClassOfBigIntToNum(
    this.value,
  );

  factory SimpleClassOfBigIntToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToNum {
  final Map<BigInt, num>? value;

  SimpleClassNullableOfBigIntToNum(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToNum.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToNumFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToNum {
  final Map<DateTime, num> value;

  SimpleClassOfDateTimeToNum(
    this.value,
  );

  factory SimpleClassOfDateTimeToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToNum {
  final Map<DateTime, num>? value;

  SimpleClassNullableOfDateTimeToNum(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToNum.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToNumFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToNum {
  final Map<dynamic, num> value;

  SimpleClassOfDynamicToNum(
    this.value,
  );

  factory SimpleClassOfDynamicToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToNum {
  final Map<dynamic, num>? value;

  SimpleClassNullableOfDynamicToNum(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToNum.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToNumFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToNum {
  final Map<EnumType, num> value;

  SimpleClassOfEnumTypeToNum(
    this.value,
  );

  factory SimpleClassOfEnumTypeToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToNum {
  final Map<EnumType, num>? value;

  SimpleClassNullableOfEnumTypeToNum(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToNum.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToNumFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToNum {
  final Map<int, num> value;

  SimpleClassOfIntToNum(
    this.value,
  );

  factory SimpleClassOfIntToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToNum {
  final Map<int, num>? value;

  SimpleClassNullableOfIntToNum(
    this.value,
  );

  factory SimpleClassNullableOfIntToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToNum {
  final Map<Object, num> value;

  SimpleClassOfObjectToNum(
    this.value,
  );

  factory SimpleClassOfObjectToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToNum {
  final Map<Object, num>? value;

  SimpleClassNullableOfObjectToNum(
    this.value,
  );

  factory SimpleClassNullableOfObjectToNum.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToNumFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToNum {
  final Map<String, num> value;

  SimpleClassOfStringToNum(
    this.value,
  );

  factory SimpleClassOfStringToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToNum {
  final Map<String, num>? value;

  SimpleClassNullableOfStringToNum(
    this.value,
  );

  factory SimpleClassNullableOfStringToNum.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToNumFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToNum {
  final Map<Uri, num> value;

  SimpleClassOfUriToNum(
    this.value,
  );

  factory SimpleClassOfUriToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToNum {
  final Map<Uri, num>? value;

  SimpleClassNullableOfUriToNum(
    this.value,
  );

  factory SimpleClassNullableOfUriToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToNumNullable {
  final Map<BigInt, num?> value;

  SimpleClassOfBigIntToNumNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToNumNullable {
  final Map<BigInt, num?>? value;

  SimpleClassNullableOfBigIntToNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToNumNullable {
  final Map<DateTime, num?> value;

  SimpleClassOfDateTimeToNumNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToNumNullable {
  final Map<DateTime, num?>? value;

  SimpleClassNullableOfDateTimeToNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToNumNullable {
  final Map<dynamic, num?> value;

  SimpleClassOfDynamicToNumNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToNumNullable {
  final Map<dynamic, num?>? value;

  SimpleClassNullableOfDynamicToNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToNumNullable {
  final Map<EnumType, num?> value;

  SimpleClassOfEnumTypeToNumNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToNumNullable {
  final Map<EnumType, num?>? value;

  SimpleClassNullableOfEnumTypeToNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToNumNullable {
  final Map<int, num?> value;

  SimpleClassOfIntToNumNullable(
    this.value,
  );

  factory SimpleClassOfIntToNumNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToNumNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToNumNullable {
  final Map<int, num?>? value;

  SimpleClassNullableOfIntToNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToNumNullable {
  final Map<Object, num?> value;

  SimpleClassOfObjectToNumNullable(
    this.value,
  );

  factory SimpleClassOfObjectToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToNumNullable {
  final Map<Object, num?>? value;

  SimpleClassNullableOfObjectToNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToNumNullable {
  final Map<String, num?> value;

  SimpleClassOfStringToNumNullable(
    this.value,
  );

  factory SimpleClassOfStringToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToNumNullable {
  final Map<String, num?>? value;

  SimpleClassNullableOfStringToNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToNumNullable {
  final Map<Uri, num?> value;

  SimpleClassOfUriToNumNullable(
    this.value,
  );

  factory SimpleClassOfUriToNumNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToNumNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToNumNullable {
  final Map<Uri, num?>? value;

  SimpleClassNullableOfUriToNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToObject {
  final Map<BigInt, Object> value;

  SimpleClassOfBigIntToObject(
    this.value,
  );

  factory SimpleClassOfBigIntToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToObject {
  final Map<BigInt, Object>? value;

  SimpleClassNullableOfBigIntToObject(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToObject {
  final Map<DateTime, Object> value;

  SimpleClassOfDateTimeToObject(
    this.value,
  );

  factory SimpleClassOfDateTimeToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToObject {
  final Map<DateTime, Object>? value;

  SimpleClassNullableOfDateTimeToObject(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToObject {
  final Map<dynamic, Object> value;

  SimpleClassOfDynamicToObject(
    this.value,
  );

  factory SimpleClassOfDynamicToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToObject {
  final Map<dynamic, Object>? value;

  SimpleClassNullableOfDynamicToObject(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToObject {
  final Map<EnumType, Object> value;

  SimpleClassOfEnumTypeToObject(
    this.value,
  );

  factory SimpleClassOfEnumTypeToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToObject {
  final Map<EnumType, Object>? value;

  SimpleClassNullableOfEnumTypeToObject(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToObject {
  final Map<int, Object> value;

  SimpleClassOfIntToObject(
    this.value,
  );

  factory SimpleClassOfIntToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToObject {
  final Map<int, Object>? value;

  SimpleClassNullableOfIntToObject(
    this.value,
  );

  factory SimpleClassNullableOfIntToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToObject {
  final Map<Object, Object> value;

  SimpleClassOfObjectToObject(
    this.value,
  );

  factory SimpleClassOfObjectToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToObject {
  final Map<Object, Object>? value;

  SimpleClassNullableOfObjectToObject(
    this.value,
  );

  factory SimpleClassNullableOfObjectToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToObject {
  final Map<String, Object> value;

  SimpleClassOfStringToObject(
    this.value,
  );

  factory SimpleClassOfStringToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToObject {
  final Map<String, Object>? value;

  SimpleClassNullableOfStringToObject(
    this.value,
  );

  factory SimpleClassNullableOfStringToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToObject {
  final Map<Uri, Object> value;

  SimpleClassOfUriToObject(
    this.value,
  );

  factory SimpleClassOfUriToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToObject {
  final Map<Uri, Object>? value;

  SimpleClassNullableOfUriToObject(
    this.value,
  );

  factory SimpleClassNullableOfUriToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToObjectNullable {
  final Map<BigInt, Object?> value;

  SimpleClassOfBigIntToObjectNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToObjectNullable {
  final Map<BigInt, Object?>? value;

  SimpleClassNullableOfBigIntToObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToObjectNullable {
  final Map<DateTime, Object?> value;

  SimpleClassOfDateTimeToObjectNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToObjectNullable {
  final Map<DateTime, Object?>? value;

  SimpleClassNullableOfDateTimeToObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToObjectNullable {
  final Map<dynamic, Object?> value;

  SimpleClassOfDynamicToObjectNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToObjectNullable {
  final Map<dynamic, Object?>? value;

  SimpleClassNullableOfDynamicToObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToObjectNullable {
  final Map<EnumType, Object?> value;

  SimpleClassOfEnumTypeToObjectNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToObjectNullable {
  final Map<EnumType, Object?>? value;

  SimpleClassNullableOfEnumTypeToObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToObjectNullable {
  final Map<int, Object?> value;

  SimpleClassOfIntToObjectNullable(
    this.value,
  );

  factory SimpleClassOfIntToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfIntToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfIntToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToObjectNullable {
  final Map<int, Object?>? value;

  SimpleClassNullableOfIntToObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToObjectNullable {
  final Map<Object, Object?> value;

  SimpleClassOfObjectToObjectNullable(
    this.value,
  );

  factory SimpleClassOfObjectToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToObjectNullable {
  final Map<Object, Object?>? value;

  SimpleClassNullableOfObjectToObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToObjectNullable {
  final Map<String, Object?> value;

  SimpleClassOfStringToObjectNullable(
    this.value,
  );

  factory SimpleClassOfStringToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToObjectNullable {
  final Map<String, Object?>? value;

  SimpleClassNullableOfStringToObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToObjectNullable {
  final Map<Uri, Object?> value;

  SimpleClassOfUriToObjectNullable(
    this.value,
  );

  factory SimpleClassOfUriToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfUriToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfUriToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToObjectNullable {
  final Map<Uri, Object?>? value;

  SimpleClassNullableOfUriToObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToString {
  final Map<BigInt, String> value;

  SimpleClassOfBigIntToString(
    this.value,
  );

  factory SimpleClassOfBigIntToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToString {
  final Map<BigInt, String>? value;

  SimpleClassNullableOfBigIntToString(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToString {
  final Map<DateTime, String> value;

  SimpleClassOfDateTimeToString(
    this.value,
  );

  factory SimpleClassOfDateTimeToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToString {
  final Map<DateTime, String>? value;

  SimpleClassNullableOfDateTimeToString(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToString {
  final Map<dynamic, String> value;

  SimpleClassOfDynamicToString(
    this.value,
  );

  factory SimpleClassOfDynamicToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToString {
  final Map<dynamic, String>? value;

  SimpleClassNullableOfDynamicToString(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToString {
  final Map<EnumType, String> value;

  SimpleClassOfEnumTypeToString(
    this.value,
  );

  factory SimpleClassOfEnumTypeToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToString {
  final Map<EnumType, String>? value;

  SimpleClassNullableOfEnumTypeToString(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToString {
  final Map<int, String> value;

  SimpleClassOfIntToString(
    this.value,
  );

  factory SimpleClassOfIntToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToString {
  final Map<int, String>? value;

  SimpleClassNullableOfIntToString(
    this.value,
  );

  factory SimpleClassNullableOfIntToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToString {
  final Map<Object, String> value;

  SimpleClassOfObjectToString(
    this.value,
  );

  factory SimpleClassOfObjectToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToString {
  final Map<Object, String>? value;

  SimpleClassNullableOfObjectToString(
    this.value,
  );

  factory SimpleClassNullableOfObjectToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToString {
  final Map<String, String> value;

  SimpleClassOfStringToString(
    this.value,
  );

  factory SimpleClassOfStringToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToString {
  final Map<String, String>? value;

  SimpleClassNullableOfStringToString(
    this.value,
  );

  factory SimpleClassNullableOfStringToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToString {
  final Map<Uri, String> value;

  SimpleClassOfUriToString(
    this.value,
  );

  factory SimpleClassOfUriToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToString {
  final Map<Uri, String>? value;

  SimpleClassNullableOfUriToString(
    this.value,
  );

  factory SimpleClassNullableOfUriToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToStringNullable {
  final Map<BigInt, String?> value;

  SimpleClassOfBigIntToStringNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToStringNullable {
  final Map<BigInt, String?>? value;

  SimpleClassNullableOfBigIntToStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToStringNullable {
  final Map<DateTime, String?> value;

  SimpleClassOfDateTimeToStringNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToStringNullable {
  final Map<DateTime, String?>? value;

  SimpleClassNullableOfDateTimeToStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToStringNullable {
  final Map<dynamic, String?> value;

  SimpleClassOfDynamicToStringNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToStringNullable {
  final Map<dynamic, String?>? value;

  SimpleClassNullableOfDynamicToStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToStringNullable {
  final Map<EnumType, String?> value;

  SimpleClassOfEnumTypeToStringNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToStringNullable {
  final Map<EnumType, String?>? value;

  SimpleClassNullableOfEnumTypeToStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToStringNullable {
  final Map<int, String?> value;

  SimpleClassOfIntToStringNullable(
    this.value,
  );

  factory SimpleClassOfIntToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfIntToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfIntToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToStringNullable {
  final Map<int, String?>? value;

  SimpleClassNullableOfIntToStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToStringNullable {
  final Map<Object, String?> value;

  SimpleClassOfObjectToStringNullable(
    this.value,
  );

  factory SimpleClassOfObjectToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToStringNullable {
  final Map<Object, String?>? value;

  SimpleClassNullableOfObjectToStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToStringNullable {
  final Map<String, String?> value;

  SimpleClassOfStringToStringNullable(
    this.value,
  );

  factory SimpleClassOfStringToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToStringNullable {
  final Map<String, String?>? value;

  SimpleClassNullableOfStringToStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToStringNullable {
  final Map<Uri, String?> value;

  SimpleClassOfUriToStringNullable(
    this.value,
  );

  factory SimpleClassOfUriToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfUriToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfUriToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToStringNullable {
  final Map<Uri, String?>? value;

  SimpleClassNullableOfUriToStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToUri {
  final Map<BigInt, Uri> value;

  SimpleClassOfBigIntToUri(
    this.value,
  );

  factory SimpleClassOfBigIntToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToUri {
  final Map<BigInt, Uri>? value;

  SimpleClassNullableOfBigIntToUri(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToUri.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToUriFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToUri {
  final Map<DateTime, Uri> value;

  SimpleClassOfDateTimeToUri(
    this.value,
  );

  factory SimpleClassOfDateTimeToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToUri {
  final Map<DateTime, Uri>? value;

  SimpleClassNullableOfDateTimeToUri(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToUri.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToUriFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToUri {
  final Map<dynamic, Uri> value;

  SimpleClassOfDynamicToUri(
    this.value,
  );

  factory SimpleClassOfDynamicToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToUri {
  final Map<dynamic, Uri>? value;

  SimpleClassNullableOfDynamicToUri(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToUri.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToUriFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToUri {
  final Map<EnumType, Uri> value;

  SimpleClassOfEnumTypeToUri(
    this.value,
  );

  factory SimpleClassOfEnumTypeToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToUri {
  final Map<EnumType, Uri>? value;

  SimpleClassNullableOfEnumTypeToUri(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToUri.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToUriFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToUri {
  final Map<int, Uri> value;

  SimpleClassOfIntToUri(
    this.value,
  );

  factory SimpleClassOfIntToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToUri {
  final Map<int, Uri>? value;

  SimpleClassNullableOfIntToUri(
    this.value,
  );

  factory SimpleClassNullableOfIntToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToUri {
  final Map<Object, Uri> value;

  SimpleClassOfObjectToUri(
    this.value,
  );

  factory SimpleClassOfObjectToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToUri {
  final Map<Object, Uri>? value;

  SimpleClassNullableOfObjectToUri(
    this.value,
  );

  factory SimpleClassNullableOfObjectToUri.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToUriFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToUri {
  final Map<String, Uri> value;

  SimpleClassOfStringToUri(
    this.value,
  );

  factory SimpleClassOfStringToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToUri {
  final Map<String, Uri>? value;

  SimpleClassNullableOfStringToUri(
    this.value,
  );

  factory SimpleClassNullableOfStringToUri.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToUriFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToUri {
  final Map<Uri, Uri> value;

  SimpleClassOfUriToUri(
    this.value,
  );

  factory SimpleClassOfUriToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToUri {
  final Map<Uri, Uri>? value;

  SimpleClassNullableOfUriToUri(
    this.value,
  );

  factory SimpleClassNullableOfUriToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToUriNullable {
  final Map<BigInt, Uri?> value;

  SimpleClassOfBigIntToUriNullable(
    this.value,
  );

  factory SimpleClassOfBigIntToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfBigIntToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToUriNullable {
  final Map<BigInt, Uri?>? value;

  SimpleClassNullableOfBigIntToUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeToUriNullable {
  final Map<DateTime, Uri?> value;

  SimpleClassOfDateTimeToUriNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToUriNullable {
  final Map<DateTime, Uri?>? value;

  SimpleClassNullableOfDateTimeToUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamicToUriNullable {
  final Map<dynamic, Uri?> value;

  SimpleClassOfDynamicToUriNullable(
    this.value,
  );

  factory SimpleClassOfDynamicToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDynamicToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToUriNullable {
  final Map<dynamic, Uri?>? value;

  SimpleClassNullableOfDynamicToUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfDynamicToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDynamicToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeToUriNullable {
  final Map<EnumType, Uri?> value;

  SimpleClassOfEnumTypeToUriNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToUriNullable {
  final Map<EnumType, Uri?>? value;

  SimpleClassNullableOfEnumTypeToUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntToUriNullable {
  final Map<int, Uri?> value;

  SimpleClassOfIntToUriNullable(
    this.value,
  );

  factory SimpleClassOfIntToUriNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToUriNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToUriNullable {
  final Map<int, Uri?>? value;

  SimpleClassNullableOfIntToUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToUriNullable {
  final Map<Object, Uri?> value;

  SimpleClassOfObjectToUriNullable(
    this.value,
  );

  factory SimpleClassOfObjectToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfObjectToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToUriNullable {
  final Map<Object, Uri?>? value;

  SimpleClassNullableOfObjectToUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringToUriNullable {
  final Map<String, Uri?> value;

  SimpleClassOfStringToUriNullable(
    this.value,
  );

  factory SimpleClassOfStringToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassOfStringToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfStringToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToUriNullable {
  final Map<String, Uri?>? value;

  SimpleClassNullableOfStringToUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriToUriNullable {
  final Map<Uri, Uri?> value;

  SimpleClassOfUriToUriNullable(
    this.value,
  );

  factory SimpleClassOfUriToUriNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToUriNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToUriNullable {
  final Map<Uri, Uri?>? value;

  SimpleClassNullableOfUriToUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriToUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToUriNullableToJson(this);
}
