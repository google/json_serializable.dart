// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'input.type_enumtype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    _$enumDecode(_$EnumTypeEnumMap, json['value']),
    _$enumDecode(_$EnumTypeEnumMap, json['nullable']),
    _$enumDecodeNullable(_$EnumTypeEnumMap, json['withDefault']) ??
        EnumType.alpha,
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': _$EnumTypeEnumMap[instance.value],
      'nullable': _$EnumTypeEnumMap[instance.nullable],
      'withDefault': _$EnumTypeEnumMap[instance.withDefault],
    };

T _$enumDecode<T>(
  Map<T, Object> enumValues,
  Object? source, {
  T? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .cast<MapEntry<T, Object>?>()
      .singleWhere((e) => e!.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue!;
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
    _$enumDecodeNullable(_$EnumTypeEnumMap, json['nullable']),
    _$enumDecodeNullable(_$EnumTypeEnumMap, json['withDefault']) ??
        EnumType.alpha,
  );
}

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': _$EnumTypeEnumMap[instance.value],
      'nullable': _$EnumTypeEnumMap[instance.nullable],
      'withDefault': _$EnumTypeEnumMap[instance.withDefault],
    };
