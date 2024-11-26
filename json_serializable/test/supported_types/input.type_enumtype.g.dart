// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'input.type_enumtype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) => SimpleClass(
      $enumDecodeWithDecodeMap(_$EnumTypeEnumDecodeMap, json['value']),
      $enumDecodeNullableWithDecodeMap(
              _$EnumTypeEnumDecodeMap, json['withDefault']) ??
          EnumType.alpha,
    );

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': _$EnumTypeEnumMap[instance.value]!,
      'withDefault': _$EnumTypeEnumMap[instance.withDefault]!,
    };

const _$EnumTypeEnumMap = {
  EnumType.alpha: 'alpha',
  EnumType.beta: 'beta',
  EnumType.gamma: 'gamma',
  EnumType.delta: 'delta',
};

const _$EnumTypeEnumDecodeMap = {
  'alpha': EnumType.alpha,
  'beta': EnumType.beta,
  'gamma': EnumType.gamma,
  'delta': EnumType.delta,
};

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) =>
    SimpleClassNullable(
      $enumDecodeNullableWithDecodeMap(_$EnumTypeEnumDecodeMap, json['value']),
      $enumDecodeNullableWithDecodeMap(
              _$EnumTypeEnumDecodeMap, json['withDefault']) ??
          EnumType.alpha,
    );

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': _$EnumTypeEnumMap[instance.value],
      'withDefault': _$EnumTypeEnumMap[instance.withDefault],
    };
