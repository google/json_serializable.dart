// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:async';

import 'package:test/test.dart';
import 'package:json/json.dart';

import "src/expect.dart";
import 'test_values.dart';

bool isJsonEqual(o1, o2) {
  if (o1 == o2) return true;
  if (o1 is List && o2 is List) {
    if (o1.length != o2.length) return false;
    for (int i = 0; i < o1.length; i++) {
      if (!isJsonEqual(o1[i], o2[i])) return false;
    }
    return true;
  }
  if (o1 is Map && o2 is Map) {
    if (o1.length != o2.length) return false;
    for (var key in o1.keys) {
      Expect.isTrue(key is String);
      if (!o2.containsKey(key)) return false;
      if (!isJsonEqual(o1[key], o2[key])) return false;
    }
    return true;
  }
  return false;
}

Stream<Object> createStream(List<String> chunks) {
  var decoder = new MyJsonDecoder();
  StreamController controller;
  controller = new StreamController<String>(onListen: () {
    chunks.forEach(controller.add);
    controller.close();
  });
  return controller.stream.transform(decoder);
}

Stream<Object> decode(String str) {
  return createStream([str]);
}

Stream<Object> decode2(String str) {
  return createStream(str.split(""));
}

void checkIsJsonEqual(expected, Stream stream) {
  stream.single.then(expectAsync1((o) {
    Expect.isTrue(isJsonEqual(expected, o));
  }));
}

void main() {
  var tests = testValues.expand((test) {
    var object = test[0];
    var string = test[1];
    var longString = "                                                        "
        "                                                        "
        "$string"
        "                                                        "
        "                                                        ";
    return [
      test,
      [object, longString]
    ];
  });
  for (var value in tests) {
    test('foo', () {
      var o = value[0];
      var string = value[1] as String;
      checkIsJsonEqual(o, decode(string));
      checkIsJsonEqual(o, decode2(string));
    });
  }
}
