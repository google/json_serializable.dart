// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.10

part of 'input.type_iterable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as List<dynamic>,
    json['nullable'] as List<dynamic>,
    json['withDefault'] as List<dynamic> ?? [42, true, false, null],
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
      'withDefault': instance.withDefault.toList(),
    };

SimpleClassBigInt _$SimpleClassBigIntFromJson(Map<String, dynamic> json) {
  return SimpleClassBigInt(
    (json['value'] as List<dynamic>).map((e) => BigInt.parse(e as String)),
    (json['nullable'] as List<dynamic>).map((e) => BigInt.parse(e as String)),
  );
}

Map<String, dynamic> _$SimpleClassBigIntToJson(SimpleClassBigInt instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e.toString()).toList(),
      'nullable': instance.nullable.map((e) => e.toString()).toList(),
    };

SimpleClassBool _$SimpleClassBoolFromJson(Map<String, dynamic> json) {
  return SimpleClassBool(
    (json['value'] as List<dynamic>).map((e) => e as bool),
    (json['nullable'] as List<dynamic>).map((e) => e as bool),
  );
}

Map<String, dynamic> _$SimpleClassBoolToJson(SimpleClassBool instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
    };

SimpleClassDateTime _$SimpleClassDateTimeFromJson(Map<String, dynamic> json) {
  return SimpleClassDateTime(
    (json['value'] as List<dynamic>).map((e) => DateTime.parse(e as String)),
    (json['nullable'] as List<dynamic>).map((e) => DateTime.parse(e as String)),
  );
}

Map<String, dynamic> _$SimpleClassDateTimeToJson(
        SimpleClassDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e.toIso8601String()).toList(),
      'nullable': instance.nullable.map((e) => e.toIso8601String()).toList(),
    };

SimpleClassDouble _$SimpleClassDoubleFromJson(Map<String, dynamic> json) {
  return SimpleClassDouble(
    (json['value'] as List<dynamic>).map((e) => (e as num).toDouble()),
    (json['nullable'] as List<dynamic>).map((e) => (e as num).toDouble()),
  );
}

Map<String, dynamic> _$SimpleClassDoubleToJson(SimpleClassDouble instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
    };

SimpleClassDuration _$SimpleClassDurationFromJson(Map<String, dynamic> json) {
  return SimpleClassDuration(
    (json['value'] as List<dynamic>)
        .map((e) => Duration(microseconds: e as int)),
    (json['nullable'] as List<dynamic>)
        .map((e) => Duration(microseconds: e as int)),
  );
}

Map<String, dynamic> _$SimpleClassDurationToJson(
        SimpleClassDuration instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e.inMicroseconds).toList(),
      'nullable': instance.nullable.map((e) => e.inMicroseconds).toList(),
    };

SimpleClassDynamic _$SimpleClassDynamicFromJson(Map<String, dynamic> json) {
  return SimpleClassDynamic(
    json['value'] as List<dynamic>,
    json['nullable'] as List<dynamic>,
  );
}

Map<String, dynamic> _$SimpleClassDynamicToJson(SimpleClassDynamic instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
    };

SimpleClassEnumType _$SimpleClassEnumTypeFromJson(Map<String, dynamic> json) {
  return SimpleClassEnumType(
    (json['value'] as List<dynamic>)
        .map((e) => _$enumDecode(_$EnumTypeEnumMap, e)),
    (json['nullable'] as List<dynamic>)
        .map((e) => _$enumDecode(_$EnumTypeEnumMap, e)),
  );
}

Map<String, dynamic> _$SimpleClassEnumTypeToJson(
        SimpleClassEnumType instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => _$EnumTypeEnumMap[e]).toList(),
      'nullable': instance.nullable.map((e) => _$EnumTypeEnumMap[e]).toList(),
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

SimpleClassNum _$SimpleClassNumFromJson(Map<String, dynamic> json) {
  return SimpleClassNum(
    (json['value'] as List<dynamic>).map((e) => e as num),
    (json['nullable'] as List<dynamic>).map((e) => e as num),
  );
}

Map<String, dynamic> _$SimpleClassNumToJson(SimpleClassNum instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
    };

SimpleClassObject _$SimpleClassObjectFromJson(Map<String, dynamic> json) {
  return SimpleClassObject(
    json['value'] as List<dynamic>,
    json['nullable'] as List<dynamic>,
  );
}

Map<String, dynamic> _$SimpleClassObjectToJson(SimpleClassObject instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
    };

SimpleClassString _$SimpleClassStringFromJson(Map<String, dynamic> json) {
  return SimpleClassString(
    (json['value'] as List<dynamic>).map((e) => e as String),
    (json['nullable'] as List<dynamic>).map((e) => e as String),
  );
}

Map<String, dynamic> _$SimpleClassStringToJson(SimpleClassString instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
    };

SimpleClassUri _$SimpleClassUriFromJson(Map<String, dynamic> json) {
  return SimpleClassUri(
    (json['value'] as List<dynamic>).map((e) => Uri.parse(e as String)),
    (json['nullable'] as List<dynamic>).map((e) => Uri.parse(e as String)),
  );
}

Map<String, dynamic> _$SimpleClassUriToJson(SimpleClassUri instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => e.toString()).toList(),
      'nullable': instance.nullable.map((e) => e.toString()).toList(),
    };
