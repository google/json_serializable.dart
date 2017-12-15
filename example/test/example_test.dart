// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:example/example.dart';
import 'package:test/test.dart';

void main() {
  test('JsonSerializable', () {
    final person = new Person('Inigo', 'Montoya', new DateTime(1560, 5, 5));

    final personJson = _encode(person);

    final person2 =
        new Person.fromJson(JSON.decode(personJson) as Map<String, dynamic>);

    expect(person.firstName, person2.firstName);
    expect(person.lastName, person2.lastName);
    expect(person.dateOfBirth, person2.dateOfBirth);

    expect(_encode(person2), equals(personJson));
  });

  test('JsonLiteral', () {
    expect(glossaryData, hasLength(1));
  });
}

String _encode(Object object) =>
    const JsonEncoder.withIndent(' ').convert(object);
