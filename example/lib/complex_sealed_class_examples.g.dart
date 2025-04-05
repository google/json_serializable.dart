// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complex_sealed_class_examples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseBaseBaseType _$BaseBaseBaseTypeFromJson(Map<String, dynamic> json) =>
    switch (json['base_base_base_type']) {
      'BaseBase' => _$BaseBaseFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
          '${json['base_base_base_type']}',
          BaseBaseBaseType,
          json,
        ),
    };

Map<String, dynamic> _$BaseBaseBaseTypeToJson(BaseBaseBaseType instance) =>
    switch (instance) {
      final BaseBase instance => {
          'base_base_base_type': 'BaseBase',
          ..._$BaseBaseToJson(instance),
        },
    };

BaseBase _$BaseBaseFromJson(Map<String, dynamic> json) =>
    switch (json['base_base_type']) {
      'Base' => _$BaseFromJson(json),
      'BaseBaseImpl' => _$BaseBaseImplFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
          '${json['base_base_type']}',
          BaseBase,
          json,
        ),
    };

Map<String, dynamic> _$BaseBaseToJson(BaseBase instance) => switch (instance) {
      final Base instance => {
          'base_base_type': 'Base',
          ..._$BaseToJson(instance),
        },
      final BaseBaseImpl instance => {
          'base_base_type': 'BaseBaseImpl',
          ..._$BaseBaseImplToJson(instance),
        },
    };

Base _$BaseFromJson(Map<String, dynamic> json) => switch (json['base_type']) {
      'FirstBaseImpl' => _$FirstBaseImplFromJson(json),
      'SecondBaseImpl' => _$SecondBaseImplFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
          '${json['base_type']}',
          Base,
          json,
        ),
    };

Map<String, dynamic> _$BaseToJson(Base instance) => switch (instance) {
      final FirstBaseImpl instance => {
          'base_type': 'FirstBaseImpl',
          ..._$FirstBaseImplToJson(instance),
        },
      final SecondBaseImpl instance => {
          'base_type': 'SecondBaseImpl',
          ..._$SecondBaseImplToJson(instance),
        },
    };

FirstBaseImpl _$FirstBaseImplFromJson(Map<String, dynamic> json) =>
    FirstBaseImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$FirstBaseImplToJson(FirstBaseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SecondBaseImpl _$SecondBaseImplFromJson(Map<String, dynamic> json) =>
    SecondBaseImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$SecondBaseImplToJson(SecondBaseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

BaseBaseImpl _$BaseBaseImplFromJson(Map<String, dynamic> json) => BaseBaseImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$BaseBaseImplToJson(BaseBaseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SecondBase _$SecondBaseFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      'ImplAll' => _$ImplAllFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
          '${json['type']}',
          SecondBase,
          json,
        ),
    };

ThirdBase _$ThirdBaseFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      'ImplAll' => _$ImplAllFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
          '${json['type']}',
          ThirdBase,
          json,
        ),
    };

ImplAll _$ImplAllFromJson(Map<String, dynamic> json) => ImplAll(
      json['value'] as String,
    );
