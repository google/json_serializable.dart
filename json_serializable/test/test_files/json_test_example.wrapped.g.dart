// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of json_serializable.test.json_test_example_wrapped;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => new Person(
    json['firstName'] as String,
    json['lastName'] as String,
    json[r'$house'] == null
        ? null
        : House.values
            .singleWhere((x) => x.toString() == "House.${json[r'$house']}"),
    middleName: json['middleName'] as String,
    dateOfBirth: json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String));

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get middleName;
  String get lastName;
  DateTime get dateOfBirth;
  House get house;
  Map<String, dynamic> toJson() => new _$PersonJsonMapWrapper(this);
}

class _$PersonJsonMapWrapper extends $JsonMapWrapper {
  final _$PersonSerializerMixin _v;
  _$PersonJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys =>
      const ['firstName', 'middleName', 'lastName', 'dateOfBirth', r'$house'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'firstName':
          return _v.firstName;
        case 'middleName':
          return _v.middleName;
        case 'lastName':
          return _v.lastName;
        case 'dateOfBirth':
          return _v.dateOfBirth?.toIso8601String();
        case r'$house':
          return _v.house == null ? null : _v.house.toString().split('.')[1];
      }
    }
    return null;
  }
}

Order _$OrderFromJson(Map<String, dynamic> json) => new Order(
    Category.values
        .singleWhere((x) => x.toString() == "Category.${json['category']}"),
    (json['items'] as List)?.map((dynamic e) =>
        e == null ? null : new Item.fromJson(e as Map<String, dynamic>)))
  ..count = json['count'] as int
  ..isRushed = json['isRushed'] as bool
  ..platform = json['platform'] == null
      ? null
      : new Platform.fromJson(json['platform'] as String)
  ..altPlatforms = json['altPlatforms'] == null
      ? null
      : new Map<String, Platform>.fromIterables(
          (json['altPlatforms'] as Map<String, dynamic>).keys,
          (json['altPlatforms'] as Map).values.map((dynamic e) =>
              e == null ? null : new Platform.fromJson(e as String)));

abstract class _$OrderSerializerMixin {
  int get count;
  bool get isRushed;
  Category get category;
  UnmodifiableListView<Item> get items;
  Platform get platform;
  Map<String, Platform> get altPlatforms;
  Map<String, dynamic> toJson() => new _$OrderJsonMapWrapper(this);
}

class _$OrderJsonMapWrapper extends $JsonMapWrapper {
  final _$OrderSerializerMixin _v;
  _$OrderJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const [
        'count',
        'isRushed',
        'category',
        'items',
        'platform',
        'altPlatforms'
      ];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'count':
          return _v.count;
        case 'isRushed':
          return _v.isRushed;
        case 'category':
          return _v.category.toString().split('.')[1];
        case 'items':
          return _v.items;
        case 'platform':
          return _v.platform;
        case 'altPlatforms':
          return _v.altPlatforms;
      }
    }
    return null;
  }
}

Item _$ItemFromJson(Map<String, dynamic> json) => new Item(json['price'] as int)
  ..itemNumber = json['item-number'] as int
  ..saleDates = (json['saleDates'] as List)
      ?.map((dynamic e) => e == null ? null : DateTime.parse(e as String))
      ?.toList()
  ..rates = (json['rates'] as List)?.map((dynamic e) => e as int)?.toList();

abstract class _$ItemSerializerMixin {
  int get price;
  int get itemNumber;
  List<DateTime> get saleDates;
  List<int> get rates;
  Map<String, dynamic> toJson() => new _$ItemJsonMapWrapper(this);
}

class _$ItemJsonMapWrapper extends $JsonMapWrapper {
  final _$ItemSerializerMixin _v;
  _$ItemJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys sync* {
    yield 'price';
    if (_v.itemNumber != null) {
      yield 'item-number';
    }
    yield 'saleDates';
    yield 'rates';
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'price':
          return _v.price;
        case 'item-number':
          return _v.itemNumber;
        case 'saleDates':
          return $wrapListHandleNull<DateTime>(
              _v.saleDates, (e) => e?.toIso8601String());
        case 'rates':
          return _v.rates;
      }
    }
    return null;
  }
}

Numbers _$NumbersFromJson(Map<String, dynamic> json) => new Numbers()
  ..ints = (json['ints'] as List)?.map((dynamic e) => e as int)?.toList()
  ..nums = (json['nums'] as List)?.map((dynamic e) => e as num)?.toList()
  ..doubles = (json['doubles'] as List)
      ?.map((dynamic e) => (e as num)?.toDouble())
      ?.toList()
  ..nnDoubles = (json['nnDoubles'] as List)
      .map((dynamic e) => (e as num).toDouble())
      .toList();

abstract class _$NumbersSerializerMixin {
  List<int> get ints;
  List<num> get nums;
  List<double> get doubles;
  List<double> get nnDoubles;
  Map<String, dynamic> toJson() => new _$NumbersJsonMapWrapper(this);
}

class _$NumbersJsonMapWrapper extends $JsonMapWrapper {
  final _$NumbersSerializerMixin _v;
  _$NumbersJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const ['ints', 'nums', 'doubles', 'nnDoubles'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'ints':
          return _v.ints;
        case 'nums':
          return _v.nums;
        case 'doubles':
          return _v.doubles;
        case 'nnDoubles':
          return _v.nnDoubles;
      }
    }
    return null;
  }
}
