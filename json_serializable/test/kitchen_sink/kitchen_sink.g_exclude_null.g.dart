// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'kitchen_sink.g_exclude_null.dart';

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

Map<String, dynamic> _$KitchenSinkToJson(KitchenSink instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('no-42', instance.ctorValidatedNo42);
  writeNotNull('dateTime', instance.dateTime?.toIso8601String());
  writeNotNull('bigInt', instance.bigInt?.toString());
  writeNotNull('iterable', instance.iterable?.toList());
  val['dynamicIterable'] = instance.dynamicIterable.toList();
  val['objectIterable'] = instance.objectIterable.toList();
  val['intIterable'] = instance.intIterable.toList();
  val['set'] = instance.set.toList();
  val['dynamicSet'] = instance.dynamicSet.toList();
  val['objectSet'] = instance.objectSet.toList();
  val['intSet'] = instance.intSet.toList();
  val['dateTimeSet'] =
      instance.dateTimeSet.map((e) => e.toIso8601String()).toList();
  val['datetime-iterable'] =
      instance.dateTimeIterable.map((e) => e.toIso8601String()).toList();
  val['list'] = instance.list;
  val['dynamicList'] = instance.dynamicList;
  val['objectList'] = instance.objectList;
  val['intList'] = instance.intList;
  val['dateTimeList'] =
      instance.dateTimeList.map((e) => e.toIso8601String()).toList();
  val['nullableSimpleObjectList'] = instance.nullableSimpleObjectList;
  val['map'] = instance.map;
  val['stringStringMap'] = instance.stringStringMap;
  val['dynamicIntMap'] = instance.dynamicIntMap;
  val['objectDateTimeMap'] = instance.objectDateTimeMap
      .map((k, e) => MapEntry(k, e.toIso8601String()));
  val['nullableSimpleObjectMap'] = instance.nullableSimpleObjectMap;
  val['crazyComplex'] = instance.crazyComplex
      .map((e) => e?.map((k, e) => MapEntry(
          k,
          e?.map((k, e) => MapEntry(
              k,
              e
                  ?.map((e) => e?.map((e) => e.toIso8601String()).toList())
                  .toList())))))
      .toList();
  val['val'] = instance.val;
  writeNotNull('writeNotNull', instance.writeNotNull);
  writeNotNull(r'$string', instance.string);
  val['simpleObject'] = instance.simpleObject;
  val['strictKeysObject'] = instance.strictKeysObject;
  writeNotNull('validatedPropertyNo42', instance.validatedPropertyNo42);
  return val;
}

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
    JsonConverterTestClass instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('duration',
      const DurationMillisecondConverter().toJson(instance.duration));
  val['durationList'] = instance.durationList
      .map(const DurationMillisecondConverter().toJson)
      .toList();
  val['bigInt'] = const BigIntStringConverter().toJson(instance.bigInt);
  val['bigIntMap'] = instance.bigIntMap
      .map((k, e) => MapEntry(k, const BigIntStringConverter().toJson(e)));
  writeNotNull(
      'nullableBigInt',
      _$JsonConverterToJson<String, BigInt>(
          instance.nullableBigInt, const BigIntStringConverter().toJson));
  val['nullableBigIntMap'] = instance.nullableBigIntMap.map((k, e) => MapEntry(
      k,
      _$JsonConverterToJson<String, BigInt>(
          e, const BigIntStringConverter().toJson)));
  writeNotNull('numberSilly',
      TrivialNumberConverter.instance.toJson(instance.numberSilly));
  val['numberSillySet'] = instance.numberSillySet
      .map(TrivialNumberConverter.instance.toJson)
      .toList();
  writeNotNull(
      'dateTime', const EpochDateTimeConverter().toJson(instance.dateTime));
  writeNotNull(
      'trivialString', trivialStringConverter.toJson(instance.trivialString));
  writeNotNull(
      'nullableNumberSilly',
      _$JsonConverterToJson<int?, TrivialNumber>(instance.nullableNumberSilly,
          TrivialNumberConverter.instance.toJson));
  val['nullableNumberSillySet'] = instance.nullableNumberSillySet
      .map((e) => _$JsonConverterToJson<int?, TrivialNumber>(
          e, TrivialNumberConverter.instance.toJson))
      .toList();
  return val;
}

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
