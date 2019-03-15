// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.g_any_map__checked__exclude_null__explicit_to_json__use_wrappers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map json) {
  return $checkedNew('KitchenSink', json, () {
    final val = KitchenSink(
        ctorValidatedNo42: $checkedConvert(json, 'no-42', (v) => v as int),
        iterable: $checkedConvert(json, 'iterable', (v) => v as List),
        dynamicIterable:
            $checkedConvert(json, 'dynamicIterable', (v) => v as List),
        objectIterable:
            $checkedConvert(json, 'objectIterable', (v) => v as List),
        intIterable: $checkedConvert(
            json, 'intIterable', (v) => (v as List)?.map((e) => e as int)),
        dateTimeIterable: $checkedConvert(
            json,
            'datetime-iterable',
            (v) => (v as List)
                ?.map((e) => e == null ? null : DateTime.parse(e as String))));
    $checkedConvert(json, 'dateTime',
        (v) => val.dateTime = v == null ? null : DateTime.parse(v as String));
    $checkedConvert(json, 'bigInt',
        (v) => val.bigInt = v == null ? null : BigInt.parse(v as String));
    $checkedConvert(json, 'set', (v) => val.set = (v as List)?.toSet());
    $checkedConvert(
        json, 'dynamicSet', (v) => val.dynamicSet = (v as List)?.toSet());
    $checkedConvert(
        json, 'objectSet', (v) => val.objectSet = (v as List)?.toSet());
    $checkedConvert(json, 'intSet',
        (v) => val.intSet = (v as List)?.map((e) => e as int)?.toSet());
    $checkedConvert(
        json,
        'dateTimeSet',
        (v) => val.dateTimeSet = (v as List)
            ?.map((e) => e == null ? null : DateTime.parse(e as String))
            ?.toSet());
    $checkedConvert(json, 'list', (v) => val.list = v as List);
    $checkedConvert(json, 'dynamicList', (v) => val.dynamicList = v as List);
    $checkedConvert(json, 'objectList', (v) => val.objectList = v as List);
    $checkedConvert(json, 'intList',
        (v) => val.intList = (v as List)?.map((e) => e as int)?.toList());
    $checkedConvert(
        json,
        'dateTimeList',
        (v) => val.dateTimeList = (v as List)
            ?.map((e) => e == null ? null : DateTime.parse(e as String))
            ?.toList());
    $checkedConvert(json, 'map', (v) => val.map = v as Map);
    $checkedConvert(
        json,
        'stringStringMap',
        (v) => val.stringStringMap = (v as Map)?.map(
              (k, e) => MapEntry(k as String, e as String),
            ));
    $checkedConvert(
        json,
        'dynamicIntMap',
        (v) => val.dynamicIntMap = (v as Map)?.map(
              (k, e) => MapEntry(k, e as int),
            ));
    $checkedConvert(
        json,
        'objectDateTimeMap',
        (v) => val.objectDateTimeMap = (v as Map)?.map(
              (k, e) =>
                  MapEntry(k, e == null ? null : DateTime.parse(e as String)),
            ));
    $checkedConvert(
        json,
        'crazyComplex',
        (v) => val.crazyComplex = (v as List)
            ?.map((e) => (e as Map)?.map(
                  (k, e) => MapEntry(
                      k as String,
                      (e as Map)?.map(
                        (k, e) => MapEntry(
                            k as String,
                            (e as List)
                                ?.map((e) => (e as List)
                                    ?.map((e) => e == null
                                        ? null
                                        : DateTime.parse(e as String))
                                    ?.toList())
                                ?.toList()),
                      )),
                ))
            ?.toList());
    $checkedConvert(
        json,
        'val',
        (v) => val.val = (v as Map)?.map(
              (k, e) => MapEntry(k as String, e as bool),
            ));
    $checkedConvert(json, 'writeNotNull', (v) => val.writeNotNull = v as bool);
    $checkedConvert(json, r'$string', (v) => val.string = v as String);
    $checkedConvert(
        json,
        'simpleObject',
        (v) => val.simpleObject =
            v == null ? null : SimpleObject.fromJson(v as Map));
    $checkedConvert(
        json,
        'strictKeysObject',
        (v) => val.strictKeysObject =
            v == null ? null : StrictKeysObject.fromJson(v as Map));
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
  Iterable<String> get keys sync* {
    if (_v.ctorValidatedNo42 != null) {
      yield 'no-42';
    }
    if (_v.dateTime != null) {
      yield 'dateTime';
    }
    if (_v.bigInt != null) {
      yield 'bigInt';
    }
    if (_v.iterable != null) {
      yield 'iterable';
    }
    if (_v.dynamicIterable != null) {
      yield 'dynamicIterable';
    }
    if (_v.objectIterable != null) {
      yield 'objectIterable';
    }
    if (_v.intIterable != null) {
      yield 'intIterable';
    }
    if (_v.set != null) {
      yield 'set';
    }
    if (_v.dynamicSet != null) {
      yield 'dynamicSet';
    }
    if (_v.objectSet != null) {
      yield 'objectSet';
    }
    if (_v.intSet != null) {
      yield 'intSet';
    }
    if (_v.dateTimeSet != null) {
      yield 'dateTimeSet';
    }
    if (_v.dateTimeIterable != null) {
      yield 'datetime-iterable';
    }
    if (_v.list != null) {
      yield 'list';
    }
    if (_v.dynamicList != null) {
      yield 'dynamicList';
    }
    if (_v.objectList != null) {
      yield 'objectList';
    }
    if (_v.intList != null) {
      yield 'intList';
    }
    if (_v.dateTimeList != null) {
      yield 'dateTimeList';
    }
    if (_v.map != null) {
      yield 'map';
    }
    if (_v.stringStringMap != null) {
      yield 'stringStringMap';
    }
    if (_v.dynamicIntMap != null) {
      yield 'dynamicIntMap';
    }
    if (_v.objectDateTimeMap != null) {
      yield 'objectDateTimeMap';
    }
    if (_v.crazyComplex != null) {
      yield 'crazyComplex';
    }
    if (_v.val != null) {
      yield 'val';
    }
    if (_v.writeNotNull != null) {
      yield 'writeNotNull';
    }
    if (_v.string != null) {
      yield r'$string';
    }
    if (_v.simpleObject != null) {
      yield 'simpleObject';
    }
    if (_v.strictKeysObject != null) {
      yield 'strictKeysObject';
    }
    if (_v.validatedPropertyNo42 != null) {
      yield 'validatedPropertyNo42';
    }
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'no-42':
          return _v.ctorValidatedNo42;
        case 'dateTime':
          return _v.dateTime?.toIso8601String();
        case 'bigInt':
          return _v.bigInt?.toString();
        case 'iterable':
          return _v.iterable?.toList();
        case 'dynamicIterable':
          return _v.dynamicIterable?.toList();
        case 'objectIterable':
          return _v.objectIterable?.toList();
        case 'intIterable':
          return _v.intIterable?.toList();
        case 'set':
          return _v.set?.toList();
        case 'dynamicSet':
          return _v.dynamicSet?.toList();
        case 'objectSet':
          return _v.objectSet?.toList();
        case 'intSet':
          return _v.intSet?.toList();
        case 'dateTimeSet':
          return _v.dateTimeSet?.map((e) => e?.toIso8601String())?.toList();
        case 'datetime-iterable':
          return _v.dateTimeIterable
              ?.map((e) => e?.toIso8601String())
              ?.toList();
        case 'list':
          return _v.list;
        case 'dynamicList':
          return _v.dynamicList;
        case 'objectList':
          return _v.objectList;
        case 'intList':
          return _v.intList;
        case 'dateTimeList':
          return $wrapListHandleNull<DateTime>(
              _v.dateTimeList, (e) => e?.toIso8601String());
        case 'map':
          return _v.map;
        case 'stringStringMap':
          return _v.stringStringMap;
        case 'dynamicIntMap':
          return _v.dynamicIntMap;
        case 'objectDateTimeMap':
          return $wrapMapHandleNull<Object, DateTime>(
              _v.objectDateTimeMap, (e) => e?.toIso8601String());
        case 'crazyComplex':
          return $wrapListHandleNull<
                  Map<String, Map<String, List<List<DateTime>>>>>(
              _v.crazyComplex,
              (e) =>
                  $wrapMapHandleNull<String, Map<String, List<List<DateTime>>>>(
                      e,
                      (e) => $wrapMapHandleNull<String, List<List<DateTime>>>(
                          e,
                          (e) => $wrapListHandleNull<List<DateTime>>(
                              e,
                              (e) => $wrapListHandleNull<DateTime>(
                                  e, (e) => e?.toIso8601String())))));
        case 'val':
          return _v.val;
        case 'writeNotNull':
          return _v.writeNotNull;
        case r'$string':
          return _v.string;
        case 'simpleObject':
          return _v.simpleObject?.toJson();
        case 'strictKeysObject':
          return _v.strictKeysObject?.toJson();
        case 'validatedPropertyNo42':
          return _v.validatedPropertyNo42;
      }
    }
    return null;
  }
}

JsonConverterTestClass _$JsonConverterTestClassFromJson(Map json) {
  return $checkedNew('JsonConverterTestClass', json, () {
    final val = JsonConverterTestClass();
    $checkedConvert(
        json,
        'duration',
        (v) => val.duration =
            v == null ? null : durationConverter.fromJson(v as int));
    $checkedConvert(
        json,
        'durationList',
        (v) => val.durationList = (v as List)
            ?.map(
                (e) => e == null ? null : durationConverter.fromJson(e as int))
            ?.toList());
    $checkedConvert(
        json,
        'bigInt',
        (v) => val.bigInt = v == null
            ? null
            : const BigIntStringConverter().fromJson(v as String));
    $checkedConvert(
        json,
        'bigIntMap',
        (v) => val.bigIntMap = (v as Map)?.map(
              (k, e) => MapEntry(
                  k as String,
                  e == null
                      ? null
                      : const BigIntStringConverter().fromJson(e as String)),
            ));
    $checkedConvert(
        json,
        'numberSilly',
        (v) => val.numberSilly = v == null
            ? null
            : TrivialNumberConverter.instance.fromJson(v as int));
    $checkedConvert(
        json,
        'numberSillySet',
        (v) => val.numberSillySet = (v as List)
            ?.map((e) => e == null
                ? null
                : TrivialNumberConverter.instance.fromJson(e as int))
            ?.toSet());
    $checkedConvert(
        json,
        'dateTime',
        (v) => val.dateTime = v == null
            ? null
            : const EpochDateTimeConverter().fromJson(v as int));
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
  Iterable<String> get keys sync* {
    if (_v.duration != null) {
      yield 'duration';
    }
    if (_v.durationList != null) {
      yield 'durationList';
    }
    if (_v.bigInt != null) {
      yield 'bigInt';
    }
    if (_v.bigIntMap != null) {
      yield 'bigIntMap';
    }
    if (_v.numberSilly != null) {
      yield 'numberSilly';
    }
    if (_v.numberSillySet != null) {
      yield 'numberSillySet';
    }
    if (_v.dateTime != null) {
      yield 'dateTime';
    }
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'duration':
          return _v.duration == null
              ? null
              : durationConverter.toJson(_v.duration);
        case 'durationList':
          return $wrapListHandleNull<Duration>(_v.durationList,
              (e) => e == null ? null : durationConverter.toJson(e));
        case 'bigInt':
          return _v.bigInt == null
              ? null
              : const BigIntStringConverter().toJson(_v.bigInt);
        case 'bigIntMap':
          return $wrapMapHandleNull<String, BigInt>(
              _v.bigIntMap,
              (e) =>
                  e == null ? null : const BigIntStringConverter().toJson(e));
        case 'numberSilly':
          return _v.numberSilly == null
              ? null
              : TrivialNumberConverter.instance.toJson(_v.numberSilly);
        case 'numberSillySet':
          return _v.numberSillySet
              ?.map((e) =>
                  e == null ? null : TrivialNumberConverter.instance.toJson(e))
              ?.toList();
        case 'dateTime':
          return _v.dateTime == null
              ? null
              : const EpochDateTimeConverter().toJson(_v.dateTime);
      }
    }
    return null;
  }
}

JsonConverterGeneric<S, T, U> _$JsonConverterGenericFromJson<S, T, U>(
    Map json) {
  return $checkedNew('JsonConverterGeneric', json, () {
    final val = JsonConverterGeneric<S, T, U>();
    $checkedConvert(
        json,
        'item',
        (v) => val.item = v == null
            ? null
            : GenericConverter<S>().fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'itemList',
        (v) => val.itemList = (v as List)
            ?.map((e) => e == null
                ? null
                : GenericConverter<T>().fromJson(e as Map<String, dynamic>))
            ?.toList());
    $checkedConvert(
        json,
        'itemMap',
        (v) => val.itemMap = (v as Map)?.map(
              (k, e) => MapEntry(
                  k as String,
                  e == null
                      ? null
                      : GenericConverter<U>()
                          .fromJson(e as Map<String, dynamic>)),
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
  Iterable<String> get keys sync* {
    if (_v.item != null) {
      yield 'item';
    }
    if (_v.itemList != null) {
      yield 'itemList';
    }
    if (_v.itemMap != null) {
      yield 'itemMap';
    }
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'item':
          return _v.item == null ? null : GenericConverter<S>().toJson(_v.item);
        case 'itemList':
          return $wrapListHandleNull<T>(_v.itemList,
              (e) => e == null ? null : GenericConverter<T>().toJson(e));
        case 'itemMap':
          return $wrapMapHandleNull<String, U>(_v.itemMap,
              (e) => e == null ? null : GenericConverter<U>().toJson(e));
      }
    }
    return null;
  }
}
