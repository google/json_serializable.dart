// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// _NonNullableGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides, hash_and_equals
import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'json_test_common.dart';

part 'json_test_example.non_nullable.g.dart';

@JsonSerializable(nullable: false)
class Person extends Object with _$PersonSerializerMixin {
  final String firstName, middleName, lastName;
  final DateTime dateOfBirth;
  @JsonKey(name: '\$house')
  final House house;

  Order order;

  Map<String, House> houseMap;

  Person(this.firstName, this.lastName, this.house,
      {this.middleName, this.dateOfBirth});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  bool operator ==(Object other) =>
      other is Person &&
      firstName == other.firstName &&
      middleName == other.middleName &&
      lastName == other.lastName &&
      dateOfBirth == other.dateOfBirth &&
      house == other.house &&
      deepEquals(houseMap, other.houseMap);
}

@JsonSerializable(nullable: false)
class Order extends Object with _$OrderSerializerMixin {
  /// Used to test that `disallowNullValues: true` forces `includeIfNull: false`
  @JsonKey(disallowNullValue: true)
  int count;
  bool isRushed;

  @JsonKey(nullable: false)
  final Category category;
  final UnmodifiableListView<Item> items;
  Platform platform;
  Map<String, Platform> altPlatforms;

  Uri homepage;

  @JsonKey(ignore: true)
  String get platformValue => platform?.description;

  set platformValue(String value) {
    throw new UnimplementedError('not impld');
  }

  // Ignored getter without value set in ctor
  int get price => items.fold(0, (total, item) => item.price + total);

  @JsonKey(ignore: true)
  bool shouldBeCached;

  Order(this.category, [Iterable<Item> items])
      : this.items = new UnmodifiableListView<Item>(
            new List<Item>.unmodifiable(items ?? const <Item>[]));

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  bool operator ==(Object other) =>
      other is Order &&
      count == other.count &&
      isRushed == other.isRushed &&
      deepEquals(items, other.items) &&
      deepEquals(altPlatforms, other.altPlatforms);
}

@JsonSerializable(nullable: false)
class Item extends ItemCore with _$ItemSerializerMixin {
  @JsonKey(includeIfNull: false, name: 'item-number')
  int itemNumber;
  List<DateTime> saleDates;
  List<int> rates;

  Item([int price]) : super(price);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  bool operator ==(Object other) =>
      other is Item &&
      price == other.price &&
      itemNumber == other.itemNumber &&
      deepEquals(saleDates, other.saleDates);
}

@JsonSerializable(nullable: false)
class Numbers extends Object with _$NumbersSerializerMixin {
  List<int> ints;
  List<num> nums;
  List<double> doubles;

  @JsonKey(nullable: false)
  List<double> nnDoubles;

  @JsonKey(fromJson: durationFromInt, toJson: durationToInt)
  Duration duration;

  @JsonKey(fromJson: dateTimeFromEpochUs, toJson: dateTimeToEpochUs)
  DateTime date;

  Numbers();

  factory Numbers.fromJson(Map<String, dynamic> json) =>
      _$NumbersFromJson(json);

  bool operator ==(Object other) =>
      other is Numbers &&
      deepEquals(ints, other.ints) &&
      deepEquals(nums, other.nums) &&
      deepEquals(doubles, other.doubles) &&
      deepEquals(nnDoubles, other.nnDoubles) &&
      deepEquals(duration, other.duration) &&
      deepEquals(date, other.date);
}
