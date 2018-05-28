// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.non_nullable.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map json) => new KitchenSink(
    ctorValidatedNo42: json['no-42'] as int,
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
  ..map = json['map'] as Map
  ..stringStringMap =
      new Map<String, String>.from(json['stringStringMap'] as Map)
  ..dynamicIntMap = new Map<String, int>.from(json['dynamicIntMap'] as Map)
  ..objectDateTimeMap = (json['objectDateTimeMap'] as Map)
      .map((k, e) => new MapEntry(k, DateTime.parse(e as String)))
  ..crazyComplex = (json['crazyComplex'] as List)
      .map((e) => (e as Map).map((k, e) => new MapEntry(
          k as String,
          (e as Map).map(
              (k, e) => new MapEntry(k as String, (e as List).map((e) => (e as List).map((e) => DateTime.parse(e as String)).toList()).toList())))))
      .toList()
  ..val = new Map<String, bool>.from(json['val'] as Map)
  ..writeNotNull = json['writeNotNull'] as bool
  ..string = json[r'$string'] as String
  ..simpleObject = new SimpleObject.fromJson(json['simpleObject'] as Map)
  ..validatedPropertyNo42 = json['validatedPropertyNo42'] as int;

abstract class _$KitchenSinkSerializerMixin {
  int get ctorValidatedNo42;
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
  Map<dynamic, int> get dynamicIntMap;
  Map<Object, DateTime> get objectDateTimeMap;
  List<Map<String, Map<String, List<List<DateTime>>>>> get crazyComplex;
  Map<String, bool> get val;
  bool get writeNotNull;
  String get string;
  SimpleObject get simpleObject;
  int get validatedPropertyNo42;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'no-42': ctorValidatedNo42,
        'dateTime': dateTime.toIso8601String(),
        'iterable': iterable.toList(),
        'dynamicIterable': dynamicIterable.toList(),
        'objectIterable': objectIterable.toList(),
        'intIterable': intIterable.toList(),
        'datetime-iterable':
            dateTimeIterable.map((e) => e.toIso8601String()).toList(),
        'list': list,
        'dynamicList': dynamicList,
        'objectList': objectList,
        'intList': intList,
        'dateTimeList': dateTimeList.map((e) => e.toIso8601String()).toList(),
        'map': map,
        'stringStringMap': stringStringMap,
        'dynamicIntMap': dynamicIntMap,
        'objectDateTimeMap': objectDateTimeMap
            .map((k, e) => new MapEntry(k, e.toIso8601String())),
        'crazyComplex': crazyComplex
            .map((e) => e.map((k, e) => new MapEntry(
                k,
                e.map((k, e) => new MapEntry(
                    k,
                    e
                        .map((e) => e.map((e) => e.toIso8601String()).toList())
                        .toList())))))
            .toList(),
        'val': val,
        'writeNotNull': writeNotNull,
        r'$string': string,
        'simpleObject': simpleObject,
        'validatedPropertyNo42': validatedPropertyNo42
      };
}
