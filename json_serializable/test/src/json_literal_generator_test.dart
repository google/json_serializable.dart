// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'package:json_serializable/src/json_literal_generator.dart';
import 'package:test/test.dart';

void main() {
  test('jsonLiteralAsDart', () {
    expect(jsonLiteralAsDart(null), 'null');
    expect(jsonLiteralAsDart(true), 'true');
    expect(jsonLiteralAsDart(false), 'false');
    expect(jsonLiteralAsDart(42), '42');
    expect(jsonLiteralAsDart(42.5), '42.5');
    expect(jsonLiteralAsDart(double.infinity), 'double.infinity');
    expect(
      jsonLiteralAsDart(double.negativeInfinity),
      'double.negativeInfinity',
    );
    expect(jsonLiteralAsDart(double.nan), 'double.nan');
    expect(jsonLiteralAsDart('foo'), "'foo'");
    expect(jsonLiteralAsDart('foo"bar'), "'foo\"bar'");

    expect(jsonLiteralAsDart([1, 2]), '[1, 2]');
    expect(jsonLiteralAsDart({1, 2}), '{1, 2}');
    expect(jsonLiteralAsDart({'a': 1}), "{'a': 1}");
  });
}
