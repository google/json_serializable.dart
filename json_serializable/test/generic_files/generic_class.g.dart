// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericClass<T, S> _$GenericClassFromJson<T extends num, S>(
    Map<String, dynamic> json) {
  return GenericClass<T, S>()
    ..fieldObject = json['fieldObject'] == null
        ? null
        : GenericClass._dataFromJson(
            json['fieldObject'] as Map<String, dynamic>)
    ..fieldDynamic = json['fieldDynamic'] == null
        ? null
        : GenericClass._dataFromJson(
            json['fieldDynamic'] as Map<String, dynamic>)
    ..fieldInt = json['fieldInt'] == null
        ? null
        : GenericClass._dataFromJson(json['fieldInt'] as Map<String, dynamic>)
    ..fieldT = json['fieldT'] == null
        ? null
        : GenericClass._dataFromJson(json['fieldT'] as Map<String, dynamic>)
    ..fieldS = json['fieldS'] == null
        ? null
        : GenericClass._dataFromJson(json['fieldS'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GenericClassToJson<T extends num, S>(
        GenericClass<T, S> instance) =>
    <String, dynamic>{
      'fieldObject': instance.fieldObject == null
          ? null
          : GenericClass._dataToJson(instance.fieldObject),
      'fieldDynamic': instance.fieldDynamic == null
          ? null
          : GenericClass._dataToJson(instance.fieldDynamic),
      'fieldInt': instance.fieldInt == null
          ? null
          : GenericClass._dataToJson(instance.fieldInt),
      'fieldT': instance.fieldT == null
          ? null
          : GenericClass._dataToJson(instance.fieldT),
      'fieldS': instance.fieldS == null
          ? null
          : GenericClass._dataToJson(instance.fieldS)
    };
