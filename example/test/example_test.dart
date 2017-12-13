// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:convert';

import 'package:example/example.dart';
import 'package:test/test.dart';

void main() {
  test('JsonSerializable', () {
    final person = new Person('Inigo', 'Montoya', new DateTime(1560, 5, 5));

    final prettyJson = const JsonEncoder.withIndent(' ').convert(person);
    print(prettyJson);

    final person2 =
        new Person.fromJson(JSON.decode(prettyJson) as Map<String, dynamic>);

    expect(person.firstName, person2.firstName);
    expect(person.lastName, person2.lastName);
    expect(person.dateOfBirth, person2.dateOfBirth);
  });

  test('JsonLiteral', () {
    expect(glossaryData, hasLength(1));
  });
}
