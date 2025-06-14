// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: hash_and_equals
import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

import '../test_utils.dart';
import 'json_test_common.dart';

part 'json_test_example.g.dart';

@JsonSerializable()
class Person {
  final String firstName, lastName;
  final String? middleName;
  final DateTime? dateOfBirth;
  @JsonKey(name: '\$house')
  final Category house;

  Order? order;

  MyList<Order>? customOrders;

  Map<String, Category>? houseMap;
  Map<Category, int>? categoryCounts;

  Person(
    this.firstName,
    this.lastName,
    this.house, {
    this.middleName,
    this.dateOfBirth,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Person &&
      firstName == other.firstName &&
      middleName == other.middleName &&
      lastName == other.lastName &&
      dateOfBirth == other.dateOfBirth &&
      house == other.house &&
      deepEquals(houseMap, other.houseMap);
}

@JsonSerializable(constructor: 'custom')
class Order {
  /// Used to test that `disallowNullValues: true` forces `includeIfNull: false`
  @JsonKey(disallowNullValue: true)
  int? count;
  bool? isRushed;

  Duration? duration;

  final Category? category;
  final UnmodifiableListView<Item>? items;
  Platform? platform;
  Map<String, Platform>? altPlatforms;

  Uri? homepage;

  @JsonKey(
    name: 'status_code',
    defaultValue: StatusCode.success,
    unknownEnumValue: StatusCode.unknown,
  )
  StatusCode? statusCode;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get platformValue => platform!.description;

  set platformValue(String value) {
    throw UnimplementedError('not impld');
  }

  // Ignored getter without value set in ctor
  int get price => items!.fold(0, (total, item) => item.price! + total);

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? shouldBeCached;

  Order.custom(this.category, [Iterable<Item>? items])
    : items = UnmodifiableListView<Item>(
        List<Item>.unmodifiable(items ?? const <Item>[]),
      );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Order &&
      count == other.count &&
      isRushed == other.isRushed &&
      deepEquals(items, other.items) &&
      deepEquals(altPlatforms, other.altPlatforms);
}

@JsonSerializable()
class Item extends ItemCore {
  @JsonKey(includeIfNull: false, name: 'item-number')
  int? itemNumber;
  List<DateTime>? saleDates;
  List<int>? rates;

  // Regression test for https://github.com/google/json_serializable.dart/issues/896
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  GeoPoint? geoPoint;

  Item([super.price]);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Item &&
      price == other.price &&
      itemNumber == other.itemNumber &&
      deepEquals(saleDates, other.saleDates);
}

GeoPoint? _fromJsonGeoPoint(Map<String, dynamic>? json) {
  if (json != null) {
    return GeoPoint(json['latitude'], json['longitude']);
  } else {
    return null;
  }
}

Map<String, dynamic>? _toJsonGeoPoint(GeoPoint? geoPoint) {
  if (geoPoint == null) {
    return null;
  }
  return {'latitude': geoPoint.latitude, 'longitude': geoPoint.longitude};
}

class GeoPoint {
  final Object? latitude, longitude;

  GeoPoint(this.latitude, this.longitude);
}

@JsonSerializable()
class Numbers {
  List<int>? ints;
  List<num>? nums;
  List<double>? doubles;

  List<double>? nnDoubles;

  @JsonKey(fromJson: durationFromInt, toJson: durationToInt)
  Duration? duration;

  @JsonKey(fromJson: stringFromDouble, toJson: stringToDouble)
  String? doubleAsString;

  @JsonKey(fromJson: dateTimeFromEpochUs, toJson: dateTimeToEpochUs)
  DateTime? date;

  Numbers();

  factory Numbers.fromJson(Map<String, dynamic> json) =>
      _$NumbersFromJson(json);

  Map<String, dynamic> toJson() => _$NumbersToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Numbers &&
      deepEquals(ints, other.ints) &&
      deepEquals(nums, other.nums) &&
      deepEquals(doubles, other.doubles) &&
      deepEquals(nnDoubles, other.nnDoubles) &&
      deepEquals(duration, other.duration) &&
      deepEquals(date, other.date);
}

@JsonSerializable()
class MapKeyVariety {
  Map<int, int>? intIntMap;
  Map<Uri, int>? uriIntMap;
  Map<DateTime, int>? dateTimeIntMap;
  Map<BigInt, int>? bigIntMap;

  MapKeyVariety();

  factory MapKeyVariety.fromJson(Map<String, dynamic> json) =>
      _$MapKeyVarietyFromJson(json);

  Map<String, dynamic> toJson() => _$MapKeyVarietyToJson(this);

  @override
  bool operator ==(Object other) =>
      other is MapKeyVariety &&
      deepEquals(other.intIntMap, intIntMap) &&
      deepEquals(other.uriIntMap, uriIntMap) &&
      deepEquals(other.dateTimeIntMap, dateTimeIntMap) &&
      deepEquals(other.bigIntMap, bigIntMap);
}

@JsonSerializable(createToJson: false)
class UnknownEnumValue {
  @JsonKey(unknownEnumValue: Category.notDiscoveredYet)
  late Category enumValue;

  @JsonKey(unknownEnumValue: Category.notDiscoveredYet)
  late Iterable<Category> enumIterable;

  @JsonKey(unknownEnumValue: Category.notDiscoveredYet)
  late List<Category> enumList;

  @JsonKey(unknownEnumValue: Category.notDiscoveredYet)
  late Set<Category> enumSet;

  UnknownEnumValue();

  factory UnknownEnumValue.fromJson(Map<String, dynamic> json) =>
      _$UnknownEnumValueFromJson(json);
}

@JsonSerializable(constructor: '_')
class PrivateConstructor {
  static int _id = 0;

  final int id;
  final String value;

  PrivateConstructor._(this.id, this.value);

  PrivateConstructor(this.value) : id = _id++;

  factory PrivateConstructor.fromJson(Map<String, dynamic> json) =>
      _$PrivateConstructorFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateConstructorToJson(this);

  @override
  bool operator ==(Object other) =>
      other is PrivateConstructor && id == other.id && value == other.value;
}

mixin RegressionTestIssue1210Mixin {
  bool? get someProperty => null;

  @override
  int get hashCode => identityHashCode(this);
}

@JsonSerializable()
class RegressionTestIssue1210 with RegressionTestIssue1210Mixin {
  const RegressionTestIssue1210(this.field);

  factory RegressionTestIssue1210.fromJson(Map<String, dynamic> json) =>
      _$RegressionTestIssue1210FromJson(json);
  final String field;

  Map<String, dynamic> toJson() => _$RegressionTestIssue1210ToJson(this);
}
