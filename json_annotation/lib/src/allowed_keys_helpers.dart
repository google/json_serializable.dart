// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Helper function used in generated code when
/// `JsonAnnotation.allowUnrecognizedKeys` is `false`.
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

/// Exception thrown if there is an unrecognized key in a json map that was
/// provided during deserialization.
class UnrecognizedKeysException implements Exception {
  /// The allowed keys for [map].
  final List<String> allowedKeys;

  /// The keys from [map] that were unrecognized.
  final List<String> unrecognizedKeys;

  /// The source [Map] that the key was found in.
  final Map map;

  /// A human-readable message corresponding to the error.
  String get message =>
      'Unrecognized keys [${unrecognizedKeys.join(', ')}], supported keys  are '
      '[${allowedKeys.join(', ')}]';

  UnrecognizedKeysException(this.unrecognizedKeys, this.map, this.allowedKeys);
}
