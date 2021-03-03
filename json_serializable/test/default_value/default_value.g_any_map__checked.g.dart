// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'default_value.g_any_map__checked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultValue _$DefaultValueFromJson(Map json) {
  return $checkedNew('DefaultValue', json, () {
    final val = DefaultValue(
      $checkedConvert(json, 'fieldBool', (v) => v ?? true as bool),
      $checkedConvert(json, 'fieldString', (v) => v ?? 'string' as String),
      $checkedConvert(json, 'fieldInt', (v) => v ?? 42 as int),
      $checkedConvert(
          json, 'fieldDouble', (v) => (v ?? 3.14 as num).toDouble()),
      $checkedConvert(
          json,
          'fieldListEmpty',
          (v) => (v == null ? <int>[] : v as List<int>)
              .map((e) => e as int)
              .toList()),
      $checkedConvert(
          json,
          'fieldSetEmpty',
          (v) => (v == null ? <int>{} : v as List<int>)
              .map((e) => e as int)
              .toSet()),
      $checkedConvert(json, 'fieldMapEmpty', (v) => v == null ? {} : v as Map),
      $checkedConvert(
          json,
          'fieldListSimple',
          (v) => (v == null ? <int>[1, 2, 3] : v as List<int>)
              .map((e) => e as int)
              .toList()),
      $checkedConvert(
          json,
          'fieldSetSimple',
          (v) => (v == null ? <String>{'entry1', 'entry2'} : v as List<String>)
              .map((e) => e as String)
              .toSet()),
      $checkedConvert(json, 'fieldMapSimple',
          (v) => Map<String, int>.from(v == null ? {'answer': 42} : v as Map)),
      $checkedConvert(
          json,
          'fieldMapListString',
          (v) => (v == null
                      ? {
                          'root': ['child']
                        }
                      : v as Map)
                  .map(
                (k, e) => MapEntry(
                    k as String, (e as List).map((e) => e as String).toList()),
              )),
      $checkedConvert(json, 'fieldEnum',
          (v) => _$enumDecodeNullable(_$GreekEnumMap, v ?? Greek.beta)!),
    );
    return val;
  });
}

Map<String, dynamic> _$DefaultValueToJson(DefaultValue instance) =>
    <String, dynamic>{
      'fieldBool': instance.fieldBool,
      'fieldString': instance.fieldString,
      'fieldInt': instance.fieldInt,
      'fieldDouble': instance.fieldDouble,
      'fieldListEmpty': instance.fieldListEmpty,
      'fieldSetEmpty': instance.fieldSetEmpty.toList(),
      'fieldMapEmpty': instance.fieldMapEmpty,
      'fieldListSimple': instance.fieldListSimple,
      'fieldSetSimple': instance.fieldSetSimple.toList(),
      'fieldMapSimple': instance.fieldMapSimple,
      'fieldMapListString': instance.fieldMapListString,
      'fieldEnum': _$GreekEnumMap[instance.fieldEnum],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => source is K ? e.key == source : e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$GreekEnumMap = {
  Greek.alpha: 'alpha',
  Greek.beta: 'beta',
  Greek.gamma: 'gamma',
  Greek.delta: 'delta',
};
