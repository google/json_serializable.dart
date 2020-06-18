// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

extension PersonExt on Person {
  static Person fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
    };
