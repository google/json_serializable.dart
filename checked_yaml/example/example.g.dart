// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore_for_file: lines_longer_than_80_chars, prefer_expression_function_bodies

Configuration _$ConfigurationFromJson(Map json) {
  return $checkedNew('Configuration', json, () {
    $checkKeys(json,
        allowedKeys: const ['name', 'count'],
        requiredKeys: const ['name', 'count']);
    final val = Configuration(
      name: $checkedConvert(json, 'name', (v) => v as String),
      count: $checkedConvert(json, 'count', (v) => v as int),
    );
    return val;
  });
}

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
    };
