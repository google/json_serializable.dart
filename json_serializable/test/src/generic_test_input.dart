// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
GenericClass<T, S> _$GenericClassFromJson<T extends num, S>(
    Map<String, dynamic> json) {
  return GenericClass<T, S>()
    ..fieldObject =
        json['fieldObject'] == null ? null : _dataFromJson(json['fieldObject'])
    ..fieldDynamic = json['fieldDynamic'] == null
        ? null
        : _dataFromJson(json['fieldDynamic'])
    ..fieldInt =
        json['fieldInt'] == null ? null : _dataFromJson(json['fieldInt'])
    ..fieldT = json['fieldT'] == null ? null : _dataFromJson(json['fieldT'])
    ..fieldS = json['fieldS'] == null ? null : _dataFromJson(json['fieldS']);
}

Map<String, dynamic> _$GenericClassToJson<T extends num, S>(
        GenericClass<T, S> instance) =>
    <String, dynamic>{
      'fieldObject': instance.fieldObject == null
          ? null
          : _dataToJson(instance.fieldObject),
      'fieldDynamic': instance.fieldDynamic == null
          ? null
          : _dataToJson(instance.fieldDynamic),
      'fieldInt':
          instance.fieldInt == null ? null : _dataToJson(instance.fieldInt),
      'fieldT': instance.fieldT == null ? null : _dataToJson(instance.fieldT),
      'fieldS': instance.fieldS == null ? null : _dataToJson(instance.fieldS)
    };
''')
@JsonSerializable()
class GenericClass<T extends num, S> {
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  Object fieldObject;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  dynamic fieldDynamic;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  int fieldInt;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T fieldT;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  S fieldS;

  GenericClass();
}

T _dataFromJson<T extends num>(Object input) => null;

Object _dataToJson<T extends num>(T input) => null;
