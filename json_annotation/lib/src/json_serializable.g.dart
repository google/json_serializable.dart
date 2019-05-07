// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonSerializable _$JsonSerializableFromJson(Map<String, dynamic> json) {
  return $checkedNew('JsonSerializable', json, () {
    $checkKeys(json, allowedKeys: const [
      'any_map',
      'checked',
      'create_factory',
      'create_to_json',
      'disallow_unrecognized_keys',
      'encode_empty_collection',
      'explicit_to_json',
      'field_rename',
      'generate_to_json_function',
      'include_if_null',
      'nullable',
      'use_wrappers'
    ]);
    final val = JsonSerializable(
        anyMap: $checkedConvert(json, 'any_map', (v) => v as bool),
        checked: $checkedConvert(json, 'checked', (v) => v as bool),
        createFactory:
            $checkedConvert(json, 'create_factory', (v) => v as bool),
        createToJson: $checkedConvert(json, 'create_to_json', (v) => v as bool),
        disallowUnrecognizedKeys: $checkedConvert(
            json, 'disallow_unrecognized_keys', (v) => v as bool),
        encodeEmptyCollection:
            $checkedConvert(json, 'encode_empty_collection', (v) => v as bool),
        explicitToJson:
            $checkedConvert(json, 'explicit_to_json', (v) => v as bool),
        fieldRename: $checkedConvert(json, 'field_rename',
            (v) => _$enumDecodeNullable(_$FieldRenameEnumMap, v)),
        generateToJsonFunction: $checkedConvert(
            json, 'generate_to_json_function', (v) => v as bool),
        includeIfNull:
            $checkedConvert(json, 'include_if_null', (v) => v as bool),
        nullable: $checkedConvert(json, 'nullable', (v) => v as bool),
        useWrappers: $checkedConvert(json, 'use_wrappers', (v) => v as bool));
    return val;
  }, fieldKeyMap: const {
    'anyMap': 'any_map',
    'createFactory': 'create_factory',
    'createToJson': 'create_to_json',
    'disallowUnrecognizedKeys': 'disallow_unrecognized_keys',
    'encodeEmptyCollection': 'encode_empty_collection',
    'explicitToJson': 'explicit_to_json',
    'fieldRename': 'field_rename',
    'generateToJsonFunction': 'generate_to_json_function',
    'includeIfNull': 'include_if_null',
    'useWrappers': 'use_wrappers'
  });
}

Map<String, dynamic> _$JsonSerializableToJson(JsonSerializable instance) =>
    <String, dynamic>{
      'any_map': instance.anyMap,
      'checked': instance.checked,
      'create_factory': instance.createFactory,
      'create_to_json': instance.createToJson,
      'disallow_unrecognized_keys': instance.disallowUnrecognizedKeys,
      'encode_empty_collection': instance.encodeEmptyCollection,
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
  FieldRename.snake: 'snake',
  FieldRename.pascal: 'pascal'
};
