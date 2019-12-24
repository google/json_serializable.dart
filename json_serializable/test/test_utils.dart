// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

final throwsCastError = throwsA(isCastError);

T roundTripObject<T>(T object, T Function(Map<String, dynamic> json) factory) {
  final data = loudEncode(object);

  final object2 = factory(json.decode(data) as Map<String, dynamic>);

  expect(object2, equals(object));

  final json2 = loudEncode(object2);

  expect(json2, equals(data));
  return object2;
}

R roundTripDisparateObjects<R, T>(
    T input,
    R Function(Map<String, dynamic> json) factory,
    Map<String, dynamic> missingKeys) {
  final data = loudEncode(input);

  final inputMap = json.decode(data) as Map<String, dynamic>;

  final result = factory(inputMap);

  final output = loudEncode(result);

  // now check the inputMap with the missing keys added back in
  // match the output map.
  final outputMap = json.decode(output) as Map<String, dynamic>;
  outputMap.addAll(missingKeys);
  expect(inputMap, equals(outputMap));

  return result;
}

/// Prints out nested causes before throwing `JsonUnsupportedObjectError`.
String loudEncode(Object object) {
  try {
    return const JsonEncoder.withIndent(' ').convert(object);
  } on JsonUnsupportedObjectError catch (e) {
    var error = e;
    do {
      final cause = error.cause;
      print(cause);
      error = (cause is JsonUnsupportedObjectError) ? cause : null;
    } while (error != null);
    rethrow;
  }
}
