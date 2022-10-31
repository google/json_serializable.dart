// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../test_utils.dart';
import 'default_value.dart' as normal;
import 'default_value.g_any_map__checked.dart' as checked;
import 'default_value_interface.dart';
import 'implicit_default_value.dart' as implicit;

const _defaultInstance = {
  'fieldBool': true,
  'fieldString': 'string',
  'fieldInt': 42,
  'fieldDouble': 3.14,
  'fieldListEmpty': [],
  'fieldSetEmpty': [],
  'fieldMapEmpty': <String, dynamic>{},
  'fieldListSimple': [1, 2, 3],
  'fieldSetSimple': ['entry1', 'entry2'],
  'fieldMapSimple': <String, dynamic>{'answer': 42},
  'fieldMapListString': {
    'root': ['child']
  },
  'durationField': 0,
  'fieldEnum': 'beta',
  'constClass': {'field': 'value'},
  'valueFromConverter': 'value',
  'valueFromFunction': 'value',
  'intDefaultValueFromFunction': 43,
  'valueFromDefaultValueDefaultConstructor': {'field': 'default'},
  'valueFromDefaultValueNamedConstructor': {'field': 'easy'},
};

const _otherValues = {
  'fieldBool': false,
  'fieldString': 'other string',
  'fieldInt': 43,
  'fieldDouble': 2.718,
  'fieldListEmpty': [42],
  'fieldSetEmpty': [42],
  'fieldMapEmpty': {'question': false},
  'fieldListSimple': [4, 5, 6],
  'fieldSetSimple': ['entry3'],
  'fieldMapSimple': <String, dynamic>{},
  'fieldMapListString': {
    'root2': ['alpha']
  },
  'durationField': 1,
  'fieldEnum': 'delta',
  'constClass': {'field': 'otherValue'},
  'valueFromConverter': 'otherValue',
  'valueFromFunction': 'otherValue',
  'intDefaultValueFromFunction': 44,
  'valueFromDefaultValueDefaultConstructor': {'field': 'other'},
  'valueFromDefaultValueNamedConstructor': {'field': 'other'},
};

void main() {
  group('nullable', () => _test(normal.fromJson));
  group('non-nullable', () => _test(checked.fromJson));
  group('implicit', () => _test(implicit.fromJson));
}

void _test(DefaultValue Function(Map<String, dynamic> json) fromJson) {
  test('empty map yields all default values', () {
    final object = fromJson({});
    expect(loudEncode(object), loudEncode(_defaultInstance));
  });
  test('default value input round-trips', () {
    final object = fromJson(_defaultInstance);
    expect(loudEncode(object), loudEncode(_defaultInstance));
  });
  test('non-default values round-trip', () {
    final object = fromJson(_otherValues);
    expect(loudEncode(object), loudEncode(_otherValues));
  });
}
