// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=3.8

import 'package:json_annotation/json_annotation.dart' as ja;
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
CheckedWithPrefix _$CheckedWithPrefixFromJson(Map<String, dynamic> json) =>
    ja.$checkedCreate('CheckedWithPrefix', json, ($checkedConvert) {
      final val = CheckedWithPrefix(
        $checkedConvert('field1', (v) => v as String),
        $checkedConvert('field2', (v) => v as String),
      );
      return val;
    });
''')
@ja.JsonSerializable(checked: true, createToJson: false)
class CheckedWithPrefix {
  final String field1;
  final String field2;

  CheckedWithPrefix(this.field1, this.field2);
}

@ShouldGenerate(r'''
EnumWithPrefix _$EnumWithPrefixFromJson(Map<String, dynamic> json) {
  ja.$checkKeys(
    json,
    requiredKeys: const ['gender'],
    disallowNullValues: const ['gender'],
  );
  return EnumWithPrefix(ja.$enumDecode(_$PrefixGenderEnumMap, json['gender']));
}

const _$PrefixGenderEnumMap = {
  PrefixGender.male: 'male',
  PrefixGender.female: 'female',
  PrefixGender.other: 'other',
};
''')
@ja.JsonSerializable(createToJson: false)
class EnumWithPrefix {
  @ja.JsonKey(required: true, disallowNullValue: true)
  final PrefixGender gender;

  EnumWithPrefix(this.gender);
}

enum PrefixGender { male, female, other }
