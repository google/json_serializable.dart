// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'test_files/json_test_example.dart';

void main() {
  group('Person', () {
    roundTripPerson(Person p) {
      _roundTripObject(p, (json) => new Person.fromJson(json));
    }

    test("null", () {
      roundTripPerson(new Person(null, null));
    });

    test("empty", () {
      roundTripPerson(new Person('', '',
          middleName: '',
          dateOfBirth: new DateTime.fromMillisecondsSinceEpoch(0)));
    });

    test("now", () {
      roundTripPerson(new Person('a', 'b',
          middleName: 'c', dateOfBirth: new DateTime.now()));
    });

    test("now toUtc", () {
      roundTripPerson(new Person('a', 'b',
          middleName: 'c', dateOfBirth: new DateTime.now().toUtc()));
    });

    test('empty json', () {
      var person = new Person.fromJson({});
      expect(person.dateOfBirth, isNull);
      roundTripPerson(person);
    });
  });

  group('Order', () {
    roundTripOrder(Order p) {
      _roundTripObject(p, (json) => new Order.fromJson(json));
    }

    test("null", () {
      roundTripOrder(new Order());
    });

    test("empty", () {
      roundTripOrder(new Order(const [])
        ..count = 0
        ..isRushed = false);
    });

    test("simple", () {
      roundTripOrder(new Order(<Item>[
        new Item(24)
          ..itemNumber = 42
          ..saleDates = [new DateTime.now()]
      ])
        ..count = 42
        ..isRushed = true);
    });

    test('empty json', () {
      var order = new Order.fromJson({});
      expect(order.items, isEmpty);
      roundTripOrder(order);
    });
  });

  group('Item', () {
    roundTripItem(Item p) {
      _roundTripObject(p, (json) => new Item.fromJson(json));
    }

    test('empty json', () {
      var item = new Item.fromJson({});
      expect(item.saleDates, isNull);
      roundTripItem(item);
    });
  });
}

void _roundTripObject(object, factory(Map<String, dynamic> json)) {
  var json = _loudEncode(object);

  var person2 = factory(JSON.decode(json) as Map<String, dynamic>);

  expect(person2, equals(object));

  var json2 = _loudEncode(person2);

  expect(json2, equals(json));
}

_loudEncode(object) {
  try {
    return JSON.encode(object.toJson());
  } on JsonUnsupportedObjectError catch (e) {
    print(e.cause);
    rethrow;
  }
}
