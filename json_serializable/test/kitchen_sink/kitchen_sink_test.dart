// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../test_utils.dart';
import 'kitchen_sink.g_any_map.dart' as nullable
    show testFactory, testFromJson, JsonConverterTestClass;
import 'kitchen_sink.g_any_map__checked__non_nullable.dart' as checked
    show testFactory, testFromJson;
import 'kitchen_sink.g_any_map__non_nullable.dart' as nn
    show testFactory, testFromJson, JsonConverterTestClass;
import 'kitchen_sink.g_any_map__non_nullable__use_wrappers.dart' as nnwrapped
    show testFactory, testFromJson;
import 'kitchen_sink.g_any_map__use_wrappers.dart' as wrapped
    show testFactory, testFromJson;
import 'kitchen_sink_interface.dart';
import 'strict_keys_object.dart';

// copied and renamed as private from /lib/src/constants.dart
const _generatedLocalVarName = 'val';
const _toJsonMapHelperName = 'writeNotNull';

final _isATypeError = const TypeMatcher<TypeError>();

Matcher _isAUnrecognizedKeysEexception(expectedMessage) =>
    const TypeMatcher<UnrecognizedKeysException>()
        .having((e) => e.message, 'message', expectedMessage);

Matcher _isMissingKeyException(expectedMessage) =>
    const TypeMatcher<MissingRequiredKeysException>()
        .having((e) => e.message, 'message', expectedMessage);

void main() {
  test('valid values covers all keys', () {
    expect(_invalidValueTypes.keys, orderedEquals(_validValues.keys));
  });

  test('required keys', () {
    expect(
        () => StrictKeysObject.fromJson({}),
        throwsA(_isMissingKeyException(
            'Required keys are missing: value, custom_field.')));
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

  group('JsonConverterTestClass', () {
    final validValues = {
      'duration': 5,
      'durationList': [5],
      'bigInt': '5',
      'bigIntMap': {'vaule': '5'},
      'numberSilly': 5,
      'numberSillySet': [5],
      'dateTime': 5
    };

    test('nullable values are allowed in the nullable version', () {
      final instance = nullable.JsonConverterTestClass();
      final json = instance.toJson();
      expect(json.values, everyElement(isNull));
      expect(json.keys, unorderedEquals(validValues.keys));

      final instance2 = nullable.JsonConverterTestClass.fromJson(json);
      expect(instance2.toJson(), json);
    });

    test('nullable values are not allowed in non-nullable version', () {
      var instance = nn.JsonConverterTestClass();
      expect(() => instance.toJson(), throwsNoSuchMethodError,
          reason: 'Trying to call `map` on a null list');

      instance = nn.JsonConverterTestClass.fromJson(validValues);
      final json = instance.toJson();
      expect(json, validValues);
      expect(json.values, everyElement(isNotNull));

      final instance2 = nn.JsonConverterTestClass.fromJson(json);
      expect(instance2.toJson(), json);
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
    {bool isChecked = false}) {
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
    final item = ctor();

    final expectedDefaultKeys = _validValues.keys.toSet()
      ..removeAll(_excludeIfNullKeys);

    final encoded = item.toJson();

    expect(encoded.keys, orderedEquals(expectedDefaultKeys));

    for (final key in expectedDefaultKeys) {
      expect(encoded, containsPair(key, isNull));
    }
  });

  test('list and map of DateTime', () {
    final now = DateTime.now();
    final item = ctor(dateTimeIterable: <DateTime>[now])
      ..dateTimeList = <DateTime>[now, null]
      ..objectDateTimeMap = <Object, DateTime>{'value': now, 'null': null};

    roundTripItem(item);
  });

  test('complex nested type', () {
    final item = ctor()
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
              [DateTime.now()]
            ]
          }
        }
      ];
    roundTripItem(item);
  });

  _sharedTests(ctor, fromJson);
}

void _sharedTests(KitchenSinkCtor ctor, KitchenSink fromJson(Map json),
    {bool isChecked = false}) {
  void roundTripSink(KitchenSink p) {
    roundTripObject(p, fromJson);
  }

  test('empty', () {
    final item = ctor();
    roundTripSink(item);
  });

  test('list and map of DateTime - not null', () {
    final now = DateTime.now();
    final item = ctor(dateTimeIterable: <DateTime>[now])
      ..dateTimeList = <DateTime>[now, now]
      ..objectDateTimeMap = <Object, DateTime>{'value': now};

    roundTripSink(item);
  });

  test('complex nested type - not null', () {
    final item = ctor()
      ..crazyComplex = [
        {},
        {
          'empty': {},
          'items': {
            'empty': [],
            'items': [
              [],
              [DateTime.now()]
            ]
          }
        }
      ];
    roundTripSink(item);
  });

  test('JSON keys should be defined in field/property order', () {
    /// Explicitly setting values from [_excludeIfNullKeys] to ensure
    /// they exist for KitchenSink where they are excluded when null
    final item = ctor(iterable: [])
      ..dateTime = DateTime.now()
      ..dateTimeList = []
      ..crazyComplex = []
      ..val = {};

    final json = item.toJson();
    expect(json.keys, orderedEquals(_validValues.keys));
  });

  test('valid values round-trip - json', () {
    expect(loudEncode(_validValues), loudEncode(fromJson(_validValues)));
  });

  test('valid values round-trip - yaml', () {
    final jsonEncoded = loudEncode(_validValues);
    final yaml = loadYaml(jsonEncoded, sourceUrl: 'input.yaml');
    expect(jsonEncoded, loudEncode(fromJson(yaml as YamlMap)));
  });

  group('a bad value for', () {
    for (final e in _invalidValueTypes.entries) {
      _testBadValue(isChecked, e.key, e.value, fromJson, false);
    }
    for (final e in _invalidCheckedValues.entries) {
      _testBadValue(isChecked, e.key, e.value, fromJson, true);
    }
  });
}

void _testBadValue(bool isChecked, String key, Object badValue,
    KitchenSink fromJson(Map json), bool checkedAssignment) {
  final matcher = _getMatcher(isChecked, key, checkedAssignment);

  for (final isJson in [true, false]) {
    test('`$key` fails with value `$badValue`- ${isJson ? 'json' : 'yaml'}',
        () {
      var copy = Map.from(_validValues);
      copy[key] = badValue;

      if (!isJson) {
        copy = loadYaml(loudEncode(copy)) as YamlMap;
      }

      expect(() => fromJson(copy), matcher);
    });
  }
}

Matcher _checkedMatcher(String expectedKey) =>
    const TypeMatcher<CheckedFromJsonException>()
        .having((e) => e.className, 'className', 'KitchenSink')
        .having((e) => e.key, 'key', expectedKey);

Matcher _getMatcher(bool checked, String expectedKey, bool checkedAssignment) {
  Matcher innerMatcher;

  if (checked) {
    if (checkedAssignment &&
        const ['intIterable', 'datetime-iterable'].contains(expectedKey)) {
      expectedKey = null;
    }

    innerMatcher = _checkedMatcher(expectedKey);
  } else {
    innerMatcher = anyOf(
        isCastError,
        _isATypeError,
        _isAUnrecognizedKeysEexception(
            'Unrecognized keys: [invalid_key]; supported keys: [value, custom_field]'));

    if (checkedAssignment) {
      switch (expectedKey) {
        case 'validatedPropertyNo42':
          innerMatcher = isStateError;
          break;
        case 'no-42':
          innerMatcher = isArgumentError;
          break;
        case 'strictKeysObject':
          innerMatcher = _isAUnrecognizedKeysEexception('bob');
          break;
        case 'intIterable':
        case 'datetime-iterable':
          innerMatcher = isCastError;
          break;
        default:
          throw StateError('Not expected! - $expectedKey');
      }
    }
  }

  return throwsA(innerMatcher);
}

final _validValues = const {
  'no-42': 0,
  'dateTime': '2018-05-10T14:20:58.927',
  'iterable': [],
  'dynamicIterable': [],
  'objectIterable': [],
  'intIterable': [],
  'set': [],
  'dynamicSet': [],
  'objectSet': [],
  'intSet': [],
  'dateTimeSet': [],
  'datetime-iterable': [],
  'list': [],
  'dynamicList': [],
  'objectList': [],
  'intList': [],
  'dateTimeList': [],
  'map': <String, dynamic>{},
  'stringStringMap': {},
  'dynamicIntMap': {},
  'objectDateTimeMap': <String, dynamic>{},
  'crazyComplex': [],
  _generatedLocalVarName: {},
  _toJsonMapHelperName: null,
  r'$string': null,
  'simpleObject': {'value': 42},
  'strictKeysObject': {'value': 10, 'custom_field': 'cool'},
  'validatedPropertyNo42': 0
};

final _invalidValueTypes = const {
  'no-42': true,
  'dateTime': true,
  'iterable': true,
  'dynamicIterable': true,
  'objectIterable': true,
  'intIterable': true,
  'set': true,
  'dynamicSet': true,
  'objectSet': true,
  'intSet': true,
  'dateTimeSet': true,
  'datetime-iterable': true,
  'list': true,
  'dynamicList': true,
  'objectList': true,
  'intList': [true],
  'dateTimeList': [true],
  'map': true,
  'stringStringMap': {'key': 42},
  'dynamicIntMap': {'key': 'value'},
  'objectDateTimeMap': {'key': 42},
  'crazyComplex': [true],
  _generatedLocalVarName: {'key': 42},
  _toJsonMapHelperName: 42,
  r'$string': true,
  'simpleObject': 42,
  'strictKeysObject': {
    'value': 10,
    'invalid_key': true,
  },
  'validatedPropertyNo42': true
};

/// Invalid values that are found after the property set or ctor call
final _invalidCheckedValues = const {
  'no-42': 42,
  'validatedPropertyNo42': 42,
  'intIterable': [true],
  'datetime-iterable': [true],
};

final _excludeIfNullKeys = const [
  'dateTime',
  'iterable',
  'dateTimeList',
  'crazyComplex',
  _generatedLocalVarName
];
