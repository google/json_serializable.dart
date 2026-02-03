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
      nested: json['nested'] == null
          ? null
          : ComprehensiveNested.fromJson(
              json['nested'] as Map<String, dynamic>,
            ),
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
      'nested': instance.nested,
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
      'items': {r'$ref': '#'},
      'description': 'Required named constructor parameter',
    },
    'optionalNullableFieldWithJsonKeyDefault': {
      'type': 'number',
      'default': 3.145,
    },
    'branch': {r'$ref': r'#/$defs/Branch'},
    'nested': {r'$ref': r'#/$defs/ComprehensiveNested'},
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
    'ComprehensiveNested': {
      'type': 'object',
      'properties': {
        'noIncludeFromJson': {'type': 'integer'},
        'writableField': {
          'type': 'integer',
          'description': 'Writable field comment\n\nWith a second line.',
        },
        'renamed_field': {'type': 'integer'},
        'getterIncluded': {'type': 'integer'},
      },
      'required': ['getterIncluded'],
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

ComprehensiveNested _$ComprehensiveNestedFromJson(Map<String, dynamic> json) =>
    ComprehensiveNested()
      ..noIncludeToJson = (json['noIncludeToJson'] as num).toInt()
      ..writableField = (json['writableField'] as num).toInt()
      ..renamedField = (json['renamed_field'] as num).toInt();

Map<String, dynamic> _$ComprehensiveNestedToJson(
  ComprehensiveNested instance,
) => <String, dynamic>{
  'writableField': instance.writableField,
  'renamed_field': instance.renamedField,
  'getterIncluded': instance.getterIncluded,
};

const _$ComprehensiveNestedJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'noIncludeFromJson': {'type': 'integer'},
    'writableField': {
      'type': 'integer',
      'description': 'Writable field comment\n\nWith a second line.',
    },
    'renamed_field': {'type': 'integer'},
    'getterIncluded': {'type': 'integer'},
  },
  'required': ['getterIncluded'],
};
