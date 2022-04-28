// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../test_utils.dart';
import 'json_converters.dart';
import 'simple_object.dart';

/// A key name that requires special encoding
const trickyKeyName = r'$string';

abstract class KitchenSinkFactory<K, V> {
  String get description;

  bool get anyMap;

  bool get checked;

  bool get nullable;

  bool get excludeNull;

  bool get explicitToJson;

  KitchenSink ctor({
    int ctorValidatedNo42,
    Iterable iterable,
    Iterable<dynamic> dynamicIterable,
    Iterable<Object> objectIterable,
    Iterable<int> intIterable,
    Iterable<DateTime> dateTimeIterable,
  });

  KitchenSink fromJson(Map<K, V> json);

  JsonConverterTestClass jsonConverterCtor();

  JsonConverterTestClass jsonConverterFromJson(Map<String, dynamic> json);

  @override
  String toString() => description;
}

abstract class JsonConverterTestClass {
  TrivialNumber? nullableNumberSilly;

  Map<String, dynamic> toJson();
}

abstract class KitchenSink {
  int? get ctorValidatedNo42;

  DateTime? dateTime;
  BigInt? bigInt;

  Iterable? get iterable;

  Iterable<dynamic> get dynamicIterable;

  Iterable<Object> get objectIterable;

  Iterable<int> get intIterable;

  Iterable<DateTime> get dateTimeIterable;

  List get list;

  List<dynamic> get dynamicList;

  List<Object> get objectList;

  List<int> get intList;

  List<DateTime> get dateTimeList;

  set dateTimeList(List<DateTime> value);

  List<SimpleObject?> get nullableSimpleObjectList;

  set nullableSimpleObjectList(List<SimpleObject?> value);

  Set get set;

  Set<dynamic> get dynamicSet;

  Set<Object> get objectSet;

  Set<int> get intSet;

  Set<DateTime> get dateTimeSet;

  Map get map;

  set map(Map value);

  Map<String, String> get stringStringMap;

  Map<dynamic, int> get dynamicIntMap;

  Map<Object, DateTime> get objectDateTimeMap;

  set objectDateTimeMap(Map<Object, DateTime> value);

  Map<String, SimpleObject?> get nullableSimpleObjectMap;

  set nullableSimpleObjectMap(Map<String, SimpleObject?> value);

  List<Map<String, Map<String, List<List<DateTime>?>?>?>?> get crazyComplex;

  set crazyComplex(
    List<Map<String, Map<String, List<List<DateTime>?>?>?>?> value,
  );

  Map<String, bool> get val;

  bool? writeNotNull;
  String? string;

  SimpleObject get simpleObject;

  int? validatedPropertyNo42;

  Map<String, dynamic> toJson();
}

// TODO: finish this...
bool sinkEquals(KitchenSink a, Object other) =>
    other is KitchenSink &&
    a.ctorValidatedNo42 == other.ctorValidatedNo42 &&
    a.dateTime == other.dateTime &&
    deepEquals(a.iterable, other.iterable) &&
    deepEquals(a.dynamicIterable, other.dynamicIterable) &&
    // objectIterable
    // intIterable
    deepEquals(a.dateTimeIterable, other.dateTimeIterable) &&
    // list
    // dynamicList
    // objectList
    // intList
    deepEquals(a.dateTimeList, other.dateTimeList) &&
    // map
    // stringStringMap
    // stringIntMap
    deepEquals(a.objectDateTimeMap, other.objectDateTimeMap) &&
    deepEquals(a.crazyComplex, other.crazyComplex) &&
    // val
    a.writeNotNull == other.writeNotNull &&
    a.string == other.string;
