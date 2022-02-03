// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_json_serial_shared_test/shared_test.dart';
import 'package:example/tuple_example.dart';
import 'package:test/test.dart';

void main() {
  test('ConcreteClass', () {
    final instance = ConcreteClass(
      Tuple(1, DateTime.fromMillisecondsSinceEpoch(24).toUtc()),
      Tuple(const Duration(seconds: 42), BigInt.two),
    );

    final encoded = loudEncode(instance);

    const expected = r'''
{
 "tuple1": {
  "value1": 1,
  "value2": "1970-01-01T00:00:00.024Z"
 },
 "tuple2": {
  "value1": 42000000,
  "value2": "2"
 }
}''';

    expect(encoded, expected);
    final decoded = ConcreteClass.fromJson(
      jsonDecode(encoded) as Map<String, dynamic>,
    );
    final encoded2 = loudEncode(decoded);
    expect(encoded2, encoded);
  });
}
