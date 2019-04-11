// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.g_exclude_null__no_encode_empty__non_nullable__use_wrappers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map<String, dynamic> json) {
  return KitchenSink(
      ctorValidatedNo42: json['no-42'] as int,
      iterable: json['iterable'] as List,
      dynamicIterable: json['dynamicIterable'] as List,
      objectIterable: json['objectIterable'] as List,
      intIterable: (json['intIterable'] as List).map((e) => e as int),
      dateTimeIterable: (json['datetime-iterable'] as List)
          .map((e) => DateTime.parse(e as String)))
    ..dateTime = DateTime.parse(json['dateTime'] as String)
    ..bigInt = BigInt.parse(json['bigInt'] as String)
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
    ..map = json['map'] as Map<String, dynamic>
    ..stringStringMap = Map<String, String>.from(json['stringStringMap'] as Map)
    ..dynamicIntMap = Map<String, int>.from(json['dynamicIntMap'] as Map)
    ..objectDateTimeMap =
        (json['objectDateTimeMap'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, DateTime.parse(e as String)),
    )
    ..crazyComplex = (json['crazyComplex'] as List)
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
        .toList()
    ..val = Map<String, bool>.from(json['val'] as Map)
    ..writeNotNull = json['writeNotNull'] as bool
    ..string = json[r'$string'] as String
    ..simpleObject =
        SimpleObject.fromJson(json['simpleObject'] as Map<String, dynamic>)
    ..strictKeysObject = StrictKeysObject.fromJson(
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
    yield 'no-42';
    yield 'dateTime';
    yield 'bigInt';
    if (_v.iterable.isNotEmpty) {
      yield 'iterable';
    }
    if (_v.dynamicIterable.isNotEmpty) {
      yield 'dynamicIterable';
    }
    if (_v.objectIterable.isNotEmpty) {
      yield 'objectIterable';
    }
    if (_v.intIterable.isNotEmpty) {
      yield 'intIterable';
    }
    if (_v.set.isNotEmpty) {
      yield 'set';
    }
    if (_v.dynamicSet.isNotEmpty) {
      yield 'dynamicSet';
    }
    if (_v.objectSet.isNotEmpty) {
      yield 'objectSet';
    }
    if (_v.intSet.isNotEmpty) {
      yield 'intSet';
    }
    if (_v.dateTimeSet.isNotEmpty) {
      yield 'dateTimeSet';
    }
    if (_v.dateTimeIterable.isNotEmpty) {
      yield 'datetime-iterable';
    }
    if (_v.list.isNotEmpty) {
      yield 'list';
    }
    if (_v.dynamicList.isNotEmpty) {
      yield 'dynamicList';
    }
    if (_v.objectList.isNotEmpty) {
      yield 'objectList';
    }
    if (_v.intList.isNotEmpty) {
      yield 'intList';
    }
    if (_v.dateTimeList.isNotEmpty) {
      yield 'dateTimeList';
    }
    if (_v.map.isNotEmpty) {
      yield 'map';
    }
    if (_v.stringStringMap.isNotEmpty) {
      yield 'stringStringMap';
    }
    if (_v.dynamicIntMap.isNotEmpty) {
      yield 'dynamicIntMap';
    }
    if (_v.objectDateTimeMap.isNotEmpty) {
      yield 'objectDateTimeMap';
    }
    if (_v.crazyComplex.isNotEmpty) {
      yield 'crazyComplex';
    }
    if (_v.val.isNotEmpty) {
      yield 'val';
    }
    yield 'writeNotNull';
    yield r'$string';
    yield 'simpleObject';
    yield 'strictKeysObject';
    yield 'validatedPropertyNo42';
  }

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
          return _$nullIfEmptyIterable(_v.iterable)?.toList();
        case 'dynamicIterable':
          return _$nullIfEmptyIterable(_v.dynamicIterable)?.toList();
        case 'objectIterable':
          return _$nullIfEmptyIterable(_v.objectIterable)?.toList();
        case 'intIterable':
          return _$nullIfEmptyIterable(_v.intIterable)?.toList();
        case 'set':
          return _$nullIfEmptyIterable(_v.set)?.toList();
        case 'dynamicSet':
          return _$nullIfEmptyIterable(_v.dynamicSet)?.toList();
        case 'objectSet':
          return _$nullIfEmptyIterable(_v.objectSet)?.toList();
        case 'intSet':
          return _$nullIfEmptyIterable(_v.intSet)?.toList();
        case 'dateTimeSet':
          return _$nullIfEmptyIterable(_v.dateTimeSet)
              ?.map((e) => e.toIso8601String())
              ?.toList();
        case 'datetime-iterable':
          return _$nullIfEmptyIterable(_v.dateTimeIterable)
              ?.map((e) => e.toIso8601String())
              ?.toList();
        case 'list':
          return _$nullIfEmptyIterable(_v.list);
        case 'dynamicList':
          return _$nullIfEmptyIterable(_v.dynamicList);
        case 'objectList':
          return _$nullIfEmptyIterable(_v.objectList);
        case 'intList':
          return _$nullIfEmptyIterable(_v.intList);
        case 'dateTimeList':
          return $wrapListHandleNull<DateTime>(
              _$nullIfEmptyIterable(_v.dateTimeList),
              (e) => e.toIso8601String());
        case 'map':
          return _$nullIfEmptyMap(_v.map);
        case 'stringStringMap':
          return _$nullIfEmptyMap(_v.stringStringMap);
        case 'dynamicIntMap':
          return _$nullIfEmptyMap(_v.dynamicIntMap);
        case 'objectDateTimeMap':
          return $wrapMapHandleNull<Object, DateTime>(
              _$nullIfEmptyMap(_v.objectDateTimeMap),
              (e) => e.toIso8601String());
        case 'crazyComplex':
          return $wrapListHandleNull<
                  Map<String, Map<String, List<List<DateTime>>>>>(
              _$nullIfEmptyIterable(_v.crazyComplex),
              (e) => $wrapMap<String, Map<String, List<List<DateTime>>>>(
                  e,
                  (e) => $wrapMap<String, List<List<DateTime>>>(
                      e,
                      (e) => $wrapList<List<DateTime>>(
                          e,
                          (e) => $wrapList<DateTime>(
                              e, (e) => e.toIso8601String())))));
        case 'val':
          return _$nullIfEmptyMap(_v.val);
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

T _$nullIfEmptyIterable<T extends Iterable>(T source) =>
    (source == null || source.isEmpty) ? null : source;

T _$nullIfEmptyMap<T extends Map>(T source) =>
    (source == null || source.isEmpty) ? null : source;

JsonConverterTestClass _$JsonConverterTestClassFromJson(
    Map<String, dynamic> json) {
  return JsonConverterTestClass()
    ..duration = durationConverter.fromJson(json['duration'] as int)
    ..durationList = (json['durationList'] as List)
        .map((e) => durationConverter.fromJson(e as int))
        .toList()
    ..bigInt = const BigIntStringConverter().fromJson(json['bigInt'] as String)
    ..bigIntMap = (json['bigIntMap'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, const BigIntStringConverter().fromJson(e as String)),
    )
    ..numberSilly =
        TrivialNumberConverter.instance.fromJson(json['numberSilly'] as int)
    ..numberSillySet = (json['numberSillySet'] as List)
        .map((e) => TrivialNumberConverter.instance.fromJson(e as int))
        .toSet()
    ..dateTime =
        const EpochDateTimeConverter().fromJson(json['dateTime'] as int);
}

Map<String, dynamic> _$JsonConverterTestClassToJson(
        JsonConverterTestClass instance) =>
    _$JsonConverterTestClassJsonMapWrapper(instance);

class _$JsonConverterTestClassJsonMapWrapper extends $JsonMapWrapper {
  final JsonConverterTestClass _v;
  _$JsonConverterTestClassJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys sync* {
    if (durationConverter.toJson(_v.duration) != null) {
      yield 'duration';
    }
    if (_v.durationList.isNotEmpty) {
      yield 'durationList';
    }
    if (const BigIntStringConverter().toJson(_v.bigInt) != null) {
      yield 'bigInt';
    }
    if (_v.bigIntMap.isNotEmpty) {
      yield 'bigIntMap';
    }
    if (TrivialNumberConverter.instance.toJson(_v.numberSilly) != null) {
      yield 'numberSilly';
    }
    if (_v.numberSillySet.isNotEmpty) {
      yield 'numberSillySet';
    }
    if (const EpochDateTimeConverter().toJson(_v.dateTime) != null) {
      yield 'dateTime';
    }
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'duration':
          return durationConverter.toJson(_v.duration);
        case 'durationList':
          return $wrapListHandleNull<Duration>(
              _$nullIfEmptyIterable(_v.durationList), durationConverter.toJson);
        case 'bigInt':
          return const BigIntStringConverter().toJson(_v.bigInt);
        case 'bigIntMap':
          return $wrapMapHandleNull<String, BigInt>(
              _$nullIfEmptyMap(_v.bigIntMap),
              const BigIntStringConverter().toJson);
        case 'numberSilly':
          return TrivialNumberConverter.instance.toJson(_v.numberSilly);
        case 'numberSillySet':
          return _$nullIfEmptyIterable(_v.numberSillySet)
              ?.map(TrivialNumberConverter.instance.toJson)
              ?.toList();
        case 'dateTime':
          return const EpochDateTimeConverter().toJson(_v.dateTime);
      }
    }
    return null;
  }
}

JsonConverterGeneric<S, T, U> _$JsonConverterGenericFromJson<S, T, U>(
    Map<String, dynamic> json) {
  return JsonConverterGeneric<S, T, U>()
    ..item =
        GenericConverter<S>().fromJson(json['item'] as Map<String, dynamic>)
    ..itemList = (json['itemList'] as List)
        .map((e) => GenericConverter<T>().fromJson(e as Map<String, dynamic>))
        .toList()
    ..itemMap = (json['itemMap'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(
          k, GenericConverter<U>().fromJson(e as Map<String, dynamic>)),
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
    if (GenericConverter<S>().toJson(_v.item) != null) {
      yield 'item';
    }
    if (_v.itemList.isNotEmpty) {
      yield 'itemList';
    }
    if (_v.itemMap.isNotEmpty) {
      yield 'itemMap';
    }
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'item':
          return GenericConverter<S>().toJson(_v.item);
        case 'itemList':
          return $wrapListHandleNull<T>(
              _$nullIfEmptyIterable(_v.itemList), GenericConverter<T>().toJson);
        case 'itemMap':
          return $wrapMapHandleNull<String, U>(
              _$nullIfEmptyMap(_v.itemMap), GenericConverter<U>().toJson);
      }
    }
    return null;
  }
}
