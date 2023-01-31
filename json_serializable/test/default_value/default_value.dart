// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides

import 'package:json_annotation/json_annotation.dart';

import 'default_value_interface.dart' as dvi hide Greek;
import 'default_value_interface.dart'
    show
        ConstClass,
        ConstClassConverter,
        Greek,
        constClassFromJson,
        constClassToJson,
        intDefaultValueFunction;

part 'default_value.g.dart';

const _intValue = 42;

dvi.DefaultValue fromJson(Map<String, dynamic> json) =>
    _$DefaultValueFromJson(json);

@JsonSerializable()
class DefaultValue implements dvi.DefaultValue {
  @JsonKey(defaultValue: true)
  bool fieldBool;

  @JsonKey(defaultValue: 'string', includeIfNull: false)
  String fieldString;

  @JsonKey(defaultValue: _intValue)
  int fieldInt;

  @JsonKey(defaultValue: 3.14)
  double fieldDouble;

  @JsonKey(defaultValue: [])
  List fieldListEmpty;

  @JsonKey(defaultValue: <int>{})
  Set fieldSetEmpty;

  @JsonKey(defaultValue: {})
  Map fieldMapEmpty;

  @JsonKey(defaultValue: [1, 2, 3])
  List<int> fieldListSimple;

  @JsonKey(defaultValue: {'entry1', 'entry2'})
  Set<String> fieldSetSimple;

  @JsonKey(defaultValue: {'answer': 42})
  Map<String, int> fieldMapSimple;

  @JsonKey(defaultValue: {
    'root': ['child']
  })
  Map<String, List<String>> fieldMapListString;

  Duration durationField;

  @JsonKey(defaultValue: Greek.beta)
  Greek fieldEnum;

  ConstClass constClass;

  @ConstClassConverter()
  ConstClass valueFromConverter;

  @JsonKey(fromJson: constClassFromJson, toJson: constClassToJson)
  ConstClass valueFromFunction;

  @JsonKey(defaultValue: intDefaultValueFunction)
  int intDefaultValueFromFunction;

  @JsonKey(defaultValue: ConstClass.new)
  ConstClass valueFromDefaultValueDefaultConstructor;

  @JsonKey(defaultValue: ConstClass.easy)
  ConstClass valueFromDefaultValueNamedConstructor;

  DefaultValue(
    this.fieldBool,
    this.fieldString,
    this.fieldInt,
    this.fieldDouble,
    this.fieldListEmpty,
    this.fieldSetEmpty,
    this.fieldMapEmpty,
    this.fieldListSimple,
    this.fieldSetSimple,
    this.fieldMapSimple,
    this.fieldMapListString,
    this.fieldEnum, {
    this.durationField = Duration.zero,
    this.constClass = const ConstClass('value'),
    this.valueFromConverter = const ConstClass('value'),
    this.valueFromFunction = const ConstClass('value'),
    required this.intDefaultValueFromFunction,
    required this.valueFromDefaultValueDefaultConstructor,
    required this.valueFromDefaultValueNamedConstructor,
  });

  factory DefaultValue.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultValueToJson(this);
}
