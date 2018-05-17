// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_config.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map json) => $checkedNew(
    'Config',
    json,
    const {'builders': 'builders'},
    () => new Config(
        builders: $checkedConvert(
            json,
            'builders',
            () => (json['builders'] as Map)?.map((k, e) => new MapEntry(
                k as String,
                e == null ? null : new Builder.fromJson(e as Map))))));

abstract class _$ConfigSerializerMixin {
  Map<String, Builder> get builders;
  Map<String, dynamic> toJson() => <String, dynamic>{'builders': builders};
}

Builder _$BuilderFromJson(Map json) => $checkedNew(
    'Builder',
    json,
    const {
      'import': 'import',
      'target': 'target',
      'isOptional': 'is_optional',
      'autoApply': 'auto_apply',
      'builderFactories': 'builder_factories',
      'appliesBuilders': 'applies_builders',
      'requiredInputs': 'required_inputs',
      'buildExtentions': 'build_extensions'
    },
    () => new Builder(
        import: $checkedConvert(json, 'import', () => json['import'] as String),
        target: $checkedConvert(json, 'target', () => json['target'] as String),
        isOptional: $checkedConvert(
            json, 'is_optional', () => json['is_optional'] as bool),
        autoApply: $checkedConvert(
            json,
            'auto_apply',
            () => json['auto_apply'] == null
                ? null
                : _fromJson(json['auto_apply'] as String)),
        builderFactories: $checkedConvert(
            json,
            'builder_factories',
            () => (json['builder_factories'] as List)
                .map((e) => e as String)
                .toList()),
        appliesBuilders: $checkedConvert(
            json,
            'applies_builders',
            () => (json['applies_builders'] as List)
                ?.map((e) => e as String)
                ?.toList()),
        requiredInputs: $checkedConvert(
            json,
            'required_inputs',
            () => (json['required_inputs'] as List)
                ?.map((e) => e as String)
                ?.toList()),
        buildExtentions: $checkedConvert(
            json,
            'build_extensions',
            () => (json['build_extensions'] as Map)?.map((k, e) => new MapEntry(
                k as String,
                (e as List)?.map((e) => e as String)?.toList())))));

abstract class _$BuilderSerializerMixin {
  String get target;
  String get import;
  bool get isOptional;
  AutoApply get autoApply;
  List<String> get builderFactories;
  List<String> get appliesBuilders;
  List<String> get requiredInputs;
  Map<String, List<String>> get buildExtentions;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('target', target);
    writeNotNull('import', import);
    writeNotNull('is_optional', isOptional);
    writeNotNull('auto_apply', autoApply == null ? null : _toJson(autoApply));
    val['builder_factories'] = builderFactories;
    writeNotNull('applies_builders', appliesBuilders);
    writeNotNull('required_inputs', requiredInputs);
    writeNotNull('build_extensions', buildExtentions);
    return val;
  }
}
