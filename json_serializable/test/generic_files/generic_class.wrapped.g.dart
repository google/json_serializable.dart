// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_class.wrapped.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

GenericClass<T, S> _$GenericClassFromJson<T extends num, S>(
        Map<String, dynamic> json) =>
    new GenericClass<T, S>()
      ..fieldObject = json['fieldObject'] == null
          ? null
          : _dataFromJson(json['fieldObject'] as Map<String, dynamic>)
      ..fieldDynamic = json['fieldDynamic'] == null
          ? null
          : _dataFromJson(json['fieldDynamic'] as Map<String, dynamic>)
      ..fieldInt = json['fieldInt'] == null
          ? null
          : _dataFromJson(json['fieldInt'] as Map<String, dynamic>)
      ..fieldT = json['fieldT'] == null
          ? null
          : _dataFromJson(json['fieldT'] as Map<String, dynamic>)
      ..fieldS = json['fieldS'] == null
          ? null
          : _dataFromJson(json['fieldS'] as Map<String, dynamic>);

abstract class _$GenericClassSerializerMixin<T extends num, S> {
  Object get fieldObject;
  dynamic get fieldDynamic;
  int get fieldInt;
  T get fieldT;
  S get fieldS;
  Map<String, dynamic> toJson() => new _$GenericClassJsonMapWrapper<T, S>(this);
}

class _$GenericClassJsonMapWrapper<T extends num, S> extends $JsonMapWrapper {
  final _$GenericClassSerializerMixin<T, S> _v;
  _$GenericClassJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys =>
      const ['fieldObject', 'fieldDynamic', 'fieldInt', 'fieldT', 'fieldS'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'fieldObject':
          return _v.fieldObject == null ? null : _dataToJson(_v.fieldObject);
        case 'fieldDynamic':
          return _v.fieldDynamic == null ? null : _dataToJson(_v.fieldDynamic);
        case 'fieldInt':
          return _v.fieldInt == null ? null : _dataToJson(_v.fieldInt);
        case 'fieldT':
          return _v.fieldT == null ? null : _dataToJson(_v.fieldT);
        case 'fieldS':
          return _v.fieldS == null ? null : _dataToJson(_v.fieldS);
      }
    }
    return null;
  }
}
