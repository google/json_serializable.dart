// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'converter_examples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue1202RegressionClass _$Issue1202RegressionClassFromJson(
        Map<String, dynamic> json) =>
    Issue1202RegressionClass(
      value: $enumDecode(_$Issue1202RegressionEnumEnumMap, json['value']),
      normalNullableValue: json['normalNullableValue'] as int?,
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
    Issue1202RegressionClass instance) {
  final val = <String, dynamic>{
    'valueWithFunctions':
        Issue1202RegressionClass._toJson(instance.valueWithFunctions),
    'notNullableValueWithConverter':
        const _Issue1202RegressionNotNullConverter()
            .toJson(instance.notNullableValueWithConverter),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', _$Issue1202RegressionEnumEnumMap[instance.value]);
  writeNotNull('normalNullableValue', instance.normalNullableValue);
  writeNotNull(
      'notNullableValueWithNullableConverter',
      const _Issue1202RegressionConverter()
          .toJson(instance.notNullableValueWithNullableConverter));
  writeNotNull(
      'valueWithNullableFunctions',
      Issue1202RegressionClass._toJsonNullable(
          instance.valueWithNullableFunctions));
  return val;
}

const _$Issue1202RegressionEnumEnumMap = {
  Issue1202RegressionEnum.normalValue: 42,
  Issue1202RegressionEnum.nullValue: null,
};
