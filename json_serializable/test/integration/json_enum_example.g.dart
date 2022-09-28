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

Map<String, dynamic> _$Issue1145RegressionAToJson(
        Issue1145RegressionA instance) =>
    <String, dynamic>{
      'status': instance.status
          .map((k, e) => MapEntry(_$Issue1145RegressionEnumEnumMap[k]!, e)),
    };

const _$Issue1145RegressionEnumEnumMap = {
  Issue1145RegressionEnum.alpha: 'alpha',
  Issue1145RegressionEnum.beta: 'beta',
  Issue1145RegressionEnum.gamma: 'gamma',
};

Map<String, dynamic> _$Issue1145RegressionBToJson(
        Issue1145RegressionB instance) =>
    <String, dynamic>{
      'status': instance.status
          .map((e) => _$Issue1145RegressionEnumEnumMap[e])
          .toList(),
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

const _$MyStatusCodeEnumMap = {
  MyStatusCode.success: 200,
  MyStatusCode.weird: 701,
};
