// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'input.type_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as Object,
    json['nullable'] as Object,
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) {
  return SimpleClassNullable(
    json['value'],
    json['nullable'],
  );
}

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
    };
