// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'converter_examples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue1202RegressionClass _$Issue1202RegressionClassFromJson(
        Map<String, dynamic> json) =>
    Issue1202RegressionClass(
      value: $enumDecode(_$Issue1202RegressionEnumEnumMap, json['value']),
      normalNullableValue: (json['normalNullableValue'] as num?)?.toInt(),
      notNullableValueWithNullableConverter:
          const _Issue1202RegressionConverter().fromJson(
              json['notNullableValueWithNullableConverter'] as String?),
      notNullableValueWithConverter:
          const _Issue1202RegressionNotNullConverter()
              .fromJson(json['notNullableValueWithConverter'] as String),
      valueWithFunctions: Issue1202RegressionClass._fromJson(
          json['valueWithFunctions'] as String),
      valueWithNullableFunctions: Issue1202RegressionClass._fromJsonNullable(
          json['valueWithNullableFunctions'] as String?),
    );

Map<String, dynamic> _$Issue1202RegressionClassToJson(
        Issue1202RegressionClass instance) =>
    <String, dynamic>{
      'valueWithFunctions':
          Issue1202RegressionClass._toJson(instance.valueWithFunctions),
      'notNullableValueWithConverter':
          const _Issue1202RegressionNotNullConverter()
              .toJson(instance.notNullableValueWithConverter),
      if (_$Issue1202RegressionEnumEnumMap[instance.value] case final value?)
        'value': value,
      if (instance.normalNullableValue case final value?)
        'normalNullableValue': value,
      if (const _Issue1202RegressionConverter()
              .toJson(instance.notNullableValueWithNullableConverter)
          case final value?)
        'notNullableValueWithNullableConverter': value,
      if (Issue1202RegressionClass._toJsonNullable(
              instance.valueWithNullableFunctions)
          case final value?)
        'valueWithNullableFunctions': value,
    };

const _$Issue1202RegressionEnumEnumMap = {
  Issue1202RegressionEnum.normalValue: 42,
  Issue1202RegressionEnum.nullValue: null,
};

Regression1229 _$Regression1229FromJson(Map<String, dynamic> json) =>
    Regression1229(
      date: _$JsonConverterFromJson<String, DateTime>(
          json['date'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$Regression1229ToJson(Regression1229 instance) =>
    <String, dynamic>{
      if (_$JsonConverterToJson<String, DateTime>(
              instance.date, const DateTimeConverter().toJson)
          case final value?)
        'date': value,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
