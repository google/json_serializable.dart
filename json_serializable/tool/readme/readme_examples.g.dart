// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'readme_examples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sample1 _$Sample1FromJson(Map<String, dynamic> json) => Sample1(
      Sample2.fromJson(json['value'] as int),
    );

Map<String, dynamic> _$Sample1ToJson(Sample1 instance) => <String, dynamic>{
      'value': instance.value,
    };

Sample3 _$Sample3FromJson(Map<String, dynamic> json) => Sample3(
      Sample3._fromJson(json['value'] as int),
    );

Map<String, dynamic> _$Sample3ToJson(Sample3 instance) => <String, dynamic>{
      'value': Sample3._toJson(instance.value),
    };

Sample4 _$Sample4FromJson(Map<String, dynamic> json) => Sample4(
      const EpochDateTimeConverter().fromJson(json['value'] as int),
    );

Map<String, dynamic> _$Sample4ToJson(Sample4 instance) => <String, dynamic>{
      'value': const EpochDateTimeConverter().toJson(instance.value),
    };
