// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'input.type_double.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) => SimpleClass(
      (json['value'] as num).toDouble(),
      (json['withDefault'] as num?)?.toDouble() ?? 3.14,
    );

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value,
      'withDefault': instance.withDefault,
    };

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) =>
    SimpleClassNullable(
      (json['value'] as num?)?.toDouble(),
      (json['withDefault'] as num?)?.toDouble() ?? 3.14,
    );

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': instance.value,
      'withDefault': instance.withDefault,
    };
