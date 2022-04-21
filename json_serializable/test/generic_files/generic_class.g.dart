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
          ..fieldT = () {
            final val = json['fieldT'];
            return val == null
                ? null
                : _SimpleConverter<T?>().fromJson(val as Map<String, dynamic>);
          }()
          ..fieldS = () {
            final val = json['fieldS'];
            return val == null
                ? null
                : _SimpleConverter<S?>().fromJson(val as Map<String, dynamic>);
          }()
          ..duration = json['duration'] == null
              ? null
              : Duration(microseconds: json['duration'] as int)
          ..listDuration = (json['listDuration'] as List<dynamic>?)
              ?.map((e) => Duration(microseconds: e as int))
              .toList();

Map<String, dynamic> _$GenericClassWithConverterToJson<T extends num, S>(
        GenericClassWithConverter<T, S> instance) =>
    <String, dynamic>{
      'fieldObject': instance.fieldObject,
      'fieldDynamic': instance.fieldDynamic,
      'fieldInt': instance.fieldInt,
      'fieldT': () {
        final val = instance.fieldT;
        return val == null ? null : _SimpleConverter<T?>().toJson(val);
      }(),
      'fieldS': () {
        final val = instance.fieldS;
        return val == null ? null : _SimpleConverter<S?>().toJson(val);
      }(),
      'duration': instance.duration?.inMicroseconds,
      'listDuration':
          instance.listDuration?.map((e) => e.inMicroseconds).toList(),
    };

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
