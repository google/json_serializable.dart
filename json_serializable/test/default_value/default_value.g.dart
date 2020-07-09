// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'default_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultValue _$DefaultValueFromJson(Map<String, dynamic> json) {
  return DefaultValue(
    json['fieldBool'] as bool ?? true,
    json['fieldString'] as String ?? 'string',
    json['fieldInt'] as int ?? 42,
    (json['fieldDouble'] as num).toDouble() ?? 3.14,
    (json['fieldListEmpty'] as List?) ?? [],
    ((json['fieldSetEmpty'] as List?)).toSet() ?? {},
    json['fieldMapEmpty'] as Map<String, dynamic> ?? {},
    ((json['fieldListSimple'] as List?)).map((e) => e as int).toList() ??
        [1, 2, 3],
    ((json['fieldSetSimple'] as List?)).map((e) => e as String).toSet() ??
        {'entry1', 'entry2'},
    Map<String, int>.from(json['fieldMapSimple'] as Map) ?? {'answer': 42},
    (json['fieldMapListString'] as Map<String, dynamic>).map(
          (k, e) =>
              MapEntry(k, ((e as List?)).map((e) => e as String).toList()),
        ) ??
        {
          'root': ['child']
        },
    _$enumDecode(_$GreekEnumMap, json['fieldEnum']) ?? Greek.beta,
  );
}

Map<String, dynamic> _$DefaultValueToJson(DefaultValue instance) {
  final val = <String, dynamic>{
    'fieldBool': instance.fieldBool,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fieldString', instance.fieldString);
  val['fieldInt'] = instance.fieldInt;
  val['fieldDouble'] = instance.fieldDouble;
  val['fieldListEmpty'] = instance.fieldListEmpty;
  val['fieldSetEmpty'] = instance.fieldSetEmpty.toList();
  val['fieldMapEmpty'] = instance.fieldMapEmpty;
  val['fieldListSimple'] = instance.fieldListSimple;
  val['fieldSetSimple'] = instance.fieldSetSimple.toList();
  val['fieldMapSimple'] = instance.fieldMapSimple;
  val['fieldMapListString'] = instance.fieldMapListString;
  val['fieldEnum'] = _$GreekEnumMap[instance.fieldEnum];
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$GreekEnumMap = {
  Greek.alpha: 'alpha',
  Greek.beta: 'beta',
  Greek.gamma: 'gamma',
  Greek.delta: 'delta',
};
