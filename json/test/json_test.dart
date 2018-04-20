// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'package:test/test.dart';
import 'test_util.dart';

main() {
  group('whitespace', () {
    // Valid white-space characters.
    var v = '\t\r\n\ ';
    // Invalid white-space and non-recognized characters.
    var invalids = ['\x00', '\f', '\x08', '\\', '\xa0', '\u2028', '\u2029'];

    // Valid whitespace accepted "everywhere".
    testJson('$v[$v-2.2e2$v,$v{$v"key"$v:${v}true$v}$v,$v"ab"$v]$v', [
      -2.2e2,
      {"key": true},
      "ab"
    ]);

    // IE9 accepts invalid characters at the end, so some of these tests have been
    // moved to json_strict_test.dart.
    for (var i in invalids) {
      testThrows('$i"s"');
      testThrows('42$i');
      testThrows('$i[]');
      testThrows('[$i]');
      testThrows('[$i"s"]');
      testThrows('["s"$i]');
      testThrows('$i{"k":"v"}');
      testThrows('{$i"k":"v"}');
      testThrows('{"k"$i:"v"}');
      testThrows('{"k":$i"v"}');
      testThrows('{"k":"v"$i}');
    }
  });

  group('words', () {
    testJson(r'true', true);
    testJson(r'false', false);
    testJson(r'null', null);
    testJson(r'[true]', [true]);
    testJson(r'{"true":true}', {"true": true});

    testThrows(r'truefalse');
    testThrows(r'trues');
    testThrows(r'nulll');
    testThrows(r'full');
    testThrows(r'nul');
    testThrows(r'tru');
    testThrows(r'fals');
    testThrows(r'\null');
    testThrows(r't\rue');
    testThrows(r't\rue');
  });

  group('objects', () {
    testJson(r'{}', {});
    testJson(r'{"x":42}', {"x": 42});
    testJson(r'{"x":{"x":{"x":42}}}', {
      "x": {
        "x": {"x": 42}
      }
    });
    testJson(r'{"x":10,"x":42}', {"x": 42});
    testJson(r'{"":42}', {"": 42});

    // Keys must be strings.
    testThrows(r'{x:10}');
    testThrows(r'{true:10}');
    testThrows(r'{false:10}');
    testThrows(r'{null:10}');
    testThrows(r'{42:10}');
    testThrows(r'{42e1:10}');
    testThrows(r'{-42:10}');
    testThrows(r'{["text"]:10}');
    testThrows(r'{:10}');
  });

  group('arrays', () {
    testJson(r'[]', []);
    testJson(r'[1.1e1,"string",true,false,null,{}]',
        [1.1e1, "string", true, false, null, {}]);
    testJson(r'[[[[[[]]]],[[[]]],[[]]]]', [
      [
        [
          [
            [[]]
          ]
        ],
        [
          [[]]
        ],
        [[]]
      ]
    ]);
    testJson(r'[{},[{}],{"x":[]}]', [
      {},
      [{}],
      {"x": []}
    ]);

    testThrows(r'[1,,2]');
    testThrows(r'[1,2,]');
    testThrows(r'[,2]');
  });
}
