// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

import '../test_utils.dart';
import 'field_map_example.dart';
import 'json_enum_example.dart';
import 'json_test_common.dart' show Category, Platform, StatusCode;
import 'json_test_example.dart';

Matcher _throwsArgumentError(matcher) =>
    throwsA(isArgumentError.having((e) => e.message, 'message', matcher));

void main() {
  group('Person', () {
    void roundTripPerson(Person p) {
      roundTripObject(p, Person.fromJson);
    }

    test('now', () {
      roundTripPerson(Person('a', 'b', Category.charmed,
          middleName: 'c', dateOfBirth: DateTime.now()));
    });

    test('now toUtc', () {
      roundTripPerson(Person('a', 'b', Category.bottom,
          middleName: 'c', dateOfBirth: DateTime.now().toUtc()));
    });

    test('empty json', () {
      final person = Person.fromJson({
        'firstName': 'a',
        'lastName': 'b',
        '\$house': 'top',
      });
      expect(person.dateOfBirth, isNull);
      roundTripPerson(person);
    });

    test('enum map', () {
      final person = Person('', '', Category.bottom)
        ..houseMap = {'bob': Category.strange}
        ..categoryCounts = {Category.strange: 1};
      expect(person.dateOfBirth, isNull);
      roundTripPerson(person);
    });
  });

  group('Order', () {
    void roundTripOrder(Order p) {
      roundTripObject(p, Order.fromJson);
    }

    test('null', () {
      roundTripOrder(
          Order.custom(Category.charmed)..statusCode = StatusCode.success);
    });

    test('empty', () {
      roundTripOrder(Order.custom(Category.strange, const [])
        ..statusCode = StatusCode.success
        ..count = 0
        ..isRushed = false);
    });

    test('simple', () {
      roundTripOrder(Order.custom(Category.top, <Item>[
        Item(24)
          ..itemNumber = 42
          ..saleDates = [DateTime.now()]
      ])
        ..statusCode = StatusCode.success
        ..count = 42
        ..isRushed = true);
    });

    test('almost empty json', () {
      final order = Order.fromJson({'category': 'not_discovered_yet'});
      expect(order.items, isEmpty);
      expect(order.category, Category.notDiscoveredYet);
      expect(
        order.statusCode,
        StatusCode.success,
        reason: 'success is the default on an unset value',
      );
      roundTripOrder(order);
    });

    test('required, but missing enum value fails', () {
      expect(
          () => Person.fromJson({
                'firstName': 'a',
                'lastName': 'b',
              }),
          _throwsArgumentError('A value must be provided. Supported values: '
              'top, bottom, strange, charmed, up, down, not_discovered_yet'));
    });

    test('mismatched enum value fails', () {
      expect(
          () => Order.fromJson({'category': 'weird'}),
          _throwsArgumentError('`weird` is not one of the supported values: '
              'top, bottom, strange, charmed, up, down, not_discovered_yet'));
    });

    test('platform', () {
      final order = Order.custom(Category.charmed)
        ..statusCode = StatusCode.success
        ..platform = Platform.undefined
        ..altPlatforms = {
          'u': Platform.undefined,
          'f': Platform.foo,
        };

      roundTripOrder(order);
    });

    test('homepage', () {
      final order = Order.custom(Category.charmed)
        ..platform = Platform.undefined
        ..statusCode = StatusCode.success
        ..altPlatforms = {
          'u': Platform.undefined,
          'f': Platform.foo,
        }
        ..homepage = Uri.parse('https://dart.dev');

      roundTripOrder(order);
    });

    test('statusCode', () {
      final order = Order.fromJson(
        {'category': 'not_discovered_yet', 'status_code': 404},
      );
      expect(order.statusCode, StatusCode.notFound);
      roundTripOrder(order);
    });

    test('statusCode "500" - weird', () {
      final order = Order.fromJson(
        {'category': 'not_discovered_yet', 'status_code': '500'},
      );
      expect(order.statusCode, StatusCode.weird);
      roundTripOrder(order);
    });

    test('statusCode `500` - unknown', () {
      final order = Order.fromJson(
        {'category': 'not_discovered_yet', 'status_code': 500},
      );
      expect(order.statusCode, StatusCode.unknown);
      roundTripOrder(order);
    });

    test('duration toJson', () {
      final order = Order.custom(Category.notDiscoveredYet)
        ..statusCode = StatusCode.success
        ..duration = const Duration(
          days: 2,
          hours: 4,
          minutes: 54,
          seconds: 33,
          milliseconds: 23,
          microseconds: 12,
        );
      expect(order.toJson()['duration'], equals(190473023012));
      roundTripOrder(order);
    });

    test('duration fromJson', () {
      final order = Order.fromJson({
        'category': 'not_discovered_yet',
        'duration': 190473023012,
      });
      expect(
          order.duration,
          equals(const Duration(
            days: 2,
            hours: 4,
            minutes: 54,
            seconds: 33,
            milliseconds: 23,
            microseconds: 12,
          )));
      roundTripOrder(order);
    });
  });

  group('Item', () {
    void roundTripItem(Item p) {
      roundTripObject(p, Item.fromJson);
    }

    test('empty json', () {
      final item = Item.fromJson({});
      expect(item.saleDates, isNull);
      roundTripItem(item);

      expect(
        item.toJson().keys,
        orderedEquals([
          'price',
          'saleDates',
          'rates',
          'geoPoint',
        ]),
        reason: 'Omits null `itemNumber`',
      );
    });

    test('set itemNumber - with custom JSON key', () {
      final item = Item.fromJson({'item-number': 42});
      expect(item.itemNumber, 42);
      roundTripItem(item);

      expect(
        item.toJson().keys,
        orderedEquals([
          'price',
          'item-number',
          'saleDates',
          'rates',
          'geoPoint',
        ]),
        reason: 'Includes non-null `itemNumber` - with custom key',
      );
    });
  });

  group('Numbers', () {
    void roundTripNumber(Numbers p) {
      roundTripObject(p, Numbers.fromJson);
    }

    test('simple', () {
      roundTripNumber(Numbers()
        ..nums = [0, 0.0]
        ..doubles = [0.0]
        ..nnDoubles = [0.0]
        ..ints = [0]
        ..duration = const Duration(seconds: 1)
        ..date = DateTime.now());
    });

    test('custom DateTime', () {
      final instance = Numbers()
        ..date = DateTime.fromMillisecondsSinceEpoch(42);
      final json = instance.toJson();
      expect(json, containsPair('date', 42000));
    });

    test('support ints as doubles', () {
      final value = {
        'doubles': [0, 0.0],
        'nnDoubles': [0, 0.0]
      };

      roundTripNumber(Numbers.fromJson(value));
    });

    test('does not support doubles as ints', () {
      final value = {
        'ints': [3.14, 0],
      };

      expect(() => Numbers.fromJson(value), throwsTypeError);
    });
  });

  test('MapKeyVariety', () {
    final instance = MapKeyVariety()
      ..bigIntMap = {BigInt.from(1): 1}
      ..dateTimeIntMap = {DateTime.parse('2018-01-01'): 2}
      ..intIntMap = {3: 3}
      ..uriIntMap = {Uri.parse('https://example.com'): 4};

    roundTripObject(instance, MapKeyVariety.fromJson);
  });

  test('UnknownEnumValue', () {
    final instance = UnknownEnumValue.fromJson({
      'enumValue': 'nope',
      'enumIterable': ['nope'],
      'enumList': ['nope'],
      'enumSet': ['nope'],
    });

    expect(instance.enumValue, Category.notDiscoveredYet);
    expect(instance.enumIterable, [Category.notDiscoveredYet]);
    expect(instance.enumList, [Category.notDiscoveredYet]);
    expect(instance.enumSet, [Category.notDiscoveredYet]);
  });

  test('PrivateConstructor', () {
    final value = PrivateConstructor('test');

    roundTripObject(value, PrivateConstructor.fromJson);
  });

  test('enum helpers', () {
    expect(standAloneEnumValues, ['a', 'b', 'g', 'd']);
    expect(dayTypeEnumValues, ['no-good', 'rotten', 'very-bad']);
  });

  test(
      'serializing a non-nullable enum as a key in a map should produce a '
      'non-nullable string key', () {
    final cls =
        Issue1145RegressionA(status: {Issue1145RegressionEnum.gamma: true});
    // Due to issue 1145 this resulted in Map<String?, dynamic>
    expect(cls.toJson()['status'], const TypeMatcher<Map<String, dynamic>>());
  });

  test(
      'serializing a nullable enum in a list should produce a list with'
      ' nullable entries', () {
    final cls = Issue1145RegressionB(status: [Issue1145RegressionEnum.gamma]);
    // Issue 1145 should not have affected nullable enums
    expect(cls.toJson()['status'], const TypeMatcher<List<String?>>());
  });

  test('unknown as null for enum', () {
    expect(
      () => Issue559Regression.fromJson({}).status,
      throwsA(isA<MissingRequiredKeysException>()),
    );
    expect(
      () => Issue559Regression.fromJson({'status': null}).status,
      throwsA(isA<DisallowedNullValueException>()),
    );
    expect(
      Issue559Regression.fromJson({'status': 'gamma'}).status,
      Issue559RegressionEnum.gamma,
    );
    expect(
      Issue559Regression.fromJson({'status': 'bob'}).status,
      isNull,
    );
  });

  test(r'_$ModelFieldMap', () {
    expect(
      modelFieldMap,
      {
        'firstName': 'first-name',
        'lastName': 'LAST_NAME',
      },
    );
  });

  test(r'Generates _$PrivateModelFieldMap instead of __$PrivateModelFieldMap',
      () {
    expect(
      privateModelFieldMap,
      {'fullName': 'full-name'},
    );
  });
}
