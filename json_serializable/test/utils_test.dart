// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'package:json_serializable/src/utils.dart';
import 'package:test/test.dart';

const _kebabItems = {
  'simple': 'simple',
  'twoWords': 'two-words',
  'FirstBig': 'first-big'
};

const _pascalItems = {
  'simple': 'Simple',
  'twoWords': 'TwoWords',
  'FirstBig': 'FirstBig'
};

const _snakeItems = {
  'simple': 'simple',
  'twoWords': 'two_words',
  'FirstBig': 'first_big'
};

void main() {
  group('kebab', () {
    for (final entry in _kebabItems.entries) {
      test('"${entry.key}"', () {
        expect(kebabCase(entry.key), entry.value);
      });
    }
  });

  group('pascal', () {
    for (final entry in _pascalItems.entries) {
      test('"${entry.key}"', () {
        expect(pascalCase(entry.key), entry.value);
      });
    }
  });

  group('snake', () {
    for (final entry in _snakeItems.entries) {
      test('"${entry.key}"', () {
        expect(snakeCase(entry.key), entry.value);
      });
    }
  });

  group('nonPrivateName', () {
    test('removes leading underscores', () {
      final name = nonPrivateName('__hello__world__');
      expect(name, equals('hello__world__'));
    });
    test('does not changes public names', () {
      final name = nonPrivateName('HelloWorld');
      expect(name, equals('HelloWorld'));
    });
  });
}
