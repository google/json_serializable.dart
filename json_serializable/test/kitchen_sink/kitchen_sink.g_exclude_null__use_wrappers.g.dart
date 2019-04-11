// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.g_exclude_null__use_wrappers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map<String, dynamic> json) {
  return KitchenSink(
      ctorValidatedNo42: json['no-42'] as int,
      iterable: json['iterable'] as List,
      dynamicIterable: json['dynamicIterable'] as List,
      objectIterable: json['objectIterable'] as List,
      intIterable: (json['intIterable'] as List)?.map((e) => e as int),
      dateTimeIterable: (json['datetime-iterable'] as List)
          ?.map((e) => e == null ? null : DateTime.parse(e as String)))
    ..dateTime = json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String)
    ..bigInt =
        json['bigInt'] == null ? null : BigInt.parse(json['bigInt'] as String)
    ..set = (json['set'] as List)?.toSet()
    ..dynamicSet = (json['dynamicSet'] as List)?.toSet()
    ..objectSet = (json['objectSet'] as List)?.toSet()
    ..intSet = (json['intSet'] as List)?.map((e) => e as int)?.toSet()
    ..dateTimeSet = (json['dateTimeSet'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String))
        ?.toSet()
    ..list = json['list'] as List
    ..dynamicList = json['dynamicList'] as List
    ..objectList = json['objectList'] as List
    ..intList = (json['intList'] as List)?.map((e) => e as int)?.toList()
    ..dateTimeList = (json['dateTimeList'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String))
        ?.toList()
    ..map = json['map'] as Map<String, dynamic>
    ..stringStringMap = (json['stringStringMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    )
    ..dynamicIntMap = (json['dynamicIntMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    )
    ..objectDateTimeMap =
        (json['objectDateTimeMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e == null ? null : DateTime.parse(e as String)),
    )
    ..crazyComplex = (json['crazyComplex'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(
                  k,
                  (e as Map<String, dynamic>)?.map(
                    (k, e) => MapEntry(
                        k,
                        (e as List)
                            ?.map((e) => (e as List)
                                ?.map((e) => e == null
                                    ? null
                                    : DateTime.parse(e as String))
                                ?.toList())
                            ?.toList()),
                  )),
            ))
        ?.toList()
    ..val = (json['val'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as bool),
    )
    ..writeNotNull = json['writeNotNull'] as bool
    ..string = json[r'$string'] as String
    ..simpleObject = json['simpleObject'] == null
        ? null
        : SimpleObject.fromJson(json['simpleObject'] as Map<String, dynamic>)
    ..strictKeysObject = json['strictKeysObject'] == null
        ? null
        : StrictKeysObject.fromJson(
            json['strictKeysObject'] as Map<String, dynamic>)
    ..validatedPropertyNo42 = json['validatedPropertyNo42'] as int;
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

JsonConverterTestClass _$JsonConverterTestClassFromJson(
    Map<String, dynamic> json) {
  return JsonConverterTestClass()
    ..duration = json['duration'] == null
        ? null
        : durationConverter.fromJson(json['duration'] as int)
    ..durationList = (json['durationList'] as List)
        ?.map((e) => e == null ? null : durationConverter.fromJson(e as int))
        ?.toList()
    ..bigInt = json['bigInt'] == null
        ? null
        : const BigIntStringConverter().fromJson(json['bigInt'] as String)
    ..bigIntMap = (json['bigIntMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          e == null
              ? null
              : const BigIntStringConverter().fromJson(e as String)),
    )
    ..numberSilly = json['numberSilly'] == null
        ? null
        : TrivialNumberConverter.instance.fromJson(json['numberSilly'] as int)
    ..numberSillySet = (json['numberSillySet'] as List)
        ?.map((e) => e == null
            ? null
            : TrivialNumberConverter.instance.fromJson(e as int))
        ?.toSet()
    ..dateTime = json['dateTime'] == null
        ? null
        : const EpochDateTimeConverter().fromJson(json['dateTime'] as int);
}

Map<String, dynamic> _$JsonConverterTestClassToJson(
        JsonConverterTestClass instance) =>
    _$JsonConverterTestClassJsonMapWrapper(instance);

class _$JsonConverterTestClassJsonMapWrapper extends $JsonMapWrapper {
  final JsonConverterTestClass _v;
  _$JsonConverterTestClassJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys sync* {
    if ((_v.duration == null ? null : durationConverter.toJson(_v.duration)) !=
        null) {
      yield 'duration';
    }
    if (_v.durationList != null) {
      yield 'durationList';
    }
    if ((_v.bigInt == null
            ? null
            : const BigIntStringConverter().toJson(_v.bigInt)) !=
        null) {
      yield 'bigInt';
    }
    if (_v.bigIntMap != null) {
      yield 'bigIntMap';
    }
    if ((_v.numberSilly == null
            ? null
            : TrivialNumberConverter.instance.toJson(_v.numberSilly)) !=
        null) {
      yield 'numberSilly';
    }
    if (_v.numberSillySet != null) {
      yield 'numberSillySet';
    }
    if ((_v.dateTime == null
            ? null
            : const EpochDateTimeConverter().toJson(_v.dateTime)) !=
        null) {
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
    Map<String, dynamic> json) {
  return JsonConverterGeneric<S, T, U>()
    ..item = json['item'] == null
        ? null
        : GenericConverter<S>().fromJson(json['item'] as Map<String, dynamic>)
    ..itemList = (json['itemList'] as List)
        ?.map((e) => e == null
            ? null
            : GenericConverter<T>().fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..itemMap = (json['itemMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          e == null
              ? null
              : GenericConverter<U>().fromJson(e as Map<String, dynamic>)),
    );
}

Map<String, dynamic> _$JsonConverterGenericToJson<S, T, U>(
        JsonConverterGeneric<S, T, U> instance) =>
    _$JsonConverterGenericJsonMapWrapper<S, T, U>(instance);

class _$JsonConverterGenericJsonMapWrapper<S, T, U> extends $JsonMapWrapper {
  final JsonConverterGeneric<S, T, U> _v;
  _$JsonConverterGenericJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys sync* {
    if ((_v.item == null ? null : GenericConverter<S>().toJson(_v.item)) !=
        null) {
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
