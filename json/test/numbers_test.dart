// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'package:json/json.dart';

import "src/expect.dart";
import 'test_util.dart';

main() {
  // Positive tests for number formats.
  var integerList = ["0", "9", "9999"];
  var signList = ["", "-"];
  var fractionList = ["", ".0", ".1", ".99999"];
  var exponentList = [""];
  for (var exphead in ["e", "E", "e-", "E-", "e+", "E+"]) {
    for (var expval in ["0", "1", "200"]) {
      exponentList.add("$exphead$expval");
    }
  }

  for (var integer in integerList) {
    for (var sign in signList) {
      for (var fraction in fractionList) {
        for (var exp in exponentList) {
          for (var ws in ["", " ", "\t"]) {
            var literal = "$ws$sign$integer$fraction$exp$ws";
            var expectedValue = num.parse(literal);
            testJson(literal, expectedValue);
          }
        }
      }
    }
  }

  // Negative tests (syntax error).
  // testError thoroughly tests the given parts with a lot of valid
  // values for the other parts.
  testError({signs, integers, fractions, exponents}) {
    def(value, defaultValue) {
      if (value == null) return defaultValue;
      if (value is List) return value;
      return [value];
    }

    signs = def(signs, signList);
    integers = def(integers, integerList);
    fractions = def(fractions, fractionList);
    exponents = def(exponents, exponentList);
    for (var integer in integers) {
      for (var sign in signs) {
        for (var fraction in fractions) {
          for (var exponent in exponents) {
            var literal = "$sign$integer$fraction$exponent";
            testThrows(literal);
          }
        }
      }
    }
  }

  // Doubles overflow to Infinity.
  testJson("1e+400", double.infinity);
  // (Integers do not, but we don't have those on dart2js).

  // Integer part cannot be omitted:
  testError(integers: "");

  // Test for "Initial zero only allowed for zero integer part" moved to
  // json_strict_test.dart because IE's JSON.decode accepts additional initial
  // zeros.

  // Only minus allowed as sign.
  testError(signs: "+");
  // Requires digits after decimal point.
  testError(fractions: ".");
  // Requires exponent digts, and only digits.
  testError(exponents: ["e", "e+", "e-", "e.0"]);

  // No whitespace inside numbers.
  // Additional case "- 2.2e+2" in json_strict_test.dart.
  testThrows("-2 .2e+2");
  testThrows("-2. 2e+2");
  testThrows("-2.2 e+2");
  testThrows("-2.2e +2");
  testThrows("-2.2e+ 2");

  testThrows("[2.,2]");
  testThrows("{2.:2}");

  testThrows("NaN");
  testThrows("Infinity");
  testThrows("-Infinity");
  Expect.throws(() => json.encode(double.nan));
  Expect.throws(() => json.encode(double.infinity));
  Expect.throws(() => json.encode(double.negativeInfinity));
}
