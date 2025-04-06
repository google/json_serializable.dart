// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'sealed_class_examples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleSealedBase _$SimpleSealedBaseFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      'SimpleSealedImplOne' => _$SimpleSealedImplOneFromJson(json),
      'SimpleSealedImplTwo' => _$SimpleSealedImplTwoFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
          '${json['type']}',
          SimpleSealedBase,
          json,
        ),
    };

Map<String, dynamic> _$SimpleSealedBaseToJson(SimpleSealedBase instance) =>
    switch (instance) {
      final SimpleSealedImplOne instance => {
          'type': 'SimpleSealedImplOne',
          ..._$SimpleSealedImplOneToJson(instance),
        },
      final SimpleSealedImplTwo instance => {
          'type': 'SimpleSealedImplTwo',
          ..._$SimpleSealedImplTwoToJson(instance),
        },
    };

SimpleSealedImplOne _$SimpleSealedImplOneFromJson(Map<String, dynamic> json) =>
    SimpleSealedImplOne(
      testFieldOne: json['testFieldOne'] as String,
      commonField: json['commonField'] as String,
    );

Map<String, dynamic> _$SimpleSealedImplOneToJson(
        SimpleSealedImplOne instance) =>
    <String, dynamic>{
      'commonField': instance.commonField,
      'testFieldOne': instance.testFieldOne,
    };

SimpleSealedImplTwo _$SimpleSealedImplTwoFromJson(Map<String, dynamic> json) =>
    SimpleSealedImplTwo(
      testFieldTwo: json['testFieldTwo'] as String,
      commonField: json['commonField'] as String,
    );

Map<String, dynamic> _$SimpleSealedImplTwoToJson(
        SimpleSealedImplTwo instance) =>
    <String, dynamic>{
      'commonField': instance.commonField,
      'testFieldTwo': instance.testFieldTwo,
    };

SealedWithDiscriminatorAndRenameBase
    _$SealedWithDiscriminatorAndRenameBaseFromJson(Map<String, dynamic> json) =>
        switch (json['custom_discriminator']) {
          'sealed_with_discriminator_and_rename_impl_one' =>
            _$SealedWithDiscriminatorAndRenameImplOneFromJson(json),
          'sealed_with_discriminator_and_rename_impl_two' =>
            _$SealedWithDiscriminatorAndRenameImplTwoFromJson(json),
          _ => throw UnrecognizedUnionTypeException(
              '${json['custom_discriminator']}',
              SealedWithDiscriminatorAndRenameBase,
              json,
            ),
        };

Map<String, dynamic> _$SealedWithDiscriminatorAndRenameBaseToJson(
        SealedWithDiscriminatorAndRenameBase instance) =>
    switch (instance) {
      final SealedWithDiscriminatorAndRenameImplOne instance => {
          'custom_discriminator':
              'sealed_with_discriminator_and_rename_impl_one',
          ..._$SealedWithDiscriminatorAndRenameImplOneToJson(instance),
        },
      final SealedWithDiscriminatorAndRenameImplTwo instance => {
          'custom_discriminator':
              'sealed_with_discriminator_and_rename_impl_two',
          ..._$SealedWithDiscriminatorAndRenameImplTwoToJson(instance),
        },
    };

SealedWithDiscriminatorAndRenameImplOne
    _$SealedWithDiscriminatorAndRenameImplOneFromJson(
            Map<String, dynamic> json) =>
        SealedWithDiscriminatorAndRenameImplOne(
          (json['testOne'] as num).toInt(),
          (json['common'] as num).toInt(),
        );

Map<String, dynamic> _$SealedWithDiscriminatorAndRenameImplOneToJson(
        SealedWithDiscriminatorAndRenameImplOne instance) =>
    <String, dynamic>{
      'common': instance.common,
      'testOne': instance.testOne,
    };

SealedWithDiscriminatorAndRenameImplTwo
    _$SealedWithDiscriminatorAndRenameImplTwoFromJson(
            Map<String, dynamic> json) =>
        SealedWithDiscriminatorAndRenameImplTwo(
          (json['testTwo'] as num).toInt(),
          (json['common'] as num).toInt(),
        );

Map<String, dynamic> _$SealedWithDiscriminatorAndRenameImplTwoToJson(
        SealedWithDiscriminatorAndRenameImplTwo instance) =>
    <String, dynamic>{
      'common': instance.common,
      'testTwo': instance.testTwo,
    };
