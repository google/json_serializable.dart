// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

@TestOn('browser || node || js || wasm')
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:test/test.dart';

import 'fixtures/models.dart';
import 'fixtures/models.js_codable.dart';

@JS('JSON.parse')
external JSAny? _jsonParse(String source);

@JS('JSON.stringify')
external String _jsonStringify(JSAny? value);

void main() {
  group('JS & Wasm runtime round-trip (.toJs() <-> .toDart())', () {
    test('UserProfile .toJs() populates exact JS wire properties and '
        '.toDart() round-trips on dart2js & dart2wasm', () {
      final original = UserProfile(
        customId: const CustomId('usr-9000'),
        firstName: 'Ada',
        loginCount: 7,
        rating: 4.75,
        score: 99.5,
        isActive: true,
        nickname: 'Lovelace',
        optionalCount: 12,
        tier: 'enterprise',
        customNamedField: 'custom-wire-val',
        kebabKey: 'kebab-wire-val',
        dotKey: 'dot-wire-val',
        createdAt: DateTime.utc(2026, 10, 18, 2),
        lastLogin: DateTime.utc(2026, 10, 18, 3, 30),
        homepage: Uri.parse('https://dart.dev/interop'),
        avatarUri: Uri.parse('https://dart.dev/logo.png'),
        quotaBytes: BigInt.parse('9007199254740993'),
        sessionDuration: const Duration(minutes: 5, seconds: 30),
        idleTimeout: const Duration(seconds: 45),
        primaryRole: Role.admin,
        secondaryRole: Role.member,
        priority: Priority.high,
        primaryChild: const Child(id: 'c-primary', count: 10, label: 'Primary'),
        optionalChild: const Child(id: 'c-opt', count: 20),
        tags: const ['dart', 'wasm', 'js'],
        luckyNumbers: const [7, 42, 256],
        permissions: const {'read', 'write', 'execute'},
        children: const [
          Child(id: 'c1', count: 1, label: 'One'),
          Child(id: 'c2', count: 2),
        ],
        counters: const {'clicks': 100, 'views': 2500, 'zero': 0},
        childByKey: const {
          'alpha': Child(id: 'a', count: 11, label: 'A'),
          'beta': Child(id: 'b', count: 22),
        },
        epochTimestamp: DateTime.fromMillisecondsSinceEpoch(
          1760000000000,
          isUtc: true,
        ),
        metadata: const MetadataBag({'env': 'prod', 'flag': true}),
      );

      final js = original.toJs();
      final rawObj = js as JSObject;

      // Verify actual JS object wire properties directly in the JS runtime.
      expect(
        rawObj.getProperty<JSString>('custom_id'.toJS).toDart,
        'id:usr-9000',
      );
      expect(rawObj.getProperty<JSString>('first_name'.toJS).toDart, 'Ada');
      expect(rawObj.getProperty<JSNumber>('login_count'.toJS).toDartInt, 7);
      expect(rawObj.getProperty<JSNumber>('rating'.toJS).toDartDouble, 4.75);
      expect(rawObj.getProperty<JSBoolean>('is_active'.toJS).toDart, isTrue);
      expect(
        rawObj.getProperty<JSString>('custom_name'.toJS).toDart,
        'custom-wire-val',
      );
      expect(
        rawObj.getProperty<JSString>('kebab-key'.toJS).toDart,
        'kebab-wire-val',
      );
      expect(
        rawObj.getProperty<JSString>('dot.key'.toJS).toDart,
        'dot-wire-val',
      );
      expect(
        rawObj.getProperty<JSString>('created_at'.toJS).toDart,
        '2026-10-18T02:00:00.000Z',
      );
      expect(
        rawObj.getProperty<JSString>('quota_bytes'.toJS).toDart,
        '9007199254740993',
      );
      expect(
        rawObj.getProperty<JSNumber>('session_duration'.toJS).toDartInt,
        const Duration(minutes: 5, seconds: 30).inMicroseconds,
      );
      expect(rawObj.getProperty<JSString>('primary_role'.toJS).toDart, 'admin');
      expect(rawObj.getProperty<JSNumber>('priority'.toJS).toDartInt, 3);

      final primaryChildJs = rawObj.getProperty<JSObject>('primary_child'.toJS);
      expect(
        primaryChildJs.getProperty<JSString>('id'.toJS).toDart,
        'c-primary',
      );
      expect(primaryChildJs.getProperty<JSNumber>('count'.toJS).toDartInt, 10);

      final countersJs = rawObj.getProperty<JSObject>('counters'.toJS);
      expect(countersJs.getProperty<JSNumber>('views'.toJS).toDartInt, 2500);

      final childByKeyJs = rawObj.getProperty<JSObject>('child_by_key'.toJS);
      final alphaJs = childByKeyJs.getProperty<JSObject>('alpha'.toJS);
      expect(alphaJs.getProperty<JSNumber>('count'.toJS).toDartInt, 11);

      // Verify JSON.stringify includes renamed and non-identifier keys.
      final jsonStr = _jsonStringify(js);
      expect(jsonStr, contains('"first_name":"Ada"'));
      expect(jsonStr, contains('"kebab-key":"kebab-wire-val"'));
      expect(jsonStr, contains('"dot.key":"dot-wire-val"'));

      // Round-trip back to Dart PODO.
      final decoded = js.toDart();
      expect(decoded, equals(original));

      // Verify UserProfileJS.fromDart factory produces identical round-trip.
      expect(UserProfileJS.fromDart(original).toDart(), equals(original));

      // Explicitly check int runtime types (catching any Wasm double
      // corruption).
      expect(decoded.loginCount, isA<int>());
      expect(decoded.optionalCount, isA<int>());
      expect(decoded.luckyNumbers, everyElement(isA<int>()));
      expect(decoded.counters.values, everyElement(isA<int>()));
      expect(decoded.childByKey['alpha']!.count, isA<int>());
    });

    test('UserProfile with null optional fields round-trips cleanly', () {
      final original = UserProfile(
        customId: const CustomId('null-test'),
        firstName: 'Grace',
        rating: 5.0,
        score: 100,
        isActive: false,
        customNamedField: 'c',
        kebabKey: 'k',
        createdAt: DateTime.utc(2026),
        homepage: Uri.parse('https://example.com'),
        quotaBytes: BigInt.from(1024),
        sessionDuration: const Duration(seconds: 10),
        primaryRole: Role.guest,
        primaryChild: const Child(id: 'root', count: 0),
        tags: const [],
        luckyNumbers: const [],
        permissions: const {},
        children: const [],
        counters: const {},
        childByKey: const {},
        epochTimestamp: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
        metadata: const MetadataBag({}),
      );

      final js = original.toJs();
      final decoded = js.toDart();
      expect(decoded, equals(original));
      expect(decoded.nickname, isNull);
      expect(decoded.optionalCount, isNull);
      expect(decoded.dotKey, isNull);
      expect(decoded.lastLogin, isNull);
      expect(decoded.avatarUri, isNull);
      expect(decoded.idleTimeout, isNull);
      expect(decoded.secondaryRole, isNull);
      expect(decoded.optionalChild, isNull);
    });

    test('DerivedEntity (InheritanceManager3 overridden getter @JsonKey) '
        'round-trips', () {
      const derived = DerivedEntity(
        id: 'ent-42',
        baseScore: 77,
        title: 'Inherited Model',
        version: 3,
      );

      final js = derived.toJs();
      final rawObj = js as JSObject;
      expect(rawObj.getProperty<JSString>('entity_id'.toJS).toDart, 'ent-42');
      expect(rawObj.getProperty<JSNumber>('base_score'.toJS).toDartInt, 77);
      expect(
        rawObj.getProperty<JSString>('title'.toJS).toDart,
        'Inherited Model',
      );
      expect(rawObj.getProperty<JSNumber>('version'.toJS).toDartInt, 3);

      expect(js.toDart(), equals(derived));
    });
  });

  group('Raw JSON.parse(...) -> ExtensionType.toDart() decoding', () {
    test('decodes raw JS object from JSON.parse with omitted defaults, '
        'nullables, and nested collections', () {
      const rawJson = '''
{
  "custom_id": "id:from-json-1",
  "first_name": "Alan",
  "rating": 4.5,
  "score": 88,
  "is_active": true,
  "custom_name": "custom-from-json",
  "kebab-key": "kebab-from-json",
  "dot.key": "dot-from-json",
  "created_at": "2026-05-01T12:00:00.000Z",
  "homepage": "https://dart.dev",
  "quota_bytes": "18446744073709551615",
  "session_duration": 60000000,
  "primary_role": "member",
  "primary_child": {
    "id": "p1",
    "count": 5
  },
  "tags": ["a", "b"],
  "lucky_numbers": [10, 20, 30],
  "permissions": ["admin", "admin", "read"],
  "children": [
    {"id": "ch1", "count": 99, "label": "Ninety-Nine"}
  ],
  "counters": {
    "hits": 42,
    "misses": 0
  },
  "child_by_key": {
    "first": {"id": "f1", "count": 7, "label": "First"}
  },
  "epoch_timestamp": 1700000000000,
  "metadata": {
    "source": "json_parse",
    "ok": true
  }
}
''';

      final userJs = _jsonParse(rawJson) as UserProfileJS;
      final decoded = userJs.toDart();

      expect(decoded.customId, const CustomId('from-json-1'));
      expect(decoded.firstName, 'Alan');
      // Omitted properties in JS (`undefined`) must trigger default values:
      expect(decoded.loginCount, 0);
      expect(decoded.tier, 'standard');
      expect(decoded.priority, Priority.medium);

      // Omitted nullable properties must decode to null:
      expect(decoded.nickname, isNull);
      expect(decoded.optionalCount, isNull);
      expect(decoded.lastLogin, isNull);
      expect(decoded.avatarUri, isNull);
      expect(decoded.idleTimeout, isNull);
      expect(decoded.secondaryRole, isNull);
      expect(decoded.optionalChild, isNull);

      // Non-identifier and dot keys:
      expect(decoded.customNamedField, 'custom-from-json');
      expect(decoded.kebabKey, 'kebab-from-json');
      expect(decoded.dotKey, 'dot-from-json');

      // Core types & BigInt:
      expect(decoded.createdAt, DateTime.utc(2026, 5, 1, 12));
      expect(decoded.homepage, Uri.parse('https://dart.dev'));
      expect(decoded.quotaBytes, BigInt.parse('18446744073709551615'));
      expect(decoded.sessionDuration, const Duration(minutes: 1));
      expect(decoded.primaryRole, Role.member);

      // Nested models, Lists, Sets, and Maps:
      expect(decoded.primaryChild, const Child(id: 'p1', count: 5));
      expect(decoded.tags, ['a', 'b']);
      expect(decoded.luckyNumbers, [10, 20, 30]);
      expect(decoded.luckyNumbers, everyElement(isA<int>()));
      expect(decoded.permissions, {'admin', 'read'});
      expect(decoded.children, [
        const Child(id: 'ch1', count: 99, label: 'Ninety-Nine'),
      ]);
      expect(decoded.counters, {'hits': 42, 'misses': 0});
      expect(decoded.counters['hits'], isA<int>());
      expect(decoded.childByKey, {
        'first': const Child(id: 'f1', count: 7, label: 'First'),
      });
      expect(
        decoded.epochTimestamp,
        DateTime.fromMillisecondsSinceEpoch(1700000000000, isUtc: true),
      );
      expect(
        decoded.metadata,
        const MetadataBag({'source': 'json_parse', 'ok': true}),
      );
    });

    test('DerivedEntityJS decodes raw JSON.parse with inherited constructor '
        'defaults', () {
      const rawJson = '{"entity_id": "e-100", "title": "From Raw JSON"}';
      final derivedJs = _jsonParse(rawJson) as DerivedEntityJS;
      final decoded = derivedJs.toDart();

      expect(decoded, const DerivedEntity(id: 'e-100', title: 'From Raw JSON'));
    });
  });
}
