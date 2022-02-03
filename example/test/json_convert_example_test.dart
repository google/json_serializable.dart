// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_json_serial_shared_test/shared_test.dart';
import 'package:example/json_converter_example.dart';
import 'package:test/test.dart';

void main() {
  test('DateTime epoch', () {
    const value = 42;

    final epochDateTime = DateTime.fromMillisecondsSinceEpoch(value);
    final instance = DateTimeExample(epochDateTime);
    final json = loudEncode(instance);
    expect(json, '''{
 "when": $value
}''');

    final copy =
        DateTimeExample.fromJson(jsonDecode(json) as Map<String, dynamic>);
    expect(copy.when, epochDateTime);
  });

  test('trivial case', () {
    final collection = GenericCollection<int>(
        page: 0, totalPages: 3, totalResults: 10, results: [1, 2, 3]);

    final encoded = loudEncode(collection);
    final collection2 = GenericCollection<int>.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>);

    expect(collection2.results, [1, 2, 3]);

    expect(loudEncode(collection2), encoded);
  });

  test('custom result', () {
    final collection = GenericCollection<CustomResult>(
        page: 0,
        totalPages: 3,
        totalResults: 10,
        results: [CustomResult('bob', 42)]);

    final encoded = loudEncode(collection);
    final collection2 = GenericCollection<CustomResult>.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>);

    expect(collection2.results, [CustomResult('bob', 42)]);

    expect(loudEncode(collection2), encoded);
  });

  test('mixed values in generic collection', () {
    final collection =
        GenericCollection(page: 0, totalPages: 3, totalResults: 10, results: [
      1,
      3.14,
      null,
      'bob',
      ['list'],
      {'map': 'map'},
      CustomResult('bob', 42)
    ]);

    final encoded = loudEncode(collection);

    expect(
      () => GenericCollection<CustomResult>.fromJson(
          jsonDecode(encoded) as Map<String, dynamic>),
      throwsTypeError,
    );
    expect(
      () => GenericCollection<int>.fromJson(
          jsonDecode(encoded) as Map<String, dynamic>),
      throwsTypeError,
    );
    expect(
      () => GenericCollection<String>.fromJson(
          jsonDecode(encoded) as Map<String, dynamic>),
      throwsTypeError,
    );

    final collection2 =
        GenericCollection.fromJson(jsonDecode(encoded) as Map<String, dynamic>);

    expect(collection2.results, [
      1,
      3.14,
      null,
      'bob',
      ['list'],
      {'map': 'map'},
      CustomResult('bob', 42)
    ]);

    expect(loudEncode(collection2), encoded);
  });
}
