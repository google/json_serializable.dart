// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class JsonSerializable {
  final bool createFactory;
  final bool createToJson;

  /// Whether the generator should include the this field in the serialized
  /// output, even if the value is `null`.
  final bool includeIfNull;

  const JsonSerializable(
      {bool createFactory: true,
      bool createToJson: true,
      bool includeIfNull: true})
      : this.createFactory = createFactory ?? true,
        this.createToJson = createToJson ?? true,
        this.includeIfNull = includeIfNull ?? true;
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

  /// [true] if the generator should include the this field in the serialized
  /// output, even if the value is `null`.
  ///
  /// The default value, `null`, indicates that the behavior should be
  /// acquired from the [JsonSerializable.includeIfNull] annotation on the
  /// enclosing class.
  final bool includeIfNull;

  /// Creates a new [JsonKey].
  ///
  /// Only required when the default behavior is not desired.
  const JsonKey({this.name, bool nullable: true, bool includeIfNull})
      : this.nullable = nullable ?? true,
        this.includeIfNull = includeIfNull;
}
