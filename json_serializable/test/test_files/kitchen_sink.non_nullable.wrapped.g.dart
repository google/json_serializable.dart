// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of json_serializable.test.kitchen_sink.non_nullable_wrapped;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map<String, dynamic> json) => new KitchenSink(
    iterable: json['iterable'] as List,
    dynamicIterable: json['dynamicIterable'] as List,
    objectIterable: json['objectIterable'] as List,
    intIterable: (json['intIterable'] as List).map((e) => e as int),
    dateTimeIterable: (json['datetime-iterable'] as List)
        .map((e) => DateTime.parse(e as String)))
  ..dateTime = DateTime.parse(json['dateTime'] as String)
  ..list = json['list'] as List
  ..dynamicList = json['dynamicList'] as List
  ..objectList = json['objectList'] as List
  ..intList = (json['intList'] as List).map((e) => e as int).toList()
  ..dateTimeList = (json['dateTimeList'] as List)
      .map((e) => DateTime.parse(e as String))
      .toList()
  ..map = json['map'] as Map<String, dynamic>
  ..stringStringMap =
      new Map<String, String>.from(json['stringStringMap'] as Map)
  ..stringIntMap = new Map<String, int>.from(json['stringIntMap'] as Map)
  ..stringDateTimeMap = new Map<String, DateTime>.fromIterables(
      (json['stringDateTimeMap'] as Map<String, dynamic>).keys,
      (json['stringDateTimeMap'] as Map)
          .values
          .map((e) => DateTime.parse(e as String)))
  ..crazyComplex = (json['crazyComplex'] as List)
      .map((e) => new Map<String, Map<String, List<List<DateTime>>>>.fromIterables(
          (e as Map<String, dynamic>).keys,
          (e as Map).values.map((e) =>
              new Map<String, List<List<DateTime>>>.fromIterables((e as Map<String, dynamic>).keys, (e as Map).values.map((e) => (e as List).map((e) => (e as List).map((e) => DateTime.parse(e as String)).toList()).toList())))))
      .toList()
  ..val = new Map<String, bool>.from(json['val'] as Map)
  ..writeNotNull = json['writeNotNull'] as bool
  ..string = json[r'$string'] as String;

abstract class _$KitchenSinkSerializerMixin {
  DateTime get dateTime;
  Iterable<dynamic> get iterable;
  Iterable<dynamic> get dynamicIterable;
  Iterable<Object> get objectIterable;
  Iterable<int> get intIterable;
  Iterable<DateTime> get dateTimeIterable;
  List<dynamic> get list;
  List<dynamic> get dynamicList;
  List<Object> get objectList;
  List<int> get intList;
  List<DateTime> get dateTimeList;
  Map<dynamic, dynamic> get map;
  Map<String, String> get stringStringMap;
  Map<String, int> get stringIntMap;
  Map<String, DateTime> get stringDateTimeMap;
  List<Map<String, Map<String, List<List<DateTime>>>>> get crazyComplex;
  Map<String, bool> get val;
  bool get writeNotNull;
  String get string;
  Map<String, dynamic> toJson() => new _$KitchenSinkJsonMapWrapper(this);
}

class _$KitchenSinkJsonMapWrapper extends $JsonMapWrapper {
  final _$KitchenSinkSerializerMixin _v;
  _$KitchenSinkJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const [
        'dateTime',
        'iterable',
        'dynamicIterable',
        'objectIterable',
        'intIterable',
        'datetime-iterable',
        'list',
        'dynamicList',
        'objectList',
        'intList',
        'dateTimeList',
        'map',
        'stringStringMap',
        'stringIntMap',
        'stringDateTimeMap',
        'crazyComplex',
        'val',
        'writeNotNull',
        r'$string'
      ];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'dateTime':
          return _v.dateTime.toIso8601String();
        case 'iterable':
          return _v.iterable.toList();
        case 'dynamicIterable':
          return _v.dynamicIterable.toList();
        case 'objectIterable':
          return _v.objectIterable.toList();
        case 'intIterable':
          return _v.intIterable.toList();
        case 'datetime-iterable':
          return _v.dateTimeIterable.map((e) => e.toIso8601String()).toList();
        case 'list':
          return _v.list;
        case 'dynamicList':
          return _v.dynamicList;
        case 'objectList':
          return _v.objectList;
        case 'intList':
          return _v.intList;
        case 'dateTimeList':
          return $wrapList<DateTime>(
              _v.dateTimeList, (e) => e.toIso8601String());
        case 'map':
          return _v.map;
        case 'stringStringMap':
          return _v.stringStringMap;
        case 'stringIntMap':
          return _v.stringIntMap;
        case 'stringDateTimeMap':
          return $wrapMap<String, DateTime>(
              _v.stringDateTimeMap, (e) => e.toIso8601String());
        case 'crazyComplex':
          return $wrapList<Map<String, Map<String, List<List<DateTime>>>>>(
              _v.crazyComplex,
              (e) => $wrapMap<String, Map<String, List<List<DateTime>>>>(
                  e,
                  (e) => $wrapMap<String, List<List<DateTime>>>(
                      e,
                      (e) => $wrapList<List<DateTime>>(
                          e,
                          (e) => $wrapList<DateTime>(
                              e, (e) => e.toIso8601String())))));
        case 'val':
          return _v.val;
        case 'writeNotNull':
          return _v.writeNotNull;
        case r'$string':
          return _v.string;
      }
    }
    return null;
  }
}
