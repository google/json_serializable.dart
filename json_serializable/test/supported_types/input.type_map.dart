// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.10

import 'package:json_annotation/json_annotation.dart';
import 'enum_type.dart';

part 'input.type_map.g.dart';

@JsonSerializable()
class SimpleClass {
  final Map value;

  @JsonKey(nullable: false)
  final Map nullable;

  @JsonKey(defaultValue: {'a': 1})
  Map withDefault;

  SimpleClass(
    this.value,
    this.nullable,
    this.withDefault,
  );

  factory SimpleClass.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassToJson(this);
}

@JsonSerializable()
class SimpleClassNullable {
  final Map? value;

  @JsonKey(nullable: false)
  final Map? nullable;

  @JsonKey(defaultValue: {'a': 1})
  Map? withDefault;

  SimpleClassNullable(
    this.value,
    this.nullable,
    this.withDefault,
  );

  factory SimpleClassNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToBigInt {
  final Map<BigInt, BigInt> value;

  @JsonKey(nullable: false)
  final Map<BigInt, BigInt> nullable;

  SimpleClassOfBigIntToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToBigInt {
  final Map<BigInt, BigInt>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, BigInt>? nullable;

  SimpleClassNullableOfBigIntToBigInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, BigInt> nullable;

  SimpleClassOfDateTimeToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToBigInt {
  final Map<DateTime, BigInt>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, BigInt>? nullable;

  SimpleClassNullableOfDateTimeToBigInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, BigInt> nullable;

  SimpleClassOfDynamicToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToBigInt {
  final Map<dynamic, BigInt>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, BigInt>? nullable;

  SimpleClassNullableOfDynamicToBigInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, BigInt> nullable;

  SimpleClassOfEnumTypeToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToBigInt {
  final Map<EnumType, BigInt>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, BigInt>? nullable;

  SimpleClassNullableOfEnumTypeToBigInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, BigInt> nullable;

  SimpleClassOfIntToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToBigInt {
  final Map<int, BigInt>? value;

  @JsonKey(nullable: false)
  final Map<int, BigInt>? nullable;

  SimpleClassNullableOfIntToBigInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Object, BigInt> nullable;

  SimpleClassOfObjectToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToBigInt {
  final Map<Object, BigInt>? value;

  @JsonKey(nullable: false)
  final Map<Object, BigInt>? nullable;

  SimpleClassNullableOfObjectToBigInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, BigInt> nullable;

  SimpleClassOfStringToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToBigInt {
  final Map<String, BigInt>? value;

  @JsonKey(nullable: false)
  final Map<String, BigInt>? nullable;

  SimpleClassNullableOfStringToBigInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, BigInt> nullable;

  SimpleClassOfUriToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToBigInt {
  final Map<Uri, BigInt>? value;

  @JsonKey(nullable: false)
  final Map<Uri, BigInt>? nullable;

  SimpleClassNullableOfUriToBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToBigInt.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToBigIntFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToBool {
  final Map<BigInt, bool> value;

  @JsonKey(nullable: false)
  final Map<BigInt, bool> nullable;

  SimpleClassOfBigIntToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToBool {
  final Map<BigInt, bool>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, bool>? nullable;

  SimpleClassNullableOfBigIntToBool(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, bool> nullable;

  SimpleClassOfDateTimeToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToBool {
  final Map<DateTime, bool>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, bool>? nullable;

  SimpleClassNullableOfDateTimeToBool(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, bool> nullable;

  SimpleClassOfDynamicToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToBool {
  final Map<dynamic, bool>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, bool>? nullable;

  SimpleClassNullableOfDynamicToBool(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, bool> nullable;

  SimpleClassOfEnumTypeToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToBool {
  final Map<EnumType, bool>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, bool>? nullable;

  SimpleClassNullableOfEnumTypeToBool(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, bool> nullable;

  SimpleClassOfIntToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToBool {
  final Map<int, bool>? value;

  @JsonKey(nullable: false)
  final Map<int, bool>? nullable;

  SimpleClassNullableOfIntToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfIntToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToBool {
  final Map<Object, bool> value;

  @JsonKey(nullable: false)
  final Map<Object, bool> nullable;

  SimpleClassOfObjectToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToBool {
  final Map<Object, bool>? value;

  @JsonKey(nullable: false)
  final Map<Object, bool>? nullable;

  SimpleClassNullableOfObjectToBool(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, bool> nullable;

  SimpleClassOfStringToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToBool {
  final Map<String, bool>? value;

  @JsonKey(nullable: false)
  final Map<String, bool>? nullable;

  SimpleClassNullableOfStringToBool(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, bool> nullable;

  SimpleClassOfUriToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToBool {
  final Map<Uri, bool>? value;

  @JsonKey(nullable: false)
  final Map<Uri, bool>? nullable;

  SimpleClassNullableOfUriToBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDateTime {
  final Map<BigInt, DateTime> value;

  @JsonKey(nullable: false)
  final Map<BigInt, DateTime> nullable;

  SimpleClassOfBigIntToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDateTime {
  final Map<BigInt, DateTime>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, DateTime>? nullable;

  SimpleClassNullableOfBigIntToDateTime(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, DateTime> nullable;

  SimpleClassOfDateTimeToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDateTime {
  final Map<DateTime, DateTime>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, DateTime>? nullable;

  SimpleClassNullableOfDateTimeToDateTime(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, DateTime> nullable;

  SimpleClassOfDynamicToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDateTime {
  final Map<dynamic, DateTime>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, DateTime>? nullable;

  SimpleClassNullableOfDynamicToDateTime(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, DateTime> nullable;

  SimpleClassOfEnumTypeToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDateTime {
  final Map<EnumType, DateTime>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, DateTime>? nullable;

  SimpleClassNullableOfEnumTypeToDateTime(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, DateTime> nullable;

  SimpleClassOfIntToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDateTime {
  final Map<int, DateTime>? value;

  @JsonKey(nullable: false)
  final Map<int, DateTime>? nullable;

  SimpleClassNullableOfIntToDateTime(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Object, DateTime> nullable;

  SimpleClassOfObjectToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDateTime {
  final Map<Object, DateTime>? value;

  @JsonKey(nullable: false)
  final Map<Object, DateTime>? nullable;

  SimpleClassNullableOfObjectToDateTime(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, DateTime> nullable;

  SimpleClassOfStringToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDateTime {
  final Map<String, DateTime>? value;

  @JsonKey(nullable: false)
  final Map<String, DateTime>? nullable;

  SimpleClassNullableOfStringToDateTime(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, DateTime> nullable;

  SimpleClassOfUriToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDateTime {
  final Map<Uri, DateTime>? value;

  @JsonKey(nullable: false)
  final Map<Uri, DateTime>? nullable;

  SimpleClassNullableOfUriToDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToDateTime.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDateTimeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDouble {
  final Map<BigInt, double> value;

  @JsonKey(nullable: false)
  final Map<BigInt, double> nullable;

  SimpleClassOfBigIntToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDouble {
  final Map<BigInt, double>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, double>? nullable;

  SimpleClassNullableOfBigIntToDouble(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, double> nullable;

  SimpleClassOfDateTimeToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDouble {
  final Map<DateTime, double>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, double>? nullable;

  SimpleClassNullableOfDateTimeToDouble(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, double> nullable;

  SimpleClassOfDynamicToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDouble {
  final Map<dynamic, double>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, double>? nullable;

  SimpleClassNullableOfDynamicToDouble(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, double> nullable;

  SimpleClassOfEnumTypeToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDouble {
  final Map<EnumType, double>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, double>? nullable;

  SimpleClassNullableOfEnumTypeToDouble(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, double> nullable;

  SimpleClassOfIntToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDouble {
  final Map<int, double>? value;

  @JsonKey(nullable: false)
  final Map<int, double>? nullable;

  SimpleClassNullableOfIntToDouble(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Object, double> nullable;

  SimpleClassOfObjectToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDouble {
  final Map<Object, double>? value;

  @JsonKey(nullable: false)
  final Map<Object, double>? nullable;

  SimpleClassNullableOfObjectToDouble(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, double> nullable;

  SimpleClassOfStringToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDouble {
  final Map<String, double>? value;

  @JsonKey(nullable: false)
  final Map<String, double>? nullable;

  SimpleClassNullableOfStringToDouble(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, double> nullable;

  SimpleClassOfUriToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDouble {
  final Map<Uri, double>? value;

  @JsonKey(nullable: false)
  final Map<Uri, double>? nullable;

  SimpleClassNullableOfUriToDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToDouble.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDoubleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDuration {
  final Map<BigInt, Duration> value;

  @JsonKey(nullable: false)
  final Map<BigInt, Duration> nullable;

  SimpleClassOfBigIntToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDuration {
  final Map<BigInt, Duration>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, Duration>? nullable;

  SimpleClassNullableOfBigIntToDuration(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, Duration> nullable;

  SimpleClassOfDateTimeToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDuration {
  final Map<DateTime, Duration>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, Duration>? nullable;

  SimpleClassNullableOfDateTimeToDuration(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, Duration> nullable;

  SimpleClassOfDynamicToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDuration {
  final Map<dynamic, Duration>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, Duration>? nullable;

  SimpleClassNullableOfDynamicToDuration(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, Duration> nullable;

  SimpleClassOfEnumTypeToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDuration {
  final Map<EnumType, Duration>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, Duration>? nullable;

  SimpleClassNullableOfEnumTypeToDuration(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, Duration> nullable;

  SimpleClassOfIntToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDuration {
  final Map<int, Duration>? value;

  @JsonKey(nullable: false)
  final Map<int, Duration>? nullable;

  SimpleClassNullableOfIntToDuration(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Object, Duration> nullable;

  SimpleClassOfObjectToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDuration {
  final Map<Object, Duration>? value;

  @JsonKey(nullable: false)
  final Map<Object, Duration>? nullable;

  SimpleClassNullableOfObjectToDuration(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, Duration> nullable;

  SimpleClassOfStringToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDuration {
  final Map<String, Duration>? value;

  @JsonKey(nullable: false)
  final Map<String, Duration>? nullable;

  SimpleClassNullableOfStringToDuration(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, Duration> nullable;

  SimpleClassOfUriToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDuration {
  final Map<Uri, Duration>? value;

  @JsonKey(nullable: false)
  final Map<Uri, Duration>? nullable;

  SimpleClassNullableOfUriToDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToDuration.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToDurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToDynamic {
  final Map<BigInt, dynamic> value;

  @JsonKey(nullable: false)
  final Map<BigInt, dynamic> nullable;

  SimpleClassOfBigIntToDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToDynamic {
  final Map<BigInt, dynamic>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, dynamic>? nullable;

  SimpleClassNullableOfBigIntToDynamic(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, dynamic> nullable;

  SimpleClassOfDateTimeToDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToDynamic {
  final Map<DateTime, dynamic>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, dynamic>? nullable;

  SimpleClassNullableOfDateTimeToDynamic(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, dynamic> nullable;

  SimpleClassOfDynamicToDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToDynamic {
  final Map<dynamic, dynamic>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, dynamic>? nullable;

  SimpleClassNullableOfDynamicToDynamic(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, dynamic> nullable;

  SimpleClassOfEnumTypeToDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToDynamic {
  final Map<EnumType, dynamic>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, dynamic>? nullable;

  SimpleClassNullableOfEnumTypeToDynamic(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, dynamic> nullable;

  SimpleClassOfIntToDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToDynamic {
  final Map<int, dynamic>? value;

  @JsonKey(nullable: false)
  final Map<int, dynamic>? nullable;

  SimpleClassNullableOfIntToDynamic(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Object, dynamic> nullable;

  SimpleClassOfObjectToDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToDynamic {
  final Map<Object, dynamic>? value;

  @JsonKey(nullable: false)
  final Map<Object, dynamic>? nullable;

  SimpleClassNullableOfObjectToDynamic(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, dynamic> nullable;

  SimpleClassOfStringToDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToDynamic {
  final Map<String, dynamic>? value;

  @JsonKey(nullable: false)
  final Map<String, dynamic>? nullable;

  SimpleClassNullableOfStringToDynamic(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, dynamic> nullable;

  SimpleClassOfUriToDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToDynamic {
  final Map<Uri, dynamic>? value;

  @JsonKey(nullable: false)
  final Map<Uri, dynamic>? nullable;

  SimpleClassNullableOfUriToDynamic(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<BigInt, EnumType> nullable;

  SimpleClassOfBigIntToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToEnumType {
  final Map<BigInt, EnumType>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, EnumType>? nullable;

  SimpleClassNullableOfBigIntToEnumType(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, EnumType> nullable;

  SimpleClassOfDateTimeToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfDateTimeToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToEnumType {
  final Map<DateTime, EnumType>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, EnumType>? nullable;

  SimpleClassNullableOfDateTimeToEnumType(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, EnumType> nullable;

  SimpleClassOfDynamicToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToEnumType {
  final Map<dynamic, EnumType>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, EnumType>? nullable;

  SimpleClassNullableOfDynamicToEnumType(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, EnumType> nullable;

  SimpleClassOfEnumTypeToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassOfEnumTypeToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToEnumType {
  final Map<EnumType, EnumType>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, EnumType>? nullable;

  SimpleClassNullableOfEnumTypeToEnumType(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, EnumType> nullable;

  SimpleClassOfIntToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToEnumType {
  final Map<int, EnumType>? value;

  @JsonKey(nullable: false)
  final Map<int, EnumType>? nullable;

  SimpleClassNullableOfIntToEnumType(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Object, EnumType> nullable;

  SimpleClassOfObjectToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToEnumType {
  final Map<Object, EnumType>? value;

  @JsonKey(nullable: false)
  final Map<Object, EnumType>? nullable;

  SimpleClassNullableOfObjectToEnumType(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, EnumType> nullable;

  SimpleClassOfStringToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToEnumType {
  final Map<String, EnumType>? value;

  @JsonKey(nullable: false)
  final Map<String, EnumType>? nullable;

  SimpleClassNullableOfStringToEnumType(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, EnumType> nullable;

  SimpleClassOfUriToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToEnumType {
  final Map<Uri, EnumType>? value;

  @JsonKey(nullable: false)
  final Map<Uri, EnumType>? nullable;

  SimpleClassNullableOfUriToEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToEnumType.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToEnumTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToInt {
  final Map<BigInt, int> value;

  @JsonKey(nullable: false)
  final Map<BigInt, int> nullable;

  SimpleClassOfBigIntToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToInt {
  final Map<BigInt, int>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, int>? nullable;

  SimpleClassNullableOfBigIntToInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, int> nullable;

  SimpleClassOfDateTimeToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToInt {
  final Map<DateTime, int>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, int>? nullable;

  SimpleClassNullableOfDateTimeToInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, int> nullable;

  SimpleClassOfDynamicToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToInt {
  final Map<dynamic, int>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, int>? nullable;

  SimpleClassNullableOfDynamicToInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, int> nullable;

  SimpleClassOfEnumTypeToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToInt {
  final Map<EnumType, int>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, int>? nullable;

  SimpleClassNullableOfEnumTypeToInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, int> nullable;

  SimpleClassOfIntToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToInt {
  final Map<int, int>? value;

  @JsonKey(nullable: false)
  final Map<int, int>? nullable;

  SimpleClassNullableOfIntToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfIntToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToInt {
  final Map<Object, int> value;

  @JsonKey(nullable: false)
  final Map<Object, int> nullable;

  SimpleClassOfObjectToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToInt {
  final Map<Object, int>? value;

  @JsonKey(nullable: false)
  final Map<Object, int>? nullable;

  SimpleClassNullableOfObjectToInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, int> nullable;

  SimpleClassOfStringToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToInt {
  final Map<String, int>? value;

  @JsonKey(nullable: false)
  final Map<String, int>? nullable;

  SimpleClassNullableOfStringToInt(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, int> nullable;

  SimpleClassOfUriToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToInt {
  final Map<Uri, int>? value;

  @JsonKey(nullable: false)
  final Map<Uri, int>? nullable;

  SimpleClassNullableOfUriToInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToNum {
  final Map<BigInt, num> value;

  @JsonKey(nullable: false)
  final Map<BigInt, num> nullable;

  SimpleClassOfBigIntToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToNum {
  final Map<BigInt, num>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, num>? nullable;

  SimpleClassNullableOfBigIntToNum(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, num> nullable;

  SimpleClassOfDateTimeToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToNum {
  final Map<DateTime, num>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, num>? nullable;

  SimpleClassNullableOfDateTimeToNum(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, num> nullable;

  SimpleClassOfDynamicToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToNum {
  final Map<dynamic, num>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, num>? nullable;

  SimpleClassNullableOfDynamicToNum(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, num> nullable;

  SimpleClassOfEnumTypeToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToNum {
  final Map<EnumType, num>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, num>? nullable;

  SimpleClassNullableOfEnumTypeToNum(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, num> nullable;

  SimpleClassOfIntToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToNum {
  final Map<int, num>? value;

  @JsonKey(nullable: false)
  final Map<int, num>? nullable;

  SimpleClassNullableOfIntToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfIntToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToNum {
  final Map<Object, num> value;

  @JsonKey(nullable: false)
  final Map<Object, num> nullable;

  SimpleClassOfObjectToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToNum {
  final Map<Object, num>? value;

  @JsonKey(nullable: false)
  final Map<Object, num>? nullable;

  SimpleClassNullableOfObjectToNum(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, num> nullable;

  SimpleClassOfStringToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToNum {
  final Map<String, num>? value;

  @JsonKey(nullable: false)
  final Map<String, num>? nullable;

  SimpleClassNullableOfStringToNum(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, num> nullable;

  SimpleClassOfUriToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToNum {
  final Map<Uri, num>? value;

  @JsonKey(nullable: false)
  final Map<Uri, num>? nullable;

  SimpleClassNullableOfUriToNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToObject {
  final Map<BigInt, Object> value;

  @JsonKey(nullable: false)
  final Map<BigInt, Object> nullable;

  SimpleClassOfBigIntToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToObject {
  final Map<BigInt, Object>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, Object>? nullable;

  SimpleClassNullableOfBigIntToObject(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, Object> nullable;

  SimpleClassOfDateTimeToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToObject {
  final Map<DateTime, Object>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, Object>? nullable;

  SimpleClassNullableOfDateTimeToObject(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, Object> nullable;

  SimpleClassOfDynamicToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToObject {
  final Map<dynamic, Object>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, Object>? nullable;

  SimpleClassNullableOfDynamicToObject(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, Object> nullable;

  SimpleClassOfEnumTypeToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToObject {
  final Map<EnumType, Object>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, Object>? nullable;

  SimpleClassNullableOfEnumTypeToObject(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, Object> nullable;

  SimpleClassOfIntToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToObject {
  final Map<int, Object>? value;

  @JsonKey(nullable: false)
  final Map<int, Object>? nullable;

  SimpleClassNullableOfIntToObject(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Object, Object> nullable;

  SimpleClassOfObjectToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToObject {
  final Map<Object, Object>? value;

  @JsonKey(nullable: false)
  final Map<Object, Object>? nullable;

  SimpleClassNullableOfObjectToObject(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, Object> nullable;

  SimpleClassOfStringToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToObject {
  final Map<String, Object>? value;

  @JsonKey(nullable: false)
  final Map<String, Object>? nullable;

  SimpleClassNullableOfStringToObject(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, Object> nullable;

  SimpleClassOfUriToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToObject {
  final Map<Uri, Object>? value;

  @JsonKey(nullable: false)
  final Map<Uri, Object>? nullable;

  SimpleClassNullableOfUriToObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToObject.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToObjectFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToString {
  final Map<BigInt, String> value;

  @JsonKey(nullable: false)
  final Map<BigInt, String> nullable;

  SimpleClassOfBigIntToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToString {
  final Map<BigInt, String>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, String>? nullable;

  SimpleClassNullableOfBigIntToString(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, String> nullable;

  SimpleClassOfDateTimeToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToString {
  final Map<DateTime, String>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, String>? nullable;

  SimpleClassNullableOfDateTimeToString(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, String> nullable;

  SimpleClassOfDynamicToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToString {
  final Map<dynamic, String>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, String>? nullable;

  SimpleClassNullableOfDynamicToString(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, String> nullable;

  SimpleClassOfEnumTypeToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToString {
  final Map<EnumType, String>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, String>? nullable;

  SimpleClassNullableOfEnumTypeToString(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, String> nullable;

  SimpleClassOfIntToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToString {
  final Map<int, String>? value;

  @JsonKey(nullable: false)
  final Map<int, String>? nullable;

  SimpleClassNullableOfIntToString(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Object, String> nullable;

  SimpleClassOfObjectToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToString {
  final Map<Object, String>? value;

  @JsonKey(nullable: false)
  final Map<Object, String>? nullable;

  SimpleClassNullableOfObjectToString(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, String> nullable;

  SimpleClassOfStringToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToString {
  final Map<String, String>? value;

  @JsonKey(nullable: false)
  final Map<String, String>? nullable;

  SimpleClassNullableOfStringToString(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, String> nullable;

  SimpleClassOfUriToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToString {
  final Map<Uri, String>? value;

  @JsonKey(nullable: false)
  final Map<Uri, String>? nullable;

  SimpleClassNullableOfUriToString(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToString.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToStringFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriToStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntToUri {
  final Map<BigInt, Uri> value;

  @JsonKey(nullable: false)
  final Map<BigInt, Uri> nullable;

  SimpleClassOfBigIntToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntToUri {
  final Map<BigInt, Uri>? value;

  @JsonKey(nullable: false)
  final Map<BigInt, Uri>? nullable;

  SimpleClassNullableOfBigIntToUri(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<DateTime, Uri> nullable;

  SimpleClassOfDateTimeToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeToUri {
  final Map<DateTime, Uri>? value;

  @JsonKey(nullable: false)
  final Map<DateTime, Uri>? nullable;

  SimpleClassNullableOfDateTimeToUri(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<dynamic, Uri> nullable;

  SimpleClassOfDynamicToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamicToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamicToUri {
  final Map<dynamic, Uri>? value;

  @JsonKey(nullable: false)
  final Map<dynamic, Uri>? nullable;

  SimpleClassNullableOfDynamicToUri(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<EnumType, Uri> nullable;

  SimpleClassOfEnumTypeToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeToUri {
  final Map<EnumType, Uri>? value;

  @JsonKey(nullable: false)
  final Map<EnumType, Uri>? nullable;

  SimpleClassNullableOfEnumTypeToUri(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<int, Uri> nullable;

  SimpleClassOfIntToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntToUri {
  final Map<int, Uri>? value;

  @JsonKey(nullable: false)
  final Map<int, Uri>? nullable;

  SimpleClassNullableOfIntToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfIntToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectToUri {
  final Map<Object, Uri> value;

  @JsonKey(nullable: false)
  final Map<Object, Uri> nullable;

  SimpleClassOfObjectToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectToUri {
  final Map<Object, Uri>? value;

  @JsonKey(nullable: false)
  final Map<Object, Uri>? nullable;

  SimpleClassNullableOfObjectToUri(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<String, Uri> nullable;

  SimpleClassOfStringToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringToUri {
  final Map<String, Uri>? value;

  @JsonKey(nullable: false)
  final Map<String, Uri>? nullable;

  SimpleClassNullableOfStringToUri(
    this.value,
    this.nullable,
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

  @JsonKey(nullable: false)
  final Map<Uri, Uri> nullable;

  SimpleClassOfUriToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriToUri {
  final Map<Uri, Uri>? value;

  @JsonKey(nullable: false)
  final Map<Uri, Uri>? nullable;

  SimpleClassNullableOfUriToUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriToUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriToUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToUriToJson(this);
}
