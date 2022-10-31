// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'json_test_example.g_any_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map json) => Person(
      json['firstName'] as String,
      json['lastName'] as String,
      $enumDecode(_$CategoryEnumMap, json[r'$house']),
      middleName: json['middleName'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
    )
      ..order = json['order'] == null
          ? null
          : Order.fromJson(Map<String, dynamic>.from(json['order'] as Map))
      ..customOrders = json['customOrders'] == null
          ? null
          : MyList<Order>.fromJson((json['customOrders'] as List<dynamic>)
              .map((e) => Order.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList())
      ..houseMap = (json['houseMap'] as Map?)?.map(
        (k, e) => MapEntry(k as String, $enumDecode(_$CategoryEnumMap, e)),
      )
      ..categoryCounts = (json['categoryCounts'] as Map?)?.map(
        (k, e) => MapEntry($enumDecode(_$CategoryEnumMap, k), e as int),
      );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      r'$house': _$CategoryEnumMap[instance.house]!,
      'order': instance.order,
      'customOrders': instance.customOrders,
      'houseMap':
          instance.houseMap?.map((k, e) => MapEntry(k, _$CategoryEnumMap[e]!)),
      'categoryCounts': instance.categoryCounts
          ?.map((k, e) => MapEntry(_$CategoryEnumMap[k]!, e)),
    };

const _$CategoryEnumMap = {
  Category.top: 'top',
  Category.bottom: 'bottom',
  Category.strange: 'strange',
  Category.charmed: 'charmed',
  Category.up: 'up',
  Category.down: 'down',
  Category.notDiscoveredYet: 'not_discovered_yet',
};

Order _$OrderFromJson(Map json) {
  $checkKeys(
    json,
    disallowNullValues: const ['count'],
  );
  return Order.custom(
    $enumDecodeNullable(_$CategoryEnumMap, json['category']),
    (json['items'] as List<dynamic>?)
        ?.map((e) => Item.fromJson(Map<String, dynamic>.from(e as Map))),
  )
    ..count = json['count'] as int?
    ..isRushed = json['isRushed'] as bool?
    ..duration = json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int)
    ..platform = json['platform'] == null
        ? null
        : Platform.fromJson(json['platform'] as String)
    ..altPlatforms = (json['altPlatforms'] as Map?)?.map(
      (k, e) => MapEntry(k as String, Platform.fromJson(e as String)),
    )
    ..homepage =
        json['homepage'] == null ? null : Uri.parse(json['homepage'] as String)
    ..statusCode = $enumDecodeNullable(_$StatusCodeEnumMap, json['status_code'],
            unknownValue: StatusCode.unknown) ??
        StatusCode.success;
}

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('count', instance.count);
  val['isRushed'] = instance.isRushed;
  val['duration'] = instance.duration?.inMicroseconds;
  val['category'] = _$CategoryEnumMap[instance.category];
  val['items'] = instance.items;
  val['platform'] = instance.platform;
  val['altPlatforms'] = instance.altPlatforms;
  val['homepage'] = instance.homepage?.toString();
  val['status_code'] = _$StatusCodeEnumMap[instance.statusCode];
  return val;
}

const _$StatusCodeEnumMap = {
  StatusCode.success: 200,
  StatusCode.notFound: 404,
  StatusCode.weird: '500',
  StatusCode.unknown: 'unknown',
};

Item _$ItemFromJson(Map json) => Item(
      json['price'] as int?,
    )
      ..itemNumber = json['item-number'] as int?
      ..saleDates = (json['saleDates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList()
      ..rates = (json['rates'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..geoPoint = _fromJsonGeoPoint(json['geoPoint'] as Map<String, dynamic>?);

Map<String, dynamic> _$ItemToJson(Item instance) {
  final val = <String, dynamic>{
    'price': instance.price,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('item-number', instance.itemNumber);
  val['saleDates'] =
      instance.saleDates?.map((e) => e.toIso8601String()).toList();
  val['rates'] = instance.rates;
  val['geoPoint'] = _toJsonGeoPoint(instance.geoPoint);
  return val;
}

Numbers _$NumbersFromJson(Map json) => Numbers()
  ..ints = (json['ints'] as List<dynamic>?)?.map((e) => e as int).toList()
  ..nums = (json['nums'] as List<dynamic>?)?.map((e) => e as num).toList()
  ..doubles = (json['doubles'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList()
  ..nnDoubles = (json['nnDoubles'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList()
  ..duration = durationFromInt(json['duration'] as int?)
  ..date = dateTimeFromEpochUs(json['date'] as int?);

Map<String, dynamic> _$NumbersToJson(Numbers instance) => <String, dynamic>{
      'ints': instance.ints,
      'nums': instance.nums,
      'doubles': instance.doubles,
      'nnDoubles': instance.nnDoubles,
      'duration': durationToInt(instance.duration),
      'date': dateTimeToEpochUs(instance.date),
    };

MapKeyVariety _$MapKeyVarietyFromJson(Map json) => MapKeyVariety()
  ..intIntMap = (json['intIntMap'] as Map?)?.map(
    (k, e) => MapEntry(int.parse(k as String), e as int),
  )
  ..uriIntMap = (json['uriIntMap'] as Map?)?.map(
    (k, e) => MapEntry(Uri.parse(k as String), e as int),
  )
  ..dateTimeIntMap = (json['dateTimeIntMap'] as Map?)?.map(
    (k, e) => MapEntry(DateTime.parse(k as String), e as int),
  )
  ..bigIntMap = (json['bigIntMap'] as Map?)?.map(
    (k, e) => MapEntry(BigInt.parse(k as String), e as int),
  );

Map<String, dynamic> _$MapKeyVarietyToJson(MapKeyVariety instance) =>
    <String, dynamic>{
      'intIntMap': instance.intIntMap?.map((k, e) => MapEntry(k.toString(), e)),
      'uriIntMap': instance.uriIntMap?.map((k, e) => MapEntry(k.toString(), e)),
      'dateTimeIntMap': instance.dateTimeIntMap
          ?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'bigIntMap': instance.bigIntMap?.map((k, e) => MapEntry(k.toString(), e)),
    };

UnknownEnumValue _$UnknownEnumValueFromJson(Map json) => UnknownEnumValue()
  ..enumValue = $enumDecode(_$CategoryEnumMap, json['enumValue'],
      unknownValue: Category.notDiscoveredYet)
  ..enumIterable = (json['enumIterable'] as List<dynamic>).map((e) =>
      $enumDecode(_$CategoryEnumMap, e,
          unknownValue: Category.notDiscoveredYet))
  ..enumList = (json['enumList'] as List<dynamic>)
      .map((e) => $enumDecode(_$CategoryEnumMap, e,
          unknownValue: Category.notDiscoveredYet))
      .toList()
  ..enumSet = (json['enumSet'] as List<dynamic>)
      .map((e) => $enumDecode(_$CategoryEnumMap, e,
          unknownValue: Category.notDiscoveredYet))
      .toSet();

PrivateConstructor _$PrivateConstructorFromJson(Map json) =>
    PrivateConstructor._(
      json['id'] as int,
      json['value'] as String,
    );

Map<String, dynamic> _$PrivateConstructorToJson(PrivateConstructor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };

RegressionTestIssue1210 _$RegressionTestIssue1210FromJson(Map json) =>
    RegressionTestIssue1210(
      json['field'] as String,
    );

Map<String, dynamic> _$RegressionTestIssue1210ToJson(
        RegressionTestIssue1210 instance) =>
    <String, dynamic>{
      'field': instance.field,
    };
