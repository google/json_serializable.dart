// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_object.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

SimpleObject _$SimpleObjectFromJson(Map json) =>
    new SimpleObject(json['value'] as int);

abstract class _$SimpleObjectSerializerMixin {
  int get value;
  Map<String, dynamic> toJson() => <String, dynamic>{'value': value};
}
