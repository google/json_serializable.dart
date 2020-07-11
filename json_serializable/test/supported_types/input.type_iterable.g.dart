// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input.type_iterable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as List,
    json['nullable'] as List,
  )..withDefault = json['withDefault'] as List ?? [42, true, false, null];
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value?.toList(),
      'nullable': instance.nullable.toList(),
      'withDefault': instance.withDefault?.toList(),
    };
