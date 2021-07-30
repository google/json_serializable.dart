// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'input.type_string.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) => SimpleClass(
      json['value'] as String,
      json['withDefault'] as String? ?? 'a string',
    );

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'withDefault': instance.withDefault,
    };

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) =>
    SimpleClassNullable(
      json['value'] as String?,
      json['withDefault'] as String? ?? 'a string',
    );

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
      'withDefault': instance.withDefault,
    };
