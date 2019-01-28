// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.non_nullable.wrapped.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map json) {
  return KitchenSink(
      ctorValidatedNo42: json['no-42'] as int,
      iterable: json['iterable'] as List,
      dynamicIterable: json['dynamicIterable'] as List,
      objectIterable: json['objectIterable'] as List,
      intIterable: (json['intIterable'] as List).map((e) => e as int),
      dateTimeIterable: (json['datetime-iterable'] as List)
          .map((e) => DateTime.parse(e as String)))
    ..dateTime = DateTime.parse(json['dateTime'] as String)
    ..set = (json['set'] as List).toSet()
    ..dynamicSet = (json['dynamicSet'] as List).toSet()
    ..objectSet = (json['objectSet'] as List).toSet()
    ..intSet = (json['intSet'] as List).map((e) => e as int).toSet()
    ..dateTimeSet = (json['dateTimeSet'] as List)
        .map((e) => DateTime.parse(e as String))
        .toSet()
    ..list = json['list'] as List
    ..dynamicList = json['dynamicList'] as List
    ..objectList = json['objectList'] as List
    ..intList = (json['intList'] as List).map((e) => e as int).toList()
    ..dateTimeList = (json['dateTimeList'] as List)
        .map((e) => DateTime.parse(e as String))
        .toList()
    ..map = json['map'] as Map
    ..stringStringMap = Map<String, String>.from(json['stringStringMap'] as Map)
    ..dynamicIntMap = Map<String, int>.from(json['dynamicIntMap'] as Map)
    ..objectDateTimeMap = (json['objectDateTimeMap'] as Map)
        .map((k, e) => MapEntry(k, DateTime.parse(e as String)))
    ..crazyComplex = (json['crazyComplex'] as List)
        .map((e) => (e as Map).map((k, e) => MapEntry(
            k as String,
            (e as Map).map((k, e) => MapEntry(
                k as String,
                (e as List)
                    .map((e) =>
                        (e as List).map((e) => DateTime.parse(e as String)).toList())
                    .toList())))))
        .toList()
    ..val = Map<String, bool>.from(json['val'] as Map)
    ..writeNotNull = json['writeNotNull'] as bool
    ..string = json[r'$string'] as String
    ..simpleObject = SimpleObject.fromJson(json['simpleObject'] as Map)
    ..strictKeysObject = StrictKeysObject.fromJson(json['strictKeysObject'] as Map)
    ..validatedPropertyNo42 = json['validatedPropertyNo42'] as int;
}

abstract class _$KitchenSinkSerializerMixin {
  int get ctorValidatedNo42;
  DateTime get dateTime;
  Iterable<dynamic> get iterable;
  Iterable<dynamic> get dynamicIterable;
  Iterable<Object> get objectIterable;
  Iterable<int> get intIterable;
  Set<dynamic> get set;
  Set<dynamic> get dynamicSet;
  Set<Object> get objectSet;
  Set<int> get intSet;
  Set<DateTime> get dateTimeSet;
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
  StrictKeysObject get strictKeysObject;
  int get validatedPropertyNo42;
  Map<String, dynamic> toJson() => _$KitchenSinkJsonMapWrapper(this);
}

class _$KitchenSinkJsonMapWrapper extends $JsonMapWrapper {
  final _$KitchenSinkSerializerMixin _v;
  _$KitchenSinkJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const [
        'no-42',
        'dateTime',
        'iterable',
        'dynamicIterable',
        'objectIterable',
        'intIterable',
        'set',
        'dynamicSet',
        'objectSet',
        'intSet',
        'dateTimeSet',
        'datetime-iterable',
        'list',
        'dynamicList',
        'objectList',
        'intList',
        'dateTimeList',
        'map',
        'stringStringMap',
        'dynamicIntMap',
        'objectDateTimeMap',
        'crazyComplex',
        'val',
        'writeNotNull',
        r'$string',
        'simpleObject',
        'strictKeysObject',
        'validatedPropertyNo42'
      ];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'no-42':
          return _v.ctorValidatedNo42;
        case 'dateTime':
          return _v.dateTime.toIso8601String();
        case 'iterable':
          return _v.iterable.toList();
        case 'dynamicIterable':
          return _v.dynamicIterable.toList();
        case 'objectIterable':
          return _v.objectIterable.toList();
        case 'intIterable':
          return _v.intIterable.toList();
        case 'set':
          return _v.set.toList();
        case 'dynamicSet':
          return _v.dynamicSet.toList();
        case 'objectSet':
          return _v.objectSet.toList();
        case 'intSet':
          return _v.intSet.toList();
        case 'dateTimeSet':
          return _v.dateTimeSet.map((e) => e.toIso8601String()).toList();
        case 'datetime-iterable':
          return _v.dateTimeIterable.map((e) => e.toIso8601String()).toList();
        case 'list':
          return _v.list;
        case 'dynamicList':
          return _v.dynamicList;
        case 'objectList':
          return _v.objectList;
        case 'intList':
          return _v.intList;
        case 'dateTimeList':
          return $wrapList<DateTime>(
              _v.dateTimeList, (e) => e.toIso8601String());
        case 'map':
          return _v.map;
        case 'stringStringMap':
          return _v.stringStringMap;
        case 'dynamicIntMap':
          return _v.dynamicIntMap;
        case 'objectDateTimeMap':
          return $wrapMap<Object, DateTime>(
              _v.objectDateTimeMap, (e) => e.toIso8601String());
        case 'crazyComplex':
          return $wrapList<Map<String, Map<String, List<List<DateTime>>>>>(
              _v.crazyComplex,
              (e) => $wrapMap<String, Map<String, List<List<DateTime>>>>(
                  e,
                  (e) => $wrapMap<String, List<List<DateTime>>>(
                      e,
                      (e) => $wrapList<List<DateTime>>(
                          e,
                          (e) => $wrapList<DateTime>(
                              e, (e) => e.toIso8601String())))));
        case 'val':
          return _v.val;
        case 'writeNotNull':
          return _v.writeNotNull;
        case r'$string':
          return _v.string;
        case 'simpleObject':
          return _v.simpleObject;
        case 'strictKeysObject':
          return _v.strictKeysObject;
        case 'validatedPropertyNo42':
          return _v.validatedPropertyNo42;
      }
    }
    return null;
  }
}

JsonConverterTestClass _$JsonConverterTestClassFromJson(Map json) {
  return JsonConverterTestClass()
    ..duration = durationConverter.fromJson(json['duration'] as int)
    ..durationList = (json['durationList'] as List)
        .map((e) => durationConverter.fromJson(e as int))
        .toList()
    ..bigInt = const BigIntStringConverter().fromJson(json['bigInt'] as String)
    ..bigIntMap = (json['bigIntMap'] as Map).map((k, e) => MapEntry(
        k as String, const BigIntStringConverter().fromJson(e as String)))
    ..numberSilly =
        TrivialNumberConverter.instance.fromJson(json['numberSilly'] as int)
    ..numberSillySet = (json['numberSillySet'] as List)
        .map((e) => TrivialNumberConverter.instance.fromJson(e as int))
        .toSet()
    ..dateTime =
        const EpochDateTimeConverter().fromJson(json['dateTime'] as int);
}

abstract class _$JsonConverterTestClassSerializerMixin {
  Duration get duration;
  List<Duration> get durationList;
  BigInt get bigInt;
  Map<String, BigInt> get bigIntMap;
  TrivialNumber get numberSilly;
  Set<TrivialNumber> get numberSillySet;
  DateTime get dateTime;
  Map<String, dynamic> toJson() => _$JsonConverterTestClassJsonMapWrapper(this);
}

class _$JsonConverterTestClassJsonMapWrapper extends $JsonMapWrapper {
  final _$JsonConverterTestClassSerializerMixin _v;
  _$JsonConverterTestClassJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const [
        'duration',
        'durationList',
        'bigInt',
        'bigIntMap',
        'numberSilly',
        'numberSillySet',
        'dateTime'
      ];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'duration':
          return durationConverter.toJson(_v.duration);
        case 'durationList':
          return $wrapList<Duration>(_v.durationList, durationConverter.toJson);
        case 'bigInt':
          return const BigIntStringConverter().toJson(_v.bigInt);
        case 'bigIntMap':
          return $wrapMap<String, BigInt>(
              _v.bigIntMap, const BigIntStringConverter().toJson);
        case 'numberSilly':
          return TrivialNumberConverter.instance.toJson(_v.numberSilly);
        case 'numberSillySet':
          return _v.numberSillySet
              .map(TrivialNumberConverter.instance.toJson)
              .toList();
        case 'dateTime':
          return const EpochDateTimeConverter().toJson(_v.dateTime);
      }
    }
    return null;
  }
}

JsonConverterGeneric<S, T, U> _$JsonConverterGenericFromJson<S, T, U>(
    Map json) {
  return JsonConverterGeneric<S, T, U>()
    ..item =
        GenericConverter<S>().fromJson(json['item'] as Map<String, dynamic>)
    ..itemList = (json['itemList'] as List)
        .map((e) => GenericConverter<T>().fromJson(e as Map<String, dynamic>))
        .toList()
    ..itemMap = (json['itemMap'] as Map).map((k, e) => MapEntry(k as String,
        GenericConverter<U>().fromJson(e as Map<String, dynamic>)));
}

abstract class _$JsonConverterGenericSerializerMixin<S, T, U> {
  S get item;
  List<T> get itemList;
  Map<String, U> get itemMap;
  Map<String, dynamic> toJson() =>
      _$JsonConverterGenericJsonMapWrapper<S, T, U>(this);
}

class _$JsonConverterGenericJsonMapWrapper<S, T, U> extends $JsonMapWrapper {
  final _$JsonConverterGenericSerializerMixin<S, T, U> _v;
  _$JsonConverterGenericJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const ['item', 'itemList', 'itemMap'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'item':
          return GenericConverter<S>().toJson(_v.item);
        case 'itemList':
          return $wrapList<T>(_v.itemList, GenericConverter<T>().toJson);
        case 'itemMap':
          return $wrapMap<String, U>(_v.itemMap, GenericConverter<U>().toJson);
      }
    }
    return null;
  }
}
