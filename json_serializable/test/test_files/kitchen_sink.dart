// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides, hash_and_equals
library json_serializable.test.kitche_sink;

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kitchen_sink.g.dart';

/// Represent a large number of combinations of fields.
///
/// Useful when making big changes to validate output values work.
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

  @JsonKey(includeIfNull: false)
  DateTime dateTime;

  @JsonKey(includeIfNull: false)
  Iterable get iterable => _iterable;
  Iterable<dynamic> get dynamicIterable => _dynamicIterable;
  Iterable<Object> get objectIterable => _objectIterable;
  Iterable<int> get intIterable => _intIterable;

  // Added a one-off annotation on a property (not a field)
  @JsonKey(name: 'datetime-iterable')
  Iterable<DateTime> get dateTimeIterable => _dateTimeIterable;

  List list;
  List<dynamic> dynamicList;
  List<Object> objectList;
  List<int> intList;
  @JsonKey(includeIfNull: false)
  List<DateTime> dateTimeList;

  Map map;
  Map<String, String> stringStringMap;
  Map<String, int> stringIntMap;
  Map<String, DateTime> stringDateTimeMap;

  @JsonKey(includeIfNull: false)
  List<Map<String, Map<String, List<List<DateTime>>>>> crazyComplex;

  // Handle fields with names that collide with helper names
  @JsonKey(includeIfNull: false)
  Map<String, bool> val;
  bool writeNotNull;
  @JsonKey(name: r'$string')
  String string;

  bool operator ==(Object other) => sinkEquals(this, other);
}

//TODO(kevmoo) - finish this...
bool sinkEquals(KitchenSink a, other) =>
    other is KitchenSink &&
    a.dateTime == other.dateTime &&
    _deepEquals(a.iterable, other.iterable) &&
    _deepEquals(a.dynamicIterable, other.dynamicIterable) &&
    _deepEquals(a.dateTimeIterable, other.dateTimeIterable) &&
    _deepEquals(a.dateTimeList, other.dateTimeList) &&
    _deepEquals(a.stringDateTimeMap, other.stringDateTimeMap) &&
    _deepEquals(a.crazyComplex, other.crazyComplex);

bool _deepEquals(a, b) => const DeepCollectionEquality().equals(a, b);
