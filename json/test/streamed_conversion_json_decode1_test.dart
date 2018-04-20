// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:async';

import 'package:test/test.dart';
import 'package:json/json.dart';

import 'test_util.dart';
import 'test_values.dart';

final _decoder = const MyJsonDecoder();

Stream<Object> createStream(List<String> chunks) {
  StreamController controller;
  controller = new StreamController<String>(onListen: () {
    chunks.forEach(controller.add);
    controller.close();
  });
  return controller.stream.transform(_decoder);
}

Stream<Object> decode(String str) {
  return createStream([str]);
}

Stream<Object> decode2(String str) {
  return createStream(str.split(""));
}

void checkIsJsonEqual(expected, Stream stream) {
  stream.single.then(expectAsync1((o) {
    expect(o, expected);
  }));
}

void main() {
  testAll<List>(expandedTestValues, (value) {
    var o = value[0];
    var string = value[1] as String;
    checkIsJsonEqual(o, decode(string));
    checkIsJsonEqual(o, decode2(string));
  });
}
