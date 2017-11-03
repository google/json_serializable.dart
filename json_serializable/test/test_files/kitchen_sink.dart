// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides, hash_and_equals
library json_serializable.test.kitchen_sink;

import 'package:json_annotation/json_annotation.dart';

import 'kitchen_sink_interface.dart' as k;

part 'kitchen_sink.g.dart';

List<T> _defaultList<T>() => null;
Map _defaultMap() => null;

@JsonSerializable()
class KitchenSink extends Object
    with _$KitchenSinkSerializerMixin
    implements k.KitchenSink {
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
      : _iterable = iterable?.toList() ?? _defaultList(),
        _dynamicIterable = dynamicIterable?.toList() ?? _defaultList(),
        _objectIterable = objectIterable?.toList() ?? _defaultList(),
        _intIterable = intIterable?.toList() ?? _defaultList(),
        _dateTimeIterable = dateTimeIterable?.toList() ?? _defaultList();

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

  List list = _defaultList();
  List<dynamic> dynamicList = _defaultList();
  List<Object> objectList = _defaultList();
  List<int> intList = _defaultList();
  @JsonKey(includeIfNull: false)
  List<DateTime> dateTimeList = _defaultList();

  Map map = _defaultMap();
  Map<String, String> stringStringMap = _defaultMap();
  Map<String, int> stringIntMap = _defaultMap();
  Map<String, DateTime> stringDateTimeMap = _defaultMap();

  @JsonKey(includeIfNull: false)
  List<Map<String, Map<String, List<List<DateTime>>>>> crazyComplex =
      _defaultList();

  // Handle fields with names that collide with helper names
  @JsonKey(includeIfNull: false)
  Map<String, bool> val = _defaultMap();
  bool writeNotNull;
  @JsonKey(name: r'$string')
  String string;

  bool operator ==(Object other) => k.sinkEquals(this, other);
}
