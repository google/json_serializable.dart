// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
NestedFields _$NestedFieldsFromJson(Map<String, dynamic> json) {
  return NestedFields(
    json['name']['firstName'] as String,
    json['name']['lastName'] as String,
    json['age'] as int,
    json['name']['family']['firstName'] as String,
    json['name']['family']['lastName'] as String,
    (json['location']['rating'] as num)?.toDouble(),
    locationName: json['location']['name'] as String,
    travelTime: json['location']['travelTime'] == null
        ? null
        : Duration(microseconds: json['location']['travelTime'] as int),
  );
}

Map<String, dynamic> _$NestedFieldsToJson(NestedFields instance) =>
    <String, dynamic>{
      'name': {
        'firstName': instance.firstName,
        'lastName': instance.lastName,
        'family': {
          'firstName': instance.familyFirstName,
          'lastName': instance.familyLastName,
        },
      },
      'age': instance.age,
      'location': {
        'name': instance.locationName,
        'rating': instance.rating,
        'travelTime': instance.travelTime?.inMicroseconds,
      },
    };
''')
@JsonSerializable()
class NestedFields {
  @JsonKey(name: 'name.firstName')
  final String firstName;

  @JsonKey(name: 'name.lastName')
  final String lastName;

  @JsonKey(name: 'age')
  final int age;

  @JsonKey(name: 'name.family.firstName')
  final String familyFirstName;

  @JsonKey(name: 'name.family.lastName')
  final String familyLastName;

  @JsonKey(name: 'location.name')
  final String locationName;

  @JsonKey(name: 'location.rating')
  final double rating;

  @JsonKey(name: 'location.travelTime')
  final Duration travelTime;

  NestedFields(
    this.firstName,
    this.lastName,
    this.age,
    this.familyFirstName,
    this.familyLastName,
    this.rating, {
    @required this.locationName,
    this.travelTime = const Duration(days: 1),
  });
}

@ShouldGenerate(r'''
GeneralTestClass3 _$GeneralTestClass3FromJson(Map<String, dynamic> json) {
  return GeneralTestClass3()
    ..firstName = json['name']['firstName'] as String
    ..lastName = json['name']['lastName'] as String
    ..age = json['age'] as int;
}

Map<String, dynamic> _$GeneralTestClass3ToJson(GeneralTestClass3 instance) =>
    <String, dynamic>{
      'name': {
        'firstName': instance.firstName,
        'lastName': instance.lastName,
      },
      'age': instance.age,
    };
''')
@JsonSerializable()
class GeneralTestClass3 {
  @JsonKey(name: 'name.firstName')
  String firstName;

  @JsonKey(name: 'name.lastName')
  String lastName;

  @JsonKey(name: 'age')
  int age;
}

@ShouldGenerate(r'''
NestedFieldsWithChecked<T> _$NestedFieldsWithCheckedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return $checkedNew('NestedFieldsWithChecked', json, () {
    final val = NestedFieldsWithChecked<T>(
      $checkedConvert(json, 'name.firstName', (v) => v as String),
      $checkedConvert(json, 'name.lastName', (v) => v as String),
      $checkedConvert(json, 'age', (v) => v as int),
      $checkedConvert(json, 'location.rating', (v) => (v as num)?.toDouble()),
      travelTime: $checkedConvert(json, 'location.travelTime',
          (v) => v == null ? null : Duration(microseconds: v as int)),
      nestedGenericField:
          $checkedConvert(json, 'location.genericField', (v) => fromJsonT(v)),
      normalGeneric:
          $checkedConvert(json, 'normalGeneric', (v) => fromJsonT(v)),
    );
    return val;
  }, fieldKeyMap: const {
    'firstName': 'name.firstName',
    'lastName': 'name.lastName',
    'rating': 'location.rating',
    'travelTime': 'location.travelTime',
    'nestedGenericField': 'location.genericField'
  });
}

Map<String, dynamic> _$NestedFieldsWithCheckedToJson<T>(
  NestedFieldsWithChecked<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'name': {
        'firstName': instance.firstName,
        'lastName': instance.lastName,
      },
      'age': instance.age,
      'location': {
        'rating': instance.rating,
        'travelTime': instance.travelTime?.inMicroseconds,
        'genericField': toJsonT(instance.nestedGenericField),
      },
      'normalGeneric': toJsonT(instance.normalGeneric),
    };
''')
@JsonSerializable(checked: true, genericArgumentFactories: true)
class NestedFieldsWithChecked<T> {
  @JsonKey(name: 'name.firstName')
  final String firstName;

  @JsonKey(name: 'name.lastName')
  final String lastName;

  @JsonKey(name: 'age')
  final int age;

  @JsonKey(name: 'location.rating')
  final double rating;

  @JsonKey(name: 'location.travelTime')
  final Duration travelTime;

  @JsonKey(name: 'location.genericField')
  final T nestedGenericField;

  @JsonKey(name: 'normalGeneric')
  final T normalGeneric;

  NestedFieldsWithChecked(
    this.firstName,
    this.lastName,
    this.age,
    this.rating, {
    this.travelTime = const Duration(days: 1),
    this.nestedGenericField,
    this.normalGeneric,
  });
}
