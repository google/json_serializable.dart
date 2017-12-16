// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Test write barrier verification mode.
// VMOptions=--verify_before_gc --verify_after_gc --old_gen_growth_rate=1 --no-background-compilation
// VMOptions=

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:async';

import "package:expect/expect.dart";
import 'package:test/test.dart';
import 'package:json/json.dart';

import 'json_unicode_tests.dart';

final jsonUtf8 = json.fuse<List<int>>(utf8);

void expectJsonEquals(o1, o2, [path = "result"]) {
  if (o1 == o2) return;
  if (o1 is List && o2 is List) {
    Expect.equals(o1.length, o2.length, "$path.length");
    for (int i = 0; i < o1.length; i++) {
      expectJsonEquals(o1[i], o2[i], "$path[$i]");
    }
    return;
  }
  if (o1 is Map && o2 is Map) {
    Expect.equals(o1.length, o2.length, "$path.length");
    for (var key in o1.keys) {
      Expect.isTrue(key is String, "$path:key = $key");
      Expect.isTrue(o2.containsKey(key), "$path[$key] missing in $o2");
      expectJsonEquals(o1[key], o2[key], "$path[$key]");
    }
    return;
  }
  Expect.equals(o1, o2);
}

Stream<Object> createStream(List<List<int>> chunks) {
  StreamController controller;
  controller = new StreamController<List<int>>(onListen: () {
    chunks.forEach(controller.add);
    controller.close();
  });
  return controller.stream.transform(jsonUtf8.decoder);
}

Stream<Object> decode(List<int> bytes) {
  return createStream([bytes]);
}

Stream<Object> decodeChunked(List<int> bytes, int chunkSize) {
  List<List<int>> chunked = <List<int>>[];
  int i = 0;
  while (i < bytes.length) {
    if (i + chunkSize <= bytes.length) {
      chunked.add(bytes.sublist(i, i + chunkSize));
    } else {
      chunked.add(bytes.sublist(i));
    }
    i += chunkSize;
  }
  return createStream(chunked);
}

void checkIsJsonEqual(expected, Stream stream) {
  stream.single.then(expectAsync1((o) {
    expectJsonEquals(expected, o);
  }));
}

main() {
  for (var value in jsonUnicodeTests) {
    test('foo', () {
      var bytes = value[0] as List<int>;
      var o = value[1];
      checkIsJsonEqual(o, decode(bytes));
      checkIsJsonEqual(o, decodeChunked(bytes, 1));
      checkIsJsonEqual(o, decodeChunked(bytes, 2));
      checkIsJsonEqual(o, decodeChunked(bytes, 3));
      checkIsJsonEqual(o, decodeChunked(bytes, 4));
      checkIsJsonEqual(o, decodeChunked(bytes, 5));
    });
  }
}
