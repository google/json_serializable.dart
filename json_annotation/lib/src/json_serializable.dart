// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// An annotation used to specify a class to generate code for.
class JsonSerializable {
  /// If `true` (the default), a private, static `_$ExampleFromJson` method
  /// is created in the generated part file.
  ///
  /// Call this method from a factory constructor added to the source class:
  ///
  /// ```dart
  /// @JsonSerializable()
  /// class Example {
  ///   // ...
  ///   factory Example.fromJson(Map<String, dynamic> json) =>
  ///     _$ExampleFromJson(json);
  /// }
  /// ```
  final bool createFactory;

  /// If `true` (the default), a private `_$ClassNameMixin` class is created
  /// in the generated part file which contains a `toJson` method.
  ///
  /// Mix in this class to the source class:
  ///
  /// ```dart
  /// @JsonSerializable()
  /// class Example extends Object with _$ExampleMixin {
  ///   // ...
  /// }
  /// ```
  final bool createToJson;

  /// Whether the generator should include fields with `null` values in the
  /// serialized output.
  final bool includeIfNull;

  /// When `true` (the default), `null` values are handled gracefully when
  /// serializing fields to JSON and when deserializing `null` and nonexistent
  /// values from a JSON map.
  ///
  /// Setting to `false` eliminates `null` verification in the generated code,
  /// which reduces the code size. Errors may be thrown at runtime if `null`
  /// values are encountered, but the original class should also implement
  /// `null` runtime validation if it's critical.
  final bool nullable;

  /// Creates a new [JsonSerializable] instance.
  const JsonSerializable(
      {bool createFactory: true,
      bool createToJson: true,
      bool includeIfNull: true,
      bool nullable: true})
      : this.createFactory = createFactory ?? true,
        this.createToJson = createToJson ?? true,
        this.includeIfNull = includeIfNull ?? true,
        this.nullable = nullable ?? true;
}

/// An annotation used to specify how a field is serialized.
class JsonKey {
  /// The key in a JSON map to use when reading and writing values corresponding
  /// to the annotated fields.
  ///
  /// If `null`, the field name is used.
  final String name;

  /// When `true`, `null` values are handled gracefully when
  /// serializing the field to JSON and when deserializing `null` and
  /// nonexistent values from a JSON map.
  ///
  /// Setting to `false` eliminates `null` verification in the generated code
  /// for the annotated field, which reduces the code size. Errors may be thrown
  /// at runtime if `null` values are encountered, but the original class should
  /// also implement `null` runtime validation if it's critical.
  ///
  /// The default value, `null`, indicates that the behavior should be
  /// acquired from the [JsonSerializable.nullable] annotation on the
  /// enclosing class.
  final bool nullable;

  /// `true` if the generator should include the this field in the serialized
  /// output, even if the value is `null`.
  ///
  /// The default value, `null`, indicates that the behavior should be
  /// acquired from the [JsonSerializable.includeIfNull] annotation on the
  /// enclosing class.
  final bool includeIfNull;

  /// `true` if the generator should ignore this field completely.
  ///
  /// If `null` (the default) or `false`, the field will be considered for
  /// serialization.
  final bool ignore;

  /// A top-level [Function] to use when deserializing the associated JSON
  /// value to the annotated field.
  ///
  /// The [Function] should take one argument that maps to the expected JSON
  /// value and return a value that can be assigned to the type of the annotated
  /// field.
  ///
  /// When creating a class that supports both `toJson` and `fromJson`
  /// (the default), you should also set [toJson] if you set [fromJson].
  /// Values returned by [toJson] should "round-trip" through [fromJson].
  final Function fromJson;

  /// A top-level [Function] to use when serializing the annotated field to
  /// JSON.
  ///
  /// The [Function] should take one argument that is compatible with the field
  /// being serialized and return a JSON-compatible value.
  ///
  /// When creating a class that supports both `toJson` and `fromJson`
  /// (the default), you should also set [fromJson] if you set [toJson].
  /// Values returned by [toJson] should "round-trip" through [fromJson].
  final Function toJson;

  /// The value to use if the source JSON does not contain this key or if the
  /// value is `null`.
  final Object defaultValue;

  /// Creates a new [JsonKey] instance.
  ///
  /// Only required when the default behavior is not desired.
  const JsonKey(
      {this.name,
      this.nullable,
      this.includeIfNull,
      this.ignore,
      this.fromJson,
      this.toJson,
      this.defaultValue});
}

// Until enum supports parse: github.com/dart-lang/sdk/issues/33244
/// Helper class used in generated code with `enum` values.
///
/// Should not be used directly.
T $enumDecode<T>(String enumName, List<T> values, String enumValue) =>
    values.singleWhere((e) => e.toString() == '$enumName.$enumValue',
        orElse: () => throw new ArgumentError(
            '`$enumValue` is not one of the supported values: '
            '${values.map(_nameForEnumValue).join(', ')}'));

/// Helper class used in generated code with nullable `enum` values.
///
/// Should not be used directly.
T $enumDecodeNullable<T>(String enumName, List<T> values, String enumValue) =>
    enumValue == null ? null : $enumDecode(enumName, values, enumValue);

// Until enum has a name property: github.com/dart-lang/sdk/issues/21712
String _nameForEnumValue(Object value) => value.toString().split('.')[1];
