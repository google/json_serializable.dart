// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_test_example.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => new Person(
    json['firstName'] as String,
    json['lastName'] as String,
    $enumDecodeNullable('House', House.values, json[r'$house'] as String),
    middleName: json['middleName'] as String,
    dateOfBirth: json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String))
  ..order = json['order'] == null
      ? null
      : new Order.fromJson(json['order'] as Map<String, dynamic>)
  ..houseMap = (json['houseMap'] as Map<String, dynamic>)?.map((k, e) =>
      new MapEntry(k, $enumDecodeNullable('House', House.values, e as String)));

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get middleName;
  String get lastName;
  DateTime get dateOfBirth;
  House get house;
  Order get order;
  Map<String, House> get houseMap;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        r'$house': house == null ? null : house.toString().split('.')[1],
        'order': order,
        'houseMap': houseMap?.map((k, e) =>
            new MapEntry(k, e == null ? null : e.toString().split('.')[1]))
      };
}

Order _$OrderFromJson(Map<String, dynamic> json) => new Order(
    $enumDecode('Category', Category.values, json['category'] as String),
    (json['items'] as List)?.map(
        (e) => e == null ? null : new Item.fromJson(e as Map<String, dynamic>)))
  ..count = json['count'] as int
  ..isRushed = json['isRushed'] as bool
  ..platform = json['platform'] == null
      ? null
      : new Platform.fromJson(json['platform'] as String)
  ..altPlatforms = (json['altPlatforms'] as Map<String, dynamic>)?.map((k, e) =>
      new MapEntry(k, e == null ? null : new Platform.fromJson(e as String)));

abstract class _$OrderSerializerMixin {
  int get count;
  bool get isRushed;
  Category get category;
  UnmodifiableListView<Item> get items;
  Platform get platform;
  Map<String, Platform> get altPlatforms;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'isRushed': isRushed,
        'category': category.toString().split('.')[1],
        'items': items,
        'platform': platform,
        'altPlatforms': altPlatforms
      };
}

Item _$ItemFromJson(Map<String, dynamic> json) => new Item(json['price'] as int)
  ..itemNumber = json['item-number'] as int
  ..saleDates = (json['saleDates'] as List)
      ?.map((e) => e == null ? null : DateTime.parse(e as String))
      ?.toList()
  ..rates = (json['rates'] as List)?.map((e) => e as int)?.toList();

abstract class _$ItemSerializerMixin {
  int get price;
  int get itemNumber;
  List<DateTime> get saleDates;
  List<int> get rates;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{
      'price': price,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('item-number', itemNumber);
    val['saleDates'] = saleDates?.map((e) => e?.toIso8601String())?.toList();
    val['rates'] = rates;
    return val;
  }
}

Numbers _$NumbersFromJson(Map<String, dynamic> json) => new Numbers()
  ..ints = (json['ints'] as List)?.map((e) => e as int)?.toList()
  ..nums = (json['nums'] as List)?.map((e) => e as num)?.toList()
  ..doubles =
      (json['doubles'] as List)?.map((e) => (e as num)?.toDouble())?.toList()
  ..nnDoubles =
      (json['nnDoubles'] as List).map((e) => (e as num).toDouble()).toList()
  ..duration =
      json['duration'] == null ? null : _fromJson(json['duration'] as int)
  ..date =
      json['date'] == null ? null : _dateTimeFromEpochUs(json['date'] as int);

abstract class _$NumbersSerializerMixin {
  List<int> get ints;
  List<num> get nums;
  List<double> get doubles;
  List<double> get nnDoubles;
  Duration get duration;
  DateTime get date;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'ints': ints,
        'nums': nums,
        'doubles': doubles,
        'nnDoubles': nnDoubles,
        'duration': duration == null ? null : _toJson(duration),
        'date': date == null ? null : _dateTimeToEpochUs(date)
      };
}
