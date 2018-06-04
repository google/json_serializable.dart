// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strict_keys_object.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

StrictKeysObject _$StrictKeysObjectFromJson(Map json) {
  $checkKeys(json,
      allowedKeys: const ['value', 'custom_field'],
      requiredKeys: const ['value', 'custom_field']);
  return new StrictKeysObject(
      json['value'] as int, json['custom_field'] as String);
}

abstract class _$StrictKeysObjectSerializerMixin {
  int get value;
  String get customField;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'value': value, 'custom_field': customField};
}
