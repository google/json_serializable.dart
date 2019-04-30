// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map json) {
  return $checkedNew('Configuration', json, () {
    final val = Configuration(
        name: $checkedConvert(json, 'name', (v) => v as String),
        count: $checkedConvert(json, 'count', (v) => v as int));
    return val;
  });
}
