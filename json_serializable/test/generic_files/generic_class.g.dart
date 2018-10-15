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

GenericClassWithConverter<T, S>
    _$GenericClassWithConverterFromJson<T extends num, S>(
        Map<String, dynamic> json) {
  return GenericClassWithConverter<T, S>()
    ..fieldObject = json['fieldObject']
    ..fieldDynamic = json['fieldDynamic']
    ..fieldInt = json['fieldInt'] as int
    ..fieldT = json['fieldT'] == null
        ? null
        : _SimpleConverter<T>().fromJson(json['fieldT'] as Map<String, dynamic>)
    ..fieldS = json['fieldS'] == null
        ? null
        : _SimpleConverter<S>().fromJson(json['fieldS'] as Map<String, dynamic>)
    ..duration = json['duration'] == null
        ? null
        : const _DurationMillisecondConverter()
            .fromJson(json['duration'] as int)
    ..listDuration = json['listDuration'] == null
        ? null
        : const _DurationListMillisecondConverter()
            .fromJson(json['listDuration'] as int);
}

Map<String, dynamic> _$GenericClassWithConverterToJson<T extends num, S>(
        GenericClassWithConverter<T, S> instance) =>
    <String, dynamic>{
      'fieldObject': instance.fieldObject,
      'fieldDynamic': instance.fieldDynamic,
      'fieldInt': instance.fieldInt,
      'fieldT': instance.fieldT == null
          ? null
          : _SimpleConverter<T>().toJson(instance.fieldT),
      'fieldS': instance.fieldS == null
          ? null
          : _SimpleConverter<S>().toJson(instance.fieldS),
      'duration': instance.duration == null
          ? null
          : const _DurationMillisecondConverter().toJson(instance.duration),
      'listDuration': instance.listDuration == null
          ? null
          : const _DurationListMillisecondConverter()
              .toJson(instance.listDuration)
    };
