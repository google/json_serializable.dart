// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'input.type_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    ((json['value'] as List)).toSet(),
    ((json['nullable'] as List)).toSet(),
  )..withDefault = (json['withDefault'] as int?) ?? 42;
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
      'withDefault': instance.withDefault,
    };
