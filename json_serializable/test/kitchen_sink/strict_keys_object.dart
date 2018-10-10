// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'strict_keys_object.g.dart';

@JsonSerializable(
    disallowUnrecognizedKeys: true, anyMap: true, generateToJsonFunction: false)
class StrictKeysObject extends Object with _$StrictKeysObjectSerializerMixin {
  @override
  @JsonKey(required: true)
  final int value;

  @override
  @JsonKey(name: 'custom_field', required: true)
  final String customField;

  StrictKeysObject(this.value, this.customField);

  factory StrictKeysObject.fromJson(Map json) =>
      _$StrictKeysObjectFromJson(json);
}
