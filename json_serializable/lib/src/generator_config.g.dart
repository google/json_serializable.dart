// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'disallow_unrecognized_keys',
    'create_factory',
    'create_to_json',
    'include_if_null',
    'nullable',
    'field_rename',
    'any_map',
    'use_wrappers',
    'checked',
    'explicit_to_json',
    'generate_to_json_function'
  ]);
  return GeneratorConfig(
      anyMap: json['any_map'] as bool,
      checked: json['checked'] as bool,
      explicitToJson: json['explicit_to_json'] as bool,
      generateToJsonFunction: json['generate_to_json_function'] as bool,
      useWrappers: json['use_wrappers'] as bool,
      disallowUnrecognizedKeys: json['disallow_unrecognized_keys'] as bool,
      createFactory: json['create_factory'] as bool,
      createToJson: json['create_to_json'] as bool,
      includeIfNull: json['include_if_null'] as bool,
      nullable: json['nullable'] as bool,
      fieldRename:
          _$enumDecodeNullable(_$FieldRenameEnumMap, json['field_rename']));
}

Map<String, dynamic> _$GeneratorConfigToJson(GeneratorConfig instance) =>
    <String, dynamic>{
      'disallow_unrecognized_keys': instance.disallowUnrecognizedKeys,
      'create_factory': instance.createFactory,
      'create_to_json': instance.createToJson,
      'include_if_null': instance.includeIfNull,
      'nullable': instance.nullable,
      'field_rename': _$FieldRenameEnumMap[instance.fieldRename],
      'any_map': instance.anyMap,
      'use_wrappers': instance.useWrappers,
      'checked': instance.checked,
      'explicit_to_json': instance.explicitToJson,
      'generate_to_json_function': instance.generateToJsonFunction
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$FieldRenameEnumMap = <FieldRename, dynamic>{
  FieldRename.none: 'none',
  FieldRename.kebab: 'kebab',
  FieldRename.snake: 'snake'
};
