// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

import 'json_serializable_generator.dart';

/// Represents the configuration for [JsonSerializableGenerator].
class GeneratorConfig {
  /// If `true`, [Map] types are *not* assumed to be [Map<String, dynamic>]
  /// – which is the default type of [Map] instances return by JSON decode in
  /// `dart:convert`.
  ///
  /// This will increase the code size, but allows [Map] types returned
  /// from other sources, such as `package:yaml`.
  ///
  /// *Note: in many cases the key values are still assumed to be [String]*.
  final bool anyMap;

  /// If `true`, wrappers are used to minimize the number of
  /// [Map] and [List] instances created during serialization.
  ///
  /// This will increase the code size, but it may improve runtime performance,
  /// especially for large object graphs.
  final bool useWrappers;

  /// If `true`, generated `fromJson` functions include extra checks to validate
  /// proper deserialization of types.
  ///
  /// If an exception is thrown during deserialization, a
  /// [CheckedFromJsonException] is thrown.
  final bool checked;

  /// If `true`, generated `toJson` methods will explicitly call `toJson` on
  /// nested objects.
  ///
  /// When using JSON encoding support in `dart:convert`, `toJson` is
  /// automatically called on objects, so the default behavior
  /// (`explicitToJson: false`) is to omit the `toJson` call.
  ///
  /// Example of `explicitToJson: false` (default)
  ///
  /// ```dart
  /// Map<String, dynamic> toJson() => {'child': child};
  /// ```
  ///
  /// Example of `explicitToJson: true`
  ///
  /// ```dart
  /// Map<String, dynamic> toJson() => {'child': child?.toJson()};
  /// ```
  final bool explicitToJson;

  /// Controls how `toJson` functionality is generated for all types processed
  /// by this generator.
  ///
  /// If `true` (the default), then a top-level function is created that you can reference
  /// from your class.
  ///
  /// ```dart
  /// @JsonSerializable()
  /// class Example {
  ///   // ...
  ///   Map<String, dynamic> toJson() => _$ExampleToJson(this);
  /// }
  /// ```
  ///
  /// If `false`, a private `_$ClassNameSerializerMixin` class is
  /// created in the generated part file which contains a `toJson` method.
  ///
  /// Mix in this class to the source class:
  ///
  /// ```dart
  /// @JsonSerializable()
  /// class Example extends Object with _$ExampleSerializerMixin {
  ///   // ...
  /// }
  /// ```
  final bool generateToJsonFunction;

  const GeneratorConfig({
    bool anyMap = false,
    bool checked = false,
    bool explicitToJson = false,
    bool generateToJsonFunction = true,
    bool useWrappers = false,
  })  : this.anyMap = anyMap ?? false,
        this.checked = checked ?? false,
        this.explicitToJson = explicitToJson ?? false,
        this.generateToJsonFunction = generateToJsonFunction ?? true,
        this.useWrappers = useWrappers ?? false;
}
