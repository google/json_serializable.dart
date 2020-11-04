// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.12

import 'package:json_annotation/json_annotation.dart';
import 'enum_type.dart';

part 'input.type_list.g.dart';

@JsonSerializable()
class SimpleClass {
  final List value;

  @JsonKey(defaultValue: [42, true, false, null])
  List withDefault;

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
  final List? value;

  @JsonKey(defaultValue: [42, true, false, null])
  List? withDefault;

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
  final List<BigInt> value;

  SimpleClassOfBigInt(
    this.value,
  );

  factory SimpleClassOfBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigInt {
  final List<BigInt>? value;

  SimpleClassNullableOfBigInt(
    this.value,
  );

  factory SimpleClassNullableOfBigInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBigIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfBigIntNullable {
  final List<BigInt?> value;

  SimpleClassOfBigIntNullable(
    this.value,
  );

  factory SimpleClassOfBigIntNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBigIntNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntNullable {
  final List<BigInt?>? value;

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
  final List<bool> value;

  SimpleClassOfBool(
    this.value,
  );

  factory SimpleClassOfBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBool {
  final List<bool>? value;

  SimpleClassNullableOfBool(
    this.value,
  );

  factory SimpleClassNullableOfBool.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfBoolFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfBoolToJson(this);
}

@JsonSerializable()
class SimpleClassOfBoolNullable {
  final List<bool?> value;

  SimpleClassOfBoolNullable(
    this.value,
  );

  factory SimpleClassOfBoolNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfBoolNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBoolNullable {
  final List<bool?>? value;

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
  final List<DateTime> value;

  SimpleClassOfDateTime(
    this.value,
  );

  factory SimpleClassOfDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTime {
  final List<DateTime>? value;

  SimpleClassNullableOfDateTime(
    this.value,
  );

  factory SimpleClassNullableOfDateTime.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassOfDateTimeNullable {
  final List<DateTime?> value;

  SimpleClassOfDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDateTimeNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeNullable {
  final List<DateTime?>? value;

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
  final List<double> value;

  SimpleClassOfDouble(
    this.value,
  );

  factory SimpleClassOfDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDouble {
  final List<double>? value;

  SimpleClassNullableOfDouble(
    this.value,
  );

  factory SimpleClassNullableOfDouble.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassOfDoubleNullable {
  final List<double?> value;

  SimpleClassOfDoubleNullable(
    this.value,
  );

  factory SimpleClassOfDoubleNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDoubleNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDoubleNullable {
  final List<double?>? value;

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
  final List<Duration> value;

  SimpleClassOfDuration(
    this.value,
  );

  factory SimpleClassOfDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDuration {
  final List<Duration>? value;

  SimpleClassNullableOfDuration(
    this.value,
  );

  factory SimpleClassNullableOfDuration.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDurationToJson(this);
}

@JsonSerializable()
class SimpleClassOfDurationNullable {
  final List<Duration?> value;

  SimpleClassOfDurationNullable(
    this.value,
  );

  factory SimpleClassOfDurationNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDurationNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDurationNullable {
  final List<Duration?>? value;

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
  final List<dynamic> value;

  SimpleClassOfDynamic(
    this.value,
  );

  factory SimpleClassOfDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamic {
  final List<dynamic>? value;

  SimpleClassNullableOfDynamic(
    this.value,
  );

  factory SimpleClassNullableOfDynamic.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumType {
  final List<EnumType> value;

  SimpleClassOfEnumType(
    this.value,
  );

  factory SimpleClassOfEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumType {
  final List<EnumType>? value;

  SimpleClassNullableOfEnumType(
    this.value,
  );

  factory SimpleClassNullableOfEnumType.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfEnumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassOfEnumTypeNullable {
  final List<EnumType?> value;

  SimpleClassOfEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfEnumTypeNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeNullable {
  final List<EnumType?>? value;

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
  final List<int> value;

  SimpleClassOfInt(
    this.value,
  );

  factory SimpleClassOfInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfInt {
  final List<int>? value;

  SimpleClassNullableOfInt(
    this.value,
  );

  factory SimpleClassNullableOfInt.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfIntFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfIntToJson(this);
}

@JsonSerializable()
class SimpleClassOfIntNullable {
  final List<int?> value;

  SimpleClassOfIntNullable(
    this.value,
  );

  factory SimpleClassOfIntNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfIntNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntNullable {
  final List<int?>? value;

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
  final List<num> value;

  SimpleClassOfNum(
    this.value,
  );

  factory SimpleClassOfNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfNum {
  final List<num>? value;

  SimpleClassNullableOfNum(
    this.value,
  );

  factory SimpleClassNullableOfNum.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfNumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfNumToJson(this);
}

@JsonSerializable()
class SimpleClassOfNumNullable {
  final List<num?> value;

  SimpleClassOfNumNullable(
    this.value,
  );

  factory SimpleClassOfNumNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfNumNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfNumNullable {
  final List<num?>? value;

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
  final List<Object> value;

  SimpleClassOfObject(
    this.value,
  );

  factory SimpleClassOfObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObject {
  final List<Object>? value;

  SimpleClassNullableOfObject(
    this.value,
  );

  factory SimpleClassNullableOfObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfObjectFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfObjectToJson(this);
}

@JsonSerializable()
class SimpleClassOfObjectNullable {
  final List<Object?> value;

  SimpleClassOfObjectNullable(
    this.value,
  );

  factory SimpleClassOfObjectNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfObjectNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectNullable {
  final List<Object?>? value;

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
  final List<String> value;

  SimpleClassOfString(
    this.value,
  );

  factory SimpleClassOfString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfString {
  final List<String>? value;

  SimpleClassNullableOfString(
    this.value,
  );

  factory SimpleClassNullableOfString.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfStringFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfStringToJson(this);
}

@JsonSerializable()
class SimpleClassOfStringNullable {
  final List<String?> value;

  SimpleClassOfStringNullable(
    this.value,
  );

  factory SimpleClassOfStringNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfStringNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringNullable {
  final List<String?>? value;

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
  final List<Uri> value;

  SimpleClassOfUri(
    this.value,
  );

  factory SimpleClassOfUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUri {
  final List<Uri>? value;

  SimpleClassNullableOfUri(
    this.value,
  );

  factory SimpleClassNullableOfUri.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableOfUriToJson(this);
}

@JsonSerializable()
class SimpleClassOfUriNullable {
  final List<Uri?> value;

  SimpleClassOfUriNullable(
    this.value,
  );

  factory SimpleClassOfUriNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassOfUriNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassOfUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriNullable {
  final List<Uri?>? value;

  SimpleClassNullableOfUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriNullable.fromJson(
          Map<String, dynamic> json) =>
      _$SimpleClassNullableOfUriNullableFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SimpleClassNullableOfUriNullableToJson(this);
}
