// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as int,
    json['nullable'] as int,
  )..withDefault = json['withDefault'] as int ?? 42;
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };
