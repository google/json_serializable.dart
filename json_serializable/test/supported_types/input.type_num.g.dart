// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.10

part of 'input.type_num.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    (json['value'] as num),
    (json['nullable'] as num),
    (json['withDefault'] as num) ?? 88.6,
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };
