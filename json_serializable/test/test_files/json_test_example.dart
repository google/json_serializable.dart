// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides, hash_and_equals
library json_serializable.test.example;

import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_test_example.g.dart';

enum House { gryffindor, hufflepuff, ravenclaw, slytherin }

@JsonSerializable()
class Person extends Object with _$PersonSerializerMixin {
  final String firstName, middleName, lastName;
  final DateTime dateOfBirth;
  final House house;

  Person(this.firstName, this.lastName, this.house,
      {this.middleName, this.dateOfBirth});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  bool operator ==(Object other) =>
      other is Person &&
      firstName == other.firstName &&
      middleName == other.middleName &&
      lastName == other.lastName &&
      dateOfBirth == other.dateOfBirth &&
      house == other.house;
}

enum Category { top, bottom, strange, charmed, up, down }

@JsonSerializable()
class Order extends Object with _$OrderSerializerMixin {
  int count;
  bool isRushed;

  @JsonKey(nullable: false)
  final Category category;
  final UnmodifiableListView<Item> items;
  Platform platform;
  Map<String, Platform> altPlatforms;

  int get price => items.fold(0, (total, item) => item.price + total);

  Order(this.category, [Iterable<Item> items])
      : this.items = new UnmodifiableListView<Item>(
            new List<Item>.unmodifiable(items ?? const <Item>[]));

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  bool operator ==(Object other) =>
      other is Order &&
      count == other.count &&
      isRushed == other.isRushed &&
      _deepEquals(items, other.items) &&
      _deepEquals(altPlatforms, other.altPlatforms);
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

class Platform {
  final String description;

  static const Platform foo = const Platform._('foo');
  static const Platform undefined = const Platform._('undefined');
  const Platform._(this.description);

  factory Platform.fromJson(String value) {
    switch (value) {
      case 'foo':
        return foo;
      case 'undefined':
        return undefined;
      default:
        throw new ArgumentError.value(value, 'value', 'Not a supported value.');
    }
  }

  String toJson() => description;
}

@JsonSerializable()
class Numbers extends Object with _$NumbersSerializerMixin {
  List<int> ints;
  List<num> nums;
  List<double> doubles;

  @JsonKey(nullable: false)
  List<double> nnDoubles;

  Numbers();

  factory Numbers.fromJson(Map<String, dynamic> json) =>
      _$NumbersFromJson(json);

  bool operator ==(Object other) =>
      other is Numbers &&
      _deepEquals(ints, other.ints) &&
      _deepEquals(nums, other.nums) &&
      _deepEquals(doubles, other.doubles) &&
      _deepEquals(nnDoubles, other.nnDoubles);
}
