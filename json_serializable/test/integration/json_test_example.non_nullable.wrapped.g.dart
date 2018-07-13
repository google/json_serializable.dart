// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_test_example.non_nullable.wrapped.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return new Person(json['firstName'] as String, json['lastName'] as String,
      _$enumDecode(_$CategoryEnumMap, json[r'$house']),
      middleName: json['middleName'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String))
    ..order = new Order.fromJson(json['order'] as Map<String, dynamic>)
    ..houseMap = (json['houseMap'] as Map<String, dynamic>)
        .map((k, e) => new MapEntry(k, _$enumDecode(_$CategoryEnumMap, e)));
}

Map<String, dynamic> _$PersonToJson(Person instance) =>
    new _$PersonJsonMapWrapper(instance);

class _$PersonJsonMapWrapper extends $JsonMapWrapper {
  final Person _v;
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
          return _v.dateOfBirth.toIso8601String();
        case r'$house':
          return _$CategoryEnumMap[_v.house];
        case 'order':
          return _v.order;
        case 'houseMap':
          return $wrapMap<String, Category>(
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
      (json['items'] as List)
          .map((e) => new Item.fromJson(e as Map<String, dynamic>)))
    ..count = json['count'] as int
    ..isRushed = json['isRushed'] as bool
    ..platform = new Platform.fromJson(json['platform'] as String)
    ..altPlatforms = (json['altPlatforms'] as Map<String, dynamic>)
        .map((k, e) => new MapEntry(k, new Platform.fromJson(e as String)))
    ..homepage = Uri.parse(json['homepage'] as String)
    ..statusCode =
        _$enumDecodeNullable(_$StatusCodeEnumMap, json['status_code']) ??
            StatusCode.success;
}

Map<String, dynamic> _$OrderToJson(Order instance) =>
    new _$OrderJsonMapWrapper(instance);

class _$OrderJsonMapWrapper extends $JsonMapWrapper {
  final Order _v;
  _$OrderJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const [
        'count',
        'isRushed',
        'category',
        'items',
        'platform',
        'altPlatforms',
        'homepage',
        'status_code'
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
          return _$CategoryEnumMap[_v.category];
        case 'items':
          return _v.items;
        case 'platform':
          return _v.platform;
        case 'altPlatforms':
          return _v.altPlatforms;
        case 'homepage':
          return _v.homepage.toString();
        case 'status_code':
          return _$StatusCodeEnumMap[_v.statusCode];
      }
    }
    return null;
  }
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$StatusCodeEnumMap = const <StatusCode, dynamic>{
  StatusCode.success: 200,
  StatusCode.notFound: 404
};

Item _$ItemFromJson(Map<String, dynamic> json) {
  return new Item(json['price'] as int)
    ..itemNumber = json['item-number'] as int
    ..saleDates = (json['saleDates'] as List)
        .map((e) => DateTime.parse(e as String))
        .toList()
    ..rates = (json['rates'] as List).map((e) => e as int).toList();
}

Map<String, dynamic> _$ItemToJson(Item instance) =>
    new _$ItemJsonMapWrapper(instance);

class _$ItemJsonMapWrapper extends $JsonMapWrapper {
  final Item _v;
  _$ItemJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys =>
      const ['price', 'item-number', 'saleDates', 'rates'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'price':
          return _v.price;
        case 'item-number':
          return _v.itemNumber;
        case 'saleDates':
          return $wrapList<DateTime>(_v.saleDates, (e) => e.toIso8601String());
        case 'rates':
          return _v.rates;
      }
    }
    return null;
  }
}

Numbers _$NumbersFromJson(Map<String, dynamic> json) {
  return new Numbers()
    ..ints = (json['ints'] as List).map((e) => e as int).toList()
    ..nums = (json['nums'] as List).map((e) => e as num).toList()
    ..doubles =
        (json['doubles'] as List).map((e) => (e as num).toDouble()).toList()
    ..nnDoubles =
        (json['nnDoubles'] as List).map((e) => (e as num).toDouble()).toList()
    ..duration = durationFromInt(json['duration'] as int)
    ..date = dateTimeFromEpochUs(json['date'] as int);
}

Map<String, dynamic> _$NumbersToJson(Numbers instance) =>
    new _$NumbersJsonMapWrapper(instance);

class _$NumbersJsonMapWrapper extends $JsonMapWrapper {
  final Numbers _v;
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
          return durationToInt(_v.duration);
        case 'date':
          return dateTimeToEpochUs(_v.date);
      }
    }
    return null;
  }
}
