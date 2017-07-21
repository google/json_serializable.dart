// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library json_serializable.example;

import 'package:json_serializable/annotations.dart';
part 'example.g.dart';

@JsonSerializable()
class Person extends Object with _$PersonSerializerMixin {
  final String firstName, middleName, lastName;

  @JsonKey('date-of-birth')
  final DateTime dateOfBirth;
  List<Order> orders;

  Person(this.firstName, this.lastName, {this.middleName, this.dateOfBirth});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}

@JsonSerializable()
class Order extends Object with _$OrderSerializerMixin {
  int count;
  int itemNumber;
  bool isRushed;
  Item item;

  Order();

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@JsonSerializable(createToJson: false)
class Item {
  int count;
  int itemNumber;
  bool isRushed;

  Item();

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@JsonLiteral('data.json')
Map get glossaryData => _$glossaryDataJsonLiteral;
