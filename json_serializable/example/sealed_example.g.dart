// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'sealed_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SealedBase _$SealedBaseFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      'SealedSub1' => _$SealedSub1FromJson(json),
      'SealedSub2' => _$SealedSub2FromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['type']}',
        SealedBase,
        json,
      ),
    };

Map<String, dynamic> _$SealedBaseToJson(SealedBase instance) =>
    switch (instance) {
      final SealedSub1 instance => {
        'type': 'SealedSub1',
        ..._$SealedSub1ToJson(instance),
      },
      final SealedSub2 instance => {
        'type': 'SealedSub2',
        ..._$SealedSub2ToJson(instance),
      },
    };

SealedSub1 _$SealedSub1FromJson(Map<String, dynamic> json) =>
    SealedSub1(exampleField1: json['exampleField1'] as String);

Map<String, dynamic> _$SealedSub1ToJson(SealedSub1 instance) =>
    <String, dynamic>{'exampleField1': instance.exampleField1};

SealedSub2 _$SealedSub2FromJson(Map<String, dynamic> json) =>
    SealedSub2(exampleField2: json['exampleField2'] as String);

Map<String, dynamic> _$SealedSub2ToJson(SealedSub2 instance) =>
    <String, dynamic>{'exampleField2': instance.exampleField2};
