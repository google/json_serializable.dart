// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.10

part of 'input.type_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    ((json['value'] as List<Object?>)).toSet(),
    ((json['nullable'] as List<Object?>)).toSet(),
  )..withDefault = ((json['withDefault'] as List<Object?>?))?.toSet() ??
      {42, true, false, null};
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
      'withDefault': instance.withDefault?.toList(),
    };
