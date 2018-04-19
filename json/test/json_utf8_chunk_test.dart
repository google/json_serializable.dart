// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes,omit_local_variable_types

import 'package:test/test.dart' as t;
import 'package:json/json.dart';

import "src/expect.dart";
import "unicode_values.dart" show unicodeTests;

main() {
  _testNumbers();
  _testStrings();
  _testKeywords();
  _testAll();
  _testMalformed();
  _testUnicodeTests();
}

// Create an UTF-8 sink from a chunked JSON decoder, then let [action]
// put data into it, and check that what comes out is equal to [expect].
void _jsonTest(String testName, Object expect, action(ByteConversionSink sink),
    [bool allowMalformed = false]) {
  _jsonParse(testName, (value) {
    Expect.equals(expect, value, "$testName:$value");
  }, action, allowMalformed);
}

void _jsonParse(
    String testName, void check(Object arg), action(ByteConversionSink sink),
    [bool allowMalformed = false]) {
  var sink = new ChunkedConversionSink.withCallback((values) {
    var value = values[0];
    check(value);
  });
  var decoderSink =
      json.decoder.startChunkedConversion(sink).asUtf8Sink(allowMalformed);
  t.test(testName, () {
    try {
      action(decoderSink);
    } on FormatException catch (e, s) {
      print("Source: ${e.source} @ ${e.offset}");
      Expect.fail("Unexpected throw($testName): $e\n$s");
    }
  });
}

void _testStrings() {
  // String literal containing characters, all escape types,
  // and a number of UTF-8 encoded characters.
  var s = r'"abc\f\ndef\r\t\b\"\/\\\u0001\u9999\uffff'
      '\x7f\xc2\x80\xdf\xbf\xe0\xa0\x80\xef\xbf\xbf'
      '\xf0\x90\x80\x80\xf4\x8f\xbf\xbf"'; // UTF-8.
  var expected = "abc\f\ndef\r\t\b\"\/\\\u0001\u9999\uffff"
      "\x7f\x80\u07ff\u0800\uffff"
      "\u{10000}\u{10ffff}";
  for (var i = 1; i < s.length - 1; i++) {
    var s1 = s.substring(0, i);
    var s2 = s.substring(i);
    _jsonTest("$s1|$s2-$i", expected, (sink) {
      sink.add(s1.codeUnits);
      sink.add(s2.codeUnits);
      sink.close();
    });
    _jsonTest("$s1|$s2-$i-slice", expected, (sink) {
      sink.addSlice(s.codeUnits, 0, i, false);
      sink.addSlice(s.codeUnits, i, s.length, true);
    });
    for (var j = i; j < s.length - 1; j++) {
      var s2a = s.substring(i, j);
      var s2b = s.substring(j);
      _jsonTest("$s1|$s2a|$s2b-$i-$j", expected, (sink) {
        sink.add(s1.codeUnits);
        sink.add(s2a.codeUnits);
        sink.add(s2b.codeUnits);
        sink.close();
      });
    }
  }
}

void _testNumbers() {
  for (var number in [
    "-0.12e-12",
    "-34.12E+12",
    "0.0e0",
    "9.9E9",
    "0",
    "9",
    "1234.56789123456701418035663664340972900390625",
    "1.2345678912345671e-14",
    "9223372036854775807"
  ]) {
    var expected = num.parse(number);
    for (int i = 1; i < number.length - 1; i++) {
      var p1 = number.substring(0, i);
      var p2 = number.substring(i);
      _jsonTest("$p1|$p2", expected, (sink) {
        sink.add(p1.codeUnits);
        sink.add(p2.codeUnits);
        sink.close();
      });

      _jsonTest("$p1|$p2/slice", expected, (sink) {
        sink.addSlice(number.codeUnits, 0, i, false);
        sink.addSlice(number.codeUnits, i, number.length, true);
      });

      for (int j = i; j < number.length - 1; j++) {
        var p2a = number.substring(i, j);
        var p2b = number.substring(j);
        _jsonTest("$p1|$p2a|$p2b", expected, (sink) {
          sink.add(p1.codeUnits);
          sink.add(p2a.codeUnits);
          sink.add(p2b.codeUnits);
          sink.close();
        });
      }
    }
  }
}

// Test that `null`, `true`, and `false` keywords are decoded correctly.
void _testKeywords() {
  for (var expected in [null, true, false]) {
    var s = "$expected";
    for (int i = 1; i < s.length - 1; i++) {
      var s1 = s.substring(0, i);
      var s2 = s.substring(i);
      _jsonTest("$s1|$s2", expected, (sink) {
        sink.add(s1.codeUnits);
        sink.add(s2.codeUnits);
        sink.close();
      });
      _jsonTest("$s1|$s2", expected, (sink) {
        sink.addSlice(s.codeUnits, 0, i, false);
        sink.addSlice(s.codeUnits, i, s.length, true);
      });
      for (var j = i; j < s.length - 1; j++) {
        var s2a = s.substring(i, j);
        var s2b = s.substring(j);
        _jsonTest("$s1|$s2a|$s2b", expected, (sink) {
          sink.add(s1.codeUnits);
          sink.add(s2a.codeUnits);
          sink.add(s2b.codeUnits);
          sink.close();
        });
      }
    }
  }
}

// Tests combinations of numbers, strings and keywords.
void _testAll() {
  var s = r'{"":[true,false,42, -33e-3,null,"\u0080"], "z": 0}';
  void check(o) {
    if (o is Map) {
      Expect.equals(2, o.length);
      Expect.equals(0, o["z"]);
      var v = o[""];
      if (v is List) {
        Expect.listEquals([true, false, 42, -33e-3, null, "\u0080"], v);
      } else {
        Expect.fail("Expected list, found ${v.runtimeType}");
      }
    } else {
      Expect.fail("Expected map, found ${o.runtimeType}");
    }
  }

  for (var i = 1; i < s.length - 1; i++) {
    var s1 = s.substring(0, i);
    var s2 = s.substring(i);
    _jsonParse("$s1|$s2-$i", check, (sink) {
      sink.add(s1.codeUnits);
      sink.add(s2.codeUnits);
      sink.close();
    });
    _jsonParse("$s1|$s2-$i-slice", check, (sink) {
      sink.addSlice(s.codeUnits, 0, i, false);
      sink.addSlice(s.codeUnits, i, s.length, true);
    });
    for (var j = i; j < s.length - 1; j++) {
      var s2a = s.substring(i, j);
      var s2b = s.substring(j);
      _jsonParse("$s1|$s2a|$s2b-$i-$j", check, (sink) {
        sink.add(s1.codeUnits);
        sink.add(s2a.codeUnits);
        sink.add(s2b.codeUnits);
        sink.close();
      });
    }
  }
}

// Check that [codes] decode to [expect] when allowing malformed UTF-8,
// and throws otherwise.
void _jsonMalformedTest(name, expect, List<int> codes) {
  // Helper method.
  void test(name, expect, action(ByteConversionSink sink)) {
    t.test(name, () {
      var tag = "Malform:$name-$expect";
      {
        // Allowing malformed, expect [expect]
        var sink = new ChunkedConversionSink.withCallback((values) {
          var value = values[0];
          Expect.equals(expect, value, tag);
        });
        var decoderSink =
            json.decoder.startChunkedConversion(sink).asUtf8Sink(true);
        try {
          action(decoderSink);
        } catch (e, s) {
          Expect.fail("Unexpected throw ($tag): $e\n$s");
        }
      }
      {
        // Not allowing malformed, expect throw.
        var sink = new ChunkedConversionSink.withCallback((values) {
          Expect.fail(tag);
        });
        var decoderSink =
            json.decoder.startChunkedConversion(sink).asUtf8Sink(false);
        Expect.throws(() {
          action(decoderSink);
        }, null, tag);
      }
    });
  }

  // Test all two and three part slices.
  for (int i = 1; i < codes.length - 1; i++) {
    test("$name:$i", expect, (sink) {
      sink.add(codes.sublist(0, i));
      sink.add(codes.sublist(i));
      sink.close();
    });
    test("$name:$i-slice", expect, (sink) {
      sink.addSlice(codes, 0, i, false);
      sink.addSlice(codes, i, codes.length, true);
    });
    for (int j = i; j < codes.length - 1; j++) {
      test("$name:$i|$j", expect, (sink) {
        sink.add(codes.sublist(0, i));
        sink.add(codes.sublist(i, j));
        sink.add(codes.sublist(j));
        sink.close();
      });
    }
  }
}

// Test that `codeString.codeUnits` fails to parse as UTF-8 JSON,
// even with decoder not throwing on malformed encodings.
void _jsonThrows(String name, String codeString) {
  testJsonThrows(String tag, action(ByteConversionSink thing)) {
    // Not allowing malformed, expect throw.
    var sink = new ChunkedConversionSink.withCallback((values) {
      Expect.fail(tag);
    });
    var decoderSink =
        json.decoder.startChunkedConversion(sink).asUtf8Sink(true);
    Expect.throws(() {
      action(decoderSink);
    }, null, tag);
  }

  var codes = codeString.codeUnits;
  for (int i = 1; i < codes.length - 1; i++) {
    testJsonThrows("$name:$i", (sink) {
      sink.add(codes.sublist(0, i));
      sink.add(codes.sublist(i));
      sink.close();
    });
    testJsonThrows("$name:$i-slice", (sink) {
      sink.addSlice(codes, 0, i, false);
      sink.addSlice(codes, i, codes.length, true);
    });
    for (int j = i; j < codes.length - 1; j++) {
      testJsonThrows("$name:$i|$j", (sink) {
        sink.add(codes.sublist(0, i));
        sink.add(codes.sublist(i, j));
        sink.add(codes.sublist(j));
        sink.close();
      });
    }
  }
}

// Malformed UTF-8 encodings.
void _testMalformed() {
  // Overlong encodings.
  _jsonMalformedTest(
      "overlong-0-2", "@\uFFFD@", [0x22, 0x40, 0xc0, 0x80, 0x40, 0x22]);
  _jsonMalformedTest(
      "overlong-0-3", "@\uFFFD@", [0x22, 0x40, 0xe0, 0x80, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("overlong-0-4", "@\uFFFD@",
      [0x22, 0x40, 0xf0, 0x80, 0x80, 0x80, 0x40, 0x22]);

  _jsonMalformedTest(
      "overlong-7f-2", "@\uFFFD@", [0x22, 0x40, 0xc1, 0xbf, 0x40, 0x22]);
  _jsonMalformedTest(
      "overlong-7f-3", "@\uFFFD@", [0x22, 0x40, 0xe0, 0x81, 0xbf, 0x40, 0x22]);
  _jsonMalformedTest("overlong-7f-4", "@\uFFFD@",
      [0x22, 0x40, 0xf0, 0x80, 0x81, 0xbf, 0x40, 0x22]);

  _jsonMalformedTest(
      "overlong-80-3", "@\uFFFD@", [0x22, 0x40, 0xe0, 0x82, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("overlong-80-4", "@\uFFFD@",
      [0x22, 0x40, 0xf0, 0x80, 0x82, 0x80, 0x40, 0x22]);

  _jsonMalformedTest(
      "overlong-7ff-3", "@\uFFFD@", [0x22, 0x40, 0xe0, 0x9f, 0xbf, 0x40, 0x22]);
  _jsonMalformedTest("overlong-7ff-4", "@\uFFFD@",
      [0x22, 0x40, 0xf0, 0x80, 0x9f, 0xbf, 0x40, 0x22]);

  _jsonMalformedTest("overlong-800-4", "@\uFFFD@",
      [0x22, 0x40, 0xf0, 0x80, 0xa0, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("overlong-ffff-4", "@\uFFFD@",
      [0x22, 0x40, 0xf0, 0x8f, 0xbf, 0xbf, 0x40, 0x22]);

  // Unterminated multibyte sequences.
  _jsonMalformedTest(
      "unterminated-2-normal", "@\uFFFD@", [0x22, 0x40, 0xc0, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-3-normal", "@\uFFFD@",
      [0x22, 0x40, 0xe0, 0x80, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-4-normal", "@\uFFFD@",
      [0x22, 0x40, 0xf0, 0x80, 0x80, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-2-multi", "@\uFFFD\x80@",
      [0x22, 0x40, 0xc0, 0xc2, 0x80, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-3-multi", "@\uFFFD\x80@",
      [0x22, 0x40, 0xe0, 0x80, 0xc2, 0x80, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-4-multi", "@\uFFFD\x80@",
      [0x22, 0x40, 0xf0, 0x80, 0x80, 0xc2, 0x80, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-2-escape", "@\uFFFD\n@",
      [0x22, 0x40, 0xc0, 0x5c, 0x6e, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-3-escape", "@\uFFFD\n@",
      [0x22, 0x40, 0xe0, 0x80, 0x5c, 0x6e, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-4-escape", "@\uFFFD\n@",
      [0x22, 0x40, 0xf0, 0x80, 0x80, 0x5c, 0x6e, 0x40, 0x22]);

  _jsonMalformedTest("unterminated-2-end", "@\uFFFD", [0x22, 0x40, 0xc0, 0x22]);

  _jsonMalformedTest(
      "unterminated-3-end", "@\uFFFD", [0x22, 0x40, 0xe0, 0x80, 0x22]);

  _jsonMalformedTest(
      "unterminated-4-end", "@\uFFFD", [0x22, 0x40, 0xf0, 0x80, 0x80, 0x22]);

  // Unexpected continuation byte
  // - after a normal character.
  _jsonMalformedTest(
      "continuation-normal", "@\uFFFD@", [0x22, 0x40, 0x80, 0x40, 0x22]);

  // - after a valid continuation byte.
  _jsonMalformedTest("continuation-continuation-2", "@\x80\uFFFD@",
      [0x22, 0x40, 0xc2, 0x80, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("continuation-continuation-3", "@\u0800\uFFFD@",
      [0x22, 0x40, 0xe0, 0xa0, 0x80, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("continuation-continuation-4", "@\u{10000}\uFFFD@",
      [0x22, 0x40, 0xf0, 0x90, 0x80, 0x80, 0x80, 0x40, 0x22]);

  // - after another invalid continuation byte
  _jsonMalformedTest("continuation-twice", "@\uFFFD\uFFFD\uFFFD@",
      [0x22, 0x40, 0x80, 0x80, 0x80, 0x40, 0x22]);
  // - at start.
  _jsonMalformedTest("continuation-start", "\uFFFD@", [0x22, 0x80, 0x40, 0x22]);

  // Unexpected leading byte where continuation byte expected.
  _jsonMalformedTest(
      "leading-2", "@\uFFFD\x80@", [0x22, 0x40, 0xc0, 0xc2, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("leading-3-1", "@\uFFFD\x80@",
      [0x22, 0x40, 0xe0, 0xc2, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("leading-3-2", "@\uFFFD\x80@",
      [0x22, 0x40, 0xe0, 0x80, 0xc2, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("leading-4-1", "@\uFFFD\x80@",
      [0x22, 0x40, 0xf0, 0xc2, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("leading-4-2", "@\uFFFD\x80@",
      [0x22, 0x40, 0xf0, 0x80, 0xc2, 0x80, 0x40, 0x22]);
  _jsonMalformedTest("leading-4-3", "@\uFFFD\x80@",
      [0x22, 0x40, 0xf0, 0x80, 0x80, 0xc2, 0x80, 0x40, 0x22]);

  // Overlong encodings of ASCII outside of strings always fail.
  // Use Latin-1 strings as argument since most chars are correct,
  // pass string.codeUnits to decoder as UTF-8.
  _jsonThrows("number-1", "\xc0\xab0.0e-0"); // '-' is 0x2b => \xc0\xab
  _jsonThrows("number-2", "-\xc0\xb0.0e-0"); // '0' is 0x30 => \xc0\xb0
  _jsonThrows("number-3", "-0\xc0\xae0e-0"); // '.' is 0x2e => \xc0\xae
  _jsonThrows("number-4", "-0.\xc0\xb0e-0");
  _jsonThrows("number-5", "-0.0\xc1\xa5-0"); // 'e' is 0x65 => \xc1\xa5
  _jsonThrows("number-6", "-0.0e\xc0\xab0");
  _jsonThrows("number-7", "-0.0e-\xc0\xb0");

  _jsonThrows("true-1", "\xc1\xb4rue"); // 't' is 0x74
  _jsonThrows("true-2", "t\xc1\xb2ue"); // 'r' is 0x72
  _jsonThrows("true-3", "tr\xc1\xb5e"); // 'u' is 0x75
  _jsonThrows("true-4", "tru\xc1\xa5"); // 'e' is 0x65

  _jsonThrows("false-1", "\xc1\xa6alse"); // 'f' is 0x66
  _jsonThrows("false-2", "f\xc1\xa1lse"); // 'a' is 0x61
  _jsonThrows("false-3", "fa\xc1\xacse"); // 'l' is 0x6c
  _jsonThrows("false-4", "fal\xc1\xb3e"); // 's' is 0x73
  _jsonThrows("false-5", "fals\xc1\xa5"); // 'e' is 0x65

  _jsonThrows("null-1", "\xc1\xaeull"); // 'n' is 0x6e
  _jsonThrows("null-2", "n\xc1\xb5ll"); // 'u' is 0x75
  _jsonThrows("null-3", "nu\xc1\xacl"); // 'l' is 0x6c
  _jsonThrows("null-4", "nul\xc1\xac"); // 'l' is 0x6c

  _jsonThrows("array-1", "\xc1\x9b0,0]"); // '[' is 0x5b
  _jsonThrows("array-2", "[0,0\xc1\x9d"); // ']' is 0x5d
  _jsonThrows("array-2", "[0\xc0\xac0]"); // ',' is 0x2c

  _jsonThrows("object-1", '\xc1\xbb"x":0}'); // '{' is 0x7b
  _jsonThrows("object-2", '{"x":0\xc1\xbd'); // '}' is 0x7d
  _jsonThrows("object-2", '{"x\xc0\xba0}'); // ':' is 0x3a

  _jsonThrows("string-1", '\xc0\xa2x"'); // '"' is 0x22
  _jsonThrows("string-1", '"x\xc0\xa2'); // Unterminated string.

  _jsonThrows("whitespace-1", "\xc0\xa01"); // ' ' is 0x20
}

void _testUnicodeTests() {
  for (var pair in unicodeTests) {
    final bytes = pair.bytes;
    final string = pair.target;
    int step = 1;
    if (bytes.length > 100) step = bytes.length ~/ 13;
    for (int i = 1; i < bytes.length - 1; i += step) {
      _jsonTest("$string:$i", string, (sink) {
        sink.add([0x22]); // Double-quote.
        sink.add(bytes.sublist(0, i));
        sink.add(bytes.sublist(i));
        sink.add([0x22]);
        sink.close();
      });
      _jsonTest("$string:$i-slice", string, (sink) {
        sink.addSlice([0x22], 0, 1, false);
        sink.addSlice(bytes, 0, i, false);
        sink.addSlice(bytes, i, bytes.length, false);
        sink.addSlice([0x22], 0, 1, true);
      });
      int skip = 1;
      if (bytes.length > 25) skip = bytes.length ~/ 17;
      for (int j = i; j < bytes.length - 1; j += skip) {
        _jsonTest("$string:$i|$j", string, (sink) {
          sink.add([0x22]);
          sink.add(bytes.sublist(0, i));
          sink.add(bytes.sublist(i, j));
          sink.add(bytes.sublist(j));
          sink.add([0x22]);
          sink.close();
        });
      }
    }
  }
}
