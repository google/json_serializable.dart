// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_class.dart';

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
  Map<String, dynamic> toJson() => <String, dynamic>{
        'fieldObject': fieldObject == null ? null : _dataToJson(fieldObject),
        'fieldDynamic': fieldDynamic == null ? null : _dataToJson(fieldDynamic),
        'fieldInt': fieldInt == null ? null : _dataToJson(fieldInt),
        'fieldT': fieldT == null ? null : _dataToJson(fieldT),
        'fieldS': fieldS == null ? null : _dataToJson(fieldS)
      };
}
