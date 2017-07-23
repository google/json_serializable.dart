// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'test_files/kitchen_sink.dart';
import 'test_utils.dart';

void main() {
  roundTripItem(KitchenSink p) {
    roundTripObject(p, (json) => new KitchenSink.fromJson(json));
  }

  test('empty json', () {
    var item = new KitchenSink();
    roundTripItem(item);
  });

  test('json keys should be defined in field/property order', () {
    var item = new KitchenSink();

    var json = item.toJson();

    var expectedOrder = [
      'iterable',
      'dynamicIterable',
      'objectIterable',
      'intIterable',
      'dateTimeIterable',
      'list',
      'dynamicList',
      'objectList',
      'intList',
      'dateTimeList',
      'map',
      'stringStringMap',
      'stringIntMap',
      'stringDateTimeMap',
      'crazyComplex'
    ];

    expect(json.keys, orderedEquals(expectedOrder));
  });

  test("list and map of DateTime", () {
    var now = new DateTime.now();
    var item = new KitchenSink(dateTimeIterable: <DateTime>[now])
      ..dateTimeList = <DateTime>[now, null]
      ..stringDateTimeMap = <String, DateTime>{'value': now, 'null': null};

    roundTripItem(item);
  });

  test('complex nested type', () {
    var item = new KitchenSink()
      ..crazyComplex = [
        null,
        {},
        {
          "null": null,
          "empty": {},
          "items": {
            "null": null,
            "empty": [],
            "items": [
              null,
              [],
              [new DateTime.now()]
            ]
          }
        }
      ];
    roundTripItem(item);
  });
}
