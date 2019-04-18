// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strict_keys_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StrictKeysObject _$StrictKeysObjectFromJson(Map json) {
  $checkKeys(json,
      allowedKeys: const ['value', 'custom_field'],
      requiredKeys: const ['value', 'custom_field']);
  return StrictKeysObject(
      int.parse(json['value'].toString()), json['custom_field'].toString());
}

abstract class _$StrictKeysObjectSerializerMixin {
  int get value;
  String get customField;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'value': value, 'custom_field': customField};
}
