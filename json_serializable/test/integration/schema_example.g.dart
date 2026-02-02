// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'schema_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemaExample _$SchemaExampleFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['propExtraFieldRequired']);
  return SchemaExample(
      (json['requiredBranch'] as List<dynamic>)
          .map((e) => SchemaExample.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['nullableRequiredPositional'] as num?)?.toDouble(),
      requiredName: (json['requiredName'] as num).toDouble(),
      nullableNotRequired:
          (json['nullableNotRequired'] as num?)?.toDouble() ?? 3.145,
      nullableRequiredName: (json['nullableRequiredName'] as num?)?.toDouble(),
      optionalNullableFieldWithJsonKeyDefault:
          (json['optionalNullableFieldWithJsonKeyDefault'] as num?)
              ?.toDouble() ??
          3.145,
      branch: Branch.fromJson(json['branch'] as Map<String, dynamic>),
    )
    ..propExtraField = json['propExtraField'] as bool
    ..propExtraFieldRequired = json['propExtraFieldRequired'] as bool;
}

Map<String, dynamic> _$SchemaExampleToJson(SchemaExample instance) =>
    <String, dynamic>{
      'requiredName': instance.requiredName,
      'nullableNotRequired': instance.nullableNotRequired,
      'nullableRequiredPositional': instance.nullableRequiredPositional,
      'nullableRequiredName': instance.nullableRequiredName,
      'requiredBranch': instance.requiredBranch,
      'optionalNullableFieldWithJsonKeyDefault':
          instance.optionalNullableFieldWithJsonKeyDefault,
      'branch': instance.branch,
      'propExtraField': instance.propExtraField,
      'propExtraFieldRequired': instance.propExtraFieldRequired,
    };

const _$SchemaExampleJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'requiredName': {
      'type': 'number',
      'description': 'Required named constructor parameter',
    },
    'nullableNotRequired': {
      'type': 'number',
      'description': 'Nullable required named constructor parameter',
      'default': 3.145,
    },
    'nullableRequiredPositional': {'type': 'number'},
    'nullableRequiredName': {'type': 'number'},
    'requiredBranch': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/SchemaExample'},
      'description': 'Required named constructor parameter',
    },
    'optionalNullableFieldWithJsonKeyDefault': {
      'type': 'number',
      'default': 3.145,
    },
    'branch': {r'$ref': r'#/$defs/Branch'},
    'propExtraField': {
      'type': 'boolean',
      'description':
          'Non-nullable field with default value - should NOT be required',
    },
    'propExtraFieldRequired': {
      'type': 'boolean',
      'description':
          'Non-ctor field with `required: true` - should be required',
    },
  },
  'required': [
    'requiredName',
    'nullableRequiredPositional',
    'nullableRequiredName',
    'requiredBranch',
    'branch',
    'propExtraFieldRequired',
  ],
  r'$defs': {
    'Branch': {
      'type': 'object',
      'properties': {
        'length': {'type': 'number'},
        'branch': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/Branch'},
        },
      },
      'required': ['length', 'branch'],
    },
  },
};

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
  length: (json['length'] as num).toDouble(),
  branch: (json['branch'] as List<dynamic>)
      .map((e) => Branch.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
  'length': instance.length,
  'branch': instance.branch,
};
