// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'dart:ui';

part 'example.g.dart';

@JsonSerializable(createEqual: true)
class Person {
  final String firstName;
  @JsonKey(includeIfNull: false)
  final String? middleName;
  final String lastName;

  @JsonKey(name: 'date-of-birth')
  final DateTime dateOfBirth;

  @JsonKey(name: 'last-order')
  final DateTime? lastOrder;

  List<Order> orders;

  Person(
    this.firstName,
    this.lastName,
    this.dateOfBirth, {
    this.middleName,
    this.lastOrder,
    List<Order>? orders,
  }) : orders = orders ?? <Order>[];

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  bool operator ==(Object other) => _$PersonIsEqual(this, other);

  int get hashCode => _$PersonHashCode(this);
}

@JsonSerializable(includeIfNull: false, createEqual: true)
class Order {
  int? count;
  int? itemNumber;
  bool? isRushed;
  Item? item;

  @JsonKey(
      name: 'prep-time',
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration? prepTime;

  @JsonKey(fromJson: _dateTimeFromEpochUs, toJson: _dateTimeToEpochUs)
  final DateTime date;

  Order(this.date);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  static Duration? _durationFromMilliseconds(int? milliseconds) =>
      milliseconds == null ? null : Duration(milliseconds: milliseconds);

  static int? _durationToMilliseconds(Duration? duration) =>
      duration?.inMilliseconds;

  static DateTime _dateTimeFromEpochUs(int us) =>
      DateTime.fromMicrosecondsSinceEpoch(us);

  static int? _dateTimeToEpochUs(DateTime? dateTime) =>
      dateTime?.microsecondsSinceEpoch;

  @override
  bool operator ==(Object other) => _$OrderIsEqual(this, other);

  int get hashCode => _$OrderHashCode(this);
}

@JsonSerializable(createEqual: false)
class Item {
  int? count;
  int? itemNumber;
  bool? isRushed;

  Item();

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonLiteral('data.json')
Map get glossaryData => _$glossaryDataJsonLiteral;
