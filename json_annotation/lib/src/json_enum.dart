// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta_meta.dart';

import 'json_serializable.dart';

/// Allows configuration of how `enum` elements are treated as JSON.
@Target({TargetKind.enumType})
class JsonEnum {
  const JsonEnum({
    this.alwaysCreate = false,
  });

  /// If `true`, `_$[enum name]EnumMap` is generated for in library containing
  /// the `enum`, even if the `enum` is not used as a field in a class annotated
  /// with [JsonSerializable].
  ///
  /// The default, `false`, means no extra helpers are generated for this `enum`
  /// unless it is used by a class annotated with [JsonSerializable].
  final bool alwaysCreate;
}
