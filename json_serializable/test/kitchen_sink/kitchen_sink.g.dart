// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'kitchen_sink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map<String, dynamic> json) => KitchenSink(
      ctorValidatedNo42: json['no-42'] as int?,
      iterable: _valueAccessor(json, 'iterable') as List<dynamic>?,
      dynamicIterable: json['dynamicIterable'] as List<dynamic>?,
      objectIterable:
          (json['objectIterable'] as List<dynamic>?)?.map((e) => e as Object),
      intIterable:
          (json['intIterable'] as List<dynamic>?)?.map((e) => e as int),
      dateTimeIterable: (json['datetime-iterable'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
    )
      ..dateTime = json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String)
      ..bigInt =
          json['bigInt'] == null ? null : BigInt.parse(json['bigInt'] as String)
      ..set = (json['set'] as List<dynamic>).toSet()
      ..dynamicSet = (json['dynamicSet'] as List<dynamic>).toSet()
      ..objectSet =
          (json['objectSet'] as List<dynamic>).map((e) => e as Object).toSet()
      ..intSet = (json['intSet'] as List<dynamic>).map((e) => e as int).toSet()
      ..dateTimeSet = (json['dateTimeSet'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toSet()
      ..list = json['list'] as List<dynamic>
      ..dynamicList = json['dynamicList'] as List<dynamic>
      ..objectList =
          (json['objectList'] as List<dynamic>).map((e) => e as Object).toList()
      ..intList =
          (json['intList'] as List<dynamic>).map((e) => e as int).toList()
      ..dateTimeList = (json['dateTimeList'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList()
      ..nullableSimpleObjectList =
          (json['nullableSimpleObjectList'] as List<dynamic>)
              .map((e) => e == null
                  ? null
                  : SimpleObject.fromJson(e as Map<String, dynamic>))
              .toList()
      ..map = json['map'] as Map<String, dynamic>
      ..stringStringMap =
          Map<String, String>.from(json['stringStringMap'] as Map)
      ..dynamicIntMap = Map<String, int>.from(json['dynamicIntMap'] as Map)
      ..objectDateTimeMap =
          (json['objectDateTimeMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, DateTime.parse(e as String)),
      )
      ..nullableSimpleObjectMap =
          (json['nullableSimpleObjectMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            e == null
                ? null
                : SimpleObject.fromJson(e as Map<String, dynamic>)),
      )
      ..crazyComplex = (json['crazyComplex'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(
                    k,
                    (e as Map<String, dynamic>?)?.map(
                      (k, e) => MapEntry(
                          k,
                          (e as List<dynamic>?)
                              ?.map((e) => (e as List<dynamic>?)
                                  ?.map((e) => DateTime.parse(e as String))
                                  .toList())
                              .toList()),
                    )),
              ))
          .toList()
      ..val = Map<String, bool>.from(json['val'] as Map)
      ..writeNotNull = json['writeNotNull'] as bool?
      ..string = KitchenSink._trickyValueAccessor(json, r'$string') as String?
      ..simpleObject =
          SimpleObject.fromJson(json['simpleObject'] as Map<String, dynamic>)
      ..strictKeysObject = StrictKeysObject.fromJson(
          json['strictKeysObject'] as Map<String, dynamic>)
      ..validatedPropertyNo42 = json['validatedPropertyNo42'] as int?;

Map<String, dynamic> _$KitchenSinkToJson(KitchenSink instance) =>
    <String, dynamic>{
      'no-42': instance.ctorValidatedNo42,
      'dateTime': instance.dateTime?.toIso8601String(),
      'bigInt': instance.bigInt?.toString(),
      'iterable': instance.iterable?.toList(),
      'dynamicIterable': instance.dynamicIterable.toList(),
      'objectIterable': instance.objectIterable.toList(),
      'intIterable': instance.intIterable.toList(),
      'set': instance.set.toList(),
      'dynamicSet': instance.dynamicSet.toList(),
      'objectSet': instance.objectSet.toList(),
      'intSet': instance.intSet.toList(),
      'dateTimeSet':
          instance.dateTimeSet.map((e) => e.toIso8601String()).toList(),
      'datetime-iterable':
          instance.dateTimeIterable.map((e) => e.toIso8601String()).toList(),
      'list': instance.list,
      'dynamicList': instance.dynamicList,
      'objectList': instance.objectList,
      'intList': instance.intList,
      'dateTimeList':
          instance.dateTimeList.map((e) => e.toIso8601String()).toList(),
      'nullableSimpleObjectList': instance.nullableSimpleObjectList,
      'map': instance.map,
      'stringStringMap': instance.stringStringMap,
      'dynamicIntMap': instance.dynamicIntMap,
      'objectDateTimeMap': instance.objectDateTimeMap
          .map((k, e) => MapEntry(k, e.toIso8601String())),
      'nullableSimpleObjectMap': instance.nullableSimpleObjectMap,
      'crazyComplex': instance.crazyComplex
          .map((e) => e?.map((k, e) => MapEntry(
              k,
              e?.map((k, e) => MapEntry(
                  k,
                  e
                      ?.map((e) => e?.map((e) => e.toIso8601String()).toList())
                      .toList())))))
          .toList(),
      'val': instance.val,
      'writeNotNull': instance.writeNotNull,
      r'$string': instance.string,
      'simpleObject': instance.simpleObject,
      'strictKeysObject': instance.strictKeysObject,
      'validatedPropertyNo42': instance.validatedPropertyNo42,
    };

JsonConverterTestClass _$JsonConverterTestClassFromJson(
        Map<String, dynamic> json) =>
    JsonConverterTestClass(
      const DurationMillisecondConverter().fromJson(json['duration'] as int?),
      (json['durationList'] as List<dynamic>)
          .map((e) => const DurationMillisecondConverter().fromJson(e as int?))
          .toList(),
      const BigIntStringConverter().fromJson(json['bigInt'] as String),
      (json['bigIntMap'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, const BigIntStringConverter().fromJson(e as String)),
      ),
      _$JsonConverterFromJson<String, BigInt>(
          json['nullableBigInt'], const BigIntStringConverter().fromJson),
      (json['nullableBigIntMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            _$JsonConverterFromJson<String, BigInt>(
                e, const BigIntStringConverter().fromJson)),
      ),
      TrivialNumberConverter.instance.fromJson(json['numberSilly'] as int?),
      (json['numberSillySet'] as List<dynamic>)
          .map((e) => TrivialNumberConverter.instance.fromJson(e as int?))
          .toSet(),
      const EpochDateTimeConverter().fromJson(json['dateTime'] as int?),
      trivialStringConverter.fromJson(json['trivialString'] as String?),
      TrivialNumberConverter.instance
          .fromJson(json['nullableNumberSilly'] as int?),
      (json['nullableNumberSillySet'] as List<dynamic>)
          .map((e) => TrivialNumberConverter.instance.fromJson(e as int?))
          .toSet(),
    );

Map<String, dynamic> _$JsonConverterTestClassToJson(
        JsonConverterTestClass instance) =>
    <String, dynamic>{
      'duration':
          const DurationMillisecondConverter().toJson(instance.duration),
      'durationList': instance.durationList
          .map(const DurationMillisecondConverter().toJson)
          .toList(),
      'bigInt': const BigIntStringConverter().toJson(instance.bigInt),
      'bigIntMap': instance.bigIntMap
          .map((k, e) => MapEntry(k, const BigIntStringConverter().toJson(e))),
      'nullableBigInt': _$JsonConverterToJson<String, BigInt>(
          instance.nullableBigInt, const BigIntStringConverter().toJson),
      'nullableBigIntMap': instance.nullableBigIntMap.map((k, e) => MapEntry(
          k,
          _$JsonConverterToJson<String, BigInt>(
              e, const BigIntStringConverter().toJson))),
      'numberSilly':
          TrivialNumberConverter.instance.toJson(instance.numberSilly),
      'numberSillySet': instance.numberSillySet
          .map(TrivialNumberConverter.instance.toJson)
          .toList(),
      'dateTime': const EpochDateTimeConverter().toJson(instance.dateTime),
      'trivialString': trivialStringConverter.toJson(instance.trivialString),
      'nullableNumberSilly': _$JsonConverterToJson<int?, TrivialNumber>(
          instance.nullableNumberSilly, TrivialNumberConverter.instance.toJson),
      'nullableNumberSillySet': instance.nullableNumberSillySet
          .map((e) => _$JsonConverterToJson<int?, TrivialNumber>(
              e, TrivialNumberConverter.instance.toJson))
          .toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

JsonConverterGeneric<S, T, U> _$JsonConverterGenericFromJson<S, T, U>(
        Map<String, dynamic> json) =>
    JsonConverterGeneric<S, T, U>(
      GenericConverter<S>().fromJson(json['item'] as Map<String, dynamic>),
      (json['itemList'] as List<dynamic>)
          .map((e) => GenericConverter<T>().fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['itemMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, GenericConverter<U>().fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$JsonConverterGenericToJson<S, T, U>(
        JsonConverterGeneric<S, T, U> instance) =>
    <String, dynamic>{
      'item': GenericConverter<S>().toJson(instance.item),
      'itemList': instance.itemList.map(GenericConverter<T>().toJson).toList(),
      'itemMap': instance.itemMap
          .map((k, e) => MapEntry(k, GenericConverter<U>().toJson(e))),
    };
