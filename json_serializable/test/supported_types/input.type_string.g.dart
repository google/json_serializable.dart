// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'input.type_string.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as String,
    json['nullable'] as String,
  )..withDefault = json['withDefault'] as String ?? 'a string';
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };
