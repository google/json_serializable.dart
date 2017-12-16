// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:async';

import 'package:test/test.dart';
import 'package:json/json.dart';

import 'unicode_test_values.dart';

final _jsonUtf8 = json.fuse<List<int>>(utf8);

Stream<List<int>> _encode(Object o) {
  StreamController controller;
  controller = new StreamController(onListen: () {
    controller.add(o);
    controller.close();
  });
  return controller.stream.transform(_jsonUtf8.encoder);
}

Future _testUnpaused(List<int> expected, Stream<List<int>> stream) async {
  final list = await stream.toList();
  var combined = <int>[];
  list.forEach(combined.addAll);
  expect(combined, equals(expected));
}

Future _testWithPauses(List<int> expected, Stream<List<int>> stream) async {
  var accumulated = <int>[];
  StreamSubscription sub;

  sub = stream.listen((x) {
    accumulated.addAll(x);
    sub.pause(new Future.delayed(Duration.zero));
  });

  await sub.asFuture();

  expect(accumulated, expected);
}

void main() {
  var count = 1;
  for (var value in jsonUnicodeTests) {
    test("test ${count++}", () async {
      await _testUnpaused(value.bytes, _encode(value.target));
      await _testWithPauses(value.bytes, _encode(value.target));
    });
  }
}
