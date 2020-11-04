// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'strict_keys_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StrictKeysObject _$StrictKeysObjectFromJson(Map json) {
  $checkKeys(json,
      allowedKeys: const ['value', 'custom_field'],
      requiredKeys: const ['value', 'custom_field']);
  return StrictKeysObject(
    json['value'] as int,
    json['custom_field'] as String,
  );
}

Map<String, dynamic> _$StrictKeysObjectToJson(StrictKeysObject instance) =>
    <String, dynamic>{
      'value': instance.value,
      'custom_field': instance.customField,
    };
