// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.g_checked__exclude_null__explicit_to_json__non_nullable__use_wrappers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map<String, dynamic> json) {
  return $checkedNew('KitchenSink', json, () {
    final val = KitchenSink(
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
    $checkedConvert(
        json, 'bigInt', (v) => val.bigInt = BigInt.parse(v as String));
    $checkedConvert(json, 'set', (v) => val.set = (v as List).toSet());
    $checkedConvert(
        json, 'dynamicSet', (v) => val.dynamicSet = (v as List).toSet());
    $checkedConvert(
        json, 'objectSet', (v) => val.objectSet = (v as List).toSet());
    $checkedConvert(json, 'intSet',
        (v) => val.intSet = (v as List).map((e) => e as int).toSet());
    $checkedConvert(
        json,
        'dateTimeSet',
        (v) => val.dateTimeSet =
            (v as List).map((e) => DateTime.parse(e as String)).toSet());
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
    $checkedConvert(json, 'map', (v) => val.map = v as Map<String, dynamic>);
    $checkedConvert(json, 'stringStringMap',
        (v) => val.stringStringMap = Map<String, String>.from(v as Map));
    $checkedConvert(json, 'dynamicIntMap',
        (v) => val.dynamicIntMap = Map<String, int>.from(v as Map));
    $checkedConvert(
        json,
        'objectDateTimeMap',
        (v) => val.objectDateTimeMap = (v as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, DateTime.parse(e as String)),
            ));
    $checkedConvert(
        json,
        'crazyComplex',
        (v) => val.crazyComplex = (v as List)
            .map((e) => (e as Map<String, dynamic>).map(
                  (k, e) => MapEntry(
                      k,
                      (e as Map<String, dynamic>).map(
                        (k, e) => MapEntry(
                            k,
                            (e as List)
                                .map((e) => (e as List)
                                    .map((e) => DateTime.parse(e as String))
                                    .toList())
                                .toList()),
                      )),
                ))
            .toList());
    $checkedConvert(
        json, 'val', (v) => val.val = Map<String, bool>.from(v as Map));
    $checkedConvert(json, 'writeNotNull', (v) => val.writeNotNull = v as bool);
    $checkedConvert(json, r'$string', (v) => val.string = v as String);
    $checkedConvert(
        json,
        'simpleObject',
        (v) => val.simpleObject =
            SimpleObject.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'strictKeysObject',
        (v) => val.strictKeysObject =
            StrictKeysObject.fromJson(v as Map<String, dynamic>));
    $checkedConvert(json, 'validatedPropertyNo42',
        (v) => val.validatedPropertyNo42 = v as int);
    return val;
  }, fieldKeyMap: const {
    'ctorValidatedNo42': 'no-42',
    'dateTimeIterable': 'datetime-iterable',
    'string': r'$string'
  });
}

Map<String, dynamic> _$KitchenSinkToJson(KitchenSink instance) =>
    _$KitchenSinkJsonMapWrapper(instance);

class _$KitchenSinkJsonMapWrapper extends $JsonMapWrapper {
  final KitchenSink _v;
  _$KitchenSinkJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const [
        'no-42',
        'dateTime',
        'bigInt',
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
        case 'bigInt':
          return _v.bigInt.toString();
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
          return _v.simpleObject.toJson();
        case 'strictKeysObject':
          return _v.strictKeysObject.toJson();
        case 'validatedPropertyNo42':
          return _v.validatedPropertyNo42;
      }
    }
    return null;
  }
}

JsonConverterTestClass _$JsonConverterTestClassFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('JsonConverterTestClass', json, () {
    final val = JsonConverterTestClass();
    $checkedConvert(json, 'duration',
        (v) => val.duration = durationConverter.fromJson(v as int));
    $checkedConvert(
        json,
        'durationList',
        (v) => val.durationList = (v as List)
            .map((e) => durationConverter.fromJson(e as int))
            .toList());
    $checkedConvert(
        json,
        'bigInt',
        (v) =>
            val.bigInt = const BigIntStringConverter().fromJson(v as String));
    $checkedConvert(
        json,
        'bigIntMap',
        (v) => val.bigIntMap = (v as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  k, const BigIntStringConverter().fromJson(e as String)),
            ));
    $checkedConvert(
        json,
        'numberSilly',
        (v) => val.numberSilly =
            TrivialNumberConverter.instance.fromJson(v as int));
    $checkedConvert(
        json,
        'numberSillySet',
        (v) => val.numberSillySet = (v as List)
            .map((e) => TrivialNumberConverter.instance.fromJson(e as int))
            .toSet());
    $checkedConvert(
        json,
        'dateTime',
        (v) =>
            val.dateTime = const EpochDateTimeConverter().fromJson(v as int));
    return val;
  });
}

Map<String, dynamic> _$JsonConverterTestClassToJson(
        JsonConverterTestClass instance) =>
    _$JsonConverterTestClassJsonMapWrapper(instance);

class _$JsonConverterTestClassJsonMapWrapper extends $JsonMapWrapper {
  final JsonConverterTestClass _v;
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
    Map<String, dynamic> json) {
  return $checkedNew('JsonConverterGeneric', json, () {
    final val = JsonConverterGeneric<S, T, U>();
    $checkedConvert(
        json,
        'item',
        (v) => val.item =
            GenericConverter<S>().fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'itemList',
        (v) => val.itemList = (v as List)
            .map((e) =>
                GenericConverter<T>().fromJson(e as Map<String, dynamic>))
            .toList());
    $checkedConvert(
        json,
        'itemMap',
        (v) => val.itemMap = (v as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  k, GenericConverter<U>().fromJson(e as Map<String, dynamic>)),
            ));
    return val;
  });
}

Map<String, dynamic> _$JsonConverterGenericToJson<S, T, U>(
        JsonConverterGeneric<S, T, U> instance) =>
    _$JsonConverterGenericJsonMapWrapper<S, T, U>(instance);

class _$JsonConverterGenericJsonMapWrapper<S, T, U> extends $JsonMapWrapper {
  final JsonConverterGeneric<S, T, U> _v;
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
