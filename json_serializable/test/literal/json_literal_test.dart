// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import '../test_file_utils.dart';
import '../test_utils.dart';
import 'json_literal.dart';

void main() {
  test('literal round-trip', () {
    var dataFilePath = testFilePath('test', 'literal', 'json_literal.json');
    var dataFile = new File(dataFilePath);

    var dataString = loudEncode(json.decode(dataFile.readAsStringSync()));
    // FYI: nice to re-write the test data when it's changed to keep it pretty
    // ... but not a good idea to ship this
    // dataFile.writeAsStringSync(dataString.replaceAll('\u007F', '\\u007F'));
    var dartString = loudEncode(data);

    expect(dartString, dataString);
  });

  test('naughty strings', () {
    var dataFilePath =
        testFilePath('test', 'literal', 'big-list-of-naughty-strings.json');
    var dataFile = new File(dataFilePath);

    var dataString = loudEncode(json.decode(dataFile.readAsStringSync()));
    var dartString = loudEncode(naughtyStrings);

    expect(dartString, dataString);
  });
}
