// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

abstract class DefaultValue {
  bool get fieldBool;

  String get fieldString;

  int get fieldInt;

  double get fieldDouble;

  List get fieldListEmpty;

  Map get fieldMapEmpty;

  Set get fieldSetEmpty;

  List<int> get fieldListSimple;

  Set<String> get fieldSetSimple;

  Map<String, int> get fieldMapSimple;

  Map<String, List<String>> get fieldMapListString;

  Duration get durationField;

  Greek get fieldEnum;

  ConstClass get constClass;

  ConstClass get valueFromConverter;

  ConstClass get valueFromFunction;

  int get intDefaultValueFromFunction;

  ConstClass get valueFromDefaultValueDefaultConstructor;

  ConstClass get valueFromDefaultValueNamedConstructor;
}

enum Greek { alpha, beta, gamma, delta }

// Regression for https://github.com/google/json_serializable.dart/issues/903
class ConstClass {
  final String field;

  const ConstClass([this.field = 'default']);

  ConstClass.easy() : field = 'easy';

  factory ConstClass.fromJson(Map<String, dynamic> json) => ConstClass(
        json['field'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'field': field,
      };
}

ConstClass constClassFromJson(String json) => ConstClass(json);

String constClassToJson(ConstClass object) => object.field;

class ConstClassConverter extends JsonConverter<ConstClass, String> {
  const ConstClassConverter();

  @override
  ConstClass fromJson(String json) => ConstClass(json);

  @override
  String toJson(ConstClass object) => object.field;
}

int intDefaultValueFunction() => 43;
