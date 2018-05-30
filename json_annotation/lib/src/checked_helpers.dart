// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Helper function used in generated code when
/// `JsonSerializableGenerator.checked` is `true`.
///
/// Should not be used directly.
T $checkedNew<T>(String className, Map map, T constructor(),
    {Map<String, String> fieldKeyMap}) {
  fieldKeyMap ??= const {};

  try {
    return constructor();
  } on CheckedFromJsonException catch (e) {
    if (e._className == null) {
      e._className = className;
      assert(identical(e.map, map));
    }
    rethrow;
  } catch (error, stack) {
    String key;
    if (error is ArgumentError) {
      key = fieldKeyMap[error.name] ?? error.name;
    }
    throw new CheckedFromJsonException(error, stack, map, key,
        className: className);
  }
}

/// Helper function used in generated code when
/// `JsonSerializableGenerator.checked` is `true`.
///
/// Should not be used directly.
T $checkedConvert<T>(Map map, String key, T castFunc(Object value)) {
  try {
    return castFunc(map[key]);
  } on CheckedFromJsonException {
    rethrow;
  } catch (error, stack) {
    throw new CheckedFromJsonException(error, stack, map, key);
  }
}

/// Exception thrown if there is a runtime exception in `fromJson`
/// code generated when `JsonSerializableGenerator.checked` is `true`
class CheckedFromJsonException implements Exception {
  /// The [Error] or [Exception] that triggered this exception.
  final Object innerError;

  /// The [StackTrace] for the [Error] or [Exception] that triggered this
  /// exception.
  final StackTrace innerStack;

  /// The key from [map] that corresponds to the thrown [innerError].
  ///
  /// May be `null`.
  final String key;

  /// The source [Map] that was used for decoding when the [innerError] was
  /// thrown.
  final Map map;

  /// A human-readable message corresponding to [innerError].
  ///
  /// May be `null`.
  final String message;

  /// The name of the class being created when [innerError] was thrown.
  String get className => _className;
  String _className;

  /// Creates a new instance of [CheckedFromJsonException].
  CheckedFromJsonException(this.innerError, this.innerStack, this.map, this.key,
      {String className})
      : _className = className,
        message = _getMessage(innerError);

  static String _getMessage(Object error) =>
      (error is ArgumentError) ? error.message?.toString() : null;
}
