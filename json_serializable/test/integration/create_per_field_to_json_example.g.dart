// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'create_per_field_to_json_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      enumValue: $enumDecodeNullable(_$EnumValueEnumMap, json['enumValue']),
      nested: json['nested'] == null
          ? null
          : Nested.fromJson(json['nested'] as Map<String, dynamic>),
      nestedExcludeIfNull: json['nestedExcludeIfNull'] == null
          ? null
          : Nested.fromJson(
              json['nestedExcludeIfNull'] as Map<String, dynamic>),
      nestedGeneric: json['nestedGeneric'] == null
          ? null
          : GenericFactory<int>.fromJson(
              json['nestedGeneric'] as Map<String, dynamic>,
              (value) => value as int),
    );

// ignore: unused_element
abstract class _$ModelPerFieldToJson {
  // ignore: unused_element
  static Object? firstName(String instance) => instance;
  // ignore: unused_element
  static Object? lastName(String instance) => instance;
  // ignore: unused_element
  static Object? enumValue(EnumValue? instance) => _$EnumValueEnumMap[instance];
  // ignore: unused_element
  static Object? nested(Nested? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? nestedGeneric(GenericFactory<int>? instance) =>
      instance?.toJson(
        (value) => value,
      );
  // ignore: unused_element
  static Object? nestedExcludeIfNull(Nested? instance) => instance?.toJson();
}

Map<String, dynamic> _$ModelToJson(Model instance) {
  final val = <String, dynamic>{
    'firstName': instance.firstName,
    'lastName': instance.lastName,
    'enumValue': _$EnumValueEnumMap[instance.enumValue],
    'nested': instance.nested?.toJson(),
    'nestedGeneric': instance.nestedGeneric?.toJson(
      (value) => value,
    ),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nestedExcludeIfNull', instance.nestedExcludeIfNull?.toJson());
  return val;
}

const _$EnumValueEnumMap = {
  EnumValue.first: '1',
  EnumValue.second: 'second',
};

Nested _$NestedFromJson(Map<String, dynamic> json) => Nested(
      json['value'] as String,
    );

Map<String, dynamic> _$NestedToJson(Nested instance) => <String, dynamic>{
      'value': instance.value,
    };

GenericFactory<T> _$GenericFactoryFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    GenericFactory<T>(
      fromJsonT(json['value']),
      (json['map'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, fromJsonT(e)),
      ),
    );

// ignore: unused_element
abstract class _$GenericFactoryPerFieldToJson {
  // ignore: unused_element
  static Object? value<T>(
    T instance,
    Object? Function(T value) toJsonT,
  ) =>
      toJsonT(instance);
  // ignore: unused_element
  static Object? map<T>(
    Map<String, T> instance,
    Object? Function(T value) toJsonT,
  ) =>
      instance.map((k, e) => MapEntry(k, toJsonT(e)));
}

Map<String, dynamic> _$GenericFactoryToJson<T>(
  GenericFactory<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'value': toJsonT(instance.value),
      'map': instance.map.map((k, e) => MapEntry(k, toJsonT(e))),
    };

// ignore: unused_element
abstract class _$PrivateModelPerFieldToJson {
  // ignore: unused_element
  static Object? fullName(String instance) => instance;
}

Map<String, dynamic> _$PrivateModelToJson(_PrivateModel instance) =>
    <String, dynamic>{
      'full-name': instance.fullName,
    };
