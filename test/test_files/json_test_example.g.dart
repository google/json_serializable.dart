// GENERATED CODE - DO NOT MODIFY BY HAND

part of source_gen.test.example;

// **************************************************************************
// Generator: JsonSerializableGenerator
// Target: class KitchenSink
// **************************************************************************

KitchenSink _$KitchenSinkFromJson(Map json) => new KitchenSink()
  ..iterable = json['iterable']
  ..dynamicIterable = json['dynamicIterable']
  ..objectIterable = json['objectIterable']
  ..intIterable = (json['intIterable'] as List)?.map((v0) => v0 as int)
  ..dateTimeIterable = (json['dateTimeIterable'] as List)
      ?.map((v0) => v0 == null ? null : DateTime.parse(v0))
  ..list = json['list']
  ..dynamicList = json['dynamicList']
  ..objectList = json['objectList']
  ..intList = (json['intList'] as List)?.map((v0) => v0 as int)?.toList()
  ..dateTimeList = (json['dateTimeList'] as List)
      ?.map((v0) => v0 == null ? null : DateTime.parse(v0))
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
            dateTimeList?.map((v0) => v0?.toIso8601String())?.toList()
      };
}

// **************************************************************************
// Generator: JsonSerializableGenerator
// Target: class Person
// **************************************************************************

Person _$PersonFromJson(Map json) =>
    new Person(json['firstName'] as String, json['lastName'] as String,
        middleName: json['middleName'] as String,
        dateOfBirth: json['dateOfBirth'] == null
            ? null
            : DateTime.parse(json['dateOfBirth']));

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

Order _$OrderFromJson(Map json) => new Order((json['items'] as List)
    ?.map((v0) => v0 == null ? null : new Item.fromJson(v0)))
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

Item _$ItemFromJson(Map json) => new Item(json['price'] as int)
  ..itemNumber = json['itemNumber'] as int
  ..saleDates = (json['saleDates'] as List)
      ?.map((v0) => v0 == null ? null : DateTime.parse(v0))
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
