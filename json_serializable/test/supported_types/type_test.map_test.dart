// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.12

// ignore_for_file: prefer_const_declarations

import 'dart:convert';

@TestOn('vm')
import 'package:test/test.dart';

import '../test_utils.dart';
import 'input.type_map.dart';

void main() {
  group('non-nullable', () {
    test('round trip', () {
      final object = SimpleClass.fromJson(_defaultInput);
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_defaultOutput));

      final object2 = SimpleClass.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });

    test('round trip null', () {
      expect(
        () => loudEncode(SimpleClass.fromJson({})),
        throwsA(isA<TypeError>()),
      );
    });

    test('round trip alternate values', () {
      final object = SimpleClass.fromJson(_nonDefaultJson);
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_nonDefaultJson));
      expect(encoded, isNot(loudEncode(_defaultOutput)));

      final object2 = SimpleClass.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });
  }); // end non-nullable group

  group('nullable', () {
    test('round trip', () {
      final object = SimpleClassNullable.fromJson(_defaultInput);
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_defaultOutput));

      final object2 = SimpleClassNullable.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });

    test('round trip null', () {
      final object = SimpleClassNullable.fromJson({});
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_nullableDefaultOutput));
      final object2 = SimpleClassNullable.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });

    test('round trip alternate values', () {
      final object = SimpleClassNullable.fromJson(_nonDefaultJson);
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_nonDefaultJson));
      expect(encoded, isNot(loudEncode(_defaultOutput)));

      final object2 = SimpleClassNullable.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });
  }); // end nullable group
  // BigInt,BigInt
  // DateTime,BigInt
  // dynamic,BigInt
  // EnumType,BigInt
  // int,BigInt
  // Object,BigInt
  // String,BigInt
  // Uri,BigInt
  // BigInt,BigInt?
  // DateTime,BigInt?
  // dynamic,BigInt?
  // EnumType,BigInt?
  // int,BigInt?
  // Object,BigInt?
  // String,BigInt?
  // Uri,BigInt?
  // BigInt,bool
  // DateTime,bool
  // dynamic,bool
  // EnumType,bool
  // int,bool
  // Object,bool
  // String,bool
  // Uri,bool
  // BigInt,bool?
  // DateTime,bool?
  // dynamic,bool?
  // EnumType,bool?
  // int,bool?
  // Object,bool?
  // String,bool?
  // Uri,bool?
  // BigInt,DateTime
  // DateTime,DateTime
  // dynamic,DateTime
  // EnumType,DateTime
  // int,DateTime
  // Object,DateTime
  // String,DateTime
  // Uri,DateTime
  // BigInt,DateTime?
  // DateTime,DateTime?
  // dynamic,DateTime?
  // EnumType,DateTime?
  // int,DateTime?
  // Object,DateTime?
  // String,DateTime?
  // Uri,DateTime?
  // BigInt,double
  // DateTime,double
  // dynamic,double
  // EnumType,double
  // int,double
  // Object,double
  // String,double
  // Uri,double
  // BigInt,double?
  // DateTime,double?
  // dynamic,double?
  // EnumType,double?
  // int,double?
  // Object,double?
  // String,double?
  // Uri,double?
  // BigInt,Duration
  // DateTime,Duration
  // dynamic,Duration
  // EnumType,Duration
  // int,Duration
  // Object,Duration
  // String,Duration
  // Uri,Duration
  // BigInt,Duration?
  // DateTime,Duration?
  // dynamic,Duration?
  // EnumType,Duration?
  // int,Duration?
  // Object,Duration?
  // String,Duration?
  // Uri,Duration?
  // BigInt,dynamic
  // DateTime,dynamic
  // dynamic,dynamic
  // EnumType,dynamic
  // int,dynamic
  // Object,dynamic
  // String,dynamic
  // Uri,dynamic
  // BigInt,EnumType
  // DateTime,EnumType
  // dynamic,EnumType
  // EnumType,EnumType
  // int,EnumType
  // Object,EnumType
  // String,EnumType
  // Uri,EnumType
  // BigInt,EnumType?
  // DateTime,EnumType?
  // dynamic,EnumType?
  // EnumType,EnumType?
  // int,EnumType?
  // Object,EnumType?
  // String,EnumType?
  // Uri,EnumType?
  // BigInt,int
  // DateTime,int
  // dynamic,int
  // EnumType,int
  // int,int
  // Object,int
  // String,int
  // Uri,int
  // BigInt,int?
  // DateTime,int?
  // dynamic,int?
  // EnumType,int?
  // int,int?
  // Object,int?
  // String,int?
  // Uri,int?
  // BigInt,num
  // DateTime,num
  // dynamic,num
  // EnumType,num
  // int,num
  // Object,num
  // String,num
  // Uri,num
  // BigInt,num?
  // DateTime,num?
  // dynamic,num?
  // EnumType,num?
  // int,num?
  // Object,num?
  // String,num?
  // Uri,num?
  // BigInt,Object
  // DateTime,Object
  // dynamic,Object
  // EnumType,Object
  // int,Object
  // Object,Object
  // String,Object
  // Uri,Object
  // BigInt,Object?
  // DateTime,Object?
  // dynamic,Object?
  // EnumType,Object?
  // int,Object?
  // Object,Object?
  // String,Object?
  // Uri,Object?
  // BigInt,String
  // DateTime,String
  // dynamic,String
  // EnumType,String
  // int,String
  // Object,String
  // String,String
  // Uri,String
  // BigInt,String?
  // DateTime,String?
  // dynamic,String?
  // EnumType,String?
  // int,String?
  // Object,String?
  // String,String?
  // Uri,String?
  // BigInt,Uri
  // DateTime,Uri
  // dynamic,Uri
  // EnumType,Uri
  // int,Uri
  // Object,Uri
  // String,Uri
  // Uri,Uri
  // BigInt,Uri?
  // DateTime,Uri?
  // dynamic,Uri?
  // EnumType,Uri?
  // int,Uri?
  // Object,Uri?
  // String,Uri?
  // Uri,Uri?
}

final _defaultValue = {'a': 1};
final _altValue = {'b': 2};

final _defaultInput = <String, Object?>{
  'value': _defaultValue,
};

final _defaultOutput = {
  'value': _defaultValue,
  'withDefault': _defaultValue,
};

final _nullableDefaultOutput = {
  'value': null,
  'withDefault': _defaultValue,
};

final _nonDefaultJson = {
  'value': _altValue,
  'withDefault': _altValue,
};
