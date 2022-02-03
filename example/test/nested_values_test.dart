// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_json_serial_shared_test/shared_test.dart';
import 'package:example/nested_values_example.dart';
import 'package:test/test.dart';

void main() {
  test('NestedValueExample', () {
    final input = jsonDecode(_input) as Map<String, dynamic>;
    final normalizedOutput = loudEncode(input);

    final instance = NestedValueExample.fromJson(input);

    expect(loudEncode(instance), normalizedOutput);
  });
}

const _input = r'''
{
  "root_items": {
      "items": [
          {
              "name": "first nested item"
          },
          {
              "name": "second nested item"
          }
      ]
  }
}
''';
