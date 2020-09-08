// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_argument_factories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericClassWithHelpers<T, S> _$GenericClassWithHelpersFromJson<T, S>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
  S Function(Object json) fromJsonS,
) {
  return GenericClassWithHelpers<T, S>(
    fromJsonT(json['value']),
    (json['list'] as List)?.map(fromJsonT)?.toList(),
    (json['someSet'] as List)?.map(fromJsonS)?.toSet(),
  );
}

Map<String, dynamic> _$GenericClassWithHelpersToJson<T, S>(
  GenericClassWithHelpers<T, S> instance,
  Object Function(T value) toJsonT,
  Object Function(S value) toJsonS,
) =>
    <String, dynamic>{
      'value': toJsonT(instance.value),
      'list': instance.list?.map(toJsonT)?.toList(),
      'someSet': instance.someSet?.map(toJsonS)?.toList(),
    };
