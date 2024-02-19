// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'json_keys_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      firstName: json['first-name'] as String,
      lastName: json['LAST_NAME'] as String,
    );

class _$ModelJsonKeys {
  const _$ModelJsonKeys();
  final String firstName = 'first-name';
  final String lastName = 'LAST_NAME';
}

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'first-name': instance.firstName,
      'LAST_NAME': instance.lastName,
    };

class _$PrivateModelJsonKeys {
  const _$PrivateModelJsonKeys();
  final String fullName = 'full-name';
}

Map<String, dynamic> _$PrivateModelToJson(_PrivateModel instance) =>
    <String, dynamic>{
      'full-name': instance.fullName,
    };
