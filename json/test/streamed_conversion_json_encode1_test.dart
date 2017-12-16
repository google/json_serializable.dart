// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:async';

import "package:expect/expect.dart";

import 'package:test/test.dart';
import 'package:json/json.dart';

import 'test_values.dart';

Stream<String> encode(Object o) {
  var encoder = new JsonEncoder();
  StreamController controller;
  controller = new StreamController(onListen: () {
    controller.add(o);
    controller.close();
  });
  return controller.stream.transform(encoder);
}

void testNoPause(String expected, Object o) {
  Stream stream = encode(o);
  stream.toList().then(expectAsync1((list) {
    StringBuffer buffer = new StringBuffer();
    buffer.writeAll(list);
    Expect.stringEquals(expected, buffer.toString());
  }));
}

void testWithPause(String expected, Object o) {
  Stream stream = encode(o);
  StringBuffer buffer = new StringBuffer();
  var sub;
  sub = stream.listen((x) {
    buffer.write(x);
    sub.pause(new Future.delayed(Duration.zero));
  }, onDone: expectAsync0(() {
    Expect.stringEquals(expected, buffer.toString());
  }));
}

void main() {
  for (var value in testValues) {
    test('foo', () {
      var o = value[0];
      var expected = value[1] as String;
      testNoPause(expected, o);
      testWithPause(expected, o);
    });
  }
}
