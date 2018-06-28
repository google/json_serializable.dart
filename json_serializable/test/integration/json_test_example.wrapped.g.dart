// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_test_example.wrapped.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return new Person(json['firstName'] as String, json['lastName'] as String,
      _$enumDecodeNullable(_$CategoryEnumMap, json[r'$house']),
      middleName: json['middleName'] as String,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String))
    ..order = json['order'] == null
        ? null
        : new Order.fromJson(json['order'] as Map<String, dynamic>)
    ..houseMap = (json['houseMap'] as Map<String, dynamic>)?.map(
        (k, e) => new MapEntry(k, _$enumDecodeNullable(_$CategoryEnumMap, e)));
}

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get middleName;
  String get lastName;
  DateTime get dateOfBirth;
  Category get house;
  Order get order;
  Map<String, Category> get houseMap;
  Map<String, dynamic> toJson() => new _$PersonJsonMapWrapper(this);
}

class _$PersonJsonMapWrapper extends $JsonMapWrapper {
  final _$PersonSerializerMixin _v;
  _$PersonJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const [
        'firstName',
        'middleName',
        'lastName',
        'dateOfBirth',
        r'$house',
        'order',
        'houseMap'
      ];

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
          return _$CategoryEnumMap[_v.house];
        case 'order':
          return _v.order;
        case 'houseMap':
          return $wrapMapHandleNull<String, Category>(
              _v.houseMap, (e) => _$CategoryEnumMap[e]);
      }
    }
    return null;
  }
}

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw new ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw new ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$CategoryEnumMap = const <Category, dynamic>{
  Category.top: 'top',
  Category.bottom: 'bottom',
  Category.strange: 'strange',
  Category.charmed: 'charmed',
  Category.up: 'up',
  Category.down: 'down',
  Category.notDiscoveredYet: 'not_discovered_yet'
};

Order _$OrderFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['count']);
  return new Order(
      _$enumDecode(_$CategoryEnumMap, json['category']),
      (json['items'] as List)?.map((e) =>
          e == null ? null : new Item.fromJson(e as Map<String, dynamic>)))
    ..count = json['count'] as int
    ..isRushed = json['isRushed'] as bool
    ..platform = json['platform'] == null
        ? null
        : new Platform.fromJson(json['platform'] as String)
    ..altPlatforms = (json['altPlatforms'] as Map<String, dynamic>)?.map((k,
            e) =>
        new MapEntry(k, e == null ? null : new Platform.fromJson(e as String)))
    ..homepage =
        json['homepage'] == null ? null : Uri.parse(json['homepage'] as String)
    ..statusCode =
        _$enumDecodeNullable(_$StatusCodeEnumMap, json['status_code']) ??
            StatusCode.success;
}

abstract class _$OrderSerializerMixin {
  int get count;
  bool get isRushed;
  Category get category;
  UnmodifiableListView<Item> get items;
  Platform get platform;
  Map<String, Platform> get altPlatforms;
  Uri get homepage;
  StatusCode get statusCode;
  Map<String, dynamic> toJson() => new _$OrderJsonMapWrapper(this);
}

class _$OrderJsonMapWrapper extends $JsonMapWrapper {
  final _$OrderSerializerMixin _v;
  _$OrderJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys sync* {
    if (_v.count != null) {
      yield 'count';
    }
    yield 'isRushed';
    yield 'category';
    yield 'items';
    yield 'platform';
    yield 'altPlatforms';
    yield 'homepage';
    yield 'status_code';
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'count':
          return _v.count;
        case 'isRushed':
          return _v.isRushed;
        case 'category':
          return _$CategoryEnumMap[_v.category];
        case 'items':
          return _v.items;
        case 'platform':
          return _v.platform;
        case 'altPlatforms':
          return _v.altPlatforms;
        case 'homepage':
          return _v.homepage?.toString();
        case 'status_code':
          return _$StatusCodeEnumMap[_v.statusCode];
      }
    }
    return null;
  }
}

const _$StatusCodeEnumMap = const <StatusCode, dynamic>{
  StatusCode.success: 200,
  StatusCode.notFound: 404
};

Item _$ItemFromJson(Map<String, dynamic> json) {
  return new Item(json['price'] as int)
    ..itemNumber = json['item-number'] as int
    ..saleDates = (json['saleDates'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String))
        ?.toList()
    ..rates = (json['rates'] as List)?.map((e) => e as int)?.toList();
}

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

Numbers _$NumbersFromJson(Map<String, dynamic> json) {
  return new Numbers()
    ..ints = (json['ints'] as List)?.map((e) => e as int)?.toList()
    ..nums = (json['nums'] as List)?.map((e) => e as num)?.toList()
    ..doubles =
        (json['doubles'] as List)?.map((e) => (e as num)?.toDouble())?.toList()
    ..nnDoubles =
        (json['nnDoubles'] as List).map((e) => (e as num).toDouble()).toList()
    ..duration = json['duration'] == null
        ? null
        : durationFromInt(json['duration'] as int)
    ..date =
        json['date'] == null ? null : dateTimeFromEpochUs(json['date'] as int);
}

abstract class _$NumbersSerializerMixin {
  List<int> get ints;
  List<num> get nums;
  List<double> get doubles;
  List<double> get nnDoubles;
  Duration get duration;
  DateTime get date;
  Map<String, dynamic> toJson() => new _$NumbersJsonMapWrapper(this);
}

class _$NumbersJsonMapWrapper extends $JsonMapWrapper {
  final _$NumbersSerializerMixin _v;
  _$NumbersJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys =>
      const ['ints', 'nums', 'doubles', 'nnDoubles', 'duration', 'date'];

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
        case 'duration':
          return _v.duration == null ? null : durationToInt(_v.duration);
        case 'date':
          return _v.date == null ? null : dateTimeToEpochUs(_v.date);
      }
    }
    return null;
  }
}
