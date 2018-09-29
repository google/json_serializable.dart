// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:test/test.dart';

import '../test_utils.dart';
import 'generic_class.dart';

void main() {
  group('generic', () {
    GenericClass<T, S> roundTripGenericClass<T extends num, S>(
        GenericClass<T, S> p) {
      final outputJson = loudEncode(p);
      final p2 = GenericClass<T, S>.fromJson(
          jsonDecode(outputJson) as Map<String, dynamic>);
      final outputJson2 = loudEncode(p2);
      expect(outputJson2, outputJson);
      return p2;
    }

    test('no type args', () {
      roundTripGenericClass(GenericClass()
        ..fieldDynamic = 1
        ..fieldInt = 2
        ..fieldObject = 3
        ..fieldT = 5
        ..fieldS = 'six');
    });
    test('with type arguments', () {
      roundTripGenericClass(GenericClass<double, String>()
        ..fieldDynamic = 1
        ..fieldInt = 2
        ..fieldObject = 3
        ..fieldT = 5.0
        ..fieldS = 'six');
    });
    test('with bad arguments', () {
      expect(
          () => GenericClass<double, String>()
            ..fieldT = (true as dynamic) as double,
          throwsCastError);
    });
    test('with bad arguments', () {
      expect(
          () =>
              GenericClass<double, String>()..fieldS = (5 as dynamic) as String,
          throwsCastError);
    });
  });
}
