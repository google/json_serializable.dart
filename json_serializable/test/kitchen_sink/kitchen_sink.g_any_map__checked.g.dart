// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'kitchen_sink.g_any_map__checked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map json) => $checkedCreate(
      'KitchenSink',
      json,
      ($checkedConvert) {
        final val = KitchenSink(
          ctorValidatedNo42: $checkedConvert('no-42', (v) => v as int?),
          iterable: $checkedConvert(
            'iterable',
            (v) => v as List<dynamic>?,
            readValue: _valueAccessor,
          ),
          dynamicIterable:
              $checkedConvert('dynamicIterable', (v) => v as List<dynamic>?),
          objectIterable: $checkedConvert('objectIterable',
              (v) => (v as List<dynamic>?)?.map((e) => e as Object)),
          intIterable: $checkedConvert('intIterable',
              (v) => (v as List<dynamic>?)?.map((e) => e as int)),
          dateTimeIterable: $checkedConvert(
              'datetime-iterable',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => DateTime.parse(e as String))),
        );
        $checkedConvert(
            'dateTime',
            (v) =>
                val.dateTime = v == null ? null : DateTime.parse(v as String));
        $checkedConvert('bigInt',
            (v) => val.bigInt = v == null ? null : BigInt.parse(v as String));
        $checkedConvert('set', (v) => val.set = (v as List<dynamic>).toSet());
        $checkedConvert(
            'dynamicSet', (v) => val.dynamicSet = (v as List<dynamic>).toSet());
        $checkedConvert(
            'objectSet',
            (v) => val.objectSet =
                (v as List<dynamic>).map((e) => e as Object).toSet());
        $checkedConvert(
            'intSet',
            (v) =>
                val.intSet = (v as List<dynamic>).map((e) => e as int).toSet());
        $checkedConvert(
            'dateTimeSet',
            (v) => val.dateTimeSet = (v as List<dynamic>)
                .map((e) => DateTime.parse(e as String))
                .toSet());
        $checkedConvert('list', (v) => val.list = v as List<dynamic>);
        $checkedConvert(
            'dynamicList', (v) => val.dynamicList = v as List<dynamic>);
        $checkedConvert(
            'objectList',
            (v) => val.objectList =
                (v as List<dynamic>).map((e) => e as Object).toList());
        $checkedConvert(
            'intList',
            (v) => val.intList =
                (v as List<dynamic>).map((e) => e as int).toList());
        $checkedConvert(
            'dateTimeList',
            (v) => val.dateTimeList = (v as List<dynamic>)
                .map((e) => DateTime.parse(e as String))
                .toList());
        $checkedConvert(
            'nullableSimpleObjectList',
            (v) => val.nullableSimpleObjectList = (v as List<dynamic>)
                .map((e) => e == null ? null : SimpleObject.fromJson(e as Map))
                .toList());
        $checkedConvert('map', (v) => val.map = v as Map);
        $checkedConvert('stringStringMap',
            (v) => val.stringStringMap = Map<String, String>.from(v as Map));
        $checkedConvert('dynamicIntMap',
            (v) => val.dynamicIntMap = Map<String, int>.from(v as Map));
        $checkedConvert(
            'objectDateTimeMap',
            (v) => val.objectDateTimeMap = (v as Map).map(
                  (k, e) => MapEntry(k as Object, DateTime.parse(e as String)),
                ));
        $checkedConvert(
            'nullableSimpleObjectMap',
            (v) => val.nullableSimpleObjectMap = (v as Map).map(
                  (k, e) => MapEntry(k as String,
                      e == null ? null : SimpleObject.fromJson(e as Map)),
                ));
        $checkedConvert(
            'crazyComplex',
            (v) => val.crazyComplex = (v as List<dynamic>)
                .map((e) => (e as Map?)?.map(
                      (k, e) => MapEntry(
                          k as String,
                          (e as Map?)?.map(
                            (k, e) => MapEntry(
                                k as String,
                                (e as List<dynamic>?)
                                    ?.map((e) => (e as List<dynamic>?)
                                        ?.map(
                                            (e) => DateTime.parse(e as String))
                                        .toList())
                                    .toList()),
                          )),
                    ))
                .toList());
        $checkedConvert(
            'val', (v) => val.val = Map<String, bool>.from(v as Map));
        $checkedConvert('writeNotNull', (v) => val.writeNotNull = v as bool?);
        $checkedConvert(
          r'$string',
          (v) => val.string = v as String?,
          readValue: KitchenSink._trickyValueAccessor,
        );
        $checkedConvert('simpleObject',
            (v) => val.simpleObject = SimpleObject.fromJson(v as Map));
        $checkedConvert('strictKeysObject',
            (v) => val.strictKeysObject = StrictKeysObject.fromJson(v as Map));
        $checkedConvert('validatedPropertyNo42',
            (v) => val.validatedPropertyNo42 = v as int?);
        return val;
      },
      fieldKeyMap: const {
        'ctorValidatedNo42': 'no-42',
        'dateTimeIterable': 'datetime-iterable',
        'string': r'$string'
      },
    );

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

JsonConverterTestClass _$JsonConverterTestClassFromJson(Map json) =>
    $checkedCreate(
      'JsonConverterTestClass',
      json,
      ($checkedConvert) {
        final val = JsonConverterTestClass(
          $checkedConvert('duration',
              (v) => const DurationMillisecondConverter().fromJson(v as int?)),
          $checkedConvert(
              'durationList',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      const DurationMillisecondConverter().fromJson(e as int?))
                  .toList()),
          $checkedConvert('bigInt',
              (v) => const BigIntStringConverter().fromJson(v as String)),
          $checkedConvert(
              'bigIntMap',
              (v) => (v as Map).map(
                    (k, e) => MapEntry(k as String,
                        const BigIntStringConverter().fromJson(e as String)),
                  )),
          $checkedConvert(
              'nullableBigInt',
              (v) => _$JsonConverterFromJson<String, BigInt>(
                  v, const BigIntStringConverter().fromJson)),
          $checkedConvert(
              'nullableBigIntMap',
              (v) => (v as Map).map(
                    (k, e) => MapEntry(
                        k as String,
                        _$JsonConverterFromJson<String, BigInt>(
                            e, const BigIntStringConverter().fromJson)),
                  )),
          $checkedConvert('numberSilly',
              (v) => TrivialNumberConverter.instance.fromJson(v as int?)),
          $checkedConvert(
              'numberSillySet',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TrivialNumberConverter.instance.fromJson(e as int?))
                  .toSet()),
          $checkedConvert('dateTime',
              (v) => const EpochDateTimeConverter().fromJson(v as int?)),
          $checkedConvert('trivialString',
              (v) => trivialStringConverter.fromJson(v as String?)),
          $checkedConvert('nullableNumberSilly',
              (v) => TrivialNumberConverter.instance.fromJson(v as int?)),
          $checkedConvert(
              'nullableNumberSillySet',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TrivialNumberConverter.instance.fromJson(e as int?))
                  .toSet()),
        );
        return val;
      },
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
        Map json) =>
    $checkedCreate(
      'JsonConverterGeneric',
      json,
      ($checkedConvert) {
        final val = JsonConverterGeneric<S, T, U>(
          $checkedConvert('item',
              (v) => GenericConverter<S>().fromJson(v as Map<String, dynamic>)),
          $checkedConvert(
              'itemList',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      GenericConverter<T>().fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert(
              'itemMap',
              (v) => (v as Map).map(
                    (k, e) => MapEntry(
                        k as String,
                        GenericConverter<U>()
                            .fromJson(e as Map<String, dynamic>)),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$JsonConverterGenericToJson<S, T, U>(
        JsonConverterGeneric<S, T, U> instance) =>
    <String, dynamic>{
      'item': GenericConverter<S>().toJson(instance.item),
      'itemList': instance.itemList.map(GenericConverter<T>().toJson).toList(),
      'itemMap': instance.itemMap
          .map((k, e) => MapEntry(k, GenericConverter<U>().toJson(e))),
    };
