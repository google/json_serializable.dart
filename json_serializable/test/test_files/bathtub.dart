// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides, hash_and_equals
library json_serializable.test.bathtub;

import 'package:json_annotation/json_annotation.dart';

import 'kitchen_sink.dart';

part 'bathtub.g.dart';

/// A copy of `KitchenSink`, but with every fields marked as not nullable.
@JsonSerializable()
class Bathtub extends Object
    with _$BathtubSerializerMixin
    implements KitchenSink {
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

  Bathtub(
      {Iterable iterable,
      Iterable<dynamic> dynamicIterable,
      Iterable<Object> objectIterable,
      Iterable<int> intIterable,
      Iterable<DateTime> dateTimeIterable})
      : _iterable = iterable?.toList() ?? [],
        _dynamicIterable = dynamicIterable?.toList() ?? [],
        _objectIterable = objectIterable?.toList() ?? [],
        _intIterable = intIterable?.toList() ?? [],
        _dateTimeIterable = dateTimeIterable?.toList() ?? [];

  factory Bathtub.fromJson(Map<String, Object> json) => _$BathtubFromJson(json);

  @JsonKey(nullable: false)
  DateTime dateTime = new DateTime(1981, 6, 5);

  @JsonKey(nullable: false)
  Iterable get iterable => _iterable;
  @JsonKey(nullable: false)
  Iterable<dynamic> get dynamicIterable => _dynamicIterable;
  @JsonKey(nullable: false)
  Iterable<Object> get objectIterable => _objectIterable;
  @JsonKey(nullable: false)
  Iterable<int> get intIterable => _intIterable;
  // Added a one-off annotation on a property (not a field)
  @JsonKey(name: 'datetime-iterable', nullable: false)
  Iterable<DateTime> get dateTimeIterable => _dateTimeIterable;

  @JsonKey(nullable: false)
  List list = [];
  @JsonKey(nullable: false)
  List<dynamic> dynamicList = [];
  @JsonKey(nullable: false)
  List<Object> objectList = [];
  @JsonKey(nullable: false)
  List<int> intList = [];
  @JsonKey(nullable: false)
  List<DateTime> dateTimeList = [];

  @JsonKey(nullable: false)
  Map map = {};
  @JsonKey(nullable: false)
  Map<String, String> stringStringMap = {};
  @JsonKey(nullable: false)
  Map<String, int> stringIntMap = {};
  @JsonKey(nullable: false)
  Map<String, DateTime> stringDateTimeMap = {};

  @JsonKey(nullable: false)
  List<Map<String, Map<String, List<List<DateTime>>>>> crazyComplex = [];

  // Handle fields with names that collide with helper names
  @JsonKey(nullable: false, includeIfNull: false)
  Map<String, bool> val = {};
  @JsonKey(nullable: false)
  bool writeNotNull;
  @JsonKey(nullable: false, name: r'$string')
  String string;

  bool operator ==(Object other) => sinkEquals(this, other);
}
