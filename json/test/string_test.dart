// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'test_util.dart';


main() {
  // String parser accepts and understands escapes.
  var input = r'"\u0000\uffff\n\r\f\t\b\/\\\"' '\x20\ufffd\uffff"';
  var expected = "\u0000\uffff\n\r\f\t\b\/\\\"\x20\ufffd\uffff";
  testJson(input, expected);
  // Empty string.
  testJson(r'""', "");
  // Escape first.
  var escapes = {
    "f": "\f",
    "b": "\b",
    "n": "\n",
    "r": "\r",
    "t": "\t",
    r"\": r"\",
    '"': '"',
    "/": "/",
  };
  escapes.forEach((esc, lit) {
    testJson('"\\$esc........"', "$lit........");
    // Escape last.
    testJson('"........\\$esc"', "........$lit");
    // Escape middle.
    testJson('"....\\$esc...."', "....$lit....");
  });

  // Does not accept single quotes.
  testThrows(r"''");
  // Throws on unterminated strings.
  testThrows(r'"......\"');
  // Throws on unterminated escapes.
  testThrows(r'"\'); // ' is not escaped.
  testThrows(r'"\a"');
  testThrows(r'"\u"');
  testThrows(r'"\u1"');
  testThrows(r'"\u12"');
  testThrows(r'"\u123"');
  testThrows(r'"\ux"');
  testThrows(r'"\u1x"');
  testThrows(r'"\u12x"');
  testThrows(r'"\u123x"');
  // Throws on bad escapes.
  testThrows(r'"\a"');
  testThrows(r'"\x00"');
  testThrows(r'"\c2"');
  testThrows(r'"\000"');
  testThrows(r'"\u{0}"');
  testThrows(r'"\%"');
  testThrows('"\\\x00"'); // Not raw string!
  // Throws on control characters.
  for (int i = 0; i < 32; i++) {
    var string = new String.fromCharCodes([0x22, i, 0x22]); // '"\x00"' etc.
    testThrows(string);
  }
}
