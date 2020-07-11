// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'input.type_datetime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    DateTime.parse(json['value'] as String),
    DateTime.parse(json['nullable'] as String),
  )..withDefault = (json['withDefault'] as int?) ?? 42;
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'nullable': instance.nullable.toIso8601String(),
      'withDefault': instance.withDefault,
    };
