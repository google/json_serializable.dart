// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'input.type_iterable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    (json['value'] as List<Object?>),
    (json['nullable'] as List<Object?>),
  )..withDefault =
      (json['withDefault'] as List<Object?>?) ?? [42, true, false, null];
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
      'nullable': instance.nullable.toList(),
      'withDefault': instance.withDefault?.toList(),
    };
