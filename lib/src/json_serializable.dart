// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class JsonSerializable {
  final bool createFactory;
  final bool createToJson;

  const JsonSerializable({bool createFactory: true, bool createToJson: true})
      : this.createFactory = createFactory,
        this.createToJson = createToJson;
}

/// An annotation used to specify how a field is serialized.
class JsonKey {
  /// The key in a JSON map to use when reading and writing values corresponding
  /// to the annotated fields.
  ///
  /// If `null`, the field name is used.
  final String name;

  /// [true] if the generator should validate all values for `null` in
  /// serialization code.
  ///
  /// Setting to [false] eliminates `null` verification in generated code, but
  /// does not prevent `null` values from being created. Annotated classes
  /// must implement their own `null` validation.
  final bool nullable;

  /// Creates a new [JsonKey].
  ///
  /// Only required when the default behavior is not desired.
  const JsonKey({this.name, bool nullable: true})
      : this.nullable = nullable ?? true;
}
