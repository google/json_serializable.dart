// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'default_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultValue _$DefaultValueFromJson(Map<String, dynamic> json) {
  return DefaultValue(
    json['fieldBool'] == null ? true : json['fieldBool'] as bool,
    json['fieldString'] == null ? 'string' : json['fieldString'] as String,
    json['fieldInt'] == null ? 42 : json['fieldInt'] as int,
    (json['fieldDouble'] == null ? 3.14 : json['fieldDouble'] as num)
        .toDouble(),
    (json['fieldListEmpty'] == null
            ? <int>[]
            : json['fieldListEmpty'] as List<int>)
        .toList(),
    (json['fieldSetEmpty'] == null
            ? <int>{}
            : json['fieldSetEmpty'] as List<int>)
        .toSet(),
    json['fieldMapEmpty'] == null
        ? {}
        : json['fieldMapEmpty'] as Map<String, dynamic>,
    (json['fieldListSimple'] == null
            ? <int>[1, 2, 3]
            : json['fieldListSimple'] as List<int>)
        .toList(),
    (json['fieldSetSimple'] == null
            ? <String>{'entry1', 'entry2'}
            : json['fieldSetSimple'] as List<String>)
        .toSet(),
    Map<String, int>.from(json['fieldMapSimple'] == null
        ? {'answer': 42}
        : json['fieldMapSimple'] as Map),
    (json['fieldMapListString'] == null
            ? {
                'root': ['child']
              }
            : json['fieldMapListString'] as Map<String, dynamic>)
        .map(
      (k, e) => MapEntry(k, (e as List).map((e) => e as String).toList()),
    ),
    _$enumDecodeNullable(_$GreekEnumMap, json['fieldEnum'] ?? Greek.beta)!,
  );
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
