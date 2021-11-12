// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'json_enum_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue559Regression _$Issue559RegressionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['status'],
    disallowNullValues: const ['status'],
  );
  return Issue559Regression(
    status: $enumDecodeNullable(_$Issue559RegressionEnumEnumMap, json['status'],
        unknownValue: JsonKey.nullForUndefinedEnumValue),
  );
}

const _$Issue559RegressionEnumEnumMap = {
  Issue559RegressionEnum.alpha: 'alpha',
  Issue559RegressionEnum.beta: 'beta',
  Issue559RegressionEnum.gamma: 'gamma',
};

const _$StandAloneEnumEnumMap = {
  StandAloneEnum.alpha: 'a',
  StandAloneEnum.beta: 'b',
  StandAloneEnum.gamma: 'g',
  StandAloneEnum.delta: 'd',
};

const _$DayTypeEnumMap = {
  DayType.noGood: 'no-good',
  DayType.rotten: 'rotten',
  DayType.veryBad: 'very-bad',
};
