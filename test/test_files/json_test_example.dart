// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library json_serializable.test.example;

import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:json_serializable/annotations.dart';

part 'json_test_example.g.dart';

@JsonSerializable()
class KitchenSink extends Object with _$KitchenSinkSerializerMixin {
  // To ensure static members are not considered for serialization.
  static const answer = 42;
  static final reason = 42;
  static int get understand => 42;

  // NOTE: exposing these as Iterable, but storing the values as List
  // to make the equality test work trivially.
  final Iterable _iterable;
  final Iterable<dynamic> _dynamicIterable;
  final Iterable<Object> _objectIterable;
  final Iterable<int> _intIterable;
  final Iterable<DateTime> _dateTimeIterable;

  KitchenSink(
      {Iterable iterable,
      Iterable<dynamic> dynamicIterable,
      Iterable<Object> objectIterable,
      Iterable<int> intIterable,
      Iterable<DateTime> dateTimeIterable})
      : _iterable = iterable?.toList(),
        _dynamicIterable = dynamicIterable?.toList(),
        _objectIterable = objectIterable?.toList(),
        _intIterable = intIterable?.toList(),
        _dateTimeIterable = dateTimeIterable?.toList();

  factory KitchenSink.fromJson(Map<String, Object> json) =>
      _$KitchenSinkFromJson(json);

  Iterable get iterable => _iterable;
  Iterable<dynamic> get dynamicIterable => _dynamicIterable;
  Iterable<Object> get objectIterable => _objectIterable;
  Iterable<int> get intIterable => _intIterable;
  Iterable<DateTime> get dateTimeIterable => _dateTimeIterable;

  List list;
  List<dynamic> dynamicList;
  List<Object> objectList;
  List<int> intList;
  List<DateTime> dateTimeList;

  Map map;
  Map<String, String> stringStringMap;
  Map<String, int> stringIntMap;
  Map<String, DateTime> stringDateTimeMap;

  //TODO(kevmoo) - finish this...
  bool operator ==(Object other) =>
      other is KitchenSink &&
      _deepEquals(iterable, other.iterable) &&
      _deepEquals(dynamicIterable, other.dynamicIterable) &&
      _deepEquals(dateTimeIterable, other.dateTimeIterable) &&
      _deepEquals(dateTimeList, other.dateTimeList) &&
      _deepEquals(stringDateTimeMap, other.stringDateTimeMap);
}

@JsonSerializable()
class Person extends Object with _$PersonSerializerMixin {
  final String firstName, middleName, lastName;
  final DateTime dateOfBirth;

  Person(this.firstName, this.lastName, {this.middleName, this.dateOfBirth});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  bool operator ==(Object other) =>
      other is Person &&
      firstName == other.firstName &&
      middleName == other.middleName &&
      lastName == other.lastName &&
      dateOfBirth == other.dateOfBirth;
}

@JsonSerializable()
class Order extends Object with _$OrderSerializerMixin {
  int count;
  bool isRushed;
  final UnmodifiableListView<Item> items;

  int get price => items.fold(0, (total, item) => item.price + total);

  Order([Iterable<Item> items])
      : this.items = new UnmodifiableListView<Item>(
            new List<Item>.unmodifiable(items ?? const <Item>[]));

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  bool operator ==(Object other) =>
      other is Order &&
      count == other.count &&
      isRushed == other.isRushed &&
      _deepEquals(items, other.items);
}

@JsonSerializable()
class Item extends Object with _$ItemSerializerMixin {
  final int price;
  int itemNumber;
  List<DateTime> saleDates;
  List<int> rates;

  Item([this.price]);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  bool operator ==(Object other) =>
      other is Item &&
      price == other.price &&
      itemNumber == other.itemNumber &&
      _deepEquals(saleDates, other.saleDates);
}

bool _deepEquals(a, b) => const DeepCollectionEquality().equals(a, b);
