// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_sink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map json) {
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
    ..set = (json['set'] as List)?.map((e) => e)?.toSet()
    ..dynamicSet = (json['dynamicSet'] as List)?.map((e) => e)?.toSet()
    ..objectSet = (json['objectSet'] as List)?.map((e) => e)?.toSet()
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
    ..map = json['map'] as Map
    ..stringStringMap = (json['stringStringMap'] as Map)
        ?.map((k, e) => MapEntry(k as String, e as String))
    ..dynamicIntMap =
        (json['dynamicIntMap'] as Map)?.map((k, e) => MapEntry(k, e as int))
    ..objectDateTimeMap = (json['objectDateTimeMap'] as Map)?.map(
        (k, e) => MapEntry(k, e == null ? null : DateTime.parse(e as String)))
    ..crazyComplex = (json['crazyComplex'] as List)
        ?.map((e) => (e as Map)?.map((k, e) => MapEntry(
            k as String,
            (e as Map)?.map((k, e) => MapEntry(k as String,
                (e as List)?.map((e) => (e as List)?.map((e) => e == null ? null : DateTime.parse(e as String))?.toList())?.toList())))))
        ?.toList()
    ..val = (json['val'] as Map)?.map((k, e) => MapEntry(k as String, e as bool))
    ..writeNotNull = json['writeNotNull'] as bool
    ..string = json[r'$string'] as String
    ..simpleObject = json['simpleObject'] == null ? null : SimpleObject.fromJson(json['simpleObject'] as Map)
    ..strictKeysObject = json['strictKeysObject'] == null ? null : StrictKeysObject.fromJson(json['strictKeysObject'] as Map)
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
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{
      'no-42': ctorValidatedNo42,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('dateTime', dateTime?.toIso8601String());
    writeNotNull('iterable', iterable?.toList());
    val['dynamicIterable'] = dynamicIterable?.toList();
    val['objectIterable'] = objectIterable?.toList();
    val['intIterable'] = intIterable?.toList();
    val['set'] = set?.toList();
    val['dynamicSet'] = dynamicSet?.toList();
    val['objectSet'] = objectSet?.toList();
    val['intSet'] = intSet?.toList();
    val['dateTimeSet'] =
        dateTimeSet?.map((e) => e?.toIso8601String())?.toList();
    val['datetime-iterable'] =
        dateTimeIterable?.map((e) => e?.toIso8601String())?.toList();
    val['list'] = list;
    val['dynamicList'] = dynamicList;
    val['objectList'] = objectList;
    val['intList'] = intList;
    writeNotNull('dateTimeList',
        dateTimeList?.map((e) => e?.toIso8601String())?.toList());
    val['map'] = map;
    val['stringStringMap'] = stringStringMap;
    val['dynamicIntMap'] = dynamicIntMap;
    val['objectDateTimeMap'] =
        objectDateTimeMap?.map((k, e) => MapEntry(k, e?.toIso8601String()));
    writeNotNull(
        'crazyComplex',
        crazyComplex
            ?.map((e) => e?.map((k, e) => MapEntry(
                k,
                e?.map((k, e) => MapEntry(
                    k,
                    e
                        ?.map((e) =>
                            e?.map((e) => e?.toIso8601String())?.toList())
                        ?.toList())))))
            ?.toList());
    writeNotNull('val', this.val);
    val['writeNotNull'] = this.writeNotNull;
    val[r'$string'] = string;
    val['simpleObject'] = simpleObject;
    val['strictKeysObject'] = strictKeysObject;
    val['validatedPropertyNo42'] = validatedPropertyNo42;
    return val;
  }
}

JsonConverterTestClass _$JsonConverterTestClassFromJson(Map json) {
  return JsonConverterTestClass()
    ..duration = durationConverter.fromJson(json['duration'] as int)
    ..durationList = (json['durationList'] as List)
        ?.map((e) => durationConverter.fromJson(e as int))
        ?.toList()
    ..bigInt = const BigIntStringConverter().fromJson(json['bigInt'] as String)
    ..bigIntMap = (json['bigIntMap'] as Map)?.map((k, e) => MapEntry(
        k as String, const BigIntStringConverter().fromJson(e as String)))
    ..numberSilly =
        TrivialNumberConverter.instance.fromJson(json['numberSilly'] as int)
    ..numberSillySet = (json['numberSillySet'] as List)
        ?.map((e) => TrivialNumberConverter.instance.fromJson(e as int))
        ?.toSet()
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
  Map<String, dynamic> toJson() => <String, dynamic>{
        'duration': durationConverter.toJson(duration),
        'durationList': durationList?.map(durationConverter.toJson)?.toList(),
        'bigInt': const BigIntStringConverter().toJson(bigInt),
        'bigIntMap': bigIntMap?.map(
            (k, e) => MapEntry(k, const BigIntStringConverter().toJson(e))),
        'numberSilly': TrivialNumberConverter.instance.toJson(numberSilly),
        'numberSillySet': numberSillySet
            ?.map(TrivialNumberConverter.instance.toJson)
            ?.toList(),
        'dateTime': const EpochDateTimeConverter().toJson(dateTime)
      };
}

JsonConverterGeneric<S, T, U> _$JsonConverterGenericFromJson<S, T, U>(
    Map json) {
  return JsonConverterGeneric<S, T, U>()
    ..item =
        GenericConverter<S>().fromJson(json['item'] as Map<String, dynamic>)
    ..itemList = (json['itemList'] as List)
        ?.map((e) => GenericConverter<T>().fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..itemMap = (json['itemMap'] as Map)?.map((k, e) => MapEntry(k as String,
        GenericConverter<U>().fromJson(e as Map<String, dynamic>)));
}

abstract class _$JsonConverterGenericSerializerMixin<S, T, U> {
  S get item;
  List<T> get itemList;
  Map<String, U> get itemMap;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'item': GenericConverter<S>().toJson(item),
        'itemList': itemList?.map(GenericConverter<T>().toJson)?.toList(),
        'itemMap':
            itemMap?.map((k, e) => MapEntry(k, GenericConverter<U>().toJson(e)))
      };
}
