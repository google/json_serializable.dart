// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides, hash_and_equals
import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'kitchen_sink_interface.dart' as k;
import 'simple_object.dart';
import 'strict_keys_object.dart';

part 'kitchen_sink.g.dart';

// NOTE: these methods are replaced in the `non_nullable` cases to return
// non-null values.
List<T> _defaultList<T>() => [];

Set<T> _defaultSet<T>() => {};

Map<K, V> _defaultMap<K, V>() => {};

SimpleObject _defaultSimpleObject() => SimpleObject(42);

StrictKeysObject _defaultStrictKeysObject() => StrictKeysObject(42, 'value');

const k.KitchenSinkFactory factory = _Factory();

class _Factory implements k.KitchenSinkFactory<String, dynamic> {
  const _Factory();

  String get description => '--defaults--';

  bool get anyMap => false;

  bool get checked => false;

  bool get nullable => true;

  bool get excludeNull => false;

  bool get explicitToJson => false;

  k.KitchenSink ctor({
    int? ctorValidatedNo42,
    Iterable? iterable,
    Iterable? dynamicIterable,
    Iterable<Object>? objectIterable,
    Iterable<int>? intIterable,
    Iterable<DateTime>? dateTimeIterable,
  }) =>
      KitchenSink(
        ctorValidatedNo42: ctorValidatedNo42,
        iterable: iterable,
        dynamicIterable: dynamicIterable,
        objectIterable: objectIterable,
        intIterable: intIterable,
        dateTimeIterable: dateTimeIterable,
      );

  k.KitchenSink fromJson(Map<String, dynamic> json) =>
      KitchenSink.fromJson(json);

  k.JsonConverterTestClass jsonConverterCtor() => JsonConverterTestClass(
        const Duration(),
        [],
        BigInt.zero,
        {},
        TrivialNumber(0),
        {},
        DateTime.fromMillisecondsSinceEpoch(0),
      );

  k.JsonConverterTestClass jsonConverterFromJson(Map<String, dynamic> json) =>
      JsonConverterTestClass.fromJson(json);
}

Object? _valueAccessor(Map json, String key) {
  if (key == 'iterable') {
    return json['iterable'] ?? json['theIterable'];
  }

  return json[key];
}

@JsonSerializable()
class KitchenSink implements k.KitchenSink {
  // NOTE: exposing these as Iterable, but storing the values as List
  // to make the equality test work trivially.
  final Iterable? _iterable;
  final Iterable<dynamic> _dynamicIterable;
  final Iterable<Object> _objectIterable;
  final Iterable<int> _intIterable;
  final Iterable<DateTime> _dateTimeIterable;

  @JsonKey(name: 'no-42')
  final int? ctorValidatedNo42;

  KitchenSink({
    this.ctorValidatedNo42,
    Iterable? iterable,
    Iterable<dynamic>? dynamicIterable,
    Iterable<Object>? objectIterable,
    Iterable<int>? intIterable,
    Iterable<DateTime>? dateTimeIterable,
  })  : _iterable = iterable?.toList(),
        _dynamicIterable = dynamicIterable?.toList() ?? _defaultList(),
        _objectIterable = objectIterable?.toList() ?? _defaultList(),
        _intIterable = intIterable?.toList() ?? _defaultList(),
        _dateTimeIterable = dateTimeIterable?.toList() ?? _defaultList() {
    if (ctorValidatedNo42 == 42) {
      throw ArgumentError.value(
          42, 'ctorValidatedNo42', 'The value `42` is not allowed.');
    }
  }

  factory KitchenSink.fromJson(Map<String, dynamic> json) =>
      _$KitchenSinkFromJson(json);

  Map<String, dynamic> toJson() => _$KitchenSinkToJson(this);

  DateTime? dateTime;

  BigInt? bigInt;

  @JsonKey(readValue: _valueAccessor)
  Iterable? get iterable => _iterable;

  Iterable<dynamic> get dynamicIterable => _dynamicIterable;

  Iterable<Object> get objectIterable => _objectIterable;

  Iterable<int> get intIterable => _intIterable;

  Set set = _defaultSet();
  Set<dynamic> dynamicSet = _defaultSet();
  Set<Object> objectSet = _defaultSet();
  Set<int> intSet = _defaultSet();
  Set<DateTime> dateTimeSet = _defaultSet();

  // Added a one-off annotation on a property (not a field)
  @JsonKey(name: 'datetime-iterable')
  Iterable<DateTime> get dateTimeIterable => _dateTimeIterable;

  List list = _defaultList();
  List<dynamic> dynamicList = _defaultList();
  List<Object> objectList = _defaultList();
  List<int> intList = _defaultList();
  List<DateTime> dateTimeList = _defaultList();
  List<SimpleObject?> nullableSimpleObjectList = _defaultList();

  Map map = _defaultMap();
  Map<String, String> stringStringMap = _defaultMap();
  Map<dynamic, int> dynamicIntMap = _defaultMap();
  Map<Object, DateTime> objectDateTimeMap = _defaultMap();
  Map<String, SimpleObject?> nullableSimpleObjectMap = _defaultMap();

  List<Map<String, Map<String, List<List<DateTime>?>?>?>?> crazyComplex =
      _defaultList();

  // Handle fields with names that collide with helper names
  Map<String, bool> val = _defaultMap();
  bool? writeNotNull;
  @JsonKey(name: k.trickyKeyName, readValue: _trickyValueAccessor)
  String? string;

  SimpleObject simpleObject = _defaultSimpleObject();

  StrictKeysObject strictKeysObject = _defaultStrictKeysObject();

  int? _validatedPropertyNo42;

  int? get validatedPropertyNo42 => _validatedPropertyNo42;

  set validatedPropertyNo42(int? value) {
    if (value == 42) {
      throw StateError('Cannot be 42!');
    }
    _validatedPropertyNo42 = value;
  }

  bool operator ==(Object other) => k.sinkEquals(this, other);

  static Object? _trickyValueAccessor(Map json, String key) {
    if (key == k.trickyKeyName) {
      return json[k.trickyKeyName] ?? json['STRING'];
    }

    return json[key];
  }
}

@JsonSerializable()
// referencing a top-level field should work
@durationConverter
// referencing via a const constructor should work
@BigIntStringConverter()
@TrivialNumberConverter.instance
@EpochDateTimeConverter()
class JsonConverterTestClass implements k.JsonConverterTestClass {
  JsonConverterTestClass(
    this.duration,
    this.durationList,
    this.bigInt,
    this.bigIntMap,
    this.numberSilly,
    this.numberSillySet,
    this.dateTime,
  );

  factory JsonConverterTestClass.fromJson(Map<String, dynamic> json) =>
      _$JsonConverterTestClassFromJson(json);

  Map<String, dynamic> toJson() => _$JsonConverterTestClassToJson(this);

  Duration? duration;
  List<Duration?> durationList;

  BigInt bigInt;
  Map<String, BigInt> bigIntMap;

  TrivialNumber numberSilly;
  Set<TrivialNumber> numberSillySet;

  DateTime? dateTime;
}

@JsonSerializable()
@GenericConverter()
class JsonConverterGeneric<S, T, U> {
  S item;
  List<T> itemList;
  Map<String, U> itemMap;

  JsonConverterGeneric(
    this.item,
    this.itemList,
    this.itemMap,
  );

  factory JsonConverterGeneric.fromJson(Map<String, dynamic> json) =>
      _$JsonConverterGenericFromJson(json);

  Map<String, dynamic> toJson() => _$JsonConverterGenericToJson(this);
}
