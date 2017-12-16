// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'package:expect/expect.dart';
import 'package:test/test.dart';

import 'package:json/json.dart';

class A {
  final x;
  A(this.x);
}

toEncodable(a) => {"A": (a as A).x};

const extendedJson = const MyJsonCodec(toEncodable: toEncodable);

main() {
  test('foo', () {
    var map = {"a": 42, "b": 42, 37: 42}; // Non-string key.
    var enc = new JsonEncoder((_) => "fixed");
    var res = enc.convert(map);
    Expect.equals('"fixed"', res);

    enc = new JsonEncoder.withIndent(" ", (_) => "fixed");
    res = enc.convert(map);
    Expect.equals('"fixed"', res);
  });
}
