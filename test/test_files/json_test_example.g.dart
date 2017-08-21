// GENERATED CODE - DO NOT MODIFY BY HAND

part of json_serializable.test.example;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => new Person(
    json['firstName'] as String,
    json['lastName'] as String,
    json['house'] == null
        ? null
        : House.values
            .singleWhere((x) => x.toString() == "House.${json['house']}"),
    middleName: json['middleName'] as String,
    dateOfBirth: json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String));

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get middleName;
  String get lastName;
  DateTime get dateOfBirth;
  House get house;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'house': house == null ? null : house.toString().split('.')[1]
      };
}

Order _$OrderFromJson(Map<String, dynamic> json) => new Order(
    Category.values
        .singleWhere((x) => x.toString() == "Category.${json['category']}"),
    (json['items'] as List)?.map(
        (e) => e == null ? null : new Item.fromJson(e as Map<String, dynamic>)))
  ..count = json['count'] as int
  ..isRushed = json['isRushed'] as bool
  ..platform = json['platform'] == null
      ? null
      : new Platform.fromJson(json['platform'] as String)
  ..altPlatforms = json['altPlatforms'] == null
      ? null
      : new Map<String, Platform>.fromIterables(
          (json['altPlatforms'] as Map<String, dynamic>).keys,
          (json['altPlatforms'] as Map).values.map(
              (e) => e == null ? null : new Platform.fromJson(e as String)));

abstract class _$OrderSerializerMixin {
  int get count;
  bool get isRushed;
  Category get category;
  UnmodifiableListView<Item> get items;
  Platform get platform;
  Map<String, Platform> get altPlatforms;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'isRushed': isRushed,
        'category': category.toString().split('.')[1],
        'items': items,
        'platform': platform,
        'altPlatforms': altPlatforms
      };
}

Item _$ItemFromJson(Map<String, dynamic> json) => new Item(json['price'] as int)
  ..itemNumber = json['itemNumber'] as int
  ..saleDates = (json['saleDates'] as List)
      ?.map((e) => e == null ? null : DateTime.parse(e as String))
      ?.toList()
  ..rates = (json['rates'] as List)?.map((e) => e as int)?.toList();

abstract class _$ItemSerializerMixin {
  int get price;
  int get itemNumber;
  List<DateTime> get saleDates;
  List<int> get rates;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'price': price,
        'itemNumber': itemNumber,
        'saleDates': saleDates?.map((e) => e?.toIso8601String())?.toList(),
        'rates': rates
      };
}

Numbers _$NumbersFromJson(Map<String, dynamic> json) => new Numbers()
  ..ints = (json['ints'] as List)?.map((e) => e as int)?.toList()
  ..nums = (json['nums'] as List)?.map((e) => e as num)?.toList()
  ..doubles =
      (json['doubles'] as List)?.map((e) => (e as num)?.toDouble())?.toList()
  ..nnDoubles =
      (json['nnDoubles'] as List).map((e) => (e as num).toDouble()).toList();

abstract class _$NumbersSerializerMixin {
  List<int> get ints;
  List<num> get nums;
  List<double> get doubles;
  List<double> get nnDoubles;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'ints': ints,
        'nums': nums,
        'doubles': doubles,
        'nnDoubles': nnDoubles
      };
}
