// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'json_meta_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      firstName: json['first-name'] as String,
      lastName: json['LAST_NAME'] as String,
    );

const _$ModelFieldMap = <String, String>{
  'firstName': 'first-name',
  'lastName': 'LAST_NAME',
};

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'first-name': instance.firstName,
      'LAST_NAME': instance.lastName,
    };
