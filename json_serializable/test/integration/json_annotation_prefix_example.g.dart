// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'json_annotation_prefix_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckedPrefixModel _$CheckedPrefixModelFromJson(Map<String, dynamic> json) =>
    ja.$checkedCreate('CheckedPrefixModel', json, ($checkedConvert) {
      final val = CheckedPrefixModel(
        field1: $checkedConvert('field1', (v) => v as String),
        field2: $checkedConvert('field2', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CheckedPrefixModelToJson(CheckedPrefixModel instance) =>
    <String, dynamic>{'field1': instance.field1, 'field2': instance.field2};

EnumPrefixModel _$EnumPrefixModelFromJson(Map<String, dynamic> json) {
  ja.$checkKeys(
    json,
    requiredKeys: const ['gender'],
    disallowNullValues: const ['gender'],
  );
  return EnumPrefixModel(
    gender: ja.$enumDecode(_$PrefixModelGenderEnumMap, json['gender']),
  );
}

Map<String, dynamic> _$EnumPrefixModelToJson(EnumPrefixModel instance) =>
    <String, dynamic>{'gender': _$PrefixModelGenderEnumMap[instance.gender]!};

const _$PrefixModelGenderEnumMap = {
  PrefixModelGender.male: 'male',
  PrefixModelGender.female: 'female',
  PrefixModelGender.other: 'other',
};
