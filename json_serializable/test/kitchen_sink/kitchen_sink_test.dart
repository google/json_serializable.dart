// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/src/constants.dart';
import 'package:yaml/yaml.dart';

import '../test_utils.dart';
import 'kitchen_sink.dart' as nullable show testFactory, testFromJson;
import 'kitchen_sink.non_nullable.checked.dart' as checked
    show testFactory, testFromJson;
import 'kitchen_sink.non_nullable.dart' as nn show testFactory, testFromJson;
import 'kitchen_sink.non_nullable.wrapped.dart' as nnwrapped
    show testFactory, testFromJson;
import 'kitchen_sink.wrapped.dart' as wrapped show testFactory, testFromJson;

import 'kitchen_sink_interface.dart';

final _isATypeError = const isInstanceOf<TypeError>();

void main() {
  test('valid values covers all keys', () {
    expect(_invalidValueTypes.keys, orderedEquals(_validValues.keys));
  });

  group('nullable', () {
    group('unwrapped', () {
      _nullableTests(nullable.testFactory, nullable.testFromJson);
    });

    group('wrapped', () {
      _nullableTests(wrapped.testFactory, wrapped.testFromJson);
    });
  });

  group('non-nullable', () {
    group('checked', () {
      _nonNullableTests(checked.testFactory, checked.testFromJson,
          isChecked: true);
    });

    group('unwrapped', () {
      _nonNullableTests(nn.testFactory, nn.testFromJson);
    });

    group('wrapped', () {
      _nonNullableTests(nnwrapped.testFactory, nnwrapped.testFromJson);
    });
  });
}

typedef KitchenSink KitchenSinkCtor(
    {int ctorValidatedNo42,
    Iterable iterable,
    Iterable<dynamic> dynamicIterable,
    Iterable<Object> objectIterable,
    Iterable<int> intIterable,
    Iterable<DateTime> dateTimeIterable});

void _nonNullableTests(KitchenSinkCtor ctor, KitchenSink fromJson(Map json),
    {bool isChecked: false}) {
  test('with null values fails serialization', () {
    expect(() => (ctor()..objectDateTimeMap = null).toJson(),
        throwsNoSuchMethodError);
  });

  test('with empty json fails deserialization', () {
    if (isChecked) {
      expect(() => fromJson({}), throwsA(_checkedMatcher('intIterable')));
    } else {
      expect(() => fromJson({}), throwsNoSuchMethodError);
    }
  });
  _sharedTests(ctor, fromJson, isChecked: isChecked);
}

void _nullableTests(KitchenSinkCtor ctor, KitchenSink fromJson(Map json)) {
  void roundTripItem(KitchenSink p) {
    roundTripObject(p, (json) => fromJson(json));
  }

  test('Fields with `!includeIfNull` should not be included when null', () {
    var item = ctor();

    var expectedDefaultKeys = _validValues.keys.toSet()
      ..removeAll(_excludeIfNullKeys);

    var encoded = item.toJson();

    expect(encoded.keys, orderedEquals(expectedDefaultKeys));

    for (var key in expectedDefaultKeys) {
      expect(encoded, containsPair(key, isNull));
    }
  });

  test('list and map of DateTime', () {
    var now = new DateTime.now();
    var item = ctor(dateTimeIterable: <DateTime>[now])
      ..dateTimeList = <DateTime>[now, null]
      ..objectDateTimeMap = <Object, DateTime>{'value': now, 'null': null};

    roundTripItem(item);
  });

  test('complex nested type', () {
    var item = ctor()
      ..crazyComplex = [
        null,
        {},
        {
          'null': null,
          'empty': {},
          'items': {
            'null': null,
            'empty': [],
            'items': [
              null,
              [],
              [new DateTime.now()]
            ]
          }
        }
      ];
    roundTripItem(item);
  });

  _sharedTests(ctor, fromJson);
}

void _sharedTests(KitchenSinkCtor ctor, KitchenSink fromJson(Map json),
    {bool isChecked: false}) {
  void roundTripSink(KitchenSink p) {
    roundTripObject(p, fromJson);
  }

  test('empty', () {
    var item = ctor();
    roundTripSink(item);
  });

  test('list and map of DateTime - not null', () {
    var now = new DateTime.now();
    var item = ctor(dateTimeIterable: <DateTime>[now])
      ..dateTimeList = <DateTime>[now, now]
      ..objectDateTimeMap = <Object, DateTime>{'value': now};

    roundTripSink(item);
  });

  test('complex nested type - not null', () {
    var item = ctor()
      ..crazyComplex = [
        {},
        {
          'empty': {},
          'items': {
            'empty': [],
            'items': [
              [],
              [new DateTime.now()]
            ]
          }
        }
      ];
    roundTripSink(item);
  });

  test('JSON keys should be defined in field/property order', () {
    /// Explicitly setting values from [_excludeIfNullKeys] to ensure
    /// they exist for KitchenSink where they are excluded when null
    var item = ctor(iterable: [])
      ..dateTime = new DateTime.now()
      ..dateTimeList = []
      ..crazyComplex = []
      ..val = {};

    var json = item.toJson();
    expect(json.keys, orderedEquals(_validValues.keys));
  });

  test('valid values round-trip - json', () {
    expect(loudEncode(_validValues), loudEncode(fromJson(_validValues)));
  });

  test('valid values round-trip - yaml', () {
    var jsonEncoded = loudEncode(_validValues);
    var yaml = loadYaml(jsonEncoded, sourceUrl: 'input.yaml');
    expect(jsonEncoded, loudEncode(fromJson(yaml as YamlMap)));
  });

  group('a bad value for', () {
    for (var e in _invalidValueTypes.entries) {
      _testBadValue(isChecked, e.key, e.value, fromJson, false);
    }
    for (var e in _invalidCheckedValues.entries) {
      _testBadValue(isChecked, e.key, e.value, fromJson, true);
    }
  });
}

void _testBadValue(bool isChecked, String key, Object badValue,
    KitchenSink fromJson(Map json), bool checkedAssignment) {
  final matcher = _getMatcher(isChecked, key, checkedAssignment);

  for (var isJson in [true, false]) {
    test('`$key` fails with value `$badValue`- ${isJson ? 'json' : 'yaml'}',
        () {
      var copy = new Map.from(_validValues);
      copy[key] = badValue;

      if (!isJson) {
        copy = loadYaml(loudEncode(copy)) as YamlMap;
      }

      expect(() => fromJson(copy), matcher);
    });
  }
}

Matcher _checkedMatcher(String expectedKey) => allOf(
    const isInstanceOf<CheckedFromJsonException>(),
    new FeatureMatcher<CheckedFromJsonException>(
        'className', (e) => e.className, 'KitchenSink'),
    new FeatureMatcher<CheckedFromJsonException>(
        'key', (e) => e.key, expectedKey));

Matcher _getMatcher(bool checked, String expectedKey, bool checkedAssignment) {
  Matcher innerMatcher;

  if (checked) {
    if (checkedAssignment &&
        const ['intIterable', 'datetime-iterable'].contains(expectedKey)) {
      expectedKey = null;
    }

    innerMatcher = _checkedMatcher(expectedKey);
  } else {
    innerMatcher = anyOf(isACastError, _isATypeError);

    if (checkedAssignment) {
      switch (expectedKey) {
        case 'validatedPropertyNo42':
          innerMatcher = isStateError;
          break;
        case 'no-42':
          innerMatcher = isArgumentError;
          break;
        case 'intIterable':
        case 'datetime-iterable':
          innerMatcher = isACastError;
          break;
        default:
          throw new StateError('Not expected! - $expectedKey');
      }
    }
  }

  return throwsA(innerMatcher);
}

final _validValues = const {
  'no-42': 0,
  'dateTime': '2018-05-10T14:20:58.927',
  'iterable': const [],
  'dynamicIterable': const [],
  'objectIterable': const [],
  'intIterable': const [],
  'datetime-iterable': const [],
  'list': const [],
  'dynamicList': const [],
  'objectList': const [],
  'intList': const [],
  'dateTimeList': const [],
  'map': const <String, dynamic>{},
  'stringStringMap': const {},
  'dynamicIntMap': const {},
  'objectDateTimeMap': const <String, dynamic>{},
  'crazyComplex': const [],
  generatedLocalVarName: const {},
  toJsonMapHelperName: null,
  r'$string': null,
  'simpleObject': const {'value': 42},
  'validatedPropertyNo42': 0
};

final _invalidValueTypes = const {
  'no-42': true,
  'dateTime': true,
  'iterable': true,
  'dynamicIterable': true,
  'objectIterable': true,
  'intIterable': true,
  'datetime-iterable': true,
  'list': true,
  'dynamicList': true,
  'objectList': true,
  'intList': const [true],
  'dateTimeList': const [true],
  'map': true,
  'stringStringMap': const {'key': 42},
  'dynamicIntMap': const {'key': 'value'},
  'objectDateTimeMap': const {'key': 42},
  'crazyComplex': const [true],
  generatedLocalVarName: const {'key': 42},
  toJsonMapHelperName: 42,
  r'$string': true,
  'simpleObject': 42,
  'validatedPropertyNo42': true
};

/// Invalid values that are found after the property set or ctor call
final _invalidCheckedValues = const {
  'no-42': 42,
  'validatedPropertyNo42': 42,
  'intIterable': const [true],
  'datetime-iterable': const [true],
};

final _excludeIfNullKeys = const [
  'dateTime',
  'iterable',
  'dateTimeList',
  'crazyComplex',
  generatedLocalVarName
];
