// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'package:json/json.dart';
import 'package:test/test.dart';

import 'test_util.dart';
import 'test_values.dart';

final _decoder = new MyJsonDecoder();

Object decode(String str) {
  Object result;

  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = _decoder.startChunkedConversion(objectSink);
  stringConversionSink.add(str);
  stringConversionSink.close();
  return result;
}

Object decode2(String str) {
  Object result;

  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = _decoder.startChunkedConversion(objectSink);
  ClosableStringSink stringSink = stringConversionSink.asStringSink();
  stringSink.write(str);
  stringSink.close();
  return result;
}

Object decode3(String str) {
  Object result;

  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = _decoder.startChunkedConversion(objectSink);
  ClosableStringSink stringSink = stringConversionSink.asStringSink();
  str.codeUnits.forEach(stringSink.writeCharCode);
  stringSink.close();
  return result;
}

Object decode4(String str) {
  Object result;

  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = _decoder.startChunkedConversion(objectSink);
  ClosableStringSink stringSink = stringConversionSink.asStringSink();
  str.runes.forEach(stringSink.writeCharCode);
  stringSink.close();
  return result;
}

Object decode5(String str) {
  Object result;

  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = _decoder.startChunkedConversion(objectSink);
  ByteConversionSink inputByteSink = stringConversionSink.asUtf8Sink(false);
  var tmpBytes = utf8.encode(str);
  inputByteSink.add(tmpBytes);
  inputByteSink.close();
  return result;
}

Object decode6(String str) {
  Object result;

  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = _decoder.startChunkedConversion(objectSink);
  ByteConversionSink inputByteSink = stringConversionSink.asUtf8Sink(false);
  var tmpBytes = utf8.encode(str);
  tmpBytes.forEach((b) => inputByteSink.addSlice([0, b, 1], 1, 2, false));
  inputByteSink.close();
  return result;
}

Object decode7(String str) {
  Object result;

  ChunkedConversionSink objectSink =
      new ChunkedConversionSink.withCallback((x) => result = x.single);
  var stringConversionSink = _decoder.startChunkedConversion(objectSink);
  stringConversionSink.addSlice("1" + str + "2", 1, str.length + 1, false);
  stringConversionSink.close();
  return result;
}

main() {
  testAll<List>(expandedTestValues, (value) {
    var o = value[0];
    var string = value[1] as String;
    expect(decode(string), o);
    expect(decode2(string), o);
    expect(decode3(string), o);
    expect(decode4(string), o);
    expect(decode5(string), o);
    expect(decode6(string), o);
    expect(decode7(string), o);
  });
}
