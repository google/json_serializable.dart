// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'generic_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericClass<T, S> _$GenericClassFromJson<T extends num, S>(
        Map<String, dynamic> json) =>
    GenericClass<T, S>()
      ..fieldObject = GenericClass._dataFromJson(
          json['fieldObject'] as Map<String, dynamic>)
      ..fieldDynamic = GenericClass._dataFromJson(
          json['fieldDynamic'] as Map<String, dynamic>)
      ..fieldInt =
          GenericClass._dataFromJson(json['fieldInt'] as Map<String, dynamic>)
      ..fieldT =
          GenericClass._dataFromJson(json['fieldT'] as Map<String, dynamic>)
      ..fieldS =
          GenericClass._dataFromJson(json['fieldS'] as Map<String, dynamic>);

Map<String, dynamic> _$GenericClassToJson<T extends num, S>(
        GenericClass<T, S> instance) =>
    <String, dynamic>{
      'fieldObject': GenericClass._dataToJson(instance.fieldObject),
      'fieldDynamic': GenericClass._dataToJson(instance.fieldDynamic),
      'fieldInt': GenericClass._dataToJson(instance.fieldInt),
      'fieldT': GenericClass._dataToJson(instance.fieldT),
      'fieldS': GenericClass._dataToJson(instance.fieldS),
    };

GenericClassWithConverter<T, S>
    _$GenericClassWithConverterFromJson<T extends num, S>(
            Map<String, dynamic> json) =>
        GenericClassWithConverter<T, S>()
          ..fieldObject = json['fieldObject']
          ..fieldDynamic = json['fieldDynamic']
          ..fieldInt = json['fieldInt'] as int?
          ..fieldT = _$JsonConverterFromJson<Map<String, dynamic>, T>(
              json['fieldT'], _SimpleConverter<T?>().fromJson)
          ..fieldS = _$JsonConverterFromJson<Map<String, dynamic>, S>(
              json['fieldS'], _SimpleConverter<S?>().fromJson)
          ..duration = const _DurationMillisecondConverter.named()
              .fromJson(json['duration'] as int?)
          ..listDuration = const _DurationListMillisecondConverter()
              .fromJson(json['listDuration'] as int?);

Map<String, dynamic> _$GenericClassWithConverterToJson<T extends num, S>(
        GenericClassWithConverter<T, S> instance) =>
    <String, dynamic>{
      'fieldObject': instance.fieldObject,
      'fieldDynamic': instance.fieldDynamic,
      'fieldInt': instance.fieldInt,
      'fieldT': _$JsonConverterToJson<Map<String, dynamic>, T>(
          instance.fieldT, _SimpleConverter<T?>().toJson),
      'fieldS': _$JsonConverterToJson<Map<String, dynamic>, S>(
          instance.fieldS, _SimpleConverter<S?>().toJson),
      'duration':
          const _DurationMillisecondConverter.named().toJson(instance.duration),
      'listDuration': const _DurationListMillisecondConverter()
          .toJson(instance.listDuration),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

Issue980ParentClass _$Issue980ParentClassFromJson(Map<String, dynamic> json) =>
    Issue980ParentClass(
      (json['list'] as List<dynamic>)
          .map((e) =>
              Issue980GenericClass<int>.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Issue980ParentClassToJson(
        Issue980ParentClass instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

Issue1047ParentClass<T> _$Issue1047ParentClassFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Issue1047ParentClass<T>(
      edges: (json['edges'] as List<dynamic>)
          .map((e) => Issue1047Class<T>.fromJson(
              e as Map<String, dynamic>, (value) => fromJsonT(value)))
          .toList(),
    );

Map<String, dynamic> _$Issue1047ParentClassToJson<T>(
  Issue1047ParentClass<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'edges': instance.edges
          .map((e) => e.toJson(
                (value) => toJsonT(value),
              ))
          .toList(),
    };

Issue1047Class<T> _$Issue1047ClassFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Issue1047Class<T>(
      node: fromJsonT(json['node']),
    );

Map<String, dynamic> _$Issue1047ClassToJson<T>(
  Issue1047Class<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'node': toJsonT(instance.node),
    };
