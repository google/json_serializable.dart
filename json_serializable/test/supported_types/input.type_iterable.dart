// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.10

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
