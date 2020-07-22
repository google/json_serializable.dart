// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: prefer_const_declarations

@TestOn('vm')
import 'package:test/test.dart';

import '../test_utils.dart';
import 'input.type_map.dart';

void main() {
  group('SimpleClass', () {
    final _defaultValue = {'a': 1};
    final _altValue = {'b': 2};

    final _emptyInput = <String, dynamic>{
      'nullable': _defaultValue,
    };

    final _defaultOutput = {
      'value': null,
      'nullable': _defaultValue,
      'withDefault': _defaultValue,
    };

    final _nonDefaultJson = {
      'value': null,
      'nullable': _altValue,
      'withDefault': _altValue,
    };

    test('round trip', () {
      final object = SimpleClass.fromJson(_emptyInput);
      expect(loudEncode(object), loudEncode(_defaultOutput));
    });

    test('round trip alternate values', () {
      final object = SimpleClass.fromJson(_nonDefaultJson);
      expect(loudEncode(object), loudEncode(_nonDefaultJson));
      expect(loudEncode(object), isNot(loudEncode(_defaultOutput)));
    });
  });

  group('<BigInt,BigInt>', () {});
  group('<BigInt,bool>', () {});
  group('<BigInt,DateTime>', () {});
  group('<BigInt,double>', () {});
  group('<BigInt,Duration>', () {});
  group('<BigInt,dynamic>', () {});
  group('<BigInt,EnumType>', () {});
  group('<BigInt,num>', () {});
  group('<BigInt,Object>', () {});
  group('<BigInt,String>', () {});
  group('<BigInt,Uri>', () {});
  group('<DateTime,BigInt>', () {});
  group('<DateTime,bool>', () {});
  group('<DateTime,DateTime>', () {});
  group('<DateTime,double>', () {});
  group('<DateTime,Duration>', () {});
  group('<DateTime,dynamic>', () {});
  group('<DateTime,EnumType>', () {});
  group('<DateTime,num>', () {});
  group('<DateTime,Object>', () {});
  group('<DateTime,String>', () {});
  group('<DateTime,Uri>', () {});
  group('<dynamic,BigInt>', () {});
  group('<dynamic,bool>', () {});
  group('<dynamic,DateTime>', () {});
  group('<dynamic,double>', () {});
  group('<dynamic,Duration>', () {});
  group('<dynamic,dynamic>', () {});
  group('<dynamic,EnumType>', () {});
  group('<dynamic,num>', () {});
  group('<dynamic,Object>', () {});
  group('<dynamic,String>', () {});
  group('<dynamic,Uri>', () {});
  group('<EnumType,BigInt>', () {});
  group('<EnumType,bool>', () {});
  group('<EnumType,DateTime>', () {});
  group('<EnumType,double>', () {});
  group('<EnumType,Duration>', () {});
  group('<EnumType,dynamic>', () {});
  group('<EnumType,EnumType>', () {});
  group('<EnumType,num>', () {});
  group('<EnumType,Object>', () {});
  group('<EnumType,String>', () {});
  group('<EnumType,Uri>', () {});
  group('<int,BigInt>', () {});
  group('<int,bool>', () {});
  group('<int,DateTime>', () {});
  group('<int,double>', () {});
  group('<int,Duration>', () {});
  group('<int,dynamic>', () {});
  group('<int,EnumType>', () {});
  group('<int,num>', () {});
  group('<int,Object>', () {});
  group('<int,String>', () {});
  group('<int,Uri>', () {});
  group('<Object,BigInt>', () {});
  group('<Object,bool>', () {});
  group('<Object,DateTime>', () {});
  group('<Object,double>', () {});
  group('<Object,Duration>', () {});
  group('<Object,dynamic>', () {});
  group('<Object,EnumType>', () {});
  group('<Object,num>', () {});
  group('<Object,Object>', () {});
  group('<Object,String>', () {});
  group('<Object,Uri>', () {});
  group('<String,BigInt>', () {});
  group('<String,bool>', () {});
  group('<String,DateTime>', () {});
  group('<String,double>', () {});
  group('<String,Duration>', () {});
  group('<String,dynamic>', () {});
  group('<String,EnumType>', () {});
  group('<String,num>', () {});
  group('<String,Object>', () {});
  group('<String,String>', () {});
  group('<String,Uri>', () {});
  group('<Uri,BigInt>', () {});
  group('<Uri,bool>', () {});
  group('<Uri,DateTime>', () {});
  group('<Uri,double>', () {});
  group('<Uri,Duration>', () {});
  group('<Uri,dynamic>', () {});
  group('<Uri,EnumType>', () {});
  group('<Uri,num>', () {});
  group('<Uri,Object>', () {});
  group('<Uri,String>', () {});
  group('<Uri,Uri>', () {});
}
