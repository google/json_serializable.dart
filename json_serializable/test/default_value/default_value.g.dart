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

Map<String, dynamic> _$DefaultValueToJson(DefaultValue instance) {
  var val = <String, dynamic>{
    'fieldBool': instance.fieldBool,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fieldString', instance.fieldString);
  val['fieldInt'] = instance.fieldInt;
  val['fieldDouble'] = instance.fieldDouble;
  val['fieldListEmpty'] = instance.fieldListEmpty;
  val['fieldMapEmpty'] = instance.fieldMapEmpty;
  val['fieldListSimple'] = instance.fieldListSimple;
  val['fieldMapSimple'] = instance.fieldMapSimple;
  val['fieldMapListString'] = instance.fieldMapListString;
  val['fieldEnum'] = instance.fieldEnum?.toString()?.split('.')?.last;
  return val;
}
