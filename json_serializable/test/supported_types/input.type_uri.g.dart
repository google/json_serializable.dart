// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.10

part of 'input.type_uri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    Uri.parse(json['value'] as String),
    Uri.parse(json['nullable'] as String),
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value.toString(),
      'nullable': instance.nullable.toString(),
    };
