// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen_test/annotations.dart';

/// Enum with no fieldRename - used to test that build config enum_field_rename
/// is applied when set (e.g. pascal) and that default is none.
@ShouldGenerate(r'''
const _$EnumForDefaultRenameEnumMap = {
  EnumForDefaultRename.firstValue: 'firstValue',
  EnumForDefaultRename.secondValue: 'secondValue',
  EnumForDefaultRename.thirdValue: 'thirdValue',
};
''')
@JsonEnum(alwaysCreate: true)
enum EnumForDefaultRename { firstValue, secondValue, thirdValue }

/// Enum with explicit fieldRename: kebab - used to test that annotation
/// overrides build config (e.g. config pascal should still yield kebab here).
@ShouldGenerate(r'''
const _$EnumWithKebabOverrideEnumMap = {
  EnumWithKebabOverride.fooBar: 'foo-bar',
  EnumWithKebabOverride.bazQux: 'baz-qux',
};
''')
@JsonEnum(alwaysCreate: true, fieldRename: FieldRename.kebab)
enum EnumWithKebabOverride { fooBar, bazQux }
