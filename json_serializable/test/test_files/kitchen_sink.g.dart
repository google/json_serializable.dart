// GENERATED CODE - DO NOT MODIFY BY HAND

part of json_serializable.test.kitche_sink;

// **************************************************************************
// Generator: JsonSerializableGenerator
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
  ..val = json['val'] == null ? null : new Map<String, bool>.from(json['val'] as Map)
  ..writeNotNull = json['writeNotNull'] as bool
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
  Map<String, bool> get val;
  bool get writeNotNull;
  String get string;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{};

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
    val['stringIntMap'] = stringIntMap;
    val['stringDateTimeMap'] = stringDateTimeMap == null
        ? null
        : new Map<String, dynamic>.fromIterables(stringDateTimeMap.keys,
            stringDateTimeMap.values.map((e) => e?.toIso8601String()));
    writeNotNull(
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
    writeNotNull('val', this.val);
    val['writeNotNull'] = this.writeNotNull;
    val[r'$string'] = string;
    return val;
  }
}
