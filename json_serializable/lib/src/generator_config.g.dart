// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
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
      useWrappers: json['use_wrappers'] as bool);
}

Map<String, dynamic> _$GeneratorConfigToJson(GeneratorConfig instance) =>
    <String, dynamic>{
      'any_map': instance.anyMap,
      'use_wrappers': instance.useWrappers,
      'checked': instance.checked,
      'explicit_to_json': instance.explicitToJson,
      'generate_to_json_function': instance.generateToJsonFunction
    };
