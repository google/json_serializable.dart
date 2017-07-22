// GENERATED CODE - DO NOT MODIFY BY HAND

part of json_serializable.test.kitche_sink;

// **************************************************************************
// Generator: JsonSerializableGenerator
// Target: class KitchenSink
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map<String, dynamic> json) => new KitchenSink(
    iterable: json['iterable'] as List,
    dynamicIterable: json['dynamicIterable'] as List,
    objectIterable: json['objectIterable'] as List,
    intIterable: (json['intIterable'] as List)?.map((e) => e as int),
    dateTimeIterable: (json['dateTimeIterable'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String)))
  ..list = json['list'] as List
  ..dynamicList = json['dynamicList'] as List
  ..objectList = json['objectList'] as List
  ..intList = (json['intList'] as List)?.map((e) => e as int)?.toList()
  ..dateTimeList = (json['dateTimeList'] as List)
      ?.map((e) => e == null ? null : DateTime.parse(e as String))
      ?.toList()
  ..map = json['map'] as Map<String, dynamic>
  ..stringStringMap = json['stringStringMap'] == null
      ? null
      : new Map<String, String>.from(json['stringStringMap'] as Map)
  ..stringIntMap = json['stringIntMap'] == null
      ? null
      : new Map<String, int>.from(json['stringIntMap'] as Map)
  ..stringDateTimeMap = json['stringDateTimeMap'] == null
      ? null
      : new Map<String, DateTime>.fromIterables(
          (json['stringDateTimeMap'] as Map<String, dynamic>).keys,
          (json['stringDateTimeMap'] as Map)
              .values
              .map((e) => e == null ? null : DateTime.parse(e as String)))
  ..crazyComplex = (json['crazyComplex'] as List)
      ?.map((e) => e == null
          ? null
          : new Map<String, Map<String, List<List<DateTime>>>>.fromIterables(
              (e as Map<String, dynamic>).keys,
              (e as Map).values.map((e) => e == null
                  ? null
                  : new Map<String, List<List<DateTime>>>.fromIterables((e as Map<String, dynamic>).keys, (e as Map).values.map((e) => (e as List)?.map((e) => (e as List)?.map((e) => e == null ? null : DateTime.parse(e as String))?.toList())?.toList())))))
      ?.toList();

abstract class _$KitchenSinkSerializerMixin {
  Iterable<dynamic> get iterable;
  Iterable<dynamic> get dynamicIterable;
  Iterable<Object> get objectIterable;
  Iterable<int> get intIterable;
  Iterable<DateTime> get dateTimeIterable;
  List<dynamic> get list;
  List<dynamic> get dynamicList;
  List<Object> get objectList;
  List<int> get intList;
  List<DateTime> get dateTimeList;
  Map<dynamic, dynamic> get map;
  Map<String, String> get stringStringMap;
  Map<String, int> get stringIntMap;
  Map<String, DateTime> get stringDateTimeMap;
  List<Map<String, Map<String, List<List<DateTime>>>>> get crazyComplex;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'iterable': iterable?.toList(),
        'dynamicIterable': dynamicIterable?.toList(),
        'objectIterable': objectIterable?.toList(),
        'intIterable': intIterable?.toList(),
        'dateTimeIterable':
            dateTimeIterable?.map((e) => e?.toIso8601String())?.toList(),
        'list': list,
        'dynamicList': dynamicList,
        'objectList': objectList,
        'intList': intList,
        'dateTimeList':
            dateTimeList?.map((e) => e?.toIso8601String())?.toList(),
        'map': map,
        'stringStringMap': stringStringMap,
        'stringIntMap': stringIntMap,
        'stringDateTimeMap': stringDateTimeMap == null
            ? null
            : new Map<String, dynamic>.fromIterables(stringDateTimeMap.keys,
                stringDateTimeMap.values.map((e) => e?.toIso8601String())),
        'crazyComplex': crazyComplex
            ?.map((e) => e == null
                ? null
                : new Map<String, dynamic>.fromIterables(
                    e.keys,
                    e.values.map((e) => e == null
                        ? null
                        : new Map<String, dynamic>.fromIterables(
                            e.keys,
                            e.values.map((e) => e
                                ?.map((e) => e
                                    ?.map((e) => e?.toIso8601String())
                                    ?.toList())
                                ?.toList())))))
            ?.toList()
      };
}
