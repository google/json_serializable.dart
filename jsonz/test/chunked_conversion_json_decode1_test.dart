// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import "package:expect/expect.dart";
import 'package:test/test.dart';
import 'package:jsonz/jsonz.dart';

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

Object decode(String str) {
  Object result;
  var decoder = new MyJsonDecoder();
  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = decoder.startChunkedConversion(objectSink);
  stringConversionSink.add(str);
  stringConversionSink.close();
  return result;
}

Object decode2(String str) {
  Object result;
  var decoder = new MyJsonDecoder();
  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = decoder.startChunkedConversion(objectSink);
  ClosableStringSink stringSink = stringConversionSink.asStringSink();
  stringSink.write(str);
  stringSink.close();
  return result;
}

Object decode3(String str) {
  Object result;
  var decoder = new MyJsonDecoder();
  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = decoder.startChunkedConversion(objectSink);
  ClosableStringSink stringSink = stringConversionSink.asStringSink();
  str.codeUnits.forEach(stringSink.writeCharCode);
  stringSink.close();
  return result;
}

Object decode4(String str) {
  Object result;
  var decoder = new MyJsonDecoder();
  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = decoder.startChunkedConversion(objectSink);
  ClosableStringSink stringSink = stringConversionSink.asStringSink();
  str.runes.forEach(stringSink.writeCharCode);
  stringSink.close();
  return result;
}

Object decode5(String str) {
  Object result;
  var decoder = new MyJsonDecoder();
  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = decoder.startChunkedConversion(objectSink);
  ByteConversionSink inputByteSink = stringConversionSink.asUtf8Sink(false);
  var tmpBytes = utf8.encode(str);
  inputByteSink.add(tmpBytes);
  inputByteSink.close();
  return result;
}

Object decode6(String str) {
  Object result;
  var decoder = new MyJsonDecoder();
  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = decoder.startChunkedConversion(objectSink);
  ByteConversionSink inputByteSink = stringConversionSink.asUtf8Sink(false);
  var tmpBytes = utf8.encode(str);
  tmpBytes.forEach((b) => inputByteSink.addSlice([0, b, 1], 1, 2, false));
  inputByteSink.close();
  return result;
}

Object decode7(String str) {
  Object result;
  var decoder = new MyJsonDecoder();
  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = decoder.startChunkedConversion(objectSink);
  stringConversionSink.addSlice("1" + str + "2", 1, str.length + 1, false);
  stringConversionSink.close();
  return result;
}

main() {
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
      Expect.isTrue(isJsonEqual(o, decode(string)));
      Expect.isTrue(isJsonEqual(o, decode2(string)));
      Expect.isTrue(isJsonEqual(o, decode3(string)));
      Expect.isTrue(isJsonEqual(o, decode4(string)));
      Expect.isTrue(isJsonEqual(o, decode5(string)));
      Expect.isTrue(isJsonEqual(o, decode6(string)));
      Expect.isTrue(isJsonEqual(o, decode7(string)));
    });
  }
}
