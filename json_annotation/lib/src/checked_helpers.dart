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
    throw new CheckedFromJsonException._(error, stack, map, key, T,
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
    throw new CheckedFromJsonException._(error, stack, map, key, T);
  }
}

/// Exception thrown if there is a runtime exception in `fromJson`
/// code generated when `JsonSerializableGenerator.checked` is `true`
class CheckedFromJsonException implements Exception {
  final Object innerError;
  final StackTrace innerStack;
  final String key;
  final Map map;
  final Type targetType;
  final Object message;

  String _className;
  String get className => _className;

  CheckedFromJsonException._(
      this.innerError, this.innerStack, this.map, this.key, this.targetType,
      {String className})
      : _className = className,
        message = _getMessage(innerError);

  static Object _getMessage(Object error) =>
      (error is ArgumentError) ? error.message : null;
}
