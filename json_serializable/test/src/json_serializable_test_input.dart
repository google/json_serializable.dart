// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
const theAnswer = 42;

@JsonSerializable()
void annotatedMethod() => null;

@JsonSerializable()
class Person {
  String firstName, lastName;
  @JsonKey(name: 'h')
  int height;
  DateTime dateOfBirth;
  dynamic dynamicType;
  var varType;
  List<int> listOfInts;
}

@JsonSerializable()
class Order {
  final String firstName, lastName;
  int height;
  DateTime dateOfBirth;

  Order(this.height, String firstName, [this.lastName])
      : this.firstName = firstName;
}

@JsonSerializable()
class FinalFields {
  final int a;
  int get b => 4;

  FinalFields(this.a);
}

@JsonSerializable()
class FromJsonOptionalParameters {
  final ChildWithFromJson child;

  FromJsonOptionalParameters(this.child);
}

class ChildWithFromJson {
  ChildWithFromJson.fromJson(json, {initValue: false});
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

  factory ChildObject.fromJson(json) => null;
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

@JsonSerializable(createFactory: false)
class KeyDupesField {
  @JsonKey(name: 'str')
  int number;

  String str;
}

@JsonSerializable(createFactory: false)
class DupeKeys {
  @JsonKey(name: 'a')
  int number;

  @JsonKey(name: 'a')
  String str;
}

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
