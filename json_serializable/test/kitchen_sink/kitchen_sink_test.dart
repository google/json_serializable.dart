// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../test_utils.dart';
import 'kitchen_sink.g_any_map.dart' as nullable show factory;
import 'kitchen_sink.g_any_map__checked__non_nullable.dart' as checked
    show factory;
import 'kitchen_sink.g_any_map__non_nullable.dart' as non_null show factory;
import 'kitchen_sink.g_any_map__non_nullable__use_wrappers.dart'
    as non_null_wrapped show factory;
import 'kitchen_sink.g_any_map__use_wrappers.dart' as wrapped show factory;
import 'kitchen_sink_interface.dart';
import 'strict_keys_object.dart';

// copied and renamed as private from /lib/src/constants.dart
const _generatedLocalVarName = 'val';
const _toJsonMapHelperName = 'writeNotNull';

final _isATypeError = const TypeMatcher<TypeError>();

Matcher _isAUnrecognizedKeysException(expectedMessage) =>
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

  for (var factory in [
    nullable.factory,
    checked.factory,
    non_null.factory,
    non_null_wrapped.factory,
    wrapped.factory,
  ]) {
    group(factory.description, () {
      if (factory.nullable) {
        _nullableTests(factory);
      } else {
        _nonNullableTests(factory, isChecked: factory.checked);
      }

      _sharedTests(factory, isChecked: factory.checked);
    });
  }
}

const _jsonConverterValidValues = {
  'duration': 5,
  'durationList': [5],
  'bigInt': '5',
  'bigIntMap': {'vaule': '5'},
  'numberSilly': 5,
  'numberSillySet': [5],
  'dateTime': 5
};

void _nonNullableTests(KitchenSinkFactory factory, {bool isChecked = false}) {
  test('with null values fails serialization', () {
    expect(() => (factory.ctor()..objectDateTimeMap = null).toJson(),
        throwsNoSuchMethodError);
  });

  test('with empty json fails deserialization', () {
    if (isChecked) {
      expect(
          () => factory.fromJson({}), throwsA(_checkedMatcher('intIterable')));
    } else {
      expect(() => factory.fromJson({}), throwsNoSuchMethodError);
    }
  });

  test('nullable values are not allowed in non-nullable version', () {
    var instance = non_null.factory.jsonConverterCtor();
    expect(() => instance.toJson(), throwsNoSuchMethodError,
        reason: 'Trying to call `map` on a null list');

    instance =
        non_null.factory.jsonConverterFromJson(_jsonConverterValidValues);
    final json = instance.toJson();
    expect(json, _jsonConverterValidValues);
    expect(json.values, everyElement(isNotNull));

    final instance2 = non_null.factory.jsonConverterFromJson(json);
    expect(instance2.toJson(), json);
  });
}

void _nullableTests(KitchenSinkFactory factory) {
  void roundTripItem(KitchenSink p) {
    roundTripObject(p, (json) => factory.fromJson(json));
  }

  test('nullable values are allowed in the nullable version', () {
    final instance = nullable.factory.jsonConverterCtor();
    final json = instance.toJson();
    expect(json.values, everyElement(isNull));
    expect(json.keys, unorderedEquals(_jsonConverterValidValues.keys));

    final instance2 = nullable.factory.jsonConverterFromJson(json);
    expect(instance2.toJson(), json);
  });

  test('Fields with `!includeIfNull` should not be included when null', () {
    final item = factory.ctor();

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
    final item = factory.ctor(dateTimeIterable: <DateTime>[now])
      ..dateTimeList = <DateTime>[now, null]
      ..objectDateTimeMap = <Object, DateTime>{'value': now, 'null': null};

    roundTripItem(item);
  });

  test('complex nested type', () {
    final item = factory.ctor()
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
}

void _sharedTests(KitchenSinkFactory factory, {bool isChecked = false}) {
  void roundTripSink(KitchenSink p) {
    roundTripObject(p, factory.fromJson);
  }

  test('empty', () {
    final item = factory.ctor();
    roundTripSink(item);
  });

  test('list and map of DateTime - not null', () {
    final now = DateTime.now();
    final item = factory.ctor(dateTimeIterable: <DateTime>[now])
      ..dateTimeList = <DateTime>[now, now]
      ..objectDateTimeMap = <Object, DateTime>{'value': now};

    roundTripSink(item);
  });

  test('complex nested type - not null', () {
    final item = factory.ctor()
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
    final item = factory.ctor(iterable: [])
      ..dateTime = DateTime.now()
      ..dateTimeList = []
      ..crazyComplex = []
      ..val = {};

    final json = item.toJson();
    expect(json.keys, orderedEquals(_validValues.keys));
  });

  test('valid values round-trip - json', () {
    expect(
        loudEncode(_validValues), loudEncode(factory.fromJson(_validValues)));
  });

  test('valid values round-trip - yaml', () {
    final jsonEncoded = loudEncode(_validValues);
    final yaml = loadYaml(jsonEncoded, sourceUrl: 'input.yaml');
    expect(jsonEncoded, loudEncode(factory.fromJson(yaml as YamlMap)));
  });

  group('a bad value for', () {
    for (final e in _invalidValueTypes.entries) {
      _testBadValue(isChecked, e.key, e.value, factory.fromJson, false);
    }
    for (final e in _invalidCheckedValues.entries) {
      _testBadValue(isChecked, e.key, e.value, factory.fromJson, true);
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
        _isAUnrecognizedKeysException(
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
          innerMatcher = _isAUnrecognizedKeysException('bob');
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
