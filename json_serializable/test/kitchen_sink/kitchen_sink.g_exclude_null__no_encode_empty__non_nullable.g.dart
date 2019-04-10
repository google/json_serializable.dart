// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.g_exclude_null__no_encode_empty__non_nullable.dart';

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

Map<String, dynamic> _$KitchenSinkToJson(KitchenSink instance) {
  final val = <String, dynamic>{
    'no-42': instance.ctorValidatedNo42,
    'dateTime': instance.dateTime.toIso8601String(),
    'bigInt': instance.bigInt.toString(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('iterable', _$nullIfEmptyIterable(instance.iterable)?.toList());
  writeNotNull('dynamicIterable',
      _$nullIfEmptyIterable(instance.dynamicIterable)?.toList());
  writeNotNull('objectIterable',
      _$nullIfEmptyIterable(instance.objectIterable)?.toList());
  writeNotNull(
      'intIterable', _$nullIfEmptyIterable(instance.intIterable)?.toList());
  writeNotNull('set', _$nullIfEmptyIterable(instance.set)?.toList());
  writeNotNull(
      'dynamicSet', _$nullIfEmptyIterable(instance.dynamicSet)?.toList());
  writeNotNull(
      'objectSet', _$nullIfEmptyIterable(instance.objectSet)?.toList());
  writeNotNull('intSet', _$nullIfEmptyIterable(instance.intSet)?.toList());
  writeNotNull(
      'dateTimeSet',
      _$nullIfEmptyIterable(instance.dateTimeSet)
          ?.map((e) => e.toIso8601String())
          ?.toList());
  writeNotNull(
      'datetime-iterable',
      _$nullIfEmptyIterable(instance.dateTimeIterable)
          ?.map((e) => e.toIso8601String())
          ?.toList());
  writeNotNull('list', _$nullIfEmptyIterable(instance.list));
  writeNotNull('dynamicList', _$nullIfEmptyIterable(instance.dynamicList));
  writeNotNull('objectList', _$nullIfEmptyIterable(instance.objectList));
  writeNotNull('intList', _$nullIfEmptyIterable(instance.intList));
  writeNotNull(
      'dateTimeList',
      _$nullIfEmptyIterable(instance.dateTimeList)
          ?.map((e) => e.toIso8601String())
          ?.toList());
  writeNotNull('map', _$nullIfEmptyMap(instance.map));
  writeNotNull('stringStringMap', _$nullIfEmptyMap(instance.stringStringMap));
  writeNotNull('dynamicIntMap', _$nullIfEmptyMap(instance.dynamicIntMap));
  writeNotNull(
      'objectDateTimeMap',
      _$nullIfEmptyMap(instance.objectDateTimeMap)
          ?.map((k, e) => MapEntry(k, e.toIso8601String())));
  writeNotNull(
      'crazyComplex',
      _$nullIfEmptyIterable(instance.crazyComplex)
          ?.map((e) => e.map((k, e) => MapEntry(
              k,
              e.map((k, e) => MapEntry(
                  k,
                  e
                      .map((e) => e.map((e) => e.toIso8601String()).toList())
                      .toList())))))
          ?.toList());
  writeNotNull('val', _$nullIfEmptyMap(instance.val));
  val['writeNotNull'] = instance.writeNotNull;
  val[r'$string'] = instance.string;
  val['simpleObject'] = instance.simpleObject;
  val['strictKeysObject'] = instance.strictKeysObject;
  val['validatedPropertyNo42'] = instance.validatedPropertyNo42;
  return val;
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
    JsonConverterTestClass instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('duration', durationConverter.toJson(instance.duration));
  writeNotNull(
      'durationList',
      _$nullIfEmptyIterable(instance.durationList)
          ?.map(durationConverter.toJson)
          ?.toList());
  writeNotNull('bigInt', const BigIntStringConverter().toJson(instance.bigInt));
  writeNotNull(
      'bigIntMap',
      _$nullIfEmptyMap(instance.bigIntMap)?.map(
          (k, e) => MapEntry(k, const BigIntStringConverter().toJson(e))));
  writeNotNull('numberSilly',
      TrivialNumberConverter.instance.toJson(instance.numberSilly));
  writeNotNull(
      'numberSillySet',
      _$nullIfEmptyIterable(instance.numberSillySet)
          ?.map(TrivialNumberConverter.instance.toJson)
          ?.toList());
  writeNotNull(
      'dateTime', const EpochDateTimeConverter().toJson(instance.dateTime));
  return val;
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
    JsonConverterGeneric<S, T, U> instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('item', GenericConverter<S>().toJson(instance.item));
  writeNotNull(
      'itemList',
      _$nullIfEmptyIterable(instance.itemList)
          ?.map(GenericConverter<T>().toJson)
          ?.toList());
  writeNotNull(
      'itemMap',
      _$nullIfEmptyMap(instance.itemMap)
          ?.map((k, e) => MapEntry(k, GenericConverter<U>().toJson(e))));
  return val;
}
