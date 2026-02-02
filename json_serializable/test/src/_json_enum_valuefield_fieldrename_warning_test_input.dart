// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

/// Enum with both valueField and fieldRename - used to test that a warning
/// is logged when fieldRename is ignored.
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
