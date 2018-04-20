// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:charcode/charcode.dart';

import 'test_util.dart';
import 'unicode_values.dart';

final List<Pair<List<int>>> jsonUnicodeTests =
    unicodeTests.expand((Pair<String> testValue) {
  // The unicode test will be a string (possibly) containing unicode
  // characters. It also contains the empty string.
  // It must not contain a double-quote '"'.
  assert(!testValue.target.contains('"'));

  // expanded will hold all tests that are generated from the unicode test.
  var expanded = <Pair>[];

  // Put the string into quotes.
  // For example: 'abcd' -> '"abcd"'.
  var inQuotesBytes = <int>[];
  inQuotesBytes.add($quote);
  inQuotesBytes.addAll(testValue.bytes);
  inQuotesBytes.add($quote);
  expanded.add(new Pair(inQuotesBytes, testValue.target));

  // Put the quoted string into a triple nested list.
  // For example: 'abcd' -> '[[["abcd"]]]'.
  var listExpected = [
    [
      [testValue.target]
    ]
  ];
  var inListBytes = <int>[];
  inListBytes.addAll([$lbracket, $lbracket, $lbracket]);
  inListBytes.addAll(inQuotesBytes);
  inListBytes.addAll([$rbracket, $rbracket, $rbracket]);
  expanded.add(new Pair(inListBytes, listExpected));

  // Put the quoted string into a triple nested list and duplicate that
  // list three times.
  // For example: 'abcd' -> '[[[["abcd"]]],[[["abcd"]]],[[["abcd"]]]]'.
  var listLongerExpected = [listExpected, listExpected, listExpected];
  var listLongerBytes = <int>[];
  listLongerBytes.add($lbracket);
  listLongerBytes.addAll(inListBytes);
  listLongerBytes.add($comma);
  listLongerBytes.addAll(inListBytes);
  listLongerBytes.add($comma);
  listLongerBytes.addAll(inListBytes);
  listLongerBytes.add($rbracket);
  expanded.add(new Pair(listLongerBytes, listLongerExpected));

  // Put the previous strings/lists into a map.
  // For example:
  //    'abcd' -> '{"abcd":[[[["abcd"]]],[[["abcd"]]],[[["abcd"]]]]}'.
  var mapExpected = {};
  mapExpected[testValue.target] = listLongerExpected;
  var mapBytes = <int>[];
  mapBytes.add($lbrace);
  mapBytes.addAll(inQuotesBytes);
  mapBytes.add($colon);
  mapBytes.addAll(listLongerBytes);
  mapBytes.add($rbrace);
  expanded.add(new Pair(mapBytes, mapExpected));

  return expanded;
}).toList();
