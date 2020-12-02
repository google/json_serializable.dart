// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'input.type_enumtype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    _$enumDecode(_$EnumTypeEnumMap, json['value']),
    _$enumDecodeNullable(_$EnumTypeEnumMap, json['withDefault']) ??
        EnumType.alpha,
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': _$EnumTypeEnumMap[instance.value],
      'withDefault': _$EnumTypeEnumMap[instance.withDefault],
    };

T _$enumDecode<T>(
  Map<T, Object> enumValues,
  Object? source, {
  T? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
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

const _$EnumTypeEnumMap = {
  EnumType.alpha: 'alpha',
  EnumType.beta: 'beta',
  EnumType.gamma: 'gamma',
  EnumType.delta: 'delta',
};

T? _$enumDecodeNullable<T>(
  Map<T, Object> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) {
  return SimpleClassNullable(
    _$enumDecodeNullable(_$EnumTypeEnumMap, json['value']),
    _$enumDecodeNullable(_$EnumTypeEnumMap, json['withDefault']) ??
        EnumType.alpha,
  );
}

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': _$EnumTypeEnumMap[instance.value],
      'withDefault': _$EnumTypeEnumMap[instance.withDefault],
    };
