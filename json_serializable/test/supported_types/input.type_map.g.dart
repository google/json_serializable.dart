// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'input.type_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as Map<String, dynamic>,
    json['nullable'] as Map<String, dynamic>,
  )..withDefault = json['withDefault'] as Map<String, dynamic> ?? {'a': 1};
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };
