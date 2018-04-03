// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

/// An annotation used to specify a class to generate code for.
class JsonSerializable {
  // TODO(kevmoo): document these fields
  final bool createFactory;
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

  // TODO(kevmoo): document the constructor
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

  /// Creates a new [JsonKey].
  ///
  /// Only required when the default behavior is not desired.
  const JsonKey({this.name, this.nullable, this.includeIfNull, this.ignore});
}

/// Helper classes used in generated code when
/// `JsonSerializableGenerator.useWrappers` is `true`.
///
/// Should not be used directly.
abstract class $JsonMapWrapper extends UnmodifiableMapBase<String, dynamic> {}

/// Helper function used in generated code when
/// `JsonSerializableGenerator.useWrappers` is `true`.
///
/// Should not be used directly.
Map<String, dynamic> $wrapMap<K, V>(
        Map<K, V> source, dynamic converter(V key)) =>
    new _MappingMap(source, converter);

/// Helper function used in generated code when
/// `JsonSerializableGenerator.useWrappers` is `true`.
///
/// Should not be used directly.
Map<String, dynamic> $wrapMapHandleNull<K, V>(
        Map<K, V> source, dynamic converter(V key)) =>
    source == null ? null : new _MappingMap(source, converter);

/// Helper function used in generated code when
/// `JsonSerializableGenerator.useWrappers` is `true`.
///
/// Should not be used directly.
List<dynamic> $wrapList<T>(List<T> source, dynamic converter(T key)) =>
    new _MappingList(source, converter);

/// Helper function used in generated code when
/// `JsonSerializableGenerator.useWrappers` is `true`.
///
/// Should not be used directly.
List<dynamic> $wrapListHandleNull<T>(
        List<T> source, dynamic converter(T key)) =>
    source == null ? null : new _MappingList(source, converter);

typedef dynamic _Convert<S>(S value);

class _MappingList<S> extends ListBase<dynamic> {
  final List<S> _source;
  final _Convert<S> _converter;

  _MappingList(this._source, this._converter);

  @override
  dynamic operator [](int index) => _converter(_source[index]);

  @override
  operator []=(int index, dynamic value) => throw new UnsupportedError('');

  @override
  int get length => _source.length;

  @override
  set length(int value) => throw new UnsupportedError('');
}

class _MappingMap<K, V> extends UnmodifiableMapBase<String, dynamic> {
  final Map<K, V> _source;
  final _Convert<V> _converter;

  _MappingMap(this._source, this._converter);

  @override
  Iterable<String> get keys => _source.keys.map((k) => k as String);

  @override
  dynamic operator [](Object key) => _converter(_source[key]);
}
