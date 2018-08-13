// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'generic_class.g.dart';

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

  factory GenericClass.fromJson(Map<String, dynamic> json) =>
      _$GenericClassFromJson<T, S>(json);

  Map<String, dynamic> toJson() => _$GenericClassToJson(this);

  static T _dataFromJson<T, S, U>(Map<String, dynamic> input,
          [S other1, U other2]) =>
      input['value'] as T;

  static Map<String, dynamic> _dataToJson<T, S, U>(T input,
          [S other1, U other2]) =>
      {'value': input};
}
