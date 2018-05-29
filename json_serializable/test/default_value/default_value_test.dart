// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../test_utils.dart';
import 'default_value.checked.dart' as checked;
import 'default_value.dart' as normal;
import 'default_value_interface.dart';

const _defaultInstance = const {
  'fieldBool': true,
  'fieldString': 'string',
  'fieldInt': 42,
  'fieldDouble': 3.14,
  'fieldListEmpty': const [],
  'fieldMapEmpty': const <String, dynamic>{},
  'fieldListSimple': const [1, 2, 3],
  'fieldMapSimple': const <String, dynamic>{'answer': 42},
  'fieldMapListString': const {
    'root': const ['child']
  },
  'fieldEnum': 'beta'
};

const _otherValues = const {
  'fieldBool': false,
  'fieldString': 'other string',
  'fieldInt': 43,
  'fieldDouble': 2.718,
  'fieldListEmpty': const [42],
  'fieldMapEmpty': const {'question': false},
  'fieldListSimple': const [4, 5, 6],
  'fieldMapSimple': const <String, dynamic>{},
  'fieldMapListString': const {
    'root2': const ['alpha']
  },
  'fieldEnum': 'delta'
};

void main() {
  group('nullable', () => _test(normal.fromJson));
  group('non-nullable', () => _test(checked.fromJson));
}

void _test(DefaultValue fromJson(Map<String, dynamic> json)) {
  test('empty map yields all default values', () {
    var object = fromJson({});
    expect(loudEncode(object), loudEncode(_defaultInstance));
  });
  test('default value input round-trips', () {
    var object = fromJson(_defaultInstance);
    expect(loudEncode(object), loudEncode(_defaultInstance));
  });
  test('non-default values round-trip', () {
    var object = fromJson(_otherValues);
    expect(loudEncode(object), loudEncode(_otherValues));
  });
}
