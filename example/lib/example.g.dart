// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      json['firstName'] as String,
      json['lastName'] as String,
      DateTime.parse(json['date-of-birth'] as String),
      middleName: json['middleName'] as String?,
      lastOrder: json['last-order'] == null
          ? null
          : DateTime.parse(json['last-order'] as String),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      if (instance.middleName case final value?) 'middleName': value,
      'lastName': instance.lastName,
      'date-of-birth': instance.dateOfBirth.toIso8601String(),
      'last-order': instance.lastOrder?.toIso8601String(),
      'orders': instance.orders,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      Order._dateTimeFromEpochUs((json['date'] as num).toInt()),
    )
      ..count = (json['count'] as num?)?.toInt()
      ..itemNumber = (json['itemNumber'] as num?)?.toInt()
      ..isRushed = json['isRushed'] as bool?
      ..item = json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>)
      ..prepTime =
          Order._durationFromMilliseconds((json['prep-time'] as num?)?.toInt());

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      if (instance.count case final value?) 'count': value,
      if (instance.itemNumber case final value?) 'itemNumber': value,
      if (instance.isRushed case final value?) 'isRushed': value,
      if (instance.item case final value?) 'item': value,
      if (Order._durationToMilliseconds(instance.prepTime) case final value?)
        'prep-time': value,
      if (Order._dateTimeToEpochUs(instance.date) case final value?)
        'date': value,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item()
  ..count = (json['count'] as num?)?.toInt()
  ..itemNumber = (json['itemNumber'] as num?)?.toInt()
  ..isRushed = json['isRushed'] as bool?;

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'count': instance.count,
      'itemNumber': instance.itemNumber,
      'isRushed': instance.isRushed,
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$glossaryDataJsonLiteral = {
  'glossary': {
    'title': 'example glossary',
    'GlossDiv': {
      'title': 'S',
      'GlossList': {
        'GlossEntry': {
          'ID': 'SGML',
          'SortAs': 'SGML',
          'GlossTerm': 'Standard Generalized Markup Language',
          'Acronym': 'SGML',
          'Abbrev': 'ISO 8879:1986',
          'GlossDef': {
            'para': 'A meta-markup language, used to create markup languages.',
            'GlossSeeAlso': ['GML', 'XML']
          },
          'GlossSee': 'markup'
        }
      }
    }
  }
};
