// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
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

  bool get explicitYesFromJson => includeFromJson == true;

  bool get explicitNoFromJson => includeFromJson == false;

  bool get explicitYesToJson => includeToJson == true;

  bool get explicitNoToJson => includeToJson == false;
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
  final bool createJsonKeys;
  final bool createPerFieldToJson;
  final bool createJsonSchema;
  final bool dateTimeUtc;
  final bool disallowUnrecognizedKeys;
  final bool explicitToJson;
  final FieldRename fieldRename;
  final FieldRename enumFieldRename;
  final bool genericArgumentFactories;
  final bool ignoreUnannotated;
  final bool includeIfNull;
  final List<FormalParameterElement> ctorParams;
  final List<DartObject> converters;

  const ClassConfig({
    required this.anyMap,
    required this.checked,
    required this.constructor,
    required this.createFactory,
    required this.createToJson,
    required this.createFieldMap,
    required this.createJsonKeys,
    required this.createPerFieldToJson,
    required this.createJsonSchema,
    required this.dateTimeUtc,
    required this.disallowUnrecognizedKeys,
    required this.explicitToJson,
    required this.fieldRename,
    required this.enumFieldRename,
    required this.genericArgumentFactories,
    required this.ignoreUnannotated,
    required this.includeIfNull,
    this.converters = const [],
    this.ctorParams = const [],
  });

  factory ClassConfig.fromJsonSerializable(JsonSerializable config) =>
      // #CHANGE WHEN UPDATING json_annotation
      ClassConfig(
        checked: config.checked ?? ClassConfig.defaults.checked,
        anyMap: config.anyMap ?? ClassConfig.defaults.anyMap,
        constructor: config.constructor ?? ClassConfig.defaults.constructor,
        createFieldMap:
            config.createFieldMap ?? ClassConfig.defaults.createFieldMap,
        createJsonKeys:
            config.createJsonKeys ?? ClassConfig.defaults.createJsonKeys,
        createPerFieldToJson:
            config.createPerFieldToJson ??
            ClassConfig.defaults.createPerFieldToJson,
        createJsonSchema:
            config.createJsonSchema ?? ClassConfig.defaults.createJsonSchema,
        createFactory:
            config.createFactory ?? ClassConfig.defaults.createFactory,
        createToJson: config.createToJson ?? ClassConfig.defaults.createToJson,
        dateTimeUtc: config.dateTimeUtc ?? ClassConfig.defaults.dateTimeUtc,
        ignoreUnannotated:
            config.ignoreUnannotated ?? ClassConfig.defaults.ignoreUnannotated,
        explicitToJson:
            config.explicitToJson ?? ClassConfig.defaults.explicitToJson,
        includeIfNull:
            config.includeIfNull ?? ClassConfig.defaults.includeIfNull,
        genericArgumentFactories:
            config.genericArgumentFactories ??
            ClassConfig.defaults.genericArgumentFactories,
        fieldRename: config.fieldRename ?? ClassConfig.defaults.fieldRename,
        enumFieldRename:
            config.enumFieldRename ?? ClassConfig.defaults.enumFieldRename,
        disallowUnrecognizedKeys:
            config.disallowUnrecognizedKeys ??
            ClassConfig.defaults.disallowUnrecognizedKeys,
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
    createJsonKeys: false,
    createPerFieldToJson: false,
    createJsonSchema: false,
    dateTimeUtc: false,
    disallowUnrecognizedKeys: false,
    explicitToJson: false,
    fieldRename: FieldRename.none,
    enumFieldRename: FieldRename.none,
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
    createJsonKeys: createJsonKeys,
    createPerFieldToJson: createPerFieldToJson,
    createJsonSchema: createJsonSchema,
    ignoreUnannotated: ignoreUnannotated,
    explicitToJson: explicitToJson,
    includeIfNull: includeIfNull,
    genericArgumentFactories: genericArgumentFactories,
    fieldRename: fieldRename,
    enumFieldRename: enumFieldRename,
    disallowUnrecognizedKeys: disallowUnrecognizedKeys,
    dateTimeUtc: dateTimeUtc,
    // TODO typeConverters = []
  );

  ClassConfig copyWith({List<FormalParameterElement>? ctorParams}) =>
      ClassConfig(
        anyMap: anyMap,
        checked: checked,
        constructor: constructor,
        createFactory: createFactory,
        createToJson: createToJson,
        createFieldMap: createFieldMap,
        createJsonKeys: createJsonKeys,
        createPerFieldToJson: createPerFieldToJson,
        createJsonSchema: createJsonSchema,
        dateTimeUtc: dateTimeUtc,
        disallowUnrecognizedKeys: disallowUnrecognizedKeys,
        explicitToJson: explicitToJson,
        fieldRename: fieldRename,
        genericArgumentFactories: genericArgumentFactories,
        ignoreUnannotated: ignoreUnannotated,
        includeIfNull: includeIfNull,
        ctorParams: ctorParams ?? this.ctorParams,
        converters: converters,
      );
}
