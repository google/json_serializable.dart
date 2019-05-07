// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')

import 'package:test/test.dart';

import 'package:json_serializable/src/utils.dart';

const _kebab_items = {
  'simple': 'simple',
  'twoWords': 'two-words',
  'FirstBig': 'first-big'
};

const _pascal_items = {
  'simple': 'Simple',
  'twoWords': 'TwoWords',
  'FirstBig': 'FirstBig'
};

const _snake_items = {
  'simple': 'simple',
  'twoWords': 'two_words',
  'FirstBig': 'first_big'
};

void main() {
  group('kebab', () {
    for (final entry in _kebab_items.entries) {
      test('"${entry.key}"', () {
        expect(kebabCase(entry.key), entry.value);
      });
    }
  });

  group('pascal', () {
    for (final entry in _pascal_items.entries) {
      test('"${entry.key}"', () {
        expect(pascalCase(entry.key), entry.value);
      });
    }
  });

  group('snake', () {
    for (final entry in _snake_items.entries) {
      test('"${entry.key}"', () {
        expect(snakeCase(entry.key), entry.value);
      });
    }
  });
}
