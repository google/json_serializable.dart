// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonSerializable _$JsonSerializableFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'any_map',
    'checked',
    'create_factory',
    'create_to_json',
    'disallow_unrecognized_keys',
    'explicit_to_json',
    'field_rename',
    'generate_to_json_function',
    'include_if_null',
    'nullable',
    'use_wrappers'
  ]);
  return JsonSerializable(
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

Map<String, dynamic> _$JsonSerializableToJson(JsonSerializable instance) =>
    <String, dynamic>{
      'any_map': instance.anyMap,
      'checked': instance.checked,
      'create_factory': instance.createFactory,
      'create_to_json': instance.createToJson,
      'disallow_unrecognized_keys': instance.disallowUnrecognizedKeys,
      'explicit_to_json': instance.explicitToJson,
      'field_rename': _$FieldRenameEnumMap[instance.fieldRename],
      'generate_to_json_function': instance.generateToJsonFunction,
      'include_if_null': instance.includeIfNull,
      'nullable': instance.nullable,
      'use_wrappers': instance.useWrappers
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
