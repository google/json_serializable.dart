// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'input.type_duration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) {
  return SimpleClass(
    Duration(microseconds: json['value'] as int),
    Duration(microseconds: json['nullable'] as int),
  );
}

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value.inMicroseconds,
      'nullable': instance.nullable.inMicroseconds,
    };
