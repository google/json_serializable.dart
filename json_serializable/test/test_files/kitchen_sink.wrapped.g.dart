// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of json_serializable.test.kitchen_sink_wrapped;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map<String, dynamic> json) => new KitchenSink(
    iterable: json['iterable'] as List,
    dynamicIterable: json['dynamicIterable'] as List,
    objectIterable: json['objectIterable'] as List,
    intIterable: (json['intIterable'] as List)?.map((dynamic e) => e as int),
    dateTimeIterable: (json['datetime-iterable'] as List)
        ?.map((dynamic e) => e == null ? null : DateTime.parse(e as String)))
  ..dateTime = json['dateTime'] == null
      ? null
      : DateTime.parse(json['dateTime'] as String)
  ..list = json['list'] as List
  ..dynamicList = json['dynamicList'] as List
  ..objectList = json['objectList'] as List
  ..intList = (json['intList'] as List)?.map((dynamic e) => e as int)?.toList()
  ..dateTimeList = (json['dateTimeList'] as List)
      ?.map((dynamic e) => e == null ? null : DateTime.parse(e as String))
      ?.toList()
  ..map = json['map'] as Map<String, dynamic>
  ..stringStringMap = json['stringStringMap'] == null
      ? null
      : new Map<String, String>.from(json['stringStringMap'] as Map)
  ..stringIntMap = json['stringIntMap'] == null
      ? null
      : new Map<String, int>.from(json['stringIntMap'] as Map)
  ..stringDateTimeMap = json['stringDateTimeMap'] == null
      ? null
      : new Map<String, DateTime>.fromIterables(
          (json['stringDateTimeMap'] as Map<String, dynamic>).keys,
          (json['stringDateTimeMap'] as Map).values.map(
              (dynamic e) => e == null ? null : DateTime.parse(e as String)))
  ..crazyComplex = (json['crazyComplex'] as List)
      ?.map((dynamic e) => e == null
          ? null
          : new Map<String, Map<String, List<List<DateTime>>>>.fromIterables((e as Map<String, dynamic>).keys, (e as Map).values.map((dynamic e) => e == null ? null : new Map<String, List<List<DateTime>>>.fromIterables((e as Map<String, dynamic>).keys, (e as Map).values.map((dynamic e) => (e as List)?.map((dynamic e) => (e as List)?.map((dynamic e) => e == null ? null : DateTime.parse(e as String))?.toList())?.toList())))))
      ?.toList()
  ..val = json['val'] == null ? null : new Map<String, bool>.from(json['val'] as Map)
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
  Iterable<String> get keys sync* {
    if (_v.dateTime != null) {
      yield 'dateTime';
    }
    if (_v.iterable != null) {
      yield 'iterable';
    }
    yield 'dynamicIterable';
    yield 'objectIterable';
    yield 'intIterable';
    yield 'datetime-iterable';
    yield 'list';
    yield 'dynamicList';
    yield 'objectList';
    yield 'intList';
    if (_v.dateTimeList != null) {
      yield 'dateTimeList';
    }
    yield 'map';
    yield 'stringStringMap';
    yield 'stringIntMap';
    yield 'stringDateTimeMap';
    if (_v.crazyComplex != null) {
      yield 'crazyComplex';
    }
    if (_v.val != null) {
      yield 'val';
    }
    yield 'writeNotNull';
    yield r'$string';
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'dateTime':
          return _v.dateTime?.toIso8601String();
        case 'iterable':
          return _v.iterable?.toList();
        case 'dynamicIterable':
          return _v.dynamicIterable?.toList();
        case 'objectIterable':
          return _v.objectIterable?.toList();
        case 'intIterable':
          return _v.intIterable?.toList();
        case 'datetime-iterable':
          return _v.dateTimeIterable
              ?.map((DateTime e) => e?.toIso8601String())
              ?.toList();
        case 'list':
          return _v.list;
        case 'dynamicList':
          return _v.dynamicList;
        case 'objectList':
          return _v.objectList;
        case 'intList':
          return _v.intList;
        case 'dateTimeList':
          return $wrapListHandleNull<DateTime>(
              _v.dateTimeList, (e) => e?.toIso8601String());
        case 'map':
          return _v.map;
        case 'stringStringMap':
          return _v.stringStringMap;
        case 'stringIntMap':
          return _v.stringIntMap;
        case 'stringDateTimeMap':
          return $wrapMapHandleNull<String, DateTime>(
              _v.stringDateTimeMap, (e) => e?.toIso8601String());
        case 'crazyComplex':
          return $wrapListHandleNull<
                  Map<String, Map<String, List<List<DateTime>>>>>(
              _v.crazyComplex,
              (e) =>
                  $wrapMapHandleNull<String, Map<String, List<List<DateTime>>>>(
                      e,
                      (e) => $wrapMapHandleNull<String, List<List<DateTime>>>(
                          e,
                          (e) => $wrapListHandleNull<List<DateTime>>(
                              e,
                              (e) => $wrapListHandleNull<DateTime>(
                                  e, (e) => e?.toIso8601String())))));
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
