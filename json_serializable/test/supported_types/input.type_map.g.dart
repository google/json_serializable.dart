// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.10

part of 'input.type_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as Map<String, dynamic>,
    json['nullable'] as Map<String, dynamic>,
    json['withDefault'] as Map<String, dynamic>? ?? {'a': 1},
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) {
  return SimpleClassNullable(
    json['value'] as Map<String, dynamic>?,
    json['nullable'] as Map<String, dynamic>?,
    json['withDefault'] as Map<String, dynamic>? ?? {'a': 1},
  );
}

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };

SimpleClassOfBigIntToBigInt _$SimpleClassOfBigIntToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToBigInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToBigIntToJson(
        SimpleClassOfBigIntToBigInt instance) =>
    <String, dynamic>{
      'value':
          instance.value.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassNullableOfBigIntToBigInt
    _$SimpleClassNullableOfBigIntToBigIntFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToBigInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToBigIntToJson(
        SimpleClassNullableOfBigIntToBigInt instance) =>
    <String, dynamic>{
      'value':
          instance.value?.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassOfDateTimeToBigInt _$SimpleClassOfDateTimeToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToBigInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToBigIntToJson(
        SimpleClassOfDateTimeToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toIso8601String(), e.toString())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toIso8601String(), e.toString())),
    };

SimpleClassNullableOfDateTimeToBigInt
    _$SimpleClassNullableOfDateTimeToBigIntFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToBigInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToBigIntToJson(
        SimpleClassNullableOfDateTimeToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.toString())),
    };

SimpleClassOfDynamicToBigInt _$SimpleClassOfDynamicToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToBigInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToBigIntToJson(
        SimpleClassOfDynamicToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassNullableOfDynamicToBigInt
    _$SimpleClassNullableOfDynamicToBigIntFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToBigInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToBigIntToJson(
        SimpleClassNullableOfDynamicToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassOfEnumTypeToBigInt _$SimpleClassOfEnumTypeToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToBigInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToBigIntToJson(
        SimpleClassOfEnumTypeToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toString())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toString())),
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

SimpleClassNullableOfEnumTypeToBigInt
    _$SimpleClassNullableOfEnumTypeToBigIntFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToBigInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToBigIntToJson(
        SimpleClassNullableOfEnumTypeToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toString())),
    };

SimpleClassOfIntToBigInt _$SimpleClassOfIntToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToBigInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToBigIntToJson(
        SimpleClassOfIntToBigInt instance) =>
    <String, dynamic>{
      'value':
          instance.value.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassNullableOfIntToBigInt _$SimpleClassNullableOfIntToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToBigInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToBigIntToJson(
        SimpleClassNullableOfIntToBigInt instance) =>
    <String, dynamic>{
      'value':
          instance.value?.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassOfObjectToBigInt _$SimpleClassOfObjectToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToBigInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToBigIntToJson(
        SimpleClassOfObjectToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassNullableOfObjectToBigInt
    _$SimpleClassNullableOfObjectToBigIntFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToBigInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToBigIntToJson(
        SimpleClassNullableOfObjectToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassOfStringToBigInt _$SimpleClassOfStringToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToBigInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToBigIntToJson(
        SimpleClassOfStringToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassNullableOfStringToBigInt
    _$SimpleClassNullableOfStringToBigIntFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToBigInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToBigIntToJson(
        SimpleClassNullableOfStringToBigInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassOfUriToBigInt _$SimpleClassOfUriToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToBigInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToBigIntToJson(
        SimpleClassOfUriToBigInt instance) =>
    <String, dynamic>{
      'value':
          instance.value.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassNullableOfUriToBigInt _$SimpleClassNullableOfUriToBigIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToBigInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), BigInt.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), BigInt.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToBigIntToJson(
        SimpleClassNullableOfUriToBigInt instance) =>
    <String, dynamic>{
      'value':
          instance.value?.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassOfBigIntToBool _$SimpleClassOfBigIntToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToBool(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToBoolToJson(
        SimpleClassOfBigIntToBool instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfBigIntToBool _$SimpleClassNullableOfBigIntToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToBool(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToBoolToJson(
        SimpleClassNullableOfBigIntToBool instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfDateTimeToBool _$SimpleClassOfDateTimeToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToBool(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToBoolToJson(
        SimpleClassOfDateTimeToBool instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassNullableOfDateTimeToBool
    _$SimpleClassNullableOfDateTimeToBoolFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToBool(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToBoolToJson(
        SimpleClassNullableOfDateTimeToBool instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassOfDynamicToBool _$SimpleClassOfDynamicToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToBool(
    Map<String, bool>.from(json['value'] as Map),
    Map<String, bool>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToBoolToJson(
        SimpleClassOfDynamicToBool instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfDynamicToBool _$SimpleClassNullableOfDynamicToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToBool(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToBoolToJson(
        SimpleClassNullableOfDynamicToBool instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfEnumTypeToBool _$SimpleClassOfEnumTypeToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToBool(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToBoolToJson(
        SimpleClassOfEnumTypeToBool instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassNullableOfEnumTypeToBool
    _$SimpleClassNullableOfEnumTypeToBoolFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToBool(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToBoolToJson(
        SimpleClassNullableOfEnumTypeToBool instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassOfIntToBool _$SimpleClassOfIntToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToBool(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToBoolToJson(
        SimpleClassOfIntToBool instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfIntToBool _$SimpleClassNullableOfIntToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToBool(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToBoolToJson(
        SimpleClassNullableOfIntToBool instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfObjectToBool _$SimpleClassOfObjectToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToBool(
    Map<String, bool>.from(json['value'] as Map),
    Map<String, bool>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToBoolToJson(
        SimpleClassOfObjectToBool instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfObjectToBool _$SimpleClassNullableOfObjectToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToBool(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToBoolToJson(
        SimpleClassNullableOfObjectToBool instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfStringToBool _$SimpleClassOfStringToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToBool(
    Map<String, bool>.from(json['value'] as Map),
    Map<String, bool>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToBoolToJson(
        SimpleClassOfStringToBool instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfStringToBool _$SimpleClassNullableOfStringToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToBool(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToBoolToJson(
        SimpleClassNullableOfStringToBool instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfUriToBool _$SimpleClassOfUriToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToBool(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToBoolToJson(
        SimpleClassOfUriToBool instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfUriToBool _$SimpleClassNullableOfUriToBoolFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToBool(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as bool),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as bool),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToBoolToJson(
        SimpleClassNullableOfUriToBool instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfBigIntToDateTime _$SimpleClassOfBigIntToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToDateTime(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToDateTimeToJson(
        SimpleClassOfBigIntToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
    };

SimpleClassNullableOfBigIntToDateTime
    _$SimpleClassNullableOfBigIntToDateTimeFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToDateTime(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToDateTimeToJson(
        SimpleClassNullableOfBigIntToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
    };

SimpleClassOfDateTimeToDateTime _$SimpleClassOfDateTimeToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToDateTime(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToDateTimeToJson(
        SimpleClassOfDateTimeToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toIso8601String(), e.toIso8601String())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toIso8601String(), e.toIso8601String())),
    };

SimpleClassNullableOfDateTimeToDateTime
    _$SimpleClassNullableOfDateTimeToDateTimeFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToDateTime(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToDateTimeToJson(
        SimpleClassNullableOfDateTimeToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.toIso8601String())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.toIso8601String())),
    };

SimpleClassOfDynamicToDateTime _$SimpleClassOfDynamicToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToDateTime(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToDateTimeToJson(
        SimpleClassOfDynamicToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toIso8601String())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, e.toIso8601String())),
    };

SimpleClassNullableOfDynamicToDateTime
    _$SimpleClassNullableOfDynamicToDateTimeFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToDateTime(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToDateTimeToJson(
        SimpleClassNullableOfDynamicToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toIso8601String())),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, e.toIso8601String())),
    };

SimpleClassOfEnumTypeToDateTime _$SimpleClassOfEnumTypeToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToDateTime(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToDateTimeToJson(
        SimpleClassOfEnumTypeToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toIso8601String())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toIso8601String())),
    };

SimpleClassNullableOfEnumTypeToDateTime
    _$SimpleClassNullableOfEnumTypeToDateTimeFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToDateTime(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToDateTimeToJson(
        SimpleClassNullableOfEnumTypeToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toIso8601String())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toIso8601String())),
    };

SimpleClassOfIntToDateTime _$SimpleClassOfIntToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToDateTime(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToDateTimeToJson(
        SimpleClassOfIntToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
    };

SimpleClassNullableOfIntToDateTime _$SimpleClassNullableOfIntToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToDateTime(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToDateTimeToJson(
        SimpleClassNullableOfIntToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
    };

SimpleClassOfObjectToDateTime _$SimpleClassOfObjectToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToDateTime(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToDateTimeToJson(
        SimpleClassOfObjectToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toIso8601String())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, e.toIso8601String())),
    };

SimpleClassNullableOfObjectToDateTime
    _$SimpleClassNullableOfObjectToDateTimeFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToDateTime(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToDateTimeToJson(
        SimpleClassNullableOfObjectToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toIso8601String())),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, e.toIso8601String())),
    };

SimpleClassOfStringToDateTime _$SimpleClassOfStringToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToDateTime(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToDateTimeToJson(
        SimpleClassOfStringToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toIso8601String())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, e.toIso8601String())),
    };

SimpleClassNullableOfStringToDateTime
    _$SimpleClassNullableOfStringToDateTimeFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToDateTime(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToDateTimeToJson(
        SimpleClassNullableOfStringToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toIso8601String())),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, e.toIso8601String())),
    };

SimpleClassOfUriToDateTime _$SimpleClassOfUriToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToDateTime(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToDateTimeToJson(
        SimpleClassOfUriToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
    };

SimpleClassNullableOfUriToDateTime _$SimpleClassNullableOfUriToDateTimeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToDateTime(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), DateTime.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), DateTime.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToDateTimeToJson(
        SimpleClassNullableOfUriToDateTime instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toIso8601String())),
    };

SimpleClassOfBigIntToDouble _$SimpleClassOfBigIntToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToDouble(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToDoubleToJson(
        SimpleClassOfBigIntToDouble instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfBigIntToDouble
    _$SimpleClassNullableOfBigIntToDoubleFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToDouble(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToDoubleToJson(
        SimpleClassNullableOfBigIntToDouble instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfDateTimeToDouble _$SimpleClassOfDateTimeToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToDouble(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToDoubleToJson(
        SimpleClassOfDateTimeToDouble instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassNullableOfDateTimeToDouble
    _$SimpleClassNullableOfDateTimeToDoubleFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToDouble(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToDoubleToJson(
        SimpleClassNullableOfDateTimeToDouble instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassOfDynamicToDouble _$SimpleClassOfDynamicToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToDouble(
    Map<String, double>.from(json['value'] as Map),
    Map<String, double>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToDoubleToJson(
        SimpleClassOfDynamicToDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfDynamicToDouble
    _$SimpleClassNullableOfDynamicToDoubleFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToDouble(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToDoubleToJson(
        SimpleClassNullableOfDynamicToDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfEnumTypeToDouble _$SimpleClassOfEnumTypeToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToDouble(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToDoubleToJson(
        SimpleClassOfEnumTypeToDouble instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassNullableOfEnumTypeToDouble
    _$SimpleClassNullableOfEnumTypeToDoubleFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToDouble(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) =>
          MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) =>
          MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToDoubleToJson(
        SimpleClassNullableOfEnumTypeToDouble instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassOfIntToDouble _$SimpleClassOfIntToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToDouble(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToDoubleToJson(
        SimpleClassOfIntToDouble instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfIntToDouble _$SimpleClassNullableOfIntToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToDouble(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToDoubleToJson(
        SimpleClassNullableOfIntToDouble instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfObjectToDouble _$SimpleClassOfObjectToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToDouble(
    Map<String, double>.from(json['value'] as Map),
    Map<String, double>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToDoubleToJson(
        SimpleClassOfObjectToDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfObjectToDouble
    _$SimpleClassNullableOfObjectToDoubleFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToDouble(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToDoubleToJson(
        SimpleClassNullableOfObjectToDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfStringToDouble _$SimpleClassOfStringToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToDouble(
    Map<String, double>.from(json['value'] as Map),
    Map<String, double>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToDoubleToJson(
        SimpleClassOfStringToDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfStringToDouble
    _$SimpleClassNullableOfStringToDoubleFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToDouble(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToDoubleToJson(
        SimpleClassNullableOfStringToDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfUriToDouble _$SimpleClassOfUriToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToDouble(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToDoubleToJson(
        SimpleClassOfUriToDouble instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfUriToDouble _$SimpleClassNullableOfUriToDoubleFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToDouble(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), (e as num).toDouble()),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToDoubleToJson(
        SimpleClassNullableOfUriToDouble instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfBigIntToDuration _$SimpleClassOfBigIntToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToDuration(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToDurationToJson(
        SimpleClassOfBigIntToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
    };

SimpleClassNullableOfBigIntToDuration
    _$SimpleClassNullableOfBigIntToDurationFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToDuration(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToDurationToJson(
        SimpleClassNullableOfBigIntToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
    };

SimpleClassOfDateTimeToDuration _$SimpleClassOfDateTimeToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToDuration(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToDurationToJson(
        SimpleClassOfDateTimeToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toIso8601String(), e.inMicroseconds)),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toIso8601String(), e.inMicroseconds)),
    };

SimpleClassNullableOfDateTimeToDuration
    _$SimpleClassNullableOfDateTimeToDurationFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToDuration(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToDurationToJson(
        SimpleClassNullableOfDateTimeToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.inMicroseconds)),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.inMicroseconds)),
    };

SimpleClassOfDynamicToDuration _$SimpleClassOfDynamicToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToDuration(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToDurationToJson(
        SimpleClassOfDynamicToDuration instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.inMicroseconds)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, e.inMicroseconds)),
    };

SimpleClassNullableOfDynamicToDuration
    _$SimpleClassNullableOfDynamicToDurationFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToDuration(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToDurationToJson(
        SimpleClassNullableOfDynamicToDuration instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.inMicroseconds)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, e.inMicroseconds)),
    };

SimpleClassOfEnumTypeToDuration _$SimpleClassOfEnumTypeToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToDuration(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToDurationToJson(
        SimpleClassOfEnumTypeToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.inMicroseconds)),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.inMicroseconds)),
    };

SimpleClassNullableOfEnumTypeToDuration
    _$SimpleClassNullableOfEnumTypeToDurationFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToDuration(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(
          _$enumDecode(_$EnumTypeEnumMap, k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToDurationToJson(
        SimpleClassNullableOfEnumTypeToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.inMicroseconds)),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.inMicroseconds)),
    };

SimpleClassOfIntToDuration _$SimpleClassOfIntToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToDuration(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToDurationToJson(
        SimpleClassOfIntToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
    };

SimpleClassNullableOfIntToDuration _$SimpleClassNullableOfIntToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToDuration(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToDurationToJson(
        SimpleClassNullableOfIntToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
    };

SimpleClassOfObjectToDuration _$SimpleClassOfObjectToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToDuration(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToDurationToJson(
        SimpleClassOfObjectToDuration instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.inMicroseconds)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, e.inMicroseconds)),
    };

SimpleClassNullableOfObjectToDuration
    _$SimpleClassNullableOfObjectToDurationFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToDuration(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToDurationToJson(
        SimpleClassNullableOfObjectToDuration instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.inMicroseconds)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, e.inMicroseconds)),
    };

SimpleClassOfStringToDuration _$SimpleClassOfStringToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToDuration(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToDurationToJson(
        SimpleClassOfStringToDuration instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.inMicroseconds)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, e.inMicroseconds)),
    };

SimpleClassNullableOfStringToDuration
    _$SimpleClassNullableOfStringToDurationFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToDuration(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToDurationToJson(
        SimpleClassNullableOfStringToDuration instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.inMicroseconds)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, e.inMicroseconds)),
    };

SimpleClassOfUriToDuration _$SimpleClassOfUriToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToDuration(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToDurationToJson(
        SimpleClassOfUriToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
    };

SimpleClassNullableOfUriToDuration _$SimpleClassNullableOfUriToDurationFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToDuration(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), Duration(microseconds: e as int)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), Duration(microseconds: e as int)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToDurationToJson(
        SimpleClassNullableOfUriToDuration instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
    };

SimpleClassOfBigIntToDynamic _$SimpleClassOfBigIntToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToDynamic(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToDynamicToJson(
        SimpleClassOfBigIntToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfBigIntToDynamic
    _$SimpleClassNullableOfBigIntToDynamicFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToDynamic(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToDynamicToJson(
        SimpleClassNullableOfBigIntToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfDateTimeToDynamic _$SimpleClassOfDateTimeToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToDynamic(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToDynamicToJson(
        SimpleClassOfDateTimeToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassNullableOfDateTimeToDynamic
    _$SimpleClassNullableOfDateTimeToDynamicFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToDynamic(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToDynamicToJson(
        SimpleClassNullableOfDateTimeToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassOfDynamicToDynamic _$SimpleClassOfDynamicToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToDynamic(
    json['value'] as Map<String, dynamic>,
    json['nullable'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToDynamicToJson(
        SimpleClassOfDynamicToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfDynamicToDynamic
    _$SimpleClassNullableOfDynamicToDynamicFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToDynamic(
    json['value'] as Map<String, dynamic>?,
    json['nullable'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToDynamicToJson(
        SimpleClassNullableOfDynamicToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfEnumTypeToDynamic _$SimpleClassOfEnumTypeToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToDynamic(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToDynamicToJson(
        SimpleClassOfEnumTypeToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassNullableOfEnumTypeToDynamic
    _$SimpleClassNullableOfEnumTypeToDynamicFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToDynamic(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToDynamicToJson(
        SimpleClassNullableOfEnumTypeToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassOfIntToDynamic _$SimpleClassOfIntToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToDynamic(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToDynamicToJson(
        SimpleClassOfIntToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfIntToDynamic _$SimpleClassNullableOfIntToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToDynamic(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToDynamicToJson(
        SimpleClassNullableOfIntToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfObjectToDynamic _$SimpleClassOfObjectToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToDynamic(
    json['value'] as Map<String, dynamic>,
    json['nullable'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToDynamicToJson(
        SimpleClassOfObjectToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfObjectToDynamic
    _$SimpleClassNullableOfObjectToDynamicFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToDynamic(
    json['value'] as Map<String, dynamic>?,
    json['nullable'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToDynamicToJson(
        SimpleClassNullableOfObjectToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfStringToDynamic _$SimpleClassOfStringToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToDynamic(
    json['value'] as Map<String, dynamic>,
    json['nullable'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SimpleClassOfStringToDynamicToJson(
        SimpleClassOfStringToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfStringToDynamic
    _$SimpleClassNullableOfStringToDynamicFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToDynamic(
    json['value'] as Map<String, dynamic>?,
    json['nullable'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToDynamicToJson(
        SimpleClassNullableOfStringToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfUriToDynamic _$SimpleClassOfUriToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToDynamic(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToDynamicToJson(
        SimpleClassOfUriToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfUriToDynamic _$SimpleClassNullableOfUriToDynamicFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToDynamic(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToDynamicToJson(
        SimpleClassNullableOfUriToDynamic instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfBigIntToEnumType _$SimpleClassOfBigIntToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToEnumType(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToEnumTypeToJson(
        SimpleClassOfBigIntToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
    };

SimpleClassNullableOfBigIntToEnumType
    _$SimpleClassNullableOfBigIntToEnumTypeFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToEnumType(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToEnumTypeToJson(
        SimpleClassNullableOfBigIntToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
    };

SimpleClassOfDateTimeToEnumType _$SimpleClassOfDateTimeToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToEnumType(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToEnumTypeToJson(
        SimpleClassOfDateTimeToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toIso8601String(), _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toIso8601String(), _$EnumTypeEnumMap[e])),
    };

SimpleClassNullableOfDateTimeToEnumType
    _$SimpleClassNullableOfDateTimeToEnumTypeFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToEnumType(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToEnumTypeToJson(
        SimpleClassNullableOfDateTimeToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toIso8601String(), _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toIso8601String(), _$EnumTypeEnumMap[e])),
    };

SimpleClassOfDynamicToEnumType _$SimpleClassOfDynamicToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToEnumType(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToEnumTypeToJson(
        SimpleClassOfDynamicToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
    };

SimpleClassNullableOfDynamicToEnumType
    _$SimpleClassNullableOfDynamicToEnumTypeFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToEnumType(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToEnumTypeToJson(
        SimpleClassNullableOfDynamicToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
    };

SimpleClassOfEnumTypeToEnumType _$SimpleClassOfEnumTypeToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToEnumType(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k),
          _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k),
          _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToEnumTypeToJson(
        SimpleClassOfEnumTypeToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], _$EnumTypeEnumMap[e])),
    };

SimpleClassNullableOfEnumTypeToEnumType
    _$SimpleClassNullableOfEnumTypeToEnumTypeFromJson(
        Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToEnumType(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k),
          _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k),
          _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToEnumTypeToJson(
        SimpleClassNullableOfEnumTypeToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], _$EnumTypeEnumMap[e])),
    };

SimpleClassOfIntToEnumType _$SimpleClassOfIntToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToEnumType(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToEnumTypeToJson(
        SimpleClassOfIntToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
    };

SimpleClassNullableOfIntToEnumType _$SimpleClassNullableOfIntToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToEnumType(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToEnumTypeToJson(
        SimpleClassNullableOfIntToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
    };

SimpleClassOfObjectToEnumType _$SimpleClassOfObjectToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToEnumType(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToEnumTypeToJson(
        SimpleClassOfObjectToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
    };

SimpleClassNullableOfObjectToEnumType
    _$SimpleClassNullableOfObjectToEnumTypeFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToEnumType(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToEnumTypeToJson(
        SimpleClassNullableOfObjectToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
    };

SimpleClassOfStringToEnumType _$SimpleClassOfStringToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToEnumType(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToEnumTypeToJson(
        SimpleClassOfStringToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
    };

SimpleClassNullableOfStringToEnumType
    _$SimpleClassNullableOfStringToEnumTypeFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToEnumType(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToEnumTypeToJson(
        SimpleClassNullableOfStringToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k, _$EnumTypeEnumMap[e])),
    };

SimpleClassOfUriToEnumType _$SimpleClassOfUriToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToEnumType(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToEnumTypeToJson(
        SimpleClassOfUriToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
    };

SimpleClassNullableOfUriToEnumType _$SimpleClassNullableOfUriToEnumTypeFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToEnumType(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), _$enumDecode(_$EnumTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToEnumTypeToJson(
        SimpleClassNullableOfUriToEnumType instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), _$EnumTypeEnumMap[e])),
    };

SimpleClassOfBigIntToInt _$SimpleClassOfBigIntToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToIntToJson(
        SimpleClassOfBigIntToInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfBigIntToInt _$SimpleClassNullableOfBigIntToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToIntToJson(
        SimpleClassNullableOfBigIntToInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfDateTimeToInt _$SimpleClassOfDateTimeToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToIntToJson(
        SimpleClassOfDateTimeToInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassNullableOfDateTimeToInt _$SimpleClassNullableOfDateTimeToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToIntToJson(
        SimpleClassNullableOfDateTimeToInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassOfDynamicToInt _$SimpleClassOfDynamicToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToInt(
    Map<String, int>.from(json['value'] as Map),
    Map<String, int>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToIntToJson(
        SimpleClassOfDynamicToInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfDynamicToInt _$SimpleClassNullableOfDynamicToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToIntToJson(
        SimpleClassNullableOfDynamicToInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfEnumTypeToInt _$SimpleClassOfEnumTypeToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToIntToJson(
        SimpleClassOfEnumTypeToInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassNullableOfEnumTypeToInt _$SimpleClassNullableOfEnumTypeToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToIntToJson(
        SimpleClassNullableOfEnumTypeToInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassOfIntToInt _$SimpleClassOfIntToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToIntToJson(
        SimpleClassOfIntToInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfIntToInt _$SimpleClassNullableOfIntToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToIntToJson(
        SimpleClassNullableOfIntToInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfObjectToInt _$SimpleClassOfObjectToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToInt(
    Map<String, int>.from(json['value'] as Map),
    Map<String, int>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToIntToJson(
        SimpleClassOfObjectToInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfObjectToInt _$SimpleClassNullableOfObjectToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToIntToJson(
        SimpleClassNullableOfObjectToInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfStringToInt _$SimpleClassOfStringToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToInt(
    Map<String, int>.from(json['value'] as Map),
    Map<String, int>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToIntToJson(
        SimpleClassOfStringToInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfStringToInt _$SimpleClassNullableOfStringToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToIntToJson(
        SimpleClassNullableOfStringToInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfUriToInt _$SimpleClassOfUriToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToInt(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToIntToJson(
        SimpleClassOfUriToInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfUriToInt _$SimpleClassNullableOfUriToIntFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToInt(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as int),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToIntToJson(
        SimpleClassNullableOfUriToInt instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfBigIntToNum _$SimpleClassOfBigIntToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToNum(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToNumToJson(
        SimpleClassOfBigIntToNum instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfBigIntToNum _$SimpleClassNullableOfBigIntToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToNum(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToNumToJson(
        SimpleClassNullableOfBigIntToNum instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfDateTimeToNum _$SimpleClassOfDateTimeToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToNum(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToNumToJson(
        SimpleClassOfDateTimeToNum instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassNullableOfDateTimeToNum _$SimpleClassNullableOfDateTimeToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToNum(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToNumToJson(
        SimpleClassNullableOfDateTimeToNum instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassOfDynamicToNum _$SimpleClassOfDynamicToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToNum(
    Map<String, num>.from(json['value'] as Map),
    Map<String, num>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToNumToJson(
        SimpleClassOfDynamicToNum instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfDynamicToNum _$SimpleClassNullableOfDynamicToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToNum(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToNumToJson(
        SimpleClassNullableOfDynamicToNum instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfEnumTypeToNum _$SimpleClassOfEnumTypeToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToNum(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToNumToJson(
        SimpleClassOfEnumTypeToNum instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassNullableOfEnumTypeToNum _$SimpleClassNullableOfEnumTypeToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToNum(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToNumToJson(
        SimpleClassNullableOfEnumTypeToNum instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassOfIntToNum _$SimpleClassOfIntToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToNum(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToNumToJson(
        SimpleClassOfIntToNum instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfIntToNum _$SimpleClassNullableOfIntToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToNum(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToNumToJson(
        SimpleClassNullableOfIntToNum instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfObjectToNum _$SimpleClassOfObjectToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToNum(
    Map<String, num>.from(json['value'] as Map),
    Map<String, num>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToNumToJson(
        SimpleClassOfObjectToNum instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfObjectToNum _$SimpleClassNullableOfObjectToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToNum(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToNumToJson(
        SimpleClassNullableOfObjectToNum instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfStringToNum _$SimpleClassOfStringToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToNum(
    Map<String, num>.from(json['value'] as Map),
    Map<String, num>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToNumToJson(
        SimpleClassOfStringToNum instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfStringToNum _$SimpleClassNullableOfStringToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToNum(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToNumToJson(
        SimpleClassNullableOfStringToNum instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfUriToNum _$SimpleClassOfUriToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToNum(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToNumToJson(
        SimpleClassOfUriToNum instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfUriToNum _$SimpleClassNullableOfUriToNumFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToNum(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as num),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as num),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToNumToJson(
        SimpleClassNullableOfUriToNum instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfBigIntToObject _$SimpleClassOfBigIntToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToObject(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToObjectToJson(
        SimpleClassOfBigIntToObject instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfBigIntToObject
    _$SimpleClassNullableOfBigIntToObjectFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToObject(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToObjectToJson(
        SimpleClassNullableOfBigIntToObject instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfDateTimeToObject _$SimpleClassOfDateTimeToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToObject(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToObjectToJson(
        SimpleClassOfDateTimeToObject instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassNullableOfDateTimeToObject
    _$SimpleClassNullableOfDateTimeToObjectFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToObject(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToObjectToJson(
        SimpleClassNullableOfDateTimeToObject instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassOfDynamicToObject _$SimpleClassOfDynamicToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToObject(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToObjectToJson(
        SimpleClassOfDynamicToObject instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfDynamicToObject
    _$SimpleClassNullableOfDynamicToObjectFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToObject(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToObjectToJson(
        SimpleClassNullableOfDynamicToObject instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfEnumTypeToObject _$SimpleClassOfEnumTypeToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToObject(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToObjectToJson(
        SimpleClassOfEnumTypeToObject instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassNullableOfEnumTypeToObject
    _$SimpleClassNullableOfEnumTypeToObjectFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToObject(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToObjectToJson(
        SimpleClassNullableOfEnumTypeToObject instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassOfIntToObject _$SimpleClassOfIntToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToObject(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToObjectToJson(
        SimpleClassOfIntToObject instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfIntToObject _$SimpleClassNullableOfIntToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToObject(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToObjectToJson(
        SimpleClassNullableOfIntToObject instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfObjectToObject _$SimpleClassOfObjectToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToObject(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToObjectToJson(
        SimpleClassOfObjectToObject instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfObjectToObject
    _$SimpleClassNullableOfObjectToObjectFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToObject(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToObjectToJson(
        SimpleClassNullableOfObjectToObject instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfStringToObject _$SimpleClassOfStringToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToObject(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToObjectToJson(
        SimpleClassOfStringToObject instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfStringToObject
    _$SimpleClassNullableOfStringToObjectFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToObject(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToObjectToJson(
        SimpleClassNullableOfStringToObject instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfUriToObject _$SimpleClassOfUriToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToObject(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToObjectToJson(
        SimpleClassOfUriToObject instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfUriToObject _$SimpleClassNullableOfUriToObjectFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToObject(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as Object),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as Object),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToObjectToJson(
        SimpleClassNullableOfUriToObject instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfBigIntToString _$SimpleClassOfBigIntToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToString(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToStringToJson(
        SimpleClassOfBigIntToString instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfBigIntToString
    _$SimpleClassNullableOfBigIntToStringFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToStringToJson(
        SimpleClassNullableOfBigIntToString instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfDateTimeToString _$SimpleClassOfDateTimeToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToString(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToStringToJson(
        SimpleClassOfDateTimeToString instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassNullableOfDateTimeToString
    _$SimpleClassNullableOfDateTimeToStringFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToStringToJson(
        SimpleClassNullableOfDateTimeToString instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

SimpleClassOfDynamicToString _$SimpleClassOfDynamicToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToString(
    Map<String, String>.from(json['value'] as Map),
    Map<String, String>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToStringToJson(
        SimpleClassOfDynamicToString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfDynamicToString
    _$SimpleClassNullableOfDynamicToStringFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToStringToJson(
        SimpleClassNullableOfDynamicToString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfEnumTypeToString _$SimpleClassOfEnumTypeToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToString(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToStringToJson(
        SimpleClassOfEnumTypeToString instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassNullableOfEnumTypeToString
    _$SimpleClassNullableOfEnumTypeToStringFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToStringToJson(
        SimpleClassNullableOfEnumTypeToString instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
      'nullable':
          instance.nullable?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e)),
    };

SimpleClassOfIntToString _$SimpleClassOfIntToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToString(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToStringToJson(
        SimpleClassOfIntToString instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfIntToString _$SimpleClassNullableOfIntToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToStringToJson(
        SimpleClassNullableOfIntToString instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfObjectToString _$SimpleClassOfObjectToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToString(
    Map<String, String>.from(json['value'] as Map),
    Map<String, String>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToStringToJson(
        SimpleClassOfObjectToString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfObjectToString
    _$SimpleClassNullableOfObjectToStringFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToStringToJson(
        SimpleClassNullableOfObjectToString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfStringToString _$SimpleClassOfStringToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToString(
    Map<String, String>.from(json['value'] as Map),
    Map<String, String>.from(json['nullable'] as Map),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToStringToJson(
        SimpleClassOfStringToString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullableOfStringToString
    _$SimpleClassNullableOfStringToStringFromJson(Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToStringToJson(
        SimpleClassNullableOfStringToString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassOfUriToString _$SimpleClassOfUriToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToString(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToStringToJson(
        SimpleClassOfUriToString instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassNullableOfUriToString _$SimpleClassNullableOfUriToStringFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToString(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as String),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), e as String),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToStringToJson(
        SimpleClassNullableOfUriToString instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k.toString(), e)),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k.toString(), e)),
    };

SimpleClassOfBigIntToUri _$SimpleClassOfBigIntToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfBigIntToUri(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(BigInt.parse(k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfBigIntToUriToJson(
        SimpleClassOfBigIntToUri instance) =>
    <String, dynamic>{
      'value':
          instance.value.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassNullableOfBigIntToUri _$SimpleClassNullableOfBigIntToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfBigIntToUri(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(BigInt.parse(k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfBigIntToUriToJson(
        SimpleClassNullableOfBigIntToUri instance) =>
    <String, dynamic>{
      'value':
          instance.value?.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassOfDateTimeToUri _$SimpleClassOfDateTimeToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDateTimeToUri(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(DateTime.parse(k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDateTimeToUriToJson(
        SimpleClassOfDateTimeToUri instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(k.toIso8601String(), e.toString())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(k.toIso8601String(), e.toString())),
    };

SimpleClassNullableOfDateTimeToUri _$SimpleClassNullableOfDateTimeToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfDateTimeToUri(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(DateTime.parse(k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToUriToJson(
        SimpleClassNullableOfDateTimeToUri instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.toString())),
    };

SimpleClassOfDynamicToUri _$SimpleClassOfDynamicToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfDynamicToUri(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfDynamicToUriToJson(
        SimpleClassOfDynamicToUri instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassNullableOfDynamicToUri _$SimpleClassNullableOfDynamicToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfDynamicToUri(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfDynamicToUriToJson(
        SimpleClassNullableOfDynamicToUri instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassOfEnumTypeToUri _$SimpleClassOfEnumTypeToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfEnumTypeToUri(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfEnumTypeToUriToJson(
        SimpleClassOfEnumTypeToUri instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toString())),
      'nullable': instance.nullable
          .map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toString())),
    };

SimpleClassNullableOfEnumTypeToUri _$SimpleClassNullableOfEnumTypeToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfEnumTypeToUri(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) =>
          MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) =>
          MapEntry(_$enumDecode(_$EnumTypeEnumMap, k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToUriToJson(
        SimpleClassNullableOfEnumTypeToUri instance) =>
    <String, dynamic>{
      'value': instance.value
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(_$EnumTypeEnumMap[k], e.toString())),
    };

SimpleClassOfIntToUri _$SimpleClassOfIntToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfIntToUri(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfIntToUriToJson(
        SimpleClassOfIntToUri instance) =>
    <String, dynamic>{
      'value':
          instance.value.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassNullableOfIntToUri _$SimpleClassNullableOfIntToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfIntToUri(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfIntToUriToJson(
        SimpleClassNullableOfIntToUri instance) =>
    <String, dynamic>{
      'value':
          instance.value?.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassOfObjectToUri _$SimpleClassOfObjectToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfObjectToUri(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfObjectToUriToJson(
        SimpleClassOfObjectToUri instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassNullableOfObjectToUri _$SimpleClassNullableOfObjectToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfObjectToUri(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfObjectToUriToJson(
        SimpleClassNullableOfObjectToUri instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassOfStringToUri _$SimpleClassOfStringToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfStringToUri(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfStringToUriToJson(
        SimpleClassOfStringToUri instance) =>
    <String, dynamic>{
      'value': instance.value.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassNullableOfStringToUri _$SimpleClassNullableOfStringToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfStringToUri(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfStringToUriToJson(
        SimpleClassNullableOfStringToUri instance) =>
    <String, dynamic>{
      'value': instance.value?.map((k, e) => MapEntry(k, e.toString())),
      'nullable': instance.nullable?.map((k, e) => MapEntry(k, e.toString())),
    };

SimpleClassOfUriToUri _$SimpleClassOfUriToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassOfUriToUri(
    (json['value'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(Uri.parse(k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassOfUriToUriToJson(
        SimpleClassOfUriToUri instance) =>
    <String, dynamic>{
      'value':
          instance.value.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable':
          instance.nullable.map((k, e) => MapEntry(k.toString(), e.toString())),
    };

SimpleClassNullableOfUriToUri _$SimpleClassNullableOfUriToUriFromJson(
    Map<String, dynamic> json) {
  return SimpleClassNullableOfUriToUri(
    (json['value'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), Uri.parse(e as String)),
    ),
    (json['nullable'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(Uri.parse(k), Uri.parse(e as String)),
    ),
  );
}

Map<String, dynamic> _$SimpleClassNullableOfUriToUriToJson(
        SimpleClassNullableOfUriToUri instance) =>
    <String, dynamic>{
      'value':
          instance.value?.map((k, e) => MapEntry(k.toString(), e.toString())),
      'nullable': instance.nullable
          ?.map((k, e) => MapEntry(k.toString(), e.toString())),
    };
