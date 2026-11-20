// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

void main() {
  test('each checked converter reads from its own source map', () {
    String Function() readerFor(Map<String, dynamic> json) => $checkedCreate(
      'Example',
      json,
      (convert) =>
          () => convert('name', (value) => value as String),
    );

    final first = readerFor({'name': 'first'});
    final second = readerFor({'name': 'second'});

    expect(first(), 'first');
    expect(second(), 'second');
    expect(first(), 'first');
  });
}
