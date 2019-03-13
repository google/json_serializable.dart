// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_class.g_use_wrappers.dart';

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
    _$GenericClassJsonMapWrapper<T, S>(instance);

class _$GenericClassJsonMapWrapper<T extends num, S> extends $JsonMapWrapper {
  final GenericClass<T, S> _v;
  _$GenericClassJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys =>
      const ['fieldObject', 'fieldDynamic', 'fieldInt', 'fieldT', 'fieldS'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'fieldObject':
          return _v.fieldObject == null
              ? null
              : GenericClass._dataToJson(_v.fieldObject);
        case 'fieldDynamic':
          return _v.fieldDynamic == null
              ? null
              : GenericClass._dataToJson(_v.fieldDynamic);
        case 'fieldInt':
          return _v.fieldInt == null
              ? null
              : GenericClass._dataToJson(_v.fieldInt);
        case 'fieldT':
          return _v.fieldT == null ? null : GenericClass._dataToJson(_v.fieldT);
        case 'fieldS':
          return _v.fieldS == null ? null : GenericClass._dataToJson(_v.fieldS);
      }
    }
    return null;
  }
}

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
    _$GenericClassWithConverterJsonMapWrapper<T, S>(instance);

class _$GenericClassWithConverterJsonMapWrapper<T extends num, S>
    extends $JsonMapWrapper {
  final GenericClassWithConverter<T, S> _v;
  _$GenericClassWithConverterJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const [
        'fieldObject',
        'fieldDynamic',
        'fieldInt',
        'fieldT',
        'fieldS',
        'duration',
        'listDuration'
      ];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'fieldObject':
          return _v.fieldObject;
        case 'fieldDynamic':
          return _v.fieldDynamic;
        case 'fieldInt':
          return _v.fieldInt;
        case 'fieldT':
          return _v.fieldT == null
              ? null
              : _SimpleConverter<T>().toJson(_v.fieldT);
        case 'fieldS':
          return _v.fieldS == null
              ? null
              : _SimpleConverter<S>().toJson(_v.fieldS);
        case 'duration':
          return _v.duration == null
              ? null
              : const _DurationMillisecondConverter().toJson(_v.duration);
        case 'listDuration':
          return _v.listDuration == null
              ? null
              : const _DurationListMillisecondConverter()
                  .toJson(_v.listDuration);
      }
    }
    return null;
  }
}
