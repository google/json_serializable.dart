// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: prefer_single_quotes

import 'package:json/json.dart';
import 'package:test/test.dart';

import "src/expect.dart";

main() {
  test('toEncodable', () {
    var map = {"a": 42, "b": 42, 37: 42}; // Non-string key.
    var enc = new JsonEncoder(toEncodable: (_) => "fixed");
    var res = enc.convert(map);
    Expect.equals('"fixed"', res);

    enc = new JsonEncoder(indent: " ", toEncodable: (_) => "fixed");
    res = enc.convert(map);
    Expect.equals('"fixed"', res);
  });
}
