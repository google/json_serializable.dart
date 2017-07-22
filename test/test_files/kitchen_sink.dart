// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides
library json_serializable.test.kitche_sink;

import 'package:collection/collection.dart';
import 'package:json_serializable/annotations.dart';

part 'kitchen_sink.g.dart';

@JsonSerializable()
class KitchenSink extends Object with _$KitchenSinkSerializerMixin {
  // To ensure static members are not considered for serialization.
  static const answer = 42;
  static final reason = 42;
  static int get understand => 42;

  // NOTE: exposing these as Iterable, but storing the values as List
  // to make the equality test work trivially.
  final Iterable _iterable;
  final Iterable<dynamic> _dynamicIterable;
  final Iterable<Object> _objectIterable;
  final Iterable<int> _intIterable;
  final Iterable<DateTime> _dateTimeIterable;

  KitchenSink(
      {Iterable iterable,
      Iterable<dynamic> dynamicIterable,
      Iterable<Object> objectIterable,
      Iterable<int> intIterable,
      Iterable<DateTime> dateTimeIterable})
      : _iterable = iterable?.toList(),
        _dynamicIterable = dynamicIterable?.toList(),
        _objectIterable = objectIterable?.toList(),
        _intIterable = intIterable?.toList(),
        _dateTimeIterable = dateTimeIterable?.toList();

  factory KitchenSink.fromJson(Map<String, Object> json) =>
      _$KitchenSinkFromJson(json);

  Iterable get iterable => _iterable;
  Iterable<dynamic> get dynamicIterable => _dynamicIterable;
  Iterable<Object> get objectIterable => _objectIterable;
  Iterable<int> get intIterable => _intIterable;
  Iterable<DateTime> get dateTimeIterable => _dateTimeIterable;

  List list;
  List<dynamic> dynamicList;
  List<Object> objectList;
  List<int> intList;
  List<DateTime> dateTimeList;

  Map map;
  Map<String, String> stringStringMap;
  Map<String, int> stringIntMap;
  Map<String, DateTime> stringDateTimeMap;

  List<Map<String, Map<String, List<List<DateTime>>>>> crazyComplex;

  //TODO(kevmoo) - finish this...
  bool operator ==(Object other) =>
      other is KitchenSink &&
      _deepEquals(iterable, other.iterable) &&
      _deepEquals(dynamicIterable, other.dynamicIterable) &&
      _deepEquals(dateTimeIterable, other.dateTimeIterable) &&
      _deepEquals(dateTimeList, other.dateTimeList) &&
      _deepEquals(stringDateTimeMap, other.stringDateTimeMap) &&
      _deepEquals(crazyComplex, other.crazyComplex);
}

bool _deepEquals(a, b) => const DeepCollectionEquality().equals(a, b);
