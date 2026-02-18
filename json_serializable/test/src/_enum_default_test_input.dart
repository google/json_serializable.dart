// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
const _$EnumValueIssue1147EnumMap = {
  EnumValueIssue1147.success: 200,
  EnumValueIssue1147.weird: 601,
};
''')
@JsonEnum(alwaysCreate: true, valueField: 'statusCodeNumber')
enum EnumValueIssue1147 {
  success(200),
  @JsonValue(601)
  weird(701);

  const EnumValueIssue1147(this.statusCodeNumber);

  final int statusCodeNumber;
}

@ShouldThrow(
  '`JsonEnum.valueField` was set to "notAField", but that is not a valid, '
  'instance field on `EnumValueNotAField`.',
)
@JsonEnum(alwaysCreate: true, valueField: 'notAField')
enum EnumValueNotAField {
  success(200),
  @JsonValue(601)
  weird(701);

  const EnumValueNotAField(this.statusCodeNumber);

  final int statusCodeNumber;
}

@ShouldThrow(
  '`JsonEnum.valueField` was set to "symbolWeird", but that field does not '
  'have a type of String, int, or null.',
)
@JsonEnum(alwaysCreate: true, valueField: 'symbolWeird')
enum EnumValueNotSupportType {
  success(#success),
  @JsonValue(601)
  weird(#weird);

  const EnumValueNotSupportType(this.symbolWeird);

  final Symbol symbolWeird;
}

@ShouldThrow(
  '`JsonEnum.valueField` was set to "values", but that is not a valid, '
  'instance field on `EnumValueWeirdField`.',
)
@JsonEnum(alwaysCreate: true, valueField: 'values')
enum EnumValueWeirdField {
  success(200),
  weird(701);

  const EnumValueWeirdField(this.something);

  final int something;
}

@ShouldThrow('`@JsonEnum` can only be used on enum elements.')
@JsonEnum() // ignore: invalid_annotation_target
class UnsupportedClass {}
