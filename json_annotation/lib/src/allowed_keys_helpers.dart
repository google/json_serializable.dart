// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Helper function used in generated code when
/// `JsonSerializable.disallowUnrecognizedKeys` is `true`.
///
/// Should not be used directly.
void $checkAllowedKeys(Map map, Iterable<String> allowedKeys) {
  if (map == null) return;
  var invalidKeys = map.keys.where((k) => !allowedKeys.contains(k));
  if (invalidKeys.isNotEmpty) {
    throw new UnrecognizedKeysException(
        new List<String>.from(invalidKeys), map, allowedKeys.toList());
  }
}

/// Exception thrown if there are unrecognized keys in a JSON map that was
/// provided during deserialization.
class UnrecognizedKeysException implements Exception {
  /// The allowed keys for [map].
  final List<String> allowedKeys;

  /// The keys from [map] that were unrecognized.
  final List<String> unrecognizedKeys;

  /// The source [Map] that the unrecognized keys were found in.
  final Map map;

  /// A human-readable message corresponding to the error.
  String get message =>
      'Unrecognized keys: [${unrecognizedKeys.join(', ')}]; supported keys: '
      '[${allowedKeys.join(', ')}]';

  UnrecognizedKeysException(this.unrecognizedKeys, this.map, this.allowedKeys);
}
