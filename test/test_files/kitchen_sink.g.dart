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
    dateTimeIterable: (json['datetime-iterable'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String)))
  ..dateTime = json['dateTime'] == null
      ? null
      : DateTime.parse(json['dateTime'] as String)
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
              (e as Map).values.map((e) =>
                  e == null ? null : new Map<String, List<List<DateTime>>>.fromIterables((e as Map<String, dynamic>).keys, (e as Map).values.map((e) => (e as List)?.map((e) => (e as List)?.map((e) => e == null ? null : DateTime.parse(e as String))?.toList())?.toList())))))
      ?.toList()
  ..$map = json[r'$map'] == null ? null : new Map<String, bool>.from(json[r'$map'] as Map)
  ..$writeNotNull = json[r'$writeNotNull'] as bool
  ..string = json[r'$string'] as String;

abstract class _$KitchenSinkSerializerMixin {
  DateTime get dateTime;
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
  Map<String, bool> get $map;
  bool get $writeNotNull;
  String get string;
  Map<String, dynamic> toJson() {
    var $map = <String, dynamic>{};
    void $writeNotNull(String key, dynamic value) {
      if (value != null) {
        $map[key] = value;
      }
    }

    $writeNotNull('dateTime', dateTime?.toIso8601String());
    $writeNotNull('iterable', iterable?.toList());
    $map['dynamicIterable'] = dynamicIterable?.toList();
    $map['objectIterable'] = objectIterable?.toList();
    $map['intIterable'] = intIterable?.toList();
    $map['datetime-iterable'] =
        dateTimeIterable?.map((e) => e?.toIso8601String())?.toList();
    $map['list'] = list;
    $map['dynamicList'] = dynamicList;
    $map['objectList'] = objectList;
    $map['intList'] = intList;
    $writeNotNull('dateTimeList',
        dateTimeList?.map((e) => e?.toIso8601String())?.toList());
    $map['map'] = map;
    $map['stringStringMap'] = stringStringMap;
    $map['stringIntMap'] = stringIntMap;
    $map['stringDateTimeMap'] = stringDateTimeMap == null
        ? null
        : new Map<String, dynamic>.fromIterables(stringDateTimeMap.keys,
            stringDateTimeMap.values.map((e) => e?.toIso8601String()));
    $writeNotNull(
        'crazyComplex',
        crazyComplex
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
            ?.toList());
    $writeNotNull(r'$map', this.$map);
    $map[r'$writeNotNull'] = this.$writeNotNull;
    $map[r'$string'] = string;
    return $map;
  }
}
