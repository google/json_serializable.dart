// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_argument_factories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericClassWithHelpers<T, S> _$GenericClassWithHelpersFromJson<T, S>(
  Map<String, dynamic> json,
  T Function(Object json) helperForT,
  S Function(Object json) helperForS,
) {
  return GenericClassWithHelpers<T, S>(
    helperForT(json['value']),
    (json['list'] as List)?.map(helperForT)?.toList(),
    (json['someSet'] as List)?.map(helperForS)?.toSet(),
  );
}

Map<String, dynamic> _$GenericClassWithHelpersToJson<T, S>(
  GenericClassWithHelpers<T, S> instance,
  Object Function(T value) helperForT,
  Object Function(S value) helperForS,
) =>
    <String, dynamic>{
      'value': helperForT(instance.value),
      'list': instance.list?.map(helperForT)?.toList(),
      'someSet': instance.someSet?.map(helperForS)?.toList(),
    };
