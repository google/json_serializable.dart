// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:json_annotation/json_annotation.dart';

/// Represents values from [JsonKey] when merged with local configuration.
class KeyConfig {
  final String? defaultValue;

  final bool disallowNullValue;

  final bool? includeFromJson;

  final bool includeIfNull;

  final bool? includeToJson;

  final String name;

  final bool required;

  final String? unknownEnumValue;

  final String? readValueFunctionName;

  KeyConfig({
    required this.defaultValue,
    required this.disallowNullValue,
    required this.includeFromJson,
    required this.includeIfNull,
    required this.includeToJson,
    required this.name,
    required this.readValueFunctionName,
    required this.required,
    required this.unknownEnumValue,
  });
}

/// Represents values from [JsonSerializable] when merged with local
/// configuration.
///
/// Values are all known, so types are non-nullable.
class ClassConfig {
  final bool anyMap;
  final bool checked;
  final String constructor;
  final bool createFactory;
  final bool createToJson;
  final bool createFieldMap;
  final bool createPerFieldToJson;
  final bool disallowUnrecognizedKeys;
  final bool explicitToJson;
  final FieldRename fieldRename;
  final bool genericArgumentFactories;
  final bool ignoreUnannotated;
  final bool includeIfNull;
  final Map<String, String> ctorParamDefaults;
  final List<DartObject> converters;

  const ClassConfig({
    required this.anyMap,
    required this.checked,
    required this.constructor,
    required this.createFactory,
    required this.createToJson,
    required this.createFieldMap,
    required this.createPerFieldToJson,
    required this.disallowUnrecognizedKeys,
    required this.explicitToJson,
    required this.fieldRename,
    required this.genericArgumentFactories,
    required this.ignoreUnannotated,
    required this.includeIfNull,
    this.converters = const [],
    this.ctorParamDefaults = const {},
  });

  factory ClassConfig.fromJsonSerializable(JsonSerializable config) =>
      // #CHANGE WHEN UPDATING json_annotation
      ClassConfig(
        checked: config.checked ?? ClassConfig.defaults.checked,
        anyMap: config.anyMap ?? ClassConfig.defaults.anyMap,
        constructor: config.constructor ?? ClassConfig.defaults.constructor,
        createFieldMap:
            config.createFieldMap ?? ClassConfig.defaults.createFieldMap,
        createPerFieldToJson: config.createPerFieldToJson ??
            ClassConfig.defaults.createPerFieldToJson,
        createFactory:
            config.createFactory ?? ClassConfig.defaults.createFactory,
        createToJson: config.createToJson ?? ClassConfig.defaults.createToJson,
        ignoreUnannotated:
            config.ignoreUnannotated ?? ClassConfig.defaults.ignoreUnannotated,
        explicitToJson:
            config.explicitToJson ?? ClassConfig.defaults.explicitToJson,
        includeIfNull:
            config.includeIfNull ?? ClassConfig.defaults.includeIfNull,
        genericArgumentFactories: config.genericArgumentFactories ??
            ClassConfig.defaults.genericArgumentFactories,
        fieldRename: config.fieldRename ?? ClassConfig.defaults.fieldRename,
        disallowUnrecognizedKeys: config.disallowUnrecognizedKeys ??
            ClassConfig.defaults.disallowUnrecognizedKeys,
        // TODO typeConverters = []
      );

  /// An instance of [JsonSerializable] with all fields set to their default
  /// values.
  static const defaults = ClassConfig(
    anyMap: false,
    checked: false,
    constructor: '',
    createFactory: true,
    createToJson: true,
    createFieldMap: false,
    createPerFieldToJson: false,
    disallowUnrecognizedKeys: false,
    explicitToJson: false,
    fieldRename: FieldRename.none,
    genericArgumentFactories: false,
    ignoreUnannotated: false,
    includeIfNull: true,
  );

  JsonSerializable toJsonSerializable() => JsonSerializable(
        checked: checked,
        anyMap: anyMap,
        constructor: constructor,
        createFactory: createFactory,
        createToJson: createToJson,
        createFieldMap: createFieldMap,
        createPerFieldToJson: createPerFieldToJson,
        ignoreUnannotated: ignoreUnannotated,
        explicitToJson: explicitToJson,
        includeIfNull: includeIfNull,
        genericArgumentFactories: genericArgumentFactories,
        fieldRename: fieldRename,
        disallowUnrecognizedKeys: disallowUnrecognizedKeys,
        // TODO typeConverters = []
      );
}
