// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
);

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
};

const _$PersonJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'firstName': {
      'type': 'string',
      'description': 'The generated code assumes these values exist in JSON.',
    },
    'lastName': {
      'type': 'string',
      'description': 'The generated code assumes these values exist in JSON.',
    },
    'dateOfBirth': {
      'type': 'string',
      'format': 'date-time',
      'description':
          "The generated code below handles if the corresponding JSON value doesn't\nexist or is empty.",
    },
  },
  'required': ['firstName', 'lastName'],
};
