// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strict_keys_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StrictKeysObject _$StrictKeysObjectFromJson(Map json) {
  $checkKeys(json,
      allowedKeys: const ['value', 'custom_field'],
      requiredKeys: const ['value', 'custom_field']);
  return StrictKeysObject(json['value'] as int, json['custom_field'] as String);
}

abstract class _$StrictKeysObjectSerializerMixin {
  int get value;
  String get customField;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'value': value, 'custom_field': customField};
}
