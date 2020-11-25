// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:example/nested_fields.dart';
import 'package:test/test.dart';

void main() {

  group('test nested json fields', (){
    test('JsonSerializable', () {
      final nestedFields = NestedFields('Rebaz', 'Raouf', 26, 'Raouf', 'Mhedin', 4, locationName: 'Iraq');

      final nestedJson = _encode(nestedFields);

      final decodedExample = NestedFields.fromJson(json.decode(nestedJson) as Map<String, dynamic>);

      expect(nestedFields.firstName, decodedExample.firstName);
      expect(nestedFields.lastName, decodedExample.lastName);
      expect(nestedFields.age, decodedExample.age);
      expect(nestedFields.familyFirstName, decodedExample.familyFirstName);
      expect(nestedFields.familyLastName, decodedExample.familyLastName);
      expect(nestedFields.locationName, decodedExample.locationName);
      expect(nestedFields.travelTime, decodedExample.travelTime);

      expect(_encode(decodedExample), equals(nestedJson));
    });

    test('JsonSerializable', () {
      final nestedInfo = NestedInfoWithChecked<String>('Rebaz', 'Raouf', 26, 4, nestedGenericField: 'test', normalGeneric: 'normal');

      final nestedJson = _encode(nestedInfo);

      final decodedExample = NestedInfoWithChecked<String>.fromJson(json.decode(nestedJson) as Map<String, dynamic>);

      expect(nestedInfo.firstName, decodedExample.firstName);
      expect(nestedInfo.lastName, decodedExample.lastName);
      expect(nestedInfo.age, decodedExample.age);
      expect(nestedInfo.travelTime, decodedExample.travelTime);
      expect(nestedInfo.nestedGenericField, decodedExample.nestedGenericField);
      expect(nestedInfo.normalGeneric, decodedExample.normalGeneric);

      expect(_encode(decodedExample), equals(nestedJson));
    });
  });
}

String _encode(Object object) => const JsonEncoder.withIndent(' ').convert(object);
