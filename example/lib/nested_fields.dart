import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'nested_fields.g.dart';

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

  factory NestedFields.fromJson(Map<String, dynamic> json) => _$NestedFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$NestedFieldsToJson(this);
}

@JsonSerializable()
class GeneralTestClass3 {
  @JsonKey(name: 'name.firstName')
  String firstName;

  @JsonKey(name: 'name.lastName')
  String lastName;

  @JsonKey(name: 'age')
  int age;
}

@JsonSerializable(checked: true, genericArgumentFactories: true)
class NestedInfoWithChecked<T> {
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

  NestedInfoWithChecked(
    this.firstName,
    this.lastName,
    this.age,
    this.rating, {
    this.travelTime = const Duration(days: 1),
    this.nestedGenericField,
    this.normalGeneric,
  });

  factory NestedInfoWithChecked.fromJson(Map<String, dynamic> json) =>
      _$NestedInfoWithCheckedFromJson(json, (value) {
        return value as T;
      });

  Map<String, dynamic> toJson() => _$NestedInfoWithCheckedToJson(this, (v) {
        return v;
      });
}
