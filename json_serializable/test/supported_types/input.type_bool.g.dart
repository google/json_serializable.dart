// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.10

part of 'input.type_bool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as bool,
    json['nullable'] as bool,
    json['withDefault'] as bool ?? true,
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };