// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_value.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

DefaultValue _$DefaultValueFromJson(Map<String, dynamic> json) {
  return new DefaultValue()
    ..fieldBool = json['fieldBool'] as bool ?? true
    ..fieldString = json['fieldString'] as String ?? 'string'
    ..fieldInt = json['fieldInt'] as int ?? 42
    ..fieldDouble = (json['fieldDouble'] as num)?.toDouble() ?? 3.14
    ..fieldListEmpty = json['fieldListEmpty'] as List ?? []
    ..fieldMapEmpty = json['fieldMapEmpty'] as Map<String, dynamic> ?? {}
    ..fieldListSimple =
        (json['fieldListSimple'] as List)?.map((e) => e as int)?.toList() ??
            [1, 2, 3]
    ..fieldMapSimple = (json['fieldMapSimple'] as Map<String, dynamic>)
            ?.map((k, e) => new MapEntry(k, e as int)) ??
        {'answer': 42}
    ..fieldMapListString = (json['fieldMapListString'] as Map<String, dynamic>)
            ?.map((k, e) => new MapEntry(
                k, (e as List)?.map((e) => e as String)?.toList())) ??
        {
          'root': ['child']
        }
    ..fieldEnum = $enumDecodeNullable(
            'Greek', Greek.values, json['fieldEnum'] as String) ??
        Greek.beta;
}

abstract class _$DefaultValueSerializerMixin {
  bool get fieldBool;
  String get fieldString;
  int get fieldInt;
  double get fieldDouble;
  List<dynamic> get fieldListEmpty;
  Map<dynamic, dynamic> get fieldMapEmpty;
  List<int> get fieldListSimple;
  Map<String, int> get fieldMapSimple;
  Map<String, List<String>> get fieldMapListString;
  Greek get fieldEnum;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'fieldBool': fieldBool,
        'fieldString': fieldString,
        'fieldInt': fieldInt,
        'fieldDouble': fieldDouble,
        'fieldListEmpty': fieldListEmpty,
        'fieldMapEmpty': fieldMapEmpty,
        'fieldListSimple': fieldListSimple,
        'fieldMapSimple': fieldMapSimple,
        'fieldMapListString': fieldMapListString,
        'fieldEnum': fieldEnum?.toString()?.split('.')?.last
      };
}
