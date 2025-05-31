// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map json) => $checkedCreate('Config', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['builders']);
  final val = Config(
    builders: $checkedConvert(
      'builders',
      (v) => (v as Map).map(
        (k, e) => MapEntry(k as String, Builder.fromJson(e as Map)),
      ),
    ),
  );
  $checkedConvert(
    'weights',
    (v) => val.weights = (v as Map?)?.map(
      (k, e) =>
          MapEntry($enumDecode(_$AutoApplyEnumMap, k), (e as num?)?.toInt()),
    ),
  );
  return val;
});

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
  'builders': instance.builders,
  'weights': instance.weights?.map(
    (k, e) => MapEntry(_$AutoApplyEnumMap[k]!, e),
  ),
};

const _$AutoApplyEnumMap = {
  AutoApply.none: 'none',
  AutoApply.dependents: 'dependents',
  AutoApply.allPackages: 'all_packages',
  AutoApply.rootPackage: 'root_package',
};

Builder _$BuilderFromJson(Map json) => $checkedCreate(
  'Builder',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'target',
        'import',
        'is_optional',
        'configLocation',
        'auto_apply',
        'build_to',
        'defaultEnumTest',
        'builder_factories',
        'applies_builders',
        'required_inputs',
        'build_extensions',
      ],
      disallowNullValues: const ['configLocation', 'auto_apply'],
    );
    final val = Builder(
      import: $checkedConvert('import', (v) => v as String?),
      target: $checkedConvert('target', (v) => v as String?),
      isOptional: $checkedConvert('is_optional', (v) => v as bool?),
      autoApply: $checkedConvert(
        'auto_apply',
        (v) => $enumDecodeNullable(_$AutoApplyEnumMap, v),
      ),
      buildTo: $checkedConvert(
        'build_to',
        (v) => $enumDecodeNullable(_$BuildToEnumMap, v),
      ),
      defaultEnumTest: $checkedConvert(
        'defaultEnumTest',
        (v) => $enumDecodeNullable(_$AutoApplyEnumMap, v),
      ),
      builderFactories: $checkedConvert(
        'builder_factories',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      appliesBuilders: $checkedConvert(
        'applies_builders',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      requiredInputs: $checkedConvert(
        'required_inputs',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      buildExtensions: $checkedConvert(
        'build_extensions',
        (v) => (v as Map?)?.map(
          (k, e) => MapEntry(
            k as String,
            (e as List<dynamic>).map((e) => e as String).toList(),
          ),
        ),
      ),
      configLocation: $checkedConvert(
        'configLocation',
        (v) => v == null ? null : Uri.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'isOptional': 'is_optional',
    'autoApply': 'auto_apply',
    'buildTo': 'build_to',
    'builderFactories': 'builder_factories',
    'appliesBuilders': 'applies_builders',
    'requiredInputs': 'required_inputs',
    'buildExtensions': 'build_extensions',
  },
);

Map<String, dynamic> _$BuilderToJson(Builder instance) => <String, dynamic>{
  'target': ?instance.target,
  'import': ?instance.import,
  'is_optional': ?instance.isOptional,
  'configLocation': ?instance.configLocation?.toString(),
  'auto_apply': ?_$AutoApplyEnumMap[instance.autoApply],
  'build_to': ?_$BuildToEnumMap[instance.buildTo],
  'defaultEnumTest': ?_$AutoApplyEnumMap[instance.defaultEnumTest],
  'builder_factories': instance.builderFactories,
  'applies_builders': ?instance.appliesBuilders,
  'required_inputs': ?instance.requiredInputs,
  'build_extensions': ?instance.buildExtensions,
};

const _$BuildToEnumMap = {BuildTo.cache: 'cache', BuildTo.source: 'source'};
