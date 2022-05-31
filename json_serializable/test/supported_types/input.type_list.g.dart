// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'input.type_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) => SimpleClass(
      json['value'] as List<dynamic>,
      json['withDefault'] as List<dynamic>? ?? [42, true, false, null],
    );

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'withDefault': instance.withDefault,
    };

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) =>
    SimpleClassNullable(
      json['value'] as List<dynamic>?,
      json['withDefault'] as List<dynamic>? ?? [42, true, false, null],
    );

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
      'withDefault': instance.withDefault,
    };

SimpleClassOfBigInt _$SimpleClassOfBigIntFromJson(Map<String, dynamic> json) =>
    SimpleClassOfBigInt(
      (json['value'] as List<dynamic>)
          .map((e) => BigInt.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfBigIntToJson(
        SimpleClassOfBigInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e.toString()).toList(),
    };

SimpleClassNullableOfBigInt _$SimpleClassNullableOfBigIntFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfBigInt(
      (json['value'] as List<dynamic>?)
          ?.map((e) => BigInt.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfBigIntToJson(
        SimpleClassNullableOfBigInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => e.toString()).toList(),
    };

SimpleClassOfBigIntNullable _$SimpleClassOfBigIntNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfBigIntNullable(
      (json['value'] as List<dynamic>)
          .map((e) => e == null ? null : BigInt.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfBigIntNullableToJson(
        SimpleClassOfBigIntNullable instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e?.toString()).toList(),
    };

SimpleClassNullableOfBigIntNullable
    _$SimpleClassNullableOfBigIntNullableFromJson(Map<String, dynamic> json) =>
        SimpleClassNullableOfBigIntNullable(
          (json['value'] as List<dynamic>?)
              ?.map((e) => e == null ? null : BigInt.parse(e as String))
              .toList(),
        );

Map<String, dynamic> _$SimpleClassNullableOfBigIntNullableToJson(
        SimpleClassNullableOfBigIntNullable instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => e?.toString()).toList(),
    };

SimpleClassOfBool _$SimpleClassOfBoolFromJson(Map<String, dynamic> json) =>
    SimpleClassOfBool(
      (json['value'] as List<dynamic>).map((e) => e as bool).toList(),
    );

Map<String, dynamic> _$SimpleClassOfBoolToJson(SimpleClassOfBool instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfBool _$SimpleClassNullableOfBoolFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfBool(
      (json['value'] as List<dynamic>?)?.map((e) => e as bool).toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfBoolToJson(
        SimpleClassNullableOfBool instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfBoolNullable _$SimpleClassOfBoolNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfBoolNullable(
      (json['value'] as List<dynamic>).map((e) => e as bool?).toList(),
    );

Map<String, dynamic> _$SimpleClassOfBoolNullableToJson(
        SimpleClassOfBoolNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfBoolNullable _$SimpleClassNullableOfBoolNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfBoolNullable(
      (json['value'] as List<dynamic>?)?.map((e) => e as bool?).toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfBoolNullableToJson(
        SimpleClassNullableOfBoolNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfDateTime _$SimpleClassOfDateTimeFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDateTime(
      (json['value'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfDateTimeToJson(
        SimpleClassOfDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e.toIso8601String()).toList(),
    };

SimpleClassNullableOfDateTime _$SimpleClassNullableOfDateTimeFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfDateTime(
      (json['value'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToJson(
        SimpleClassNullableOfDateTime instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => e.toIso8601String()).toList(),
    };

SimpleClassOfDateTimeNullable _$SimpleClassOfDateTimeNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDateTimeNullable(
      (json['value'] as List<dynamic>)
          .map((e) => e == null ? null : DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfDateTimeNullableToJson(
        SimpleClassOfDateTimeNullable instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e?.toIso8601String()).toList(),
    };

SimpleClassNullableOfDateTimeNullable
    _$SimpleClassNullableOfDateTimeNullableFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfDateTimeNullable(
          (json['value'] as List<dynamic>?)
              ?.map((e) => e == null ? null : DateTime.parse(e as String))
              .toList(),
        );

Map<String, dynamic> _$SimpleClassNullableOfDateTimeNullableToJson(
        SimpleClassNullableOfDateTimeNullable instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => e?.toIso8601String()).toList(),
    };

SimpleClassOfDouble _$SimpleClassOfDoubleFromJson(Map<String, dynamic> json) =>
    SimpleClassOfDouble(
      (json['value'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfDoubleToJson(
        SimpleClassOfDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfDouble _$SimpleClassNullableOfDoubleFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfDouble(
      (json['value'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfDoubleToJson(
        SimpleClassNullableOfDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfDoubleNullable _$SimpleClassOfDoubleNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDoubleNullable(
      (json['value'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfDoubleNullableToJson(
        SimpleClassOfDoubleNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfDoubleNullable
    _$SimpleClassNullableOfDoubleNullableFromJson(Map<String, dynamic> json) =>
        SimpleClassNullableOfDoubleNullable(
          (json['value'] as List<dynamic>?)
              ?.map((e) => (e as num?)?.toDouble())
              .toList(),
        );

Map<String, dynamic> _$SimpleClassNullableOfDoubleNullableToJson(
        SimpleClassNullableOfDoubleNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfDuration _$SimpleClassOfDurationFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDuration(
      (json['value'] as List<dynamic>)
          .map((e) => Duration(microseconds: e as int))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfDurationToJson(
        SimpleClassOfDuration instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e.inMicroseconds).toList(),
    };

SimpleClassNullableOfDuration _$SimpleClassNullableOfDurationFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfDuration(
      (json['value'] as List<dynamic>?)
          ?.map((e) => Duration(microseconds: e as int))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfDurationToJson(
        SimpleClassNullableOfDuration instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => e.inMicroseconds).toList(),
    };

SimpleClassOfDurationNullable _$SimpleClassOfDurationNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDurationNullable(
      (json['value'] as List<dynamic>)
          .map((e) => e == null ? null : Duration(microseconds: e as int))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfDurationNullableToJson(
        SimpleClassOfDurationNullable instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e?.inMicroseconds).toList(),
    };

SimpleClassNullableOfDurationNullable
    _$SimpleClassNullableOfDurationNullableFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfDurationNullable(
          (json['value'] as List<dynamic>?)
              ?.map((e) => e == null ? null : Duration(microseconds: e as int))
              .toList(),
        );

Map<String, dynamic> _$SimpleClassNullableOfDurationNullableToJson(
        SimpleClassNullableOfDurationNullable instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => e?.inMicroseconds).toList(),
    };

SimpleClassOfDynamic _$SimpleClassOfDynamicFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDynamic(
      json['value'] as List<dynamic>,
    );

Map<String, dynamic> _$SimpleClassOfDynamicToJson(
        SimpleClassOfDynamic instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfDynamic _$SimpleClassNullableOfDynamicFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfDynamic(
      json['value'] as List<dynamic>?,
    );

Map<String, dynamic> _$SimpleClassNullableOfDynamicToJson(
        SimpleClassNullableOfDynamic instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfEnumType _$SimpleClassOfEnumTypeFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfEnumType(
      (json['value'] as List<dynamic>)
          .map((e) => $enumDecode(_$EnumTypeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfEnumTypeToJson(
        SimpleClassOfEnumType instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => _$EnumTypeEnumMap[e]!).toList(),
    };

const _$EnumTypeEnumMap = {
  EnumType.alpha: 'alpha',
  EnumType.beta: 'beta',
  EnumType.gamma: 'gamma',
  EnumType.delta: 'delta',
};

SimpleClassNullableOfEnumType _$SimpleClassNullableOfEnumTypeFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfEnumType(
      (json['value'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$EnumTypeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToJson(
        SimpleClassNullableOfEnumType instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => _$EnumTypeEnumMap[e]!).toList(),
    };

SimpleClassOfEnumTypeNullable _$SimpleClassOfEnumTypeNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfEnumTypeNullable(
      (json['value'] as List<dynamic>)
          .map((e) => $enumDecodeNullable(_$EnumTypeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfEnumTypeNullableToJson(
        SimpleClassOfEnumTypeNullable instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => _$EnumTypeEnumMap[e]).toList(),
    };

SimpleClassNullableOfEnumTypeNullable
    _$SimpleClassNullableOfEnumTypeNullableFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfEnumTypeNullable(
          (json['value'] as List<dynamic>?)
              ?.map((e) => $enumDecodeNullable(_$EnumTypeEnumMap, e))
              .toList(),
        );

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeNullableToJson(
        SimpleClassNullableOfEnumTypeNullable instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => _$EnumTypeEnumMap[e]).toList(),
    };

SimpleClassOfInt _$SimpleClassOfIntFromJson(Map<String, dynamic> json) =>
    SimpleClassOfInt(
      (json['value'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$SimpleClassOfIntToJson(SimpleClassOfInt instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfInt _$SimpleClassNullableOfIntFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfInt(
      (json['value'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfIntToJson(
        SimpleClassNullableOfInt instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfIntNullable _$SimpleClassOfIntNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfIntNullable(
      (json['value'] as List<dynamic>).map((e) => e as int?).toList(),
    );

Map<String, dynamic> _$SimpleClassOfIntNullableToJson(
        SimpleClassOfIntNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfIntNullable _$SimpleClassNullableOfIntNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfIntNullable(
      (json['value'] as List<dynamic>?)?.map((e) => e as int?).toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfIntNullableToJson(
        SimpleClassNullableOfIntNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfNum _$SimpleClassOfNumFromJson(Map<String, dynamic> json) =>
    SimpleClassOfNum(
      (json['value'] as List<dynamic>).map((e) => e as num).toList(),
    );

Map<String, dynamic> _$SimpleClassOfNumToJson(SimpleClassOfNum instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfNum _$SimpleClassNullableOfNumFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfNum(
      (json['value'] as List<dynamic>?)?.map((e) => e as num).toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfNumToJson(
        SimpleClassNullableOfNum instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfNumNullable _$SimpleClassOfNumNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfNumNullable(
      (json['value'] as List<dynamic>).map((e) => e as num?).toList(),
    );

Map<String, dynamic> _$SimpleClassOfNumNullableToJson(
        SimpleClassOfNumNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfNumNullable _$SimpleClassNullableOfNumNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfNumNullable(
      (json['value'] as List<dynamic>?)?.map((e) => e as num?).toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfNumNullableToJson(
        SimpleClassNullableOfNumNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfObject _$SimpleClassOfObjectFromJson(Map<String, dynamic> json) =>
    SimpleClassOfObject(
      (json['value'] as List<dynamic>).map((e) => e as Object).toList(),
    );

Map<String, dynamic> _$SimpleClassOfObjectToJson(
        SimpleClassOfObject instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfObject _$SimpleClassNullableOfObjectFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfObject(
      (json['value'] as List<dynamic>?)?.map((e) => e as Object).toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfObjectToJson(
        SimpleClassNullableOfObject instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfObjectNullable _$SimpleClassOfObjectNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfObjectNullable(
      json['value'] as List<dynamic>,
    );

Map<String, dynamic> _$SimpleClassOfObjectNullableToJson(
        SimpleClassOfObjectNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfObjectNullable
    _$SimpleClassNullableOfObjectNullableFromJson(Map<String, dynamic> json) =>
        SimpleClassNullableOfObjectNullable(
          json['value'] as List<dynamic>?,
        );

Map<String, dynamic> _$SimpleClassNullableOfObjectNullableToJson(
        SimpleClassNullableOfObjectNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfString _$SimpleClassOfStringFromJson(Map<String, dynamic> json) =>
    SimpleClassOfString(
      (json['value'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SimpleClassOfStringToJson(
        SimpleClassOfString instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfString _$SimpleClassNullableOfStringFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfString(
      (json['value'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfStringToJson(
        SimpleClassNullableOfString instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfStringNullable _$SimpleClassOfStringNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfStringNullable(
      (json['value'] as List<dynamic>).map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$SimpleClassOfStringNullableToJson(
        SimpleClassOfStringNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassNullableOfStringNullable
    _$SimpleClassNullableOfStringNullableFromJson(Map<String, dynamic> json) =>
        SimpleClassNullableOfStringNullable(
          (json['value'] as List<dynamic>?)?.map((e) => e as String?).toList(),
        );

Map<String, dynamic> _$SimpleClassNullableOfStringNullableToJson(
        SimpleClassNullableOfStringNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SimpleClassOfUri _$SimpleClassOfUriFromJson(Map<String, dynamic> json) =>
    SimpleClassOfUri(
      (json['value'] as List<dynamic>)
          .map((e) => Uri.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfUriToJson(SimpleClassOfUri instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e.toString()).toList(),
    };

SimpleClassNullableOfUri _$SimpleClassNullableOfUriFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfUri(
      (json['value'] as List<dynamic>?)
          ?.map((e) => Uri.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfUriToJson(
        SimpleClassNullableOfUri instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => e.toString()).toList(),
    };

SimpleClassOfUriNullable _$SimpleClassOfUriNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfUriNullable(
      (json['value'] as List<dynamic>)
          .map((e) => e == null ? null : Uri.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassOfUriNullableToJson(
        SimpleClassOfUriNullable instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e?.toString()).toList(),
    };

SimpleClassNullableOfUriNullable _$SimpleClassNullableOfUriNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfUriNullable(
      (json['value'] as List<dynamic>?)
          ?.map((e) => e == null ? null : Uri.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassNullableOfUriNullableToJson(
        SimpleClassNullableOfUriNullable instance) =>
    <String, dynamic>{
      'value': instance.value?.map((e) => e?.toString()).toList(),
    };
