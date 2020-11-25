// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

NestedInfoWithChecked<T> _$NestedInfoWithCheckedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return $checkedNew('NestedInfoWithChecked', json, () {
    final val = NestedInfoWithChecked<T>(
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

Map<String, dynamic> _$NestedInfoWithCheckedToJson<T>(
  NestedInfoWithChecked<T> instance,
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
