// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.10

part of 'input.type_int.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    json['value'] as int,
    json['nullable'] as int,
    json['withDefault'] as int? ?? 42,
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) {
  return SimpleClassNullable(
    json['value'] as int?,
    json['nullable'] as int?,
    json['withDefault'] as int? ?? 42,
  );
}

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };
