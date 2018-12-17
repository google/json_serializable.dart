// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_test_example.unknowable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(json['firstName'] as String, json['lastName'] as String,
      _$enumDecode(_$CategoryEnumMap, json[r'$house']),
      middleName: json['middleName'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String))
    ..order = Order.fromJson(json['order'] as Map<String, dynamic>)
    ..houseMap = (json['houseMap'] as Map<String, dynamic>)
        .map((k, e) => MapEntry(k, _$enumDecode(_$CategoryEnumMap, e)))
    ..categoryCounts = (json['categoryCounts'] as Map<String, dynamic>)
        .map((k, e) => MapEntry(_$enumDecode(_$CategoryEnumMap, k), e as int));
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      r'$house': _$CategoryEnumMap[instance.house],
      'order': instance.order,
      'houseMap':
          instance.houseMap.map((k, e) => MapEntry(k, _$CategoryEnumMap[e])),
      'categoryCounts': instance.categoryCounts
          .map((k, e) => MapEntry(_$CategoryEnumMap[k], e))
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

const _$CategoryEnumMap = <Category, dynamic>{
  Category.top: 'top',
  Category.bottom: 'bottom',
  Category.strange: 'strange',
  Category.charmed: 'charmed',
  Category.up: 'up',
  Category.down: 'down',
  Category.notDiscoveredYet: 'not_discovered_yet'
};

Order _$OrderFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['count']);
  return Order(
      _$enumDecodeUnknowable(_$CategoryEnumMap, json['category']) ??
          Category.notDiscoveredYet,
      (json['items'] as List)
          .map((e) => Item.fromJson(e as Map<String, dynamic>)))
    ..count = json['count'] as int
    ..isRushed = json['isRushed'] as bool
    ..duration = Duration(microseconds: json['duration'] as int)
    ..platform = Platform.fromJson(json['platform'] as String)
    ..altPlatforms = (json['altPlatforms'] as Map<String, dynamic>)
        .map((k, e) => MapEntry(k, Platform.fromJson(e as String)))
    ..homepage = Uri.parse(json['homepage'] as String)
    ..statusCode =
        _$enumDecodeNullable(_$StatusCodeEnumMap, json['status_code']) ??
            StatusCode.success;
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'count': instance.count,
      'isRushed': instance.isRushed,
      'duration': instance.duration.inMicroseconds,
      'category': _$CategoryEnumMap[instance.category],
      'items': instance.items,
      'platform': instance.platform,
      'altPlatforms': instance.altPlatforms,
      'homepage': instance.homepage.toString(),
      'status_code': _$StatusCodeEnumMap[instance.statusCode]
    };

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

T _$enumDecodeUnknowable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  if (enumValues.values.singleWhere((v) => v == source) == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$StatusCodeEnumMap = <StatusCode, dynamic>{
  StatusCode.success: 200,
  StatusCode.notFound: 404
};

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(json['price'] as int)
    ..itemNumber = json['item-number'] as int
    ..saleDates = (json['saleDates'] as List)
        .map((e) => DateTime.parse(e as String))
        .toList()
    ..rates = (json['rates'] as List).map((e) => e as int).toList();
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'price': instance.price,
      'item-number': instance.itemNumber,
      'saleDates': instance.saleDates.map((e) => e.toIso8601String()).toList(),
      'rates': instance.rates
    };

Numbers _$NumbersFromJson(Map<String, dynamic> json) {
  return Numbers()
    ..ints = (json['ints'] as List).map((e) => e as int).toList()
    ..nums = (json['nums'] as List).map((e) => e as num).toList()
    ..doubles =
        (json['doubles'] as List).map((e) => (e as num).toDouble()).toList()
    ..nnDoubles =
        (json['nnDoubles'] as List).map((e) => (e as num).toDouble()).toList()
    ..duration = durationFromInt(json['duration'] as int)
    ..date = dateTimeFromEpochUs(json['date'] as int);
}

Map<String, dynamic> _$NumbersToJson(Numbers instance) => <String, dynamic>{
      'ints': instance.ints,
      'nums': instance.nums,
      'doubles': instance.doubles,
      'nnDoubles': instance.nnDoubles,
      'duration': durationToInt(instance.duration),
      'date': dateTimeToEpochUs(instance.date)
    };
