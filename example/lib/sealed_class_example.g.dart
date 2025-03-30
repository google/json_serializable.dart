// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_class_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySealedClass _$MySealedClassFromJson(Map<String, dynamic> json) =>
    switch (json['runtimeType']) {
      'first_subtype' => _$FirstSubtypeFromJson(json),
      'second_subtype' => _$SecondSubtypeFromJson(json),
      _ => throw UnrerecognizedUnionTypeException(
          '${json['runtimeType']}',
          MySealedClass,
          json,
        ),
    };

Map<String, dynamic> _$MySealedClassToJson(MySealedClass instance) =>
    switch (instance) {
      final FirstSubtype instance => {
          'runtimeType': 'first_subtype',
          ..._$FirstSubtypeToJson(instance),
        },
      final SecondSubtype instance => {
          'runtimeType': 'second_subtype',
          ..._$SecondSubtypeToJson(instance),
        },
    };

FirstSubtype _$FirstSubtypeFromJson(Map<String, dynamic> json) => FirstSubtype(
      json['someAttribute'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$FirstSubtypeToJson(FirstSubtype instance) =>
    <String, dynamic>{
      'value': instance.value,
      'someAttribute': instance.someAttribute,
    };

SecondSubtype _$SecondSubtypeFromJson(Map<String, dynamic> json) =>
    SecondSubtype(
      json['someOtherAttribute'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$SecondSubtypeToJson(SecondSubtype instance) =>
    <String, dynamic>{
      'value': instance.value,
      'someOtherAttribute': instance.someOtherAttribute,
    };
