// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen_test/annotations.dart';

/// Enum with both valueField and fieldRename - used to test that a warning
/// is logged when fieldRename is ignored.
@ShouldGenerate(
  r'''
const _$EnumWithValueFieldAndFieldRenameEnumMap = {
  EnumWithValueFieldAndFieldRename.success: 200,
  EnumWithValueFieldAndFieldRename.error: 500,
};
''',
  expectedLogItems: [
    '`JsonEnum.fieldRename` is ignored when `valueField` is set. '
        'Enum values are derived from the `code` field.',
  ],
)
@JsonEnum(
  alwaysCreate: true,
  valueField: 'code',
  fieldRename: FieldRename.kebab,
)
enum EnumWithValueFieldAndFieldRename {
  success(200),
  error(500);

  const EnumWithValueFieldAndFieldRename(this.code);

  final int code;
}

@ShouldGenerate(r'''
const _$EnumWithJsonConfigThatSetsTheOutputEnumMap = {
  EnumWithJsonConfigThatSetsTheOutput.aFunkyName: 'a_funky_name',
  EnumWithJsonConfigThatSetsTheOutput.anotherFunkyName: 'another_funky_name',
};
''')
@JsonEnum(alwaysCreate: true)
enum EnumWithJsonConfigThatSetsTheOutput { aFunkyName, anotherFunkyName }
