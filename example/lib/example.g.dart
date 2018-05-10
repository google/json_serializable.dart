// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => new Person(
    json['firstName'] as String,
    json['lastName'] as String,
    DateTime.parse(json['date-of-birth'] as String),
    middleName: json['middleName'] as String,
    lastOrder: json['last-order'] == null
        ? null
        : DateTime.parse(json['last-order'] as String),
    orders: (json['orders'] as List)
        .map((e) => new Order.fromJson(e as Map<String, dynamic>))
        .toList());

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get middleName;
  String get lastName;
  DateTime get dateOfBirth;
  DateTime get lastOrder;
  List<Order> get orders;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{
      'firstName': firstName,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('middleName', middleName);
    val['lastName'] = lastName;
    val['date-of-birth'] = dateOfBirth.toIso8601String();
    val['last-order'] = lastOrder?.toIso8601String();
    val['orders'] = orders;
    return val;
  }
}

Order _$OrderFromJson(Map<String, dynamic> json) => new Order(
    json['date'] == null ? null : _dateTimeFromEpochUs(json['date'] as int))
  ..count = json['count'] as int
  ..itemNumber = json['itemNumber'] as int
  ..isRushed = json['isRushed'] as bool
  ..item = json['item'] == null
      ? null
      : new Item.fromJson(json['item'] as Map<String, dynamic>)
  ..prepTime = json['prep-time'] == null
      ? null
      : _durationFromMillseconds(json['prep-time'] as int);

abstract class _$OrderSerializerMixin {
  int get count;
  int get itemNumber;
  bool get isRushed;
  Item get item;
  Duration get prepTime;
  DateTime get date;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('count', count);
    writeNotNull('itemNumber', itemNumber);
    writeNotNull('isRushed', isRushed);
    writeNotNull('item', item);
    writeNotNull('prep-time',
        prepTime == null ? null : _durationToMilliseconds(prepTime));
    writeNotNull('date', date == null ? null : _dateTimeToEpochUs(date));
    return val;
  }
}

Item _$ItemFromJson(Map<String, dynamic> json) => new Item()
  ..count = json['count'] as int
  ..itemNumber = json['itemNumber'] as int
  ..isRushed = json['isRushed'] as bool;

// **************************************************************************
// Generator: JsonLiteralGenerator
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
            'para':
                'A meta-markup language, used to create markup languages such as DocBook.',
            'GlossSeeAlso': ['GML', 'XML']
          },
          'GlossSee': 'markup'
        }
      }
    }
  }
};
