// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:async';

import 'package:test/test.dart';
import 'package:json/json.dart';

import 'test_util.dart';
import 'unicode_test_values.dart';

final _jsonUtf8 = json.fuse<List<int>>(utf8);

Stream<Object> _createStream(List<List<int>> chunks) {
  StreamController controller;
  controller = new StreamController<List<int>>(onListen: () {
    chunks.forEach(controller.add);
    controller.close();
  });
  return controller.stream.transform(_jsonUtf8.decoder);
}

Stream<Object> _decode(List<int> bytes) => _createStream([bytes]);

Stream<Object> _decodeChunked(List<int> bytes, int chunkSize) {
  var chunked = <List<int>>[];
  var i = 0;
  while (i < bytes.length) {
    if (i + chunkSize <= bytes.length) {
      chunked.add(bytes.sublist(i, i + chunkSize));
    } else {
      chunked.add(bytes.sublist(i));
    }
    i += chunkSize;
  }
  return _createStream(chunked);
}

main() {
  testAll<Pair>(jsonUnicodeTests, (value) async {
    expect(await _decode(value.bytes).single, value.target);
    expect(await _decodeChunked(value.bytes, 1).single, value.target);
    expect(await _decodeChunked(value.bytes, 2).single, value.target);
    expect(await _decodeChunked(value.bytes, 3).single, value.target);
    expect(await _decodeChunked(value.bytes, 4).single, value.target);
    expect(await _decodeChunked(value.bytes, 5).single, value.target);
  });
}
