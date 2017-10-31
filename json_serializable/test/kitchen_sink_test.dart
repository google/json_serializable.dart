// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:json_serializable/src/utils.dart';

import 'test_files/kitchen_sink.dart' as nullable;
import 'test_files/kitchen_sink.non_nullable.dart' as nn;
import 'test_files/kitchen_sink.non_nullable.wrapped.dart' as nnwrapped;
import 'test_files/kitchen_sink.wrapped.dart' as wrapped;
import 'test_files/kitchen_sink_interface.dart';
import 'test_utils.dart';

void main() {
  group('nullable', () {
    group('unwrapped', () {
      _nullableTests(
          (
                  {Iterable iterable,
                  Iterable<dynamic> dynamicIterable,
                  Iterable<Object> objectIterable,
                  Iterable<int> intIterable,
                  Iterable<DateTime> dateTimeIterable}) =>
              new nullable.KitchenSink(
                  iterable: iterable,
                  dynamicIterable: dynamicIterable,
                  objectIterable: objectIterable,
                  intIterable: intIterable,
                  dateTimeIterable: dateTimeIterable),
          (j) => new nullable.KitchenSink.fromJson(j));
    });

    group('wrapped', () {
      _nullableTests(
          (
                  {Iterable iterable,
                  Iterable<dynamic> dynamicIterable,
                  Iterable<Object> objectIterable,
                  Iterable<int> intIterable,
                  Iterable<DateTime> dateTimeIterable}) =>
              new wrapped.KitchenSink(
                  iterable: iterable,
                  dynamicIterable: dynamicIterable,
                  objectIterable: objectIterable,
                  intIterable: intIterable,
                  dateTimeIterable: dateTimeIterable),
          (j) => new wrapped.KitchenSink.fromJson(j));
    });
  });

  group('non-nullable', () {
    group('unwrapped', () {
      _nonNullableTests(
          (
                  {Iterable iterable,
                  Iterable<dynamic> dynamicIterable,
                  Iterable<Object> objectIterable,
                  Iterable<int> intIterable,
                  Iterable<DateTime> dateTimeIterable}) =>
              new nn.KitchenSink(
                  iterable: iterable,
                  dynamicIterable: dynamicIterable,
                  objectIterable: objectIterable,
                  intIterable: intIterable,
                  dateTimeIterable: dateTimeIterable),
          (j) => new nn.KitchenSink.fromJson(j));
    });

    group('wrapped', () {
      _nonNullableTests(
          (
                  {Iterable iterable,
                  Iterable<dynamic> dynamicIterable,
                  Iterable<Object> objectIterable,
                  Iterable<int> intIterable,
                  Iterable<DateTime> dateTimeIterable}) =>
              new nnwrapped.KitchenSink(
                  iterable: iterable,
                  dynamicIterable: dynamicIterable,
                  objectIterable: objectIterable,
                  intIterable: intIterable,
                  dateTimeIterable: dateTimeIterable),
          (j) => new nnwrapped.KitchenSink.fromJson(j));
    });
  });
}

typedef KitchenSink KitchenSinkCtor(
    {Iterable iterable,
    Iterable<dynamic> dynamicIterable,
    Iterable<Object> objectIterable,
    Iterable<int> intIterable,
    Iterable<DateTime> dateTimeIterable});

void _nonNullableTests(
    KitchenSinkCtor ctor, KitchenSink fromJson(Map<String, dynamic> json)) {
  test('with null values fails serialization', () {
    expect(() => (ctor()..stringDateTimeMap = null).toJson(),
        throwsNoSuchMethodError);
  });

  test('with empty json fails deserialization', () {
    expect(() => fromJson({}), throwsNoSuchMethodError);
  });
  _sharedTests(ctor, fromJson);
}

void _nullableTests(
    KitchenSinkCtor ctor, KitchenSink fromJson(Map<String, dynamic> json)) {
  roundTripItem(KitchenSink p) {
    roundTripObject(p, (json) => fromJson(json));
  }

  test('Fields with `!includeIfNull` should not be included when null', () {
    var item = ctor();

    var expectedDefaultKeys = _expectedOrder.toSet()
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
      ..stringDateTimeMap = <String, DateTime>{'value': now, 'null': null};

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

void _sharedTests(
    KitchenSinkCtor ctor, KitchenSink fromJson(Map<String, dynamic> json)) {
  roundTripSink(KitchenSink p) {
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
      ..stringDateTimeMap = <String, DateTime>{'value': now};

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
    expect(json.keys, orderedEquals(_expectedOrder));
  });
}

final _excludeIfNullKeys = [
  'dateTime',
  'iterable',
  'dateTimeList',
  'crazyComplex',
  toJsonMapVarName
];

final _expectedOrder = [
  'dateTime',
  'iterable',
  'dynamicIterable',
  'objectIterable',
  'intIterable',
  'datetime-iterable',
  'list',
  'dynamicList',
  'objectList',
  'intList',
  'dateTimeList',
  'map',
  'stringStringMap',
  'stringIntMap',
  'stringDateTimeMap',
  'crazyComplex',
  toJsonMapVarName,
  toJsonMapHelperName,
  r'$string'
];
