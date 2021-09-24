// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

import 'type_helper.dart';
import 'type_helpers/big_int_helper.dart';
import 'type_helpers/config_types.dart';
import 'type_helpers/convert_helper.dart';
import 'type_helpers/date_time_helper.dart';
import 'type_helpers/duration_helper.dart';
import 'type_helpers/enum_helper.dart';
import 'type_helpers/generic_factory_helper.dart';
import 'type_helpers/iterable_helper.dart';
import 'type_helpers/json_converter_helper.dart';
import 'type_helpers/json_helper.dart';
import 'type_helpers/map_helper.dart';
import 'type_helpers/uri_helper.dart';
import 'type_helpers/value_helper.dart';

class Settings {
  static const _coreHelpers = <TypeHelper>[
    IterableHelper(),
    MapHelper(),
    EnumHelper(),
    ValueHelper(),
  ];

  static const defaultHelpers = <TypeHelper>[
    BigIntHelper(),
    DateTimeHelper(),
    DurationHelper(),
    JsonHelper(),
    UriHelper(),
  ];

  final List<TypeHelper> _typeHelpers;

  Iterable<TypeHelper> get allHelpers => const <TypeHelper>[
        ConvertHelper(),
        JsonConverterHelper(),
        GenericFactoryHelper(),
      ].followedBy(_typeHelpers).followedBy(_coreHelpers);

  final JsonSerializable _config;

  // #CHANGE WHEN UPDATING json_annotation
  ClassConfig get config => ClassConfig(
        checked: _config.checked ?? ClassConfig.defaults.checked,
        anyMap: _config.anyMap ?? ClassConfig.defaults.anyMap,
        constructor: _config.constructor ?? ClassConfig.defaults.constructor,
        createFactory:
            _config.createFactory ?? ClassConfig.defaults.createFactory,
        createToJson: _config.createToJson ?? ClassConfig.defaults.createToJson,
        ignoreUnannotated:
            _config.ignoreUnannotated ?? ClassConfig.defaults.ignoreUnannotated,
        explicitToJson:
            _config.explicitToJson ?? ClassConfig.defaults.explicitToJson,
        includeIfNull:
            _config.includeIfNull ?? ClassConfig.defaults.includeIfNull,
        genericArgumentFactories: _config.genericArgumentFactories ??
            ClassConfig.defaults.genericArgumentFactories,
        fieldRename: _config.fieldRename ?? ClassConfig.defaults.fieldRename,
        disallowUnrecognizedKeys: _config.disallowUnrecognizedKeys ??
            ClassConfig.defaults.disallowUnrecognizedKeys,
      );

  /// Creates an instance of [Settings].
  ///
  /// If [typeHelpers] is not provided, the built-in helpers are used:
  /// [BigIntHelper], [DateTimeHelper], [DurationHelper], [JsonHelper], and
  /// [UriHelper].
  const Settings({
    JsonSerializable? config,
    List<TypeHelper>? typeHelpers,
  })  : _config = config ?? ClassConfig.defaults,
        _typeHelpers = typeHelpers ?? defaultHelpers;

  /// Creates an instance of [Settings].
  ///
  /// [typeHelpers] provides a set of [TypeHelper] that will be used along with
  /// the built-in helpers:
  /// [BigIntHelper], [DateTimeHelper], [DurationHelper], [JsonHelper], and
  /// [UriHelper].
  factory Settings.withDefaultHelpers(
    Iterable<TypeHelper> typeHelpers, {
    JsonSerializable? config,
  }) =>
      Settings(
        config: config,
        typeHelpers: List.unmodifiable(typeHelpers.followedBy(defaultHelpers)),
      );
}
