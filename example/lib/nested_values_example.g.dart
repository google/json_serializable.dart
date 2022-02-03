// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_values_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestedValueExample _$NestedValueExampleFromJson(Map<String, dynamic> json) =>
    NestedValueExample(
      const _NestedListConverter()
          .fromJson(json['root_items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedValueExampleToJson(NestedValueExample instance) =>
    <String, dynamic>{
      'root_items': const _NestedListConverter().toJson(instance.nestedValues),
    };
