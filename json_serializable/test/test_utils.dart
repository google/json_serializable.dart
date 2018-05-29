// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

final isACastError = const isInstanceOf<CastError>();

// TODO(kevmoo) add this to pkg/matcher – is nice!
class FeatureMatcher<T> extends CustomMatcher {
  final dynamic Function(T value) _feature;

  FeatureMatcher(String name, this._feature, matcher)
      : super('`$name`', '`$name`', matcher);

  @override
  featureValueOf(covariant T actual) => _feature(actual);
}

T roundTripObject<T>(T object, T factory(Map<String, dynamic> json)) {
  var data = loudEncode(object);

  var object2 = factory(json.decode(data) as Map<String, dynamic>);

  expect(object2, equals(object));

  var json2 = loudEncode(object2);

  expect(json2, equals(data));
  return object2;
}

/// Prints out nested causes before throwing `JsonUnsupportedObjectError`.
String loudEncode(Object object) {
  try {
    return const JsonEncoder.withIndent(' ').convert(object);
  } on JsonUnsupportedObjectError catch (e) {
    var error = e;
    do {
      var cause = error.cause;
      print(cause);
      error = (cause is JsonUnsupportedObjectError) ? cause : null;
    } while (error != null);
    rethrow;
  }
}
