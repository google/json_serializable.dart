// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.g_any_map__checked__explicit_to_json.dart';

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

Map<String, dynamic> _$KitchenSinkToJson(KitchenSink instance) {
  final val = <String, dynamic>{
    'no-42': instance.ctorValidatedNo42,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dateTime', instance.dateTime?.toIso8601String());
  writeNotNull('bigInt', instance.bigInt?.toString());
  writeNotNull('iterable', instance.iterable?.toList());
  val['dynamicIterable'] = instance.dynamicIterable?.toList();
  val['objectIterable'] = instance.objectIterable?.toList();
  val['intIterable'] = instance.intIterable?.toList();
  val['set'] = instance.set?.toList();
  val['dynamicSet'] = instance.dynamicSet?.toList();
  val['objectSet'] = instance.objectSet?.toList();
  val['intSet'] = instance.intSet?.toList();
  val['dateTimeSet'] =
      instance.dateTimeSet?.map((e) => e?.toIso8601String())?.toList();
  val['datetime-iterable'] =
      instance.dateTimeIterable?.map((e) => e?.toIso8601String())?.toList();
  val['list'] = instance.list;
  val['dynamicList'] = instance.dynamicList;
  val['objectList'] = instance.objectList;
  val['intList'] = instance.intList;
  writeNotNull('dateTimeList',
      instance.dateTimeList?.map((e) => e?.toIso8601String())?.toList());
  val['map'] = instance.map;
  val['stringStringMap'] = instance.stringStringMap;
  val['dynamicIntMap'] = instance.dynamicIntMap;
  val['objectDateTimeMap'] = instance.objectDateTimeMap
      ?.map((k, e) => MapEntry(k, e?.toIso8601String()));
  writeNotNull(
      'crazyComplex',
      instance.crazyComplex
          ?.map((e) => e?.map((k, e) => MapEntry(
              k,
              e?.map((k, e) => MapEntry(
                  k,
                  e
                      ?.map(
                          (e) => e?.map((e) => e?.toIso8601String())?.toList())
                      ?.toList())))))
          ?.toList());
  writeNotNull('val', instance.val);
  val['writeNotNull'] = instance.writeNotNull;
  val[r'$string'] = instance.string;
  val['simpleObject'] = instance.simpleObject?.toJson();
  val['strictKeysObject'] = instance.strictKeysObject?.toJson();
  val['validatedPropertyNo42'] = instance.validatedPropertyNo42;
  return val;
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
    <String, dynamic>{
      'duration': instance.duration == null
          ? null
          : durationConverter.toJson(instance.duration),
      'durationList': instance.durationList
          ?.map((e) => e == null ? null : durationConverter.toJson(e))
          ?.toList(),
      'bigInt': instance.bigInt == null
          ? null
          : const BigIntStringConverter().toJson(instance.bigInt),
      'bigIntMap': instance.bigIntMap?.map((k, e) => MapEntry(
          k, e == null ? null : const BigIntStringConverter().toJson(e))),
      'numberSilly': instance.numberSilly == null
          ? null
          : TrivialNumberConverter.instance.toJson(instance.numberSilly),
      'numberSillySet': instance.numberSillySet
          ?.map((e) =>
              e == null ? null : TrivialNumberConverter.instance.toJson(e))
          ?.toList(),
      'dateTime': instance.dateTime == null
          ? null
          : const EpochDateTimeConverter().toJson(instance.dateTime)
    };

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
    <String, dynamic>{
      'item': instance.item == null
          ? null
          : GenericConverter<S>().toJson(instance.item),
      'itemList': instance.itemList
          ?.map((e) => e == null ? null : GenericConverter<T>().toJson(e))
          ?.toList(),
      'itemMap': instance.itemMap?.map((k, e) =>
          MapEntry(k, e == null ? null : GenericConverter<U>().toJson(e)))
    };
