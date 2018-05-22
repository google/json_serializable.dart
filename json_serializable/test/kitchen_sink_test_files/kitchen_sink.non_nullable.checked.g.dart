// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.non_nullable.checked.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map json) =>
    $checkedNew('KitchenSink', json, () {
      var val = new KitchenSink(
          ctorValidatedNo42: $checkedConvert(json, 'no-42', (v) => v as int),
          iterable: $checkedConvert(json, 'iterable', (v) => v as List),
          dynamicIterable:
              $checkedConvert(json, 'dynamicIterable', (v) => v as List),
          objectIterable:
              $checkedConvert(json, 'objectIterable', (v) => v as List),
          intIterable: $checkedConvert(
              json, 'intIterable', (v) => (v as List).map((e) => e as int)),
          dateTimeIterable: $checkedConvert(json, 'datetime-iterable',
              (v) => (v as List).map((e) => DateTime.parse(e as String))));

      $checkedConvert(
          json, 'dateTime', (v) => val.dateTime = DateTime.parse(v as String));
      $checkedConvert(json, 'list', (v) => val.list = v as List);
      $checkedConvert(json, 'dynamicList', (v) => val.dynamicList = v as List);
      $checkedConvert(json, 'objectList', (v) => val.objectList = v as List);
      $checkedConvert(json, 'intList',
          (v) => val.intList = (v as List).map((e) => e as int).toList());
      $checkedConvert(
          json,
          'dateTimeList',
          (v) => val.dateTimeList =
              (v as List).map((e) => DateTime.parse(e as String)).toList());
      $checkedConvert(json, 'map', (v) => val.map = v as Map);
      $checkedConvert(json, 'stringStringMap',
          (v) => val.stringStringMap = new Map<String, String>.from(v as Map));
      $checkedConvert(json, 'dynamicIntMap',
          (v) => val.dynamicIntMap = new Map<String, int>.from(v as Map));
      $checkedConvert(
          json,
          'objectDateTimeMap',
          (v) => val.objectDateTimeMap = (v as Map)
              .map((k, e) => new MapEntry(k, DateTime.parse(e as String))));
      $checkedConvert(
          json,
          'crazyComplex',
          (v) => val.crazyComplex = (v as List)
              .map((e) => (e as Map).map((k, e) => new MapEntry(
                  k as String,
                  (e as Map).map((k, e) => new MapEntry(
                      k as String,
                      (e as List)
                          .map((e) => (e as List)
                              .map((e) => DateTime.parse(e as String))
                              .toList())
                          .toList())))))
              .toList());
      $checkedConvert(
          json, 'val', (v) => val.val = new Map<String, bool>.from(v as Map));
      $checkedConvert(
          json, 'writeNotNull', (v) => val.writeNotNull = v as bool);
      $checkedConvert(json, r'$string', (v) => val.string = v as String);
      $checkedConvert(json, 'simpleObject',
          (v) => val.simpleObject = new SimpleObject.fromJson(v as Map));
      $checkedConvert(json, 'validatedPropertyNo42',
          (v) => val.validatedPropertyNo42 = v as int);
      return val;
    }, fieldKeyMap: const {
      'ctorValidatedNo42': 'no-42',
      'dateTimeIterable': 'datetime-iterable',
      'string': r'$string'
    });

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
