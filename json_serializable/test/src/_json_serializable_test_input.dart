// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

//ignore_for_file: avoid_unused_constructor_parameters, prefer_initializing_formals
import 'package:json_annotation/json_annotation.dart';

import 'annotation.dart';

part 'checked_test_input.dart';
part 'default_value_input.dart';
part 'field_namer_input.dart';
part 'generic_test_input.dart';
part 'setter_test_input.dart';
part 'to_from_json_test_input.dart';

@ShouldThrow('field', 'Generator cannot target `theAnswer`.',
    'Remove the JsonSerializable annotation from `theAnswer`.')
@JsonSerializable()
const theAnswer = 42;

@ShouldThrow('function', 'Generator cannot target `annotatedMethod`.',
    'Remove the JsonSerializable annotation from `annotatedMethod`.')
@JsonSerializable()
void annotatedMethod() => null;

@ShouldGenerate(r'''
Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..height = json['h'] as int
    ..dateOfBirth = json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String)
    ..dynamicType = json['dynamicType']
    ..varType = json['varType']
    ..listOfInts = (json['listOfInts'] as List)?.map((e) => e as int)?.toList();
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'h': instance.height,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'dynamicType': instance.dynamicType,
      'varType': instance.varType,
      'listOfInts': instance.listOfInts
    };
''')
@JsonSerializable()
class Person {
  String firstName, lastName;
  @JsonKey(name: 'h')
  int height;
  DateTime dateOfBirth;
  dynamic dynamicType;
  //ignore: prefer_typing_uninitialized_variables
  var varType;
  List<int> listOfInts;
}

@ShouldGenerate(r'''
Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(json['height'] as int, json['firstName'] as String,
      json['lastName'] as String)
    ..dateOfBirth = json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String);
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'height': instance.height,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String()
    };
''')
@JsonSerializable()
class Order {
  final String firstName, lastName;
  int height;
  DateTime dateOfBirth;

  Order(this.height, String firstName, [this.lastName])
      : this.firstName = firstName;
}

@ShouldGenerate(r'''
FinalFields _$FinalFieldsFromJson(Map<String, dynamic> json) {
  return FinalFields(json['a'] as int);
}

Map<String, dynamic> _$FinalFieldsToJson(FinalFields instance) =>
    <String, dynamic>{'a': instance.a};
''')
@JsonSerializable()
class FinalFields {
  final int a;
  int get b => 4;

  FinalFields(this.a);
}

@ShouldGenerate(r'''
FinalFieldsNotSetInCtor _$FinalFieldsNotSetInCtorFromJson(
    Map<String, dynamic> json) {
  return FinalFieldsNotSetInCtor();
}

Map<String, dynamic> _$FinalFieldsNotSetInCtorToJson(
        FinalFieldsNotSetInCtor instance) =>
    <String, dynamic>{};
''')
@JsonSerializable()
class FinalFieldsNotSetInCtor {
  final int a = 1;

  FinalFieldsNotSetInCtor();
}

@JsonSerializable(createToJson: false)
class FromJsonOptionalParameters {
  final ChildWithFromJson child;

  FromJsonOptionalParameters(this.child);
}

class ChildWithFromJson {
  ChildWithFromJson.fromJson(json, {initValue = false});
}

@JsonSerializable()
class ParentObject {
  int number;
  String str;
  ChildObject child;
}

@JsonSerializable()
class ChildObject {
  int number;
  String str;
}

@JsonSerializable()
class ParentObjectWithChildren {
  int number;
  String str;
  List<ChildObject> children;
}

@JsonSerializable()
class ParentObjectWithDynamicChildren {
  int number;
  String str;
  List<dynamic> children;
}

@JsonSerializable()
class UnknownCtorParamType {
  int number;

  // ignore: undefined_class, field_initializer_not_assignable
  UnknownCtorParamType(Bob number) : this.number = number;
}

@JsonSerializable()
class UnknownFieldType {
  // ignore: undefined_class
  Bob number;
}

@JsonSerializable(createFactory: false)
class UnknownFieldTypeToJsonOnly {
  // ignore: undefined_class
  Bob number;
}

@JsonSerializable()
class UnknownFieldTypeWithConvert {
  @JsonKey(fromJson: _everythingIs42, toJson: _everythingIs42)
  // ignore: undefined_class
  Bob number;
}

dynamic _everythingIs42(Object input) => 42;

@JsonSerializable(createFactory: false)
class NoSerializeFieldType {
  Stopwatch watch;
}

@JsonSerializable(createToJson: false)
class NoDeserializeFieldType {
  Stopwatch watch;
}

@JsonSerializable(createFactory: false)
class NoSerializeBadKey {
  Map<int, DateTime> intDateTimeMap;
}

@JsonSerializable(createToJson: false)
class NoDeserializeBadKey {
  Map<int, DateTime> intDateTimeMap;
}

@JsonSerializable(createFactory: false)
class IncludeIfNullAll {
  @JsonKey(includeIfNull: true)
  int number;
  String str;
}

@ShouldGenerate(r'''
Map<String, dynamic> _$IncludeIfNullOverrideToJson(
    IncludeIfNullOverride instance) {
  var val = <String, dynamic>{
    'number': instance.number,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('str', instance.str);
  return val;
}
''')
@JsonSerializable(createFactory: false, includeIfNull: false)
class IncludeIfNullOverride {
  @JsonKey(includeIfNull: true)
  int number;
  String str;
}

// https://github.com/dart-lang/json_serializable/issues/7 regression
@JsonSerializable()
class NoCtorClass {
  final int member;

  factory NoCtorClass.fromJson(Map<String, dynamic> json) => null;
}

@ShouldThrow(
    'fails if name duplicates existing field',
    'More than one field has the JSON key `str`.',
    'Check the `JsonKey` annotations on fields.')
@JsonSerializable(createFactory: false)
class KeyDupesField {
  @JsonKey(name: 'str')
  int number;

  String str;
}

@ShouldThrow(
    'fails if two names collide',
    'More than one field has the JSON key `a`.',
    'Check the `JsonKey` annotations on fields.')
@JsonSerializable(createFactory: false)
class DupeKeys {
  @JsonKey(name: 'a')
  int number;

  @JsonKey(name: 'a')
  String str;
}

@ShouldGenerate(r'''
Map<String, dynamic> _$IgnoredFieldClassToJson(IgnoredFieldClass instance) =>
    <String, dynamic>{
      'ignoredFalseField': instance.ignoredFalseField,
      'ignoredNullField': instance.ignoredNullField
    };
''')
@JsonSerializable(createFactory: false)
class IgnoredFieldClass {
  @JsonKey(ignore: true)
  int ignoredTrueField;

  @JsonKey(ignore: false)
  int ignoredFalseField;

  int ignoredNullField;
}

@ShouldThrow(
    'fails if ignored field is referenced by ctor',
    'Cannot populate the required constructor argument: '
    'ignoredTrueField. It is assigned to an ignored field.')
@JsonSerializable()
class IgnoredFieldCtorClass {
  @JsonKey(ignore: true)
  int ignoredTrueField;
  IgnoredFieldCtorClass(this.ignoredTrueField);
}

@ShouldThrow(
    'fails if private field is referenced by ctor',
    'Cannot populate the required constructor argument: '
    '_privateField. It is assigned to a private field.')
@JsonSerializable()
class PrivateFieldCtorClass {
  // ignore: unused_field
  int _privateField;
  PrivateFieldCtorClass(this._privateField);
}

@ShouldThrow(
    '`disallowNullvalue` and `includeIfNull` both `true`',
    'Error with `@JsonKey` on `field`. '
    'Cannot set both `disallowNullvalue` and `includeIfNull` to `true`. '
    'This leads to incompatible `toJson` and `fromJson` behavior.')
@JsonSerializable()
class IncludeIfNullDisallowNullClass {
  @JsonKey(includeIfNull: true, disallowNullValue: true)
  int field;
}

@ShouldGenerate(r'''
SubType _$SubTypeFromJson(Map<String, dynamic> json) {
  return SubType(
      json['subTypeViaCtor'] as int, json['super-type-via-ctor'] as int)
    ..superTypeReadWrite = json['superTypeReadWrite'] as int
    ..subTypeReadWrite = json['subTypeReadWrite'] as int;
}

Map<String, dynamic> _$SubTypeToJson(SubType instance) {
  var val = <String, dynamic>{
    'super-type-via-ctor': instance.superTypeViaCtor,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('superTypeReadWrite', instance.superTypeReadWrite);
  val['subTypeViaCtor'] = instance.subTypeViaCtor;
  val['subTypeReadWrite'] = instance.subTypeReadWrite;
  return val;
}
''', expectedWrappedOutput: r'''
SubType _$SubTypeFromJson(Map<String, dynamic> json) {
  return SubType(
      json['subTypeViaCtor'] as int, json['super-type-via-ctor'] as int)
    ..superTypeReadWrite = json['superTypeReadWrite'] as int
    ..subTypeReadWrite = json['subTypeReadWrite'] as int;
}

Map<String, dynamic> _$SubTypeToJson(SubType instance) =>
    _$SubTypeJsonMapWrapper(instance);

class _$SubTypeJsonMapWrapper extends $JsonMapWrapper {
  final SubType _v;
  _$SubTypeJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys sync* {
    yield 'super-type-via-ctor';
    if (_v.superTypeReadWrite != null) {
      yield 'superTypeReadWrite';
    }
    yield 'subTypeViaCtor';
    yield 'subTypeReadWrite';
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'super-type-via-ctor':
          return _v.superTypeViaCtor;
        case 'superTypeReadWrite':
          return _v.superTypeReadWrite;
        case 'subTypeViaCtor':
          return _v.subTypeViaCtor;
        case 'subTypeReadWrite':
          return _v.subTypeReadWrite;
      }
    }
    return null;
  }
}
''')
@JsonSerializable()
class SubType extends SuperType {
  final int subTypeViaCtor;
  int subTypeReadWrite;

  SubType(this.subTypeViaCtor, int superTypeViaCtor) : super(superTypeViaCtor);
}

// NOTE: `SuperType` is intentionally after `SubType` in the source file to
// validate field ordering semantics.
class SuperType {
  @JsonKey(name: 'super-type-via-ctor', nullable: false)
  final int superTypeViaCtor;

  @JsonKey(includeIfNull: false)
  int superTypeReadWrite;

  SuperType(this.superTypeViaCtor);

  /// Add a property to try to throw-off the generator
  int get priceHalf => priceFraction(2);

  /// Add a method to try to throw-off the generator
  int priceFraction(int other) =>
      superTypeViaCtor == null ? null : superTypeViaCtor ~/ other;
}

@JsonSerializable(createFactory: false)
class TrivialNestedNullable {
  TrivialNestedNullable child;
  int otherField;
}

@JsonSerializable(createFactory: false, nullable: false)
class TrivialNestedNonNullable {
  TrivialNestedNonNullable child;
  int otherField;
}

@ShouldThrow(
    'enums annotated with JsonValue must be string, int or null',
    'The `JsonValue` annotation on `BadEnum.value` does not have a value '
    'of type String, int, or null.')
@JsonSerializable()
class JsonValueWithBool {
  BadEnum field;
}

enum BadEnum {
  @JsonValue(true)
  value
}

@ShouldGenerate(r'''const _$GoodEnumEnumMap = <GoodEnum, dynamic>{
  GoodEnum.noAnnotation: 'noAnnotation',
  GoodEnum.stringAnnotation: 'string annotation',
  GoodEnum.stringAnnotationWeird: r"string annotation with $ funky 'values'",
  GoodEnum.intValue: 42,
  GoodEnum.nullValue: null
};
''', contains: true)
@JsonSerializable()
class JsonValueValid {
  GoodEnum field;
}

enum GoodEnum {
  noAnnotation,
  @JsonValue('string annotation')
  stringAnnotation,
  @JsonValue("string annotation with \$ funky 'values'")
  stringAnnotationWeird,
  @JsonValue(42)
  intValue,
  @JsonValue(null)
  nullValue
}
