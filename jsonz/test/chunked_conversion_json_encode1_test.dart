// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import "package:expect/expect.dart";
import 'package:test/test.dart';
import 'package:jsonz/jsonz.dart';

import 'test_values.dart';

class MyStringConversionSink extends StringConversionSinkBase {
  final _buffer = new StringBuffer();
  var callback;

  MyStringConversionSink(this.callback);

  @override
  addSlice(str, start, end, bool isLast) {
    _buffer.write(str.substring(start, end));
    if (isLast) close();
  }

  @override
  close() {
    callback(_buffer.toString());
  }
}

String encode(Object o) {
  String result;
  ChunkedConversionSink<String> stringSink =
      new MyStringConversionSink((x) => result = x as String);
  var objectSink = new JsonEncoder().startChunkedConversion(stringSink);
  objectSink.add(o);
  objectSink.close();
  return result;
}

String encode2(Object o) {
  String result;
  var encoder = new JsonEncoder();
  ChunkedConversionSink<String> stringSink =
      new StringConversionSink.withCallback((x) => result = x);
  var objectSink = encoder.startChunkedConversion(stringSink);
  objectSink.add(o);
  objectSink.close();
  return result;
}

main() {
  for (var value in testValues) {
    test('foo', () {
      var o = value[0];
      var expected = value[1];
      Expect.equals(expected, encode(o));
      Expect.equals(expected, encode2(o));
    });
  }
}
