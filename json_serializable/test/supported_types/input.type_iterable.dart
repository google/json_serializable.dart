// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.12

import 'package:json_annotation/json_annotation.dart';
import 'enum_type.dart';

part 'input.type_iterable.g.dart';

@JsonSerializable()
class SimpleClass {
  final Iterable value;

  @JsonKey(nullable: false)
  final Iterable nullable;

  @JsonKey(defaultValue: [42, true, false, null])
  Iterable withDefault;

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
  final Iterable? value;

  @JsonKey(nullable: false)
  final Iterable? nullable;

  @JsonKey(defaultValue: [42, true, false, null])
  Iterable? withDefault;

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
class SimpleClassOfBigInt {
  final Iterable<BigInt> value;

  @JsonKey(nullable: false)
  final Iterable<BigInt> nullable;

  SimpleClassOfBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigInt {
  final Iterable<BigInt>? value;

  @JsonKey(nullable: false)
  final Iterable<BigInt>? nullable;

  SimpleClassNullableOfBigInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntNullable {
  final Iterable<BigInt?> value;

  @JsonKey(nullable: false)
  final Iterable<BigInt?> nullable;

  SimpleClassOfBigIntNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBigIntNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntNullable {
  final Iterable<BigInt?>? value;

  @JsonKey(nullable: false)
  final Iterable<BigInt?>? nullable;

  SimpleClassNullableOfBigIntNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfBigIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBool {
  final Iterable<bool> value;

  @JsonKey(nullable: false)
  final Iterable<bool> nullable;

  SimpleClassOfBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBool {
  final Iterable<bool>? value;

  @JsonKey(nullable: false)
  final Iterable<bool>? nullable;

  SimpleClassNullableOfBool(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfBoolNullable {
  final Iterable<bool?> value;

  @JsonKey(nullable: false)
  final Iterable<bool?> nullable;

  SimpleClassOfBoolNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfBoolNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBoolNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBoolNullable {
  final Iterable<bool?>? value;

  @JsonKey(nullable: false)
  final Iterable<bool?>? nullable;

  SimpleClassNullableOfBoolNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfBoolNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBoolNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTime {
  final Iterable<DateTime> value;

  @JsonKey(nullable: false)
  final Iterable<DateTime> nullable;

  SimpleClassOfDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTime {
  final Iterable<DateTime>? value;

  @JsonKey(nullable: false)
  final Iterable<DateTime>? nullable;

  SimpleClassNullableOfDateTime(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeNullable {
  final Iterable<DateTime?> value;

  @JsonKey(nullable: false)
  final Iterable<DateTime?> nullable;

  SimpleClassOfDateTimeNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDateTimeNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeNullable {
  final Iterable<DateTime?>? value;

  @JsonKey(nullable: false)
  final Iterable<DateTime?>? nullable;

  SimpleClassNullableOfDateTimeNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfDateTimeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDouble {
  final Iterable<double> value;

  @JsonKey(nullable: false)
  final Iterable<double> nullable;

  SimpleClassOfDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDouble {
  final Iterable<double>? value;

  @JsonKey(nullable: false)
  final Iterable<double>? nullable;

  SimpleClassNullableOfDouble(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfDoubleNullable {
  final Iterable<double?> value;

  @JsonKey(nullable: false)
  final Iterable<double?> nullable;

  SimpleClassOfDoubleNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDoubleNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDoubleNullable {
  final Iterable<double?>? value;

  @JsonKey(nullable: false)
  final Iterable<double?>? nullable;

  SimpleClassNullableOfDoubleNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfDoubleNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDuration {
  final Iterable<Duration> value;

  @JsonKey(nullable: false)
  final Iterable<Duration> nullable;

  SimpleClassOfDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDuration {
  final Iterable<Duration>? value;

  @JsonKey(nullable: false)
  final Iterable<Duration>? nullable;

  SimpleClassNullableOfDuration(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfDurationNullable {
  final Iterable<Duration?> value;

  @JsonKey(nullable: false)
  final Iterable<Duration?> nullable;

  SimpleClassOfDurationNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDurationNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDurationNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDurationNullable {
  final Iterable<Duration?>? value;

  @JsonKey(nullable: false)
  final Iterable<Duration?>? nullable;

  SimpleClassNullableOfDurationNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfDurationNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDurationNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfDynamic {
  final Iterable<dynamic> value;

  @JsonKey(nullable: false)
  final Iterable<dynamic> nullable;

  SimpleClassOfDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamic {
  final Iterable<dynamic>? value;

  @JsonKey(nullable: false)
  final Iterable<dynamic>? nullable;

  SimpleClassNullableOfDynamic(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumType {
  final Iterable<EnumType> value;

  @JsonKey(nullable: false)
  final Iterable<EnumType> nullable;

  SimpleClassOfEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumType {
  final Iterable<EnumType>? value;

  @JsonKey(nullable: false)
  final Iterable<EnumType>? nullable;

  SimpleClassNullableOfEnumType(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeNullable {
  final Iterable<EnumType?> value;

  @JsonKey(nullable: false)
  final Iterable<EnumType?> nullable;

  SimpleClassOfEnumTypeNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfEnumTypeNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeNullable {
  final Iterable<EnumType?>? value;

  @JsonKey(nullable: false)
  final Iterable<EnumType?>? nullable;

  SimpleClassNullableOfEnumTypeNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfEnumTypeNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfInt {
  final Iterable<int> value;

  @JsonKey(nullable: false)
  final Iterable<int> nullable;

  SimpleClassOfInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfInt {
  final Iterable<int>? value;

  @JsonKey(nullable: false)
  final Iterable<int>? nullable;

  SimpleClassNullableOfInt(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntNullable {
  final Iterable<int?> value;

  @JsonKey(nullable: false)
  final Iterable<int?> nullable;

  SimpleClassOfIntNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfIntNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntNullable {
  final Iterable<int?>? value;

  @JsonKey(nullable: false)
  final Iterable<int?>? nullable;

  SimpleClassNullableOfIntNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfIntNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfNum {
  final Iterable<num> value;

  @JsonKey(nullable: false)
  final Iterable<num> nullable;

  SimpleClassOfNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfNum {
  final Iterable<num>? value;

  @JsonKey(nullable: false)
  final Iterable<num>? nullable;

  SimpleClassNullableOfNum(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfNumNullable {
  final Iterable<num?> value;

  @JsonKey(nullable: false)
  final Iterable<num?> nullable;

  SimpleClassOfNumNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfNumNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfNumNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfNumNullable {
  final Iterable<num?>? value;

  @JsonKey(nullable: false)
  final Iterable<num?>? nullable;

  SimpleClassNullableOfNumNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfNumNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfNumNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfObject {
  final Iterable<Object> value;

  @JsonKey(nullable: false)
  final Iterable<Object> nullable;

  SimpleClassOfObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObject {
  final Iterable<Object>? value;

  @JsonKey(nullable: false)
  final Iterable<Object>? nullable;

  SimpleClassNullableOfObject(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectNullable {
  final Iterable<Object?> value;

  @JsonKey(nullable: false)
  final Iterable<Object?> nullable;

  SimpleClassOfObjectNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfObjectNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectNullable {
  final Iterable<Object?>? value;

  @JsonKey(nullable: false)
  final Iterable<Object?>? nullable;

  SimpleClassNullableOfObjectNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfObjectNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfString {
  final Iterable<String> value;

  @JsonKey(nullable: false)
  final Iterable<String> nullable;

  SimpleClassOfString(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfString {
  final Iterable<String>? value;

  @JsonKey(nullable: false)
  final Iterable<String>? nullable;

  SimpleClassNullableOfString(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringNullable {
  final Iterable<String?> value;

  @JsonKey(nullable: false)
  final Iterable<String?> nullable;

  SimpleClassOfStringNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfStringNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringNullable {
  final Iterable<String?>? value;

  @JsonKey(nullable: false)
  final Iterable<String?>? nullable;

  SimpleClassNullableOfStringNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfStringNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfUri {
  final Iterable<Uri> value;

  @JsonKey(nullable: false)
  final Iterable<Uri> nullable;

  SimpleClassOfUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUri {
  final Iterable<Uri>? value;

  @JsonKey(nullable: false)
  final Iterable<Uri>? nullable;

  SimpleClassNullableOfUri(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriNullable {
  final Iterable<Uri?> value;

  @JsonKey(nullable: false)
  final Iterable<Uri?> nullable;

  SimpleClassOfUriNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassOfUriNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriNullable {
  final Iterable<Uri?>? value;

  @JsonKey(nullable: false)
  final Iterable<Uri?>? nullable;

  SimpleClassNullableOfUriNullable(
    this.value,
    this.nullable,
  );

  factory SimpleClassNullableOfUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriNullableToJson(this);
}
