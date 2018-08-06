// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

/// Helper class used in generated code when
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
    _MappingMap(source, converter);

/// Helper function used in generated code when
/// `JsonSerializableGenerator.useWrappers` is `true`.
///
/// Should not be used directly.
Map<String, dynamic> $wrapMapHandleNull<K, V>(
        Map<K, V> source, dynamic converter(V key)) =>
    source == null ? null : _MappingMap(source, converter);

/// Helper function used in generated code when
/// `JsonSerializableGenerator.useWrappers` is `true`.
///
/// Should not be used directly.
List<dynamic> $wrapList<T>(List<T> source, dynamic converter(T key)) =>
    _MappingList(source, converter);

/// Helper function used in generated code when
/// `JsonSerializableGenerator.useWrappers` is `true`.
///
/// Should not be used directly.
List<dynamic> $wrapListHandleNull<T>(
        List<T> source, dynamic converter(T key)) =>
    source == null ? null : _MappingList(source, converter);

typedef dynamic _Convert<S>(S value);

class _MappingList<S> extends ListBase<dynamic> {
  final List<S> _source;
  final _Convert<S> _converter;

  _MappingList(this._source, this._converter);

  @override
  dynamic operator [](int index) => _converter(_source[index]);

  @override
  operator []=(int index, dynamic value) => throw UnsupportedError('');

  @override
  int get length => _source.length;

  @override
  set length(int value) => throw UnsupportedError('');
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
