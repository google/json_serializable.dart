// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_class.wrapped.dart';

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
