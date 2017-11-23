// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:async';

import "package:expect/expect.dart";
import 'package:test/test.dart';
import 'package:jsonz/jsonz.dart';

import 'json_unicode_tests.dart';

final jsonUtf8 = json.fuse<List<int>>(utf8);

Stream<List<int>> encode(Object o) {
  StreamController controller;
  controller = new StreamController(onListen: () {
    controller.add(o);
    controller.close();
  });
  return controller.stream.transform(jsonUtf8.encoder);
}

void testUnpaused(List<int> expected, Stream<List<int>> stream) {
  stream.toList().then(expectAsync1((list) {
    var combined = <int>[];
    list.forEach(combined.addAll);
    Expect.listEquals(expected, combined);
  }));
}

void testWithPauses(List<int> expected, Stream<List<int>> stream) {
  var accumulated = <int>[];
  var sub;
  sub = stream.listen((x) {
    accumulated.addAll(x);
    sub.pause(new Future.delayed(Duration.zero));
  }, onDone: expectAsync0(() {
    Expect.listEquals(expected, accumulated);
  }));
}

void main() {
  for (var value in jsonUnicodeTests) {
    test("foo", () {
      var expected = value[0] as List<int>;
      var object = value[1];
      testUnpaused(expected, encode(object));
      testWithPauses(expected, encode(object));
    });
  }
}
