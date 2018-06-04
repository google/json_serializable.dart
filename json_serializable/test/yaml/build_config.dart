// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'build_config.g.dart';

@JsonSerializable()
class Config extends Object with _$ConfigSerializerMixin {
  @JsonKey(required: true)
  final Map<String, Builder> builders;

  Config({@required this.builders});

  factory Config.fromJson(Map map) => _$ConfigFromJson(map);
}

@JsonSerializable(includeIfNull: false, disallowUnrecognizedKeys: true)
class Builder extends Object with _$BuilderSerializerMixin {
  @JsonKey(nullable: true)
  final String target;

  final String import;

  @JsonKey(name: 'is_optional')
  final bool isOptional;

  @JsonKey(
      name: 'auto_apply',
      toJson: _autoApplyToJson,
      fromJson: _autoApplyFromJson)
  final AutoApply autoApply;

  @JsonKey(name: 'build_to', toJson: _buildToToJson, fromJson: _buildToFromJson)
  final BuildTo buildTo;

  final AutoApply defaultEnumTest;

  @JsonKey(name: 'builder_factories', nullable: false)
  final List<String> builderFactories;

  @JsonKey(name: 'applies_builders')
  final List<String> appliesBuilders;

  @JsonKey(name: 'required_inputs')
  final List<String> requiredInputs;

  @JsonKey(name: 'build_extensions')
  final Map<String, List<String>> buildExtentions;

  Builder({
    @required this.import,
    this.target,
    this.isOptional,
    this.autoApply,
    this.buildTo,
    this.defaultEnumTest,
    this.builderFactories,
    this.appliesBuilders,
    this.requiredInputs,
    this.buildExtentions,
  }) {
    if (builderFactories.isEmpty) {
      throw new ArgumentError.value(builderFactories, 'builderFactories',
          'Must have at least one value.');
    }
  }

  factory Builder.fromJson(Map map) => _$BuilderFromJson(map);
}

enum AutoApply { none, dependents, allPackages, rootPackage }

enum BuildTo { cache, source }

AutoApply _autoApplyFromJson(String input) =>
    _fromJson(input, _autoApplyConvert, 'autoApply');

String _autoApplyToJson(AutoApply value) =>
    _toJson(value, _autoApplyConvert, 'autoApply');

BuildTo _buildToFromJson(String input) =>
    _fromJson(input, _buildToConvert, 'buildTo');

String _buildToToJson(BuildTo value) =>
    _toJson(value, _buildToConvert, 'buildTo');

// TODO: remove all of this and annotate the fields on the enum – once we have
// https://github.com/dart-lang/json_serializable/issues/38
T _fromJson<T>(String input, Map<String, T> convertMap, String fieldName) {
  var value = convertMap[input];
  if (value == null) {
    var allowed = convertMap.keys.map((e) => '"$e"').join(', ');
    throw new ArgumentError.value(
        input, fieldName, '"$input" is not in the supported set: $allowed.');
  }
  return value;
}

String _toJson<T>(T value, Map<String, T> convertMap, String fieldName) {
  if (value == null) {
    return null;
  }
  var string = convertMap.entries
      .singleWhere((e) => e.value == value, orElse: () => null)
      ?.key;

  if (string == null) {
    throw new ArgumentError.value(value, fieldName, 'Unsupported value.');
  }
  return string;
}

const _autoApplyConvert = const {
  'none': AutoApply.none,
  'dependents': AutoApply.dependents,
  'all_packages': AutoApply.allPackages,
  'root_package': AutoApply.rootPackage
};

const _buildToConvert = const {
  'cache': BuildTo.cache,
  'source': BuildTo.source,
};
