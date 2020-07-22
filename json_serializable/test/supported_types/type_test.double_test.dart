// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: prefer_const_declarations

@TestOn('vm')
import 'package:test/test.dart';

import '../test_utils.dart';
import 'input.type_double.dart';

void main() {
  group('SimpleClass', () {
    final _defaultValue = 3.14;
    final _altValue = 6.28;

    final _emptyInput = <String, dynamic>{
      'nullable': _defaultValue,
    };

    final _defaultOutput = {
      'value': null,
      'nullable': _defaultValue,
      'withDefault': _defaultValue,
    };

    final _nonDefaultJson = {
      'value': null,
      'nullable': _altValue,
      'withDefault': _altValue,
    };

    test('round trip', () {
      final object = SimpleClass.fromJson(_emptyInput);
      expect(loudEncode(object), loudEncode(_defaultOutput));
    });

    test('round trip alternate values', () {
      final object = SimpleClass.fromJson(_nonDefaultJson);
      expect(loudEncode(object), loudEncode(_nonDefaultJson));
      expect(loudEncode(object), isNot(loudEncode(_defaultOutput)));
    });
  });

  // Place-holder for generic tests, if any.
}
