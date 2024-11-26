// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

A _$AFromJson(Map<String, dynamic> json) => A(
      $enumDecodeNullableWithDecodeMap(
          _$StatusCodeEnumDecodeMap, json['statusCode']),
      $enumDecodeWithDecodeMap(_$StatusCode2EnumDecodeMap, json['statusCode2']),
      $enumDecodeWithDecodeMap(_$StatusCode3EnumDecodeMap, json['statusCode3']),
    );

Map<String, dynamic> _$AToJson(A instance) => <String, dynamic>{
      'statusCode': _$StatusCodeEnumMap[instance.statusCode],
      'statusCode2': _$StatusCode2EnumMap[instance.statusCode2]!,
      'statusCode3': _$StatusCode3EnumMap[instance.statusCode3]!,
    };

const _$StatusCodeEnumMap = {
  StatusCode.success: 200,
  StatusCode.movedPermanently: 301,
  StatusCode.found: 302,
  StatusCode.internalServerError: 500,
};

const _$StatusCodeEnumDecodeMap = {
  200: StatusCode.success,
  201: StatusCode.success,
  202: StatusCode.success,
  301: StatusCode.movedPermanently,
  302: StatusCode.found,
  500: StatusCode.internalServerError,
};

const _$StatusCode2EnumMap = {
  StatusCode2.success: 200,
  StatusCode2.movedPermanently: 301,
  StatusCode2.found: 302,
  StatusCode2.internalServerError: 500,
};

const _$StatusCode2EnumDecodeMap = {
  200: StatusCode2.success,
  301: StatusCode2.movedPermanently,
  302: StatusCode2.found,
  500: StatusCode2.internalServerError,
};

const _$StatusCode3EnumMap = {
  StatusCode3.success: 200,
  StatusCode3.movedPermanently: 301,
  StatusCode3.found: 1000,
  StatusCode3.internalServerError: 500,
};

const _$StatusCode3EnumDecodeMap = {
  200: StatusCode3.success,
  301: StatusCode3.movedPermanently,
  1000: StatusCode3.found,
  500: StatusCode3.internalServerError,
};
