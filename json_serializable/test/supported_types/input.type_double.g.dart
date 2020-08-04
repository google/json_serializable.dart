// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.10

part of 'input.type_double.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    (json['value'] as num).toDouble(),
    (json['nullable'] as num).toDouble(),
    (json['withDefault'] as num).toDouble() ?? 3.14,
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'nullable': instance.nullable,
      'withDefault': instance.withDefault,
    };
