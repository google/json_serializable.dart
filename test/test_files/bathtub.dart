// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides
library json_serializable.test.bathtub;

import 'package:collection/collection.dart';
import 'package:json_serializable/annotations.dart';

part 'bathtub.g.dart';

/// A copy of `KitchenSink`, but with every fields marked as not nullable.
@JsonSerializable()
class Bathtub extends Object with _$BathtubSerializerMixin {
  // To ensure static members are not considered for serialization.
  static const answer = 42;
  static final reason = 42;
  static int get understand => 42;

  // NOTE: exposing these as Iterable, but storing the values as List
  // to make the equality test work trivially.
  @JsonKey(nullable: false)
  final Iterable _iterable;
  @JsonKey(nullable: false)
  final Iterable<dynamic> _dynamicIterable;
  @JsonKey(nullable: false)
  final Iterable<Object> _objectIterable;
  @JsonKey(nullable: false)
  final Iterable<int> _intIterable;
  @JsonKey(nullable: false)
  final Iterable<DateTime> _dateTimeIterable;

  Bathtub(
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

  factory Bathtub.fromJson(Map<String, Object> json) => _$BathtubFromJson(json);

  @JsonKey(nullable: false)
  Iterable get iterable => _iterable;
  @JsonKey(nullable: false)
  Iterable<dynamic> get dynamicIterable => _dynamicIterable;
  @JsonKey(nullable: false)
  Iterable<Object> get objectIterable => _objectIterable;
  @JsonKey(nullable: false)
  Iterable<int> get intIterable => _intIterable;
  @JsonKey(nullable: false)
  Iterable<DateTime> get dateTimeIterable => _dateTimeIterable;

  @JsonKey(nullable: false)
  List list;
  @JsonKey(nullable: false)
  List<dynamic> dynamicList;
  @JsonKey(nullable: false)
  List<Object> objectList;
  @JsonKey(nullable: false)
  List<int> intList;
  @JsonKey(nullable: false)
  List<DateTime> dateTimeList;

  @JsonKey(nullable: false)
  Map map;
  @JsonKey(nullable: false)
  Map<String, String> stringStringMap;
  @JsonKey(nullable: false)
  Map<String, int> stringIntMap;
  @JsonKey(nullable: false)
  Map<String, DateTime> stringDateTimeMap;

  @JsonKey(nullable: false)
  List<Map<String, Map<String, List<List<DateTime>>>>> crazyComplex;

  //TODO(kevmoo) - finish this...
  bool operator ==(Object other) =>
      other is Bathtub &&
      _deepEquals(iterable, other.iterable) &&
      _deepEquals(dynamicIterable, other.dynamicIterable) &&
      _deepEquals(dateTimeIterable, other.dateTimeIterable) &&
      _deepEquals(dateTimeList, other.dateTimeList) &&
      _deepEquals(stringDateTimeMap, other.stringDateTimeMap) &&
      _deepEquals(crazyComplex, other.crazyComplex);
}

bool _deepEquals(a, b) => const DeepCollectionEquality().equals(a, b);
