// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../test_utils.dart';
import 'default_value.dart';

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
    'root2': const ['child1', 'child2']
  },
};

void main() {
  test('empty map yields all default values', () {
    var object = new DefaultValue.fromJson({});
    expect(loudEncode(object), loudEncode(_defaultInstance));
  });
  test('default value input round-trips', () {
    var object = new DefaultValue.fromJson(_defaultInstance);
    expect(loudEncode(object), loudEncode(_defaultInstance));
  });
  test('non-default values round-trip', () {
    var object = new DefaultValue.fromJson(_otherValues);
    expect(loudEncode(object), loudEncode(_otherValues));
  });
}
