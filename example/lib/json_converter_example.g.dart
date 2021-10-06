// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_converter_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTimeExample _$DateTimeExampleFromJson(Map<String, dynamic> json) =>
    DateTimeExample(
      const _DateTimeEpochConverter().fromJson(json['when'] as int),
    );

Map<String, dynamic> _$DateTimeExampleToJson(DateTimeExample instance) =>
    <String, dynamic>{
      'when': const _DateTimeEpochConverter().toJson(instance.when),
    };

class _$DateTimeExampleFields {
  const _$DateTimeExampleFields();
  final String when = 'when';
}

GenericCollection<T> _$GenericCollectionFromJson<T>(
        Map<String, dynamic> json) =>
    GenericCollection<T>(
      page: json['page'] as int?,
      totalResults: json['total_results'] as int?,
      totalPages: json['total_pages'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map(_Converter<T>().fromJson)
          .toList(),
    );

Map<String, dynamic> _$GenericCollectionToJson<T>(
        GenericCollection<T> instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'results': instance.results?.map(_Converter<T>().toJson).toList(),
    };

class _$GenericCollectionFields {
  const _$GenericCollectionFields();
  final String page = 'page';
  final String totalResults = 'total_results';
  final String totalPages = 'total_pages';
  final String results = 'results';
}

CustomResult _$CustomResultFromJson(Map<String, dynamic> json) => CustomResult(
      json['name'] as String,
      json['size'] as int,
    );

Map<String, dynamic> _$CustomResultToJson(CustomResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
    };

class _$CustomResultFields {
  const _$CustomResultFields();
  final String name = 'name';
  final String size = 'size';
}
