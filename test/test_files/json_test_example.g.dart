// GENERATED CODE - DO NOT MODIFY BY HAND

part of json_serializable.test.example;

// **************************************************************************
// Generator: JsonSerializableGenerator
// Target: class KitchenSink
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map<String, dynamic> json) => new KitchenSink(
    iterable: json['iterable'] as List,
    dynamicIterable: json['dynamicIterable'] as List,
    objectIterable: json['objectIterable'] as List,
    intIterable: (json['intIterable'] as List)?.map((v0) => v0 as int),
    dateTimeIterable: (json['dateTimeIterable'] as List)
        ?.map((v0) => v0 == null ? null : DateTime.parse(v0 as String)))
  ..list = json['list'] as List
  ..dynamicList = json['dynamicList'] as List
  ..objectList = json['objectList'] as List
  ..intList = (json['intList'] as List)?.map((v0) => v0 as int)?.toList()
  ..dateTimeList = (json['dateTimeList'] as List)
      ?.map((v0) => v0 == null ? null : DateTime.parse(v0 as String))
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
              .map((v0) => v0 == null ? null : DateTime.parse(v0 as String)))
  ..crazyComplex = (json['crazyComplex'] as List)
      ?.map((v0) => v0 == null
          ? null
          : new Map<String, Map<String, List<List<DateTime>>>>.fromIterables(
              (v0 as Map<String, dynamic>).keys,
              (v0 as Map).values.map((v1) => v1 == null
                  ? null
                  : new Map<String, List<List<DateTime>>>.fromIterables((v1 as Map<String, dynamic>).keys, (v1 as Map).values.map((v2) => (v2 as List)?.map((v3) => (v3 as List)?.map((v4) => v4 == null ? null : DateTime.parse(v4 as String))?.toList())?.toList())))))
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
            dateTimeIterable?.map((v0) => v0?.toIso8601String())?.toList(),
        'list': list,
        'dynamicList': dynamicList,
        'objectList': objectList,
        'intList': intList,
        'dateTimeList':
            dateTimeList?.map((v0) => v0?.toIso8601String())?.toList(),
        'map': map,
        'stringStringMap': stringStringMap,
        'stringIntMap': stringIntMap,
        'stringDateTimeMap': stringDateTimeMap == null
            ? null
            : new Map<String, dynamic>.fromIterables(stringDateTimeMap.keys,
                stringDateTimeMap.values.map((v0) => v0?.toIso8601String())),
        'crazyComplex': crazyComplex
            ?.map((v0) => v0 == null
                ? null
                : new Map<String, dynamic>.fromIterables(
                    v0.keys,
                    v0.values.map((v1) => v1 == null
                        ? null
                        : new Map<String, dynamic>.fromIterables(
                            v1.keys,
                            v1.values.map((v2) => v2
                                ?.map((v3) => v3
                                    ?.map((v4) => v4?.toIso8601String())
                                    ?.toList())
                                ?.toList())))))
            ?.toList()
      };
}

// **************************************************************************
// Generator: JsonSerializableGenerator
// Target: class Person
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) =>
    new Person(json['firstName'] as String, json['lastName'] as String,
        middleName: json['middleName'] as String,
        dateOfBirth: json['dateOfBirth'] == null
            ? null
            : DateTime.parse(json['dateOfBirth'] as String));

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get middleName;
  String get lastName;
  DateTime get dateOfBirth;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth?.toIso8601String()
      };
}

// **************************************************************************
// Generator: JsonSerializableGenerator
// Target: class Order
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) =>
    new Order((json['items'] as List)?.map((v0) =>
        v0 == null ? null : new Item.fromJson(v0 as Map<String, dynamic>)))
      ..count = json['count'] as int
      ..isRushed = json['isRushed'] as bool;

abstract class _$OrderSerializerMixin {
  int get count;
  bool get isRushed;
  UnmodifiableListView<Item> get items;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'count': count, 'isRushed': isRushed, 'items': items};
}

// **************************************************************************
// Generator: JsonSerializableGenerator
// Target: class Item
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => new Item(json['price'] as int)
  ..itemNumber = json['itemNumber'] as int
  ..saleDates = (json['saleDates'] as List)
      ?.map((v0) => v0 == null ? null : DateTime.parse(v0 as String))
      ?.toList()
  ..rates = (json['rates'] as List)?.map((v0) => v0 as int)?.toList();

abstract class _$ItemSerializerMixin {
  int get price;
  int get itemNumber;
  List<DateTime> get saleDates;
  List<int> get rates;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'price': price,
        'itemNumber': itemNumber,
        'saleDates': saleDates?.map((v0) => v0?.toIso8601String())?.toList(),
        'rates': rates
      };
}
