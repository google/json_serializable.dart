// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'input.type_bigint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) => SimpleClass(
      BigInt.parse(json['value'] as String),
      json['withDefault'] == null
          ? _defaultValueFunc()
          : BigInt.parse(json['withDefault'] as String),
    );

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': instance.value.toString(),
      'withDefault': instance.withDefault.toString(),
    };

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) =>
    SimpleClassNullable(
      json['value'] == null ? null : BigInt.parse(json['value'] as String),
      json['withDefault'] == null
          ? _defaultValueFunc()
          : BigInt.parse(json['withDefault'] as String),
    );

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': instance.value?.toString(),
      'withDefault': instance.withDefault?.toString(),
    };
