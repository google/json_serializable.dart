// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_value.checked.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

DefaultValue _$DefaultValueFromJson(Map json) {
  return $checkedNew('DefaultValue', json, () {
    var val = new DefaultValue();
    $checkedConvert(
        json, 'fieldBool', (v) => val.fieldBool = v as bool ?? true);
    $checkedConvert(
        json, 'fieldString', (v) => val.fieldString = v as String ?? 'string');
    $checkedConvert(json, 'fieldInt', (v) => val.fieldInt = v as int ?? 42);
    $checkedConvert(json, 'fieldDouble',
        (v) => val.fieldDouble = (v as num)?.toDouble() ?? 3.14);
    $checkedConvert(
        json, 'fieldListEmpty', (v) => val.fieldListEmpty = v as List ?? []);
    $checkedConvert(
        json, 'fieldMapEmpty', (v) => val.fieldMapEmpty = v as Map ?? {});
    $checkedConvert(
        json,
        'fieldListSimple',
        (v) => val.fieldListSimple =
            (v as List)?.map((e) => e as int)?.toList() ?? [1, 2, 3]);
    $checkedConvert(
        json,
        'fieldMapSimple',
        (v) => val.fieldMapSimple =
            (v as Map)?.map((k, e) => new MapEntry(k as String, e as int)) ??
                {'answer': 42});
    $checkedConvert(
        json,
        'fieldMapListString',
        (v) => val.fieldMapListString = (v as Map)?.map((k, e) => new MapEntry(
                k as String, (e as List)?.map((e) => e as String)?.toList())) ??
            {
              'root': ['child']
            });
    $checkedConvert(
        json,
        'fieldEnum',
        (v) => val.fieldEnum =
            $enumDecodeNullable('Greek', Greek.values, v as String) ??
                Greek.beta);
    return val;
  });
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
        'fieldEnum':
            fieldEnum == null ? null : fieldEnum.toString().split('.')[1]
      };
}
