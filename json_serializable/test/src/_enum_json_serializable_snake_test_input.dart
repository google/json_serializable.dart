// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
JsonSerialWithEnum _$JsonSerialWithEnumFromJson(Map<String, dynamic> json) =>
    JsonSerialWithEnum(
      $enumDecode(_$EnumForJsonSerialEnumMap, json['enumValue']),
    );

Map<String, dynamic> _$JsonSerialWithEnumToJson(JsonSerialWithEnum instance) =>
    <String, dynamic>{
      'enumValue': _$EnumForJsonSerialEnumMap[instance.enumValue]!,
    };

const _$EnumForJsonSerialEnumMap = {
  EnumForJsonSerial.aFunkyName: 'a_funky_name',
  EnumForJsonSerial.anotherFunkyName: 'another_funky_name',
};
''')
@JsonSerializable()
class JsonSerialWithEnum {
  final EnumForJsonSerial enumValue;

  JsonSerialWithEnum(this.enumValue);
}

enum EnumForJsonSerial { aFunkyName, anotherFunkyName }
