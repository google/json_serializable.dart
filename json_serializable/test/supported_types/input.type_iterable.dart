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

  @JsonKey(defaultValue: [42, true, false, null])
  Iterable withDefault;

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
  final Iterable? value;

  @JsonKey(defaultValue: [42, true, false, null])
  Iterable? withDefault;

  SimpleClassNullable(
    this.value,
    this.withDefault,
  );

  factory SimpleClassNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigInt {
  final Iterable<BigInt> value;

  SimpleClassOfBigInt(
    this.value,
  );

  factory SimpleClassOfBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigInt {
  final Iterable<BigInt>? value;

  SimpleClassNullableOfBigInt(
    this.value,
  );

  factory SimpleClassNullableOfBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntNullable {
  final Iterable<BigInt?> value;

  SimpleClassOfBigIntNullable(
    this.value,
  );

  factory SimpleClassOfBigIntNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntNullable {
  final Iterable<BigInt?>? value;

  SimpleClassNullableOfBigIntNullable(
    this.value,
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

  SimpleClassOfBool(
    this.value,
  );

  factory SimpleClassOfBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBool {
  final Iterable<bool>? value;

  SimpleClassNullableOfBool(
    this.value,
  );

  factory SimpleClassNullableOfBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfBoolNullable {
  final Iterable<bool?> value;

  SimpleClassOfBoolNullable(
    this.value,
  );

  factory SimpleClassOfBoolNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBoolNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBoolNullable {
  final Iterable<bool?>? value;

  SimpleClassNullableOfBoolNullable(
    this.value,
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

  SimpleClassOfDateTime(
    this.value,
  );

  factory SimpleClassOfDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTime {
  final Iterable<DateTime>? value;

  SimpleClassNullableOfDateTime(
    this.value,
  );

  factory SimpleClassNullableOfDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeNullable {
  final Iterable<DateTime?> value;

  SimpleClassOfDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeNullable {
  final Iterable<DateTime?>? value;

  SimpleClassNullableOfDateTimeNullable(
    this.value,
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

  SimpleClassOfDouble(
    this.value,
  );

  factory SimpleClassOfDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDouble {
  final Iterable<double>? value;

  SimpleClassNullableOfDouble(
    this.value,
  );

  factory SimpleClassNullableOfDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfDoubleNullable {
  final Iterable<double?> value;

  SimpleClassOfDoubleNullable(
    this.value,
  );

  factory SimpleClassOfDoubleNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDoubleNullable {
  final Iterable<double?>? value;

  SimpleClassNullableOfDoubleNullable(
    this.value,
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

  SimpleClassOfDuration(
    this.value,
  );

  factory SimpleClassOfDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDuration {
  final Iterable<Duration>? value;

  SimpleClassNullableOfDuration(
    this.value,
  );

  factory SimpleClassNullableOfDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfDurationNullable {
  final Iterable<Duration?> value;

  SimpleClassOfDurationNullable(
    this.value,
  );

  factory SimpleClassOfDurationNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDurationNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDurationNullable {
  final Iterable<Duration?>? value;

  SimpleClassNullableOfDurationNullable(
    this.value,
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

  SimpleClassOfDynamic(
    this.value,
  );

  factory SimpleClassOfDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamic {
  final Iterable<dynamic>? value;

  SimpleClassNullableOfDynamic(
    this.value,
  );

  factory SimpleClassNullableOfDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumType {
  final Iterable<EnumType> value;

  SimpleClassOfEnumType(
    this.value,
  );

  factory SimpleClassOfEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumType {
  final Iterable<EnumType>? value;

  SimpleClassNullableOfEnumType(
    this.value,
  );

  factory SimpleClassNullableOfEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeNullable {
  final Iterable<EnumType?> value;

  SimpleClassOfEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeNullable {
  final Iterable<EnumType?>? value;

  SimpleClassNullableOfEnumTypeNullable(
    this.value,
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

  SimpleClassOfInt(
    this.value,
  );

  factory SimpleClassOfInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfInt {
  final Iterable<int>? value;

  SimpleClassNullableOfInt(
    this.value,
  );

  factory SimpleClassNullableOfInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntNullable {
  final Iterable<int?> value;

  SimpleClassOfIntNullable(
    this.value,
  );

  factory SimpleClassOfIntNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntNullable {
  final Iterable<int?>? value;

  SimpleClassNullableOfIntNullable(
    this.value,
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

  SimpleClassOfNum(
    this.value,
  );

  factory SimpleClassOfNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfNum {
  final Iterable<num>? value;

  SimpleClassNullableOfNum(
    this.value,
  );

  factory SimpleClassNullableOfNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfNumNullable {
  final Iterable<num?> value;

  SimpleClassOfNumNullable(
    this.value,
  );

  factory SimpleClassOfNumNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfNumNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfNumNullable {
  final Iterable<num?>? value;

  SimpleClassNullableOfNumNullable(
    this.value,
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

  SimpleClassOfObject(
    this.value,
  );

  factory SimpleClassOfObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObject {
  final Iterable<Object>? value;

  SimpleClassNullableOfObject(
    this.value,
  );

  factory SimpleClassNullableOfObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectNullable {
  final Iterable<Object?> value;

  SimpleClassOfObjectNullable(
    this.value,
  );

  factory SimpleClassOfObjectNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectNullable {
  final Iterable<Object?>? value;

  SimpleClassNullableOfObjectNullable(
    this.value,
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

  SimpleClassOfString(
    this.value,
  );

  factory SimpleClassOfString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfString {
  final Iterable<String>? value;

  SimpleClassNullableOfString(
    this.value,
  );

  factory SimpleClassNullableOfString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringNullable {
  final Iterable<String?> value;

  SimpleClassOfStringNullable(
    this.value,
  );

  factory SimpleClassOfStringNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringNullable {
  final Iterable<String?>? value;

  SimpleClassNullableOfStringNullable(
    this.value,
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

  SimpleClassOfUri(
    this.value,
  );

  factory SimpleClassOfUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUri {
  final Iterable<Uri>? value;

  SimpleClassNullableOfUri(
    this.value,
  );

  factory SimpleClassNullableOfUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriNullable {
  final Iterable<Uri?> value;

  SimpleClassOfUriNullable(
    this.value,
  );

  factory SimpleClassOfUriNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriNullable {
  final Iterable<Uri?>? value;

  SimpleClassNullableOfUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriNullableToJson(this);
}
