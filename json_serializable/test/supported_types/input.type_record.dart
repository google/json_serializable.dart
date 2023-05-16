// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'enum_type.dart';

part 'input.type_record.g.dart';

typedef RecordTypeDef = ();

@JsonSerializable()
class SimpleClass {
  final RecordTypeDef value;

  SimpleClass(
    this.value,
  );

  factory SimpleClass.fromJson(Map<String, Object?> json) =>
      _$SimpleClassFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassToJson(this);
}

@JsonSerializable()
class SimpleClassNullable {
  final RecordTypeDef? value;

  SimpleClassNullable(
    this.value,
  );

  factory SimpleClassNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableToJson(this);
}

typedef SimpleClassOfBigIntTypeDef = (BigInt, {BigInt named});

@JsonSerializable()
class SimpleClassOfBigInt {
  final SimpleClassOfBigIntTypeDef value;

  SimpleClassOfBigInt(
    this.value,
  );

  factory SimpleClassOfBigInt.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfBigIntFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfBigIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigInt {
  final SimpleClassOfBigIntTypeDef? value;

  SimpleClassNullableOfBigInt(
    this.value,
  );

  factory SimpleClassNullableOfBigInt.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfBigIntFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfBigIntToJson(this);
}

typedef SimpleClassOfBigIntNullableTypeDef = (BigInt?, {BigInt? named});

@JsonSerializable()
class SimpleClassOfBigIntNullable {
  final SimpleClassOfBigIntNullableTypeDef value;

  SimpleClassOfBigIntNullable(
    this.value,
  );

  factory SimpleClassOfBigIntNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfBigIntNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfBigIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBigIntNullable {
  final SimpleClassOfBigIntNullableTypeDef? value;

  SimpleClassNullableOfBigIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfBigIntNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfBigIntNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfBigIntNullableToJson(this);
}

typedef SimpleClassOfBoolTypeDef = (bool, {bool named});

@JsonSerializable()
class SimpleClassOfBool {
  final SimpleClassOfBoolTypeDef value;

  SimpleClassOfBool(
    this.value,
  );

  factory SimpleClassOfBool.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfBoolFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfBoolToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBool {
  final SimpleClassOfBoolTypeDef? value;

  SimpleClassNullableOfBool(
    this.value,
  );

  factory SimpleClassNullableOfBool.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfBoolFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfBoolToJson(this);
}

typedef SimpleClassOfBoolNullableTypeDef = (bool?, {bool? named});

@JsonSerializable()
class SimpleClassOfBoolNullable {
  final SimpleClassOfBoolNullableTypeDef value;

  SimpleClassOfBoolNullable(
    this.value,
  );

  factory SimpleClassOfBoolNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfBoolNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfBoolNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfBoolNullable {
  final SimpleClassOfBoolNullableTypeDef? value;

  SimpleClassNullableOfBoolNullable(
    this.value,
  );

  factory SimpleClassNullableOfBoolNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfBoolNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfBoolNullableToJson(this);
}

typedef SimpleClassOfDateTimeTypeDef = (DateTime, {DateTime named});

@JsonSerializable()
class SimpleClassOfDateTime {
  final SimpleClassOfDateTimeTypeDef value;

  SimpleClassOfDateTime(
    this.value,
  );

  factory SimpleClassOfDateTime.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfDateTimeFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfDateTimeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTime {
  final SimpleClassOfDateTimeTypeDef? value;

  SimpleClassNullableOfDateTime(
    this.value,
  );

  factory SimpleClassNullableOfDateTime.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfDateTimeFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfDateTimeToJson(this);
}

typedef SimpleClassOfDateTimeNullableTypeDef = (DateTime?, {DateTime? named});

@JsonSerializable()
class SimpleClassOfDateTimeNullable {
  final SimpleClassOfDateTimeNullableTypeDef value;

  SimpleClassOfDateTimeNullable(
    this.value,
  );

  factory SimpleClassOfDateTimeNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfDateTimeNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfDateTimeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDateTimeNullable {
  final SimpleClassOfDateTimeNullableTypeDef? value;

  SimpleClassNullableOfDateTimeNullable(
    this.value,
  );

  factory SimpleClassNullableOfDateTimeNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfDateTimeNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfDateTimeNullableToJson(this);
}

typedef SimpleClassOfDoubleTypeDef = (double, {double named});

@JsonSerializable()
class SimpleClassOfDouble {
  final SimpleClassOfDoubleTypeDef value;

  SimpleClassOfDouble(
    this.value,
  );

  factory SimpleClassOfDouble.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfDoubleFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfDoubleToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDouble {
  final SimpleClassOfDoubleTypeDef? value;

  SimpleClassNullableOfDouble(
    this.value,
  );

  factory SimpleClassNullableOfDouble.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfDoubleFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfDoubleToJson(this);
}

typedef SimpleClassOfDoubleNullableTypeDef = (double?, {double? named});

@JsonSerializable()
class SimpleClassOfDoubleNullable {
  final SimpleClassOfDoubleNullableTypeDef value;

  SimpleClassOfDoubleNullable(
    this.value,
  );

  factory SimpleClassOfDoubleNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfDoubleNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfDoubleNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDoubleNullable {
  final SimpleClassOfDoubleNullableTypeDef? value;

  SimpleClassNullableOfDoubleNullable(
    this.value,
  );

  factory SimpleClassNullableOfDoubleNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfDoubleNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfDoubleNullableToJson(this);
}

typedef SimpleClassOfDurationTypeDef = (Duration, {Duration named});

@JsonSerializable()
class SimpleClassOfDuration {
  final SimpleClassOfDurationTypeDef value;

  SimpleClassOfDuration(
    this.value,
  );

  factory SimpleClassOfDuration.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfDurationFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfDurationToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDuration {
  final SimpleClassOfDurationTypeDef? value;

  SimpleClassNullableOfDuration(
    this.value,
  );

  factory SimpleClassNullableOfDuration.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfDurationFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfDurationToJson(this);
}

typedef SimpleClassOfDurationNullableTypeDef = (Duration?, {Duration? named});

@JsonSerializable()
class SimpleClassOfDurationNullable {
  final SimpleClassOfDurationNullableTypeDef value;

  SimpleClassOfDurationNullable(
    this.value,
  );

  factory SimpleClassOfDurationNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfDurationNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfDurationNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDurationNullable {
  final SimpleClassOfDurationNullableTypeDef? value;

  SimpleClassNullableOfDurationNullable(
    this.value,
  );

  factory SimpleClassNullableOfDurationNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfDurationNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfDurationNullableToJson(this);
}

typedef SimpleClassOfDynamicTypeDef = (dynamic, {dynamic named});

@JsonSerializable()
class SimpleClassOfDynamic {
  final SimpleClassOfDynamicTypeDef value;

  SimpleClassOfDynamic(
    this.value,
  );

  factory SimpleClassOfDynamic.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfDynamicFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfDynamicToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfDynamic {
  final SimpleClassOfDynamicTypeDef? value;

  SimpleClassNullableOfDynamic(
    this.value,
  );

  factory SimpleClassNullableOfDynamic.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfDynamicFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfDynamicToJson(this);
}

typedef SimpleClassOfEnumTypeTypeDef = (EnumType, {EnumType named});

@JsonSerializable()
class SimpleClassOfEnumType {
  final SimpleClassOfEnumTypeTypeDef value;

  SimpleClassOfEnumType(
    this.value,
  );

  factory SimpleClassOfEnumType.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfEnumTypeFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfEnumTypeToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumType {
  final SimpleClassOfEnumTypeTypeDef? value;

  SimpleClassNullableOfEnumType(
    this.value,
  );

  factory SimpleClassNullableOfEnumType.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfEnumTypeFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfEnumTypeToJson(this);
}

typedef SimpleClassOfEnumTypeNullableTypeDef = (EnumType?, {EnumType? named});

@JsonSerializable()
class SimpleClassOfEnumTypeNullable {
  final SimpleClassOfEnumTypeNullableTypeDef value;

  SimpleClassOfEnumTypeNullable(
    this.value,
  );

  factory SimpleClassOfEnumTypeNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfEnumTypeNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfEnumTypeNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfEnumTypeNullable {
  final SimpleClassOfEnumTypeNullableTypeDef? value;

  SimpleClassNullableOfEnumTypeNullable(
    this.value,
  );

  factory SimpleClassNullableOfEnumTypeNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfEnumTypeNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfEnumTypeNullableToJson(this);
}

typedef SimpleClassOfFromJsonDynamicParamTypeDef = (
  FromJsonDynamicParam, {
  FromJsonDynamicParam named
});

@JsonSerializable()
class SimpleClassOfFromJsonDynamicParam {
  final SimpleClassOfFromJsonDynamicParamTypeDef value;

  SimpleClassOfFromJsonDynamicParam(
    this.value,
  );

  factory SimpleClassOfFromJsonDynamicParam.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassOfFromJsonDynamicParamFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassOfFromJsonDynamicParamToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfFromJsonDynamicParam {
  final SimpleClassOfFromJsonDynamicParamTypeDef? value;

  SimpleClassNullableOfFromJsonDynamicParam(
    this.value,
  );

  factory SimpleClassNullableOfFromJsonDynamicParam.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfFromJsonDynamicParamFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfFromJsonDynamicParamToJson(this);
}

typedef SimpleClassOfFromJsonNullableObjectParamTypeDef = (
  FromJsonNullableObjectParam, {
  FromJsonNullableObjectParam named
});

@JsonSerializable()
class SimpleClassOfFromJsonNullableObjectParam {
  final SimpleClassOfFromJsonNullableObjectParamTypeDef value;

  SimpleClassOfFromJsonNullableObjectParam(
    this.value,
  );

  factory SimpleClassOfFromJsonNullableObjectParam.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassOfFromJsonNullableObjectParamFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassOfFromJsonNullableObjectParamToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfFromJsonNullableObjectParam {
  final SimpleClassOfFromJsonNullableObjectParamTypeDef? value;

  SimpleClassNullableOfFromJsonNullableObjectParam(
    this.value,
  );

  factory SimpleClassNullableOfFromJsonNullableObjectParam.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfFromJsonNullableObjectParamFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfFromJsonNullableObjectParamToJson(this);
}

typedef SimpleClassOfFromJsonObjectParamTypeDef = (
  FromJsonObjectParam, {
  FromJsonObjectParam named
});

@JsonSerializable()
class SimpleClassOfFromJsonObjectParam {
  final SimpleClassOfFromJsonObjectParamTypeDef value;

  SimpleClassOfFromJsonObjectParam(
    this.value,
  );

  factory SimpleClassOfFromJsonObjectParam.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassOfFromJsonObjectParamFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassOfFromJsonObjectParamToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfFromJsonObjectParam {
  final SimpleClassOfFromJsonObjectParamTypeDef? value;

  SimpleClassNullableOfFromJsonObjectParam(
    this.value,
  );

  factory SimpleClassNullableOfFromJsonObjectParam.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfFromJsonObjectParamFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfFromJsonObjectParamToJson(this);
}

typedef SimpleClassOfIntTypeDef = (int, {int named});

@JsonSerializable()
class SimpleClassOfInt {
  final SimpleClassOfIntTypeDef value;

  SimpleClassOfInt(
    this.value,
  );

  factory SimpleClassOfInt.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfIntFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfIntToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfInt {
  final SimpleClassOfIntTypeDef? value;

  SimpleClassNullableOfInt(
    this.value,
  );

  factory SimpleClassNullableOfInt.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfIntFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfIntToJson(this);
}

typedef SimpleClassOfIntNullableTypeDef = (int?, {int? named});

@JsonSerializable()
class SimpleClassOfIntNullable {
  final SimpleClassOfIntNullableTypeDef value;

  SimpleClassOfIntNullable(
    this.value,
  );

  factory SimpleClassOfIntNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfIntNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfIntNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfIntNullable {
  final SimpleClassOfIntNullableTypeDef? value;

  SimpleClassNullableOfIntNullable(
    this.value,
  );

  factory SimpleClassNullableOfIntNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfIntNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfIntNullableToJson(this);
}

typedef SimpleClassOfNumTypeDef = (num, {num named});

@JsonSerializable()
class SimpleClassOfNum {
  final SimpleClassOfNumTypeDef value;

  SimpleClassOfNum(
    this.value,
  );

  factory SimpleClassOfNum.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfNumFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfNumToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfNum {
  final SimpleClassOfNumTypeDef? value;

  SimpleClassNullableOfNum(
    this.value,
  );

  factory SimpleClassNullableOfNum.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfNumFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfNumToJson(this);
}

typedef SimpleClassOfNumNullableTypeDef = (num?, {num? named});

@JsonSerializable()
class SimpleClassOfNumNullable {
  final SimpleClassOfNumNullableTypeDef value;

  SimpleClassOfNumNullable(
    this.value,
  );

  factory SimpleClassOfNumNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfNumNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfNumNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfNumNullable {
  final SimpleClassOfNumNullableTypeDef? value;

  SimpleClassNullableOfNumNullable(
    this.value,
  );

  factory SimpleClassNullableOfNumNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfNumNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfNumNullableToJson(this);
}

typedef SimpleClassOfObjectTypeDef = (Object, {Object named});

@JsonSerializable()
class SimpleClassOfObject {
  final SimpleClassOfObjectTypeDef value;

  SimpleClassOfObject(
    this.value,
  );

  factory SimpleClassOfObject.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfObjectFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfObjectToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObject {
  final SimpleClassOfObjectTypeDef? value;

  SimpleClassNullableOfObject(
    this.value,
  );

  factory SimpleClassNullableOfObject.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfObjectFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfObjectToJson(this);
}

typedef SimpleClassOfObjectNullableTypeDef = (Object?, {Object? named});

@JsonSerializable()
class SimpleClassOfObjectNullable {
  final SimpleClassOfObjectNullableTypeDef value;

  SimpleClassOfObjectNullable(
    this.value,
  );

  factory SimpleClassOfObjectNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfObjectNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfObjectNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfObjectNullable {
  final SimpleClassOfObjectNullableTypeDef? value;

  SimpleClassNullableOfObjectNullable(
    this.value,
  );

  factory SimpleClassNullableOfObjectNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfObjectNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfObjectNullableToJson(this);
}

typedef SimpleClassOfRecordTypeDef = (
  (int, String, {bool truth}), {
  (int, String, {bool truth}) named
});

@JsonSerializable()
class SimpleClassOfRecord {
  final SimpleClassOfRecordTypeDef value;

  SimpleClassOfRecord(
    this.value,
  );

  factory SimpleClassOfRecord.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfRecordFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfRecordToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfRecord {
  final SimpleClassOfRecordTypeDef? value;

  SimpleClassNullableOfRecord(
    this.value,
  );

  factory SimpleClassNullableOfRecord.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfRecordFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfRecordToJson(this);
}

typedef SimpleClassOfStringTypeDef = (String, {String named});

@JsonSerializable()
class SimpleClassOfString {
  final SimpleClassOfStringTypeDef value;

  SimpleClassOfString(
    this.value,
  );

  factory SimpleClassOfString.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfStringFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfStringToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfString {
  final SimpleClassOfStringTypeDef? value;

  SimpleClassNullableOfString(
    this.value,
  );

  factory SimpleClassNullableOfString.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfStringFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfStringToJson(this);
}

typedef SimpleClassOfStringNullableTypeDef = (String?, {String? named});

@JsonSerializable()
class SimpleClassOfStringNullable {
  final SimpleClassOfStringNullableTypeDef value;

  SimpleClassOfStringNullable(
    this.value,
  );

  factory SimpleClassOfStringNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfStringNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfStringNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfStringNullable {
  final SimpleClassOfStringNullableTypeDef? value;

  SimpleClassNullableOfStringNullable(
    this.value,
  );

  factory SimpleClassNullableOfStringNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfStringNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfStringNullableToJson(this);
}

typedef SimpleClassOfUriTypeDef = (Uri, {Uri named});

@JsonSerializable()
class SimpleClassOfUri {
  final SimpleClassOfUriTypeDef value;

  SimpleClassOfUri(
    this.value,
  );

  factory SimpleClassOfUri.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfUriFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfUriToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUri {
  final SimpleClassOfUriTypeDef? value;

  SimpleClassNullableOfUri(
    this.value,
  );

  factory SimpleClassNullableOfUri.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableOfUriFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableOfUriToJson(this);
}

typedef SimpleClassOfUriNullableTypeDef = (Uri?, {Uri? named});

@JsonSerializable()
class SimpleClassOfUriNullable {
  final SimpleClassOfUriNullableTypeDef value;

  SimpleClassOfUriNullable(
    this.value,
  );

  factory SimpleClassOfUriNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassOfUriNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassOfUriNullableToJson(this);
}

@JsonSerializable()
class SimpleClassNullableOfUriNullable {
  final SimpleClassOfUriNullableTypeDef? value;

  SimpleClassNullableOfUriNullable(
    this.value,
  );

  factory SimpleClassNullableOfUriNullable.fromJson(
          Map<String, Object?> json) =>
      _$SimpleClassNullableOfUriNullableFromJson(json);

  Map<String, Object?> toJson() =>
      _$SimpleClassNullableOfUriNullableToJson(this);
}
