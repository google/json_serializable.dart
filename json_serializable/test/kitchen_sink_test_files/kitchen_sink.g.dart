// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map json) => new KitchenSink(
    ctorValidatedNo42: json['no-42'] as int,
    iterable: json['iterable'] as List,
    dynamicIterable: json['dynamicIterable'] as List,
    objectIterable: json['objectIterable'] as List,
    intIterable: (json['intIterable'] as List)?.map((e) => e as int),
    dateTimeIterable: (json['datetime-iterable'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String)))
  ..dateTime = json['dateTime'] == null
      ? null
      : DateTime.parse(json['dateTime'] as String)
  ..list = json['list'] as List
  ..dynamicList = json['dynamicList'] as List
  ..objectList = json['objectList'] as List
  ..intList = (json['intList'] as List)?.map((e) => e as int)?.toList()
  ..dateTimeList = (json['dateTimeList'] as List)
      ?.map((e) => e == null ? null : DateTime.parse(e as String))
      ?.toList()
  ..map = json['map'] as Map
  ..stringStringMap = (json['stringStringMap'] as Map)
      ?.map((k, e) => new MapEntry(k as String, e as String))
  ..dynamicIntMap =
      (json['dynamicIntMap'] as Map)?.map((k, e) => new MapEntry(k, e as int))
  ..objectDateTimeMap = (json['objectDateTimeMap'] as Map)?.map(
      (k, e) => new MapEntry(k, e == null ? null : DateTime.parse(e as String)))
  ..crazyComplex = (json['crazyComplex'] as List)
      ?.map((e) => (e as Map)?.map((k, e) => new MapEntry(
          k as String, (e as Map)?.map((k, e) => new MapEntry(k as String, (e as List)?.map((e) => (e as List)?.map((e) => e == null ? null : DateTime.parse(e as String))?.toList())?.toList())))))
      ?.toList()
  ..val = (json['val'] as Map)?.map((k, e) => new MapEntry(k as String, e as bool))
  ..writeNotNull = json['writeNotNull'] as bool
  ..string = json[r'$string'] as String
  ..simpleObject = json['simpleObject'] == null ? null : new SimpleObject.fromJson(json['simpleObject'] as Map)
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
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{
      'no-42': ctorValidatedNo42,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('dateTime', dateTime?.toIso8601String());
    writeNotNull('iterable', iterable?.toList());
    val['dynamicIterable'] = dynamicIterable?.toList();
    val['objectIterable'] = objectIterable?.toList();
    val['intIterable'] = intIterable?.toList();
    val['datetime-iterable'] =
        dateTimeIterable?.map((e) => e?.toIso8601String())?.toList();
    val['list'] = list;
    val['dynamicList'] = dynamicList;
    val['objectList'] = objectList;
    val['intList'] = intList;
    writeNotNull('dateTimeList',
        dateTimeList?.map((e) => e?.toIso8601String())?.toList());
    val['map'] = map;
    val['stringStringMap'] = stringStringMap;
    val['dynamicIntMap'] = dynamicIntMap;
    val['objectDateTimeMap'] =
        objectDateTimeMap?.map((k, e) => new MapEntry(k, e?.toIso8601String()));
    writeNotNull(
        'crazyComplex',
        crazyComplex
            ?.map((e) => e?.map((k, e) => new MapEntry(
                k,
                e?.map((k, e) => new MapEntry(
                    k,
                    e
                        ?.map((e) =>
                            e?.map((e) => e?.toIso8601String())?.toList())
                        ?.toList())))))
            ?.toList());
    writeNotNull('val', this.val);
    val['writeNotNull'] = this.writeNotNull;
    val[r'$string'] = string;
    val['simpleObject'] = simpleObject;
    val['validatedPropertyNo42'] = validatedPropertyNo42;
    return val;
  }
}
