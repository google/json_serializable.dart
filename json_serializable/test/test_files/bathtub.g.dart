// GENERATED CODE - DO NOT MODIFY BY HAND

part of json_serializable.test.bathtub;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Bathtub _$BathtubFromJson(Map<String, dynamic> json) => new Bathtub(
    iterable: json['iterable'] as List,
    dynamicIterable: json['dynamicIterable'] as List,
    objectIterable: json['objectIterable'] as List,
    intIterable: (json['intIterable'] as List).map((e) => e as int),
    dateTimeIterable: (json['datetime-iterable'] as List)
        .map((e) => DateTime.parse(e as String)))
  ..dateTime = DateTime.parse(json['dateTime'] as String)
  ..list = json['list'] as List
  ..dynamicList = json['dynamicList'] as List
  ..objectList = json['objectList'] as List
  ..intList = (json['intList'] as List).map((e) => e as int).toList()
  ..dateTimeList = (json['dateTimeList'] as List)
      .map((e) => DateTime.parse(e as String))
      .toList()
  ..map = json['map'] as Map<String, dynamic>
  ..stringStringMap =
      new Map<String, String>.from(json['stringStringMap'] as Map)
  ..stringIntMap = new Map<String, int>.from(json['stringIntMap'] as Map)
  ..stringDateTimeMap = new Map<String, DateTime>.fromIterables(
      (json['stringDateTimeMap'] as Map<String, dynamic>).keys,
      (json['stringDateTimeMap'] as Map)
          .values
          .map((e) => DateTime.parse(e as String)))
  ..crazyComplex = (json['crazyComplex'] as List)
      .map((e) => new Map<String, Map<String, List<List<DateTime>>>>.fromIterables(
          (e as Map<String, dynamic>).keys,
          (e as Map).values.map((e) =>
              new Map<String, List<List<DateTime>>>.fromIterables((e as Map<String, dynamic>).keys, (e as Map).values.map((e) => (e as List).map((e) => (e as List).map((e) => DateTime.parse(e as String)).toList()).toList())))))
      .toList()
  ..val = new Map<String, bool>.from(json['val'] as Map)
  ..writeNotNull = json['writeNotNull'] as bool
  ..string = json[r'$string'] as String;

abstract class _$BathtubSerializerMixin {
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
    var val = <String, dynamic>{
      'dateTime': dateTime.toIso8601String(),
      'iterable': iterable.toList(),
      'dynamicIterable': dynamicIterable.toList(),
      'objectIterable': objectIterable.toList(),
      'intIterable': intIterable.toList(),
      'datetime-iterable':
          dateTimeIterable.map((e) => e.toIso8601String()).toList(),
      'list': list,
      'dynamicList': dynamicList,
      'objectList': objectList,
      'intList': intList,
      'dateTimeList': dateTimeList.map((e) => e.toIso8601String()).toList(),
      'map': map,
      'stringStringMap': stringStringMap,
      'stringIntMap': stringIntMap,
      'stringDateTimeMap': new Map<String, dynamic>.fromIterables(
          stringDateTimeMap.keys,
          stringDateTimeMap.values.map((e) => e.toIso8601String())),
      'crazyComplex': crazyComplex
          .map((e) => new Map<String, dynamic>.fromIterables(
              e.keys,
              e.values.map((e) => new Map<String, dynamic>.fromIterables(
                  e.keys,
                  e.values.map((e) => e
                      .map((e) => e.map((e) => e.toIso8601String()).toList())
                      .toList())))))
          .toList(),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('val', this.val);
    val['writeNotNull'] = this.writeNotNull;
    val[r'$string'] = string;
    return val;
  }
}
