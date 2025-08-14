// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// An annotation used to specify how a enum value is serialized.
class JsonValue {
  /// The value to use when serializing and deserializing.
  ///
  /// Can be a [String] or an [int].
  final dynamic value;

  /// Optional values that can be used when deserializing.
  ///
  /// The elements of [aliases] must be either [String] or [int].
  final Set<Object> aliases;

  const JsonValue(this.value, {this.aliases = const {}});
}
