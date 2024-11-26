// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

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
    status: $enumDecodeNullableWithDecodeMap(
        _$Issue559RegressionEnumEnumDecodeMap, json['status'],
        unknownValue: JsonKey.nullForUndefinedEnumValue),
  );
}

const _$Issue559RegressionEnumEnumMap = {
  Issue559RegressionEnum.alpha: 'alpha',
  Issue559RegressionEnum.beta: 'beta',
  Issue559RegressionEnum.gamma: 'gamma',
};

// ignore: unused_element
const _$Issue559RegressionEnumEnumDecodeMap = {
  'alpha': Issue559RegressionEnum.alpha,
  'beta': Issue559RegressionEnum.beta,
  'gamma': Issue559RegressionEnum.gamma,
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

// ignore: unused_element
const _$Issue1145RegressionEnumEnumDecodeMap = {
  'alpha': Issue1145RegressionEnum.alpha,
  'beta': Issue1145RegressionEnum.beta,
  'gamma': Issue1145RegressionEnum.gamma,
};

Map<String, dynamic> _$Issue1145RegressionBToJson(
        Issue1145RegressionB instance) =>
    <String, dynamic>{
      'status': instance.status
          .map((e) => _$Issue1145RegressionEnumEnumMap[e])
          .toList(),
    };

Issue1226Regression _$Issue1226RegressionFromJson(Map<String, dynamic> json) =>
    Issue1226Regression(
      durationType: $enumDecodeNullableWithDecodeMap(
          _$Issue1145RegressionEnumEnumDecodeMap, json['durationType']),
    );

Map<String, dynamic> _$Issue1226RegressionToJson(
        Issue1226Regression instance) =>
    <String, dynamic>{
      if (_$Issue1145RegressionEnumEnumMap[instance.durationType]
          case final value?)
        'durationType': value,
    };

EnumWithAliasesData _$EnumWithAliasesDataFromJson(Map<String, dynamic> json) =>
    EnumWithAliasesData(
      $enumDecodeWithDecodeMap(_$EnumWithAliasesEnumDecodeMap, json['value']),
    );

Map<String, dynamic> _$EnumWithAliasesDataToJson(
        EnumWithAliasesData instance) =>
    <String, dynamic>{
      'value': _$EnumWithAliasesEnumMap[instance.value]!,
    };

const _$EnumWithAliasesEnumMap = {
  EnumWithAliases.one: '1',
  EnumWithAliases.two: '2',
  EnumWithAliases.three: '3',
};

// ignore: unused_element
const _$EnumWithAliasesEnumDecodeMap = {
  '1': EnumWithAliases.one,
  '2': EnumWithAliases.two,
  'two': EnumWithAliases.two,
  'deux': EnumWithAliases.two,
  '3': EnumWithAliases.three,
};

const _$StandAloneEnumEnumMap = {
  StandAloneEnum.alpha: 'a',
  StandAloneEnum.beta: 'b',
  StandAloneEnum.gamma: 'g',
  StandAloneEnum.delta: 'd',
};

// ignore: unused_element
const _$StandAloneEnumEnumDecodeMap = {
  'a': StandAloneEnum.alpha,
  'b': StandAloneEnum.beta,
  'g': StandAloneEnum.gamma,
  'd': StandAloneEnum.delta,
};

const _$DayTypeEnumMap = {
  DayType.noGood: 'no-good',
  DayType.rotten: 'rotten',
  DayType.veryBad: 'very-bad',
};

// ignore: unused_element
const _$DayTypeEnumDecodeMap = {
  'no-good': DayType.noGood,
  'rotten': DayType.rotten,
  'very-bad': DayType.veryBad,
};

const _$MyStatusCodeEnumMap = {
  MyStatusCode.success: 200,
  MyStatusCode.weird: 701,
};

// ignore: unused_element
const _$MyStatusCodeEnumDecodeMap = {
  200: MyStatusCode.success,
  701: MyStatusCode.weird,
};

const _$EnumValueFieldIndexEnumMap = {
  EnumValueFieldIndex.success: 0,
  EnumValueFieldIndex.weird: 701,
  EnumValueFieldIndex.oneMore: 2,
};

// ignore: unused_element
const _$EnumValueFieldIndexEnumDecodeMap = {
  0: EnumValueFieldIndex.success,
  701: EnumValueFieldIndex.weird,
  2: EnumValueFieldIndex.oneMore,
};
