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

  @JsonKey(disallowNullValue: true)
  final Uri configLocation;

  @JsonKey(name: 'auto_apply', disallowNullValue: true)
  final AutoApply autoApply;

  @JsonKey(name: 'build_to')
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

  Builder(
      {@required this.import,
      this.target,
      this.isOptional,
      this.autoApply,
      this.buildTo,
      this.defaultEnumTest,
      this.builderFactories,
      this.appliesBuilders,
      this.requiredInputs,
      this.buildExtentions,
      this.configLocation}) {
    if (builderFactories.isEmpty) {
      throw new ArgumentError.value(builderFactories, 'builderFactories',
          'Must have at least one value.');
    }
  }

  factory Builder.fromJson(Map map) => _$BuilderFromJson(map);
}

enum AutoApply {
  none,
  dependents,
  @JsonValue('all_packages')
  allPackages,
  @JsonValue('root_package')
  rootPackage
}

enum BuildTo { cache, source }
