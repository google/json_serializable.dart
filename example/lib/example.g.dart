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

Map<String, dynamic> _$PersonToJson(Person instance) {
  final val = <String, dynamic>{
    'firstName': instance.firstName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('middleName', instance.middleName);
  val['lastName'] = instance.lastName;
  val['date-of-birth'] = instance.dateOfBirth.toIso8601String();
  val['last-order'] = instance.lastOrder?.toIso8601String();
  val['orders'] = instance.orders;
  return val;
}

class _$PersonFields {
  const _$PersonFields();
  final String firstName = 'firstName';
  final String middleName = 'middleName';
  final String lastName = 'lastName';
  final String dateOfBirth = 'date-of-birth';
  final String lastOrder = 'last-order';
  final String orders = 'orders';
}

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      Order._dateTimeFromEpochUs(json['date'] as int),
    )
      ..count = json['count'] as int?
      ..itemNumber = json['itemNumber'] as int?
      ..isRushed = json['isRushed'] as bool?
      ..item = json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>)
      ..prepTime = Order._durationFromMilliseconds(json['prep-time'] as int?);

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('count', instance.count);
  writeNotNull('itemNumber', instance.itemNumber);
  writeNotNull('isRushed', instance.isRushed);
  writeNotNull('item', instance.item);
  writeNotNull('prep-time', Order._durationToMilliseconds(instance.prepTime));
  writeNotNull('date', Order._dateTimeToEpochUs(instance.date));
  return val;
}

class _$OrderFields {
  const _$OrderFields();
  final String count = 'count';
  final String itemNumber = 'itemNumber';
  final String isRushed = 'isRushed';
  final String item = 'item';
  final String prepTime = 'prep-time';
  final String date = 'date';
}

Item _$ItemFromJson(Map<String, dynamic> json) => Item()
  ..count = json['count'] as int?
  ..itemNumber = json['itemNumber'] as int?
  ..isRushed = json['isRushed'] as bool?;

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'count': instance.count,
      'itemNumber': instance.itemNumber,
      'isRushed': instance.isRushed,
    };

class _$ItemFields {
  const _$ItemFields();
  final String count = 'count';
  final String itemNumber = 'itemNumber';
  final String isRushed = 'isRushed';
}

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
