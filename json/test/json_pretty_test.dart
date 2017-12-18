// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Note: This test relies on LF line endings in the source file.
// It requires an entry in the .gitattributes file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'package:test/test.dart';
import 'package:json/json.dart';

import "src/expect.dart";

void main() {
  test('pretty', () {
    var encoder = const JsonEncoder(indent: '\x00');
    var encoded = encoder.convert([
      [],
      [[]]
    ]);
    Expect.equals("[\n\x00[],\n\x00[\n\x00\x00[]\n\x00]\n]", encoded);
  });

  _expect(null, 'null');

  _expect([
    [],
    [[]]
  ], '''
[
  [],
  [
    []
  ]
]''');

  _expect([1, 2, 3, 4], '''
[
  1,
  2,
  3,
  4
]''');

  _expect([true, null, 'hello', 42.42], '''
[
  true,
  null,
  "hello",
  42.42
]''');

  _expect({"hello": [], "goodbye": {}}, '''{
  "hello": [],
  "goodbye": {}
}''');

  _expect([
    "test",
    1,
    2,
    33234.324,
    true,
    false,
    null,
    {
      "test1": "test2",
      "test3": "test4",
      "grace": 5,
      "shanna": [0, 1, 2]
    },
    {
      "lib": "app.dart",
      "src": ["foo.dart", "bar.dart"]
    }
  ], '''[
  "test",
  1,
  2,
  33234.324,
  true,
  false,
  null,
  {
    "test1": "test2",
    "test3": "test4",
    "grace": 5,
    "shanna": [
      0,
      1,
      2
    ]
  },
  {
    "lib": "app.dart",
    "src": [
      "foo.dart",
      "bar.dart"
    ]
  }
]''');
}

void _expect(Object object, String expected) {
  test('pretty', () {
    var encoder = const JsonEncoder(indent: '  ');
    var prettyOutput = encoder.convert(object);

    expect(prettyOutput, expected);

    encoder = const JsonEncoder(indent: '');

    var flatOutput = encoder.convert(object);

    var flatExpected = const LineSplitter()
        .convert(expected)
        .map((line) => line.trimLeft())
        .join('\n');

    Expect.equals(flatExpected, flatOutput);

    var compactOutput = json.encode(object);

    encoder = const JsonEncoder(indent: null);
    Expect.equals(compactOutput, encoder.convert(object));

    var prettyDecoded = json.decode(prettyOutput);

    Expect.equals(compactOutput, json.encode(prettyDecoded));
  });
}
