// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta_meta.dart';

/// When applied to `enum` definitions, causes the corresponding private
//  `_$EnumNameEnumMap` and `_$enumDecode` helpers to be generated, even  if the
//  `enum` is not referenced elsewhere in generated code.
@Target({TargetKind.enumType})
class JsonEnum {
  const JsonEnum();
}
