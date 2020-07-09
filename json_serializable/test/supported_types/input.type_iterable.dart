// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:json_annotation/json_annotation.dart';

part 'input.type_iterable.g.dart';

@JsonSerializable()
class SimpleClass {
  final Iterable value;

  @JsonKey(nullable: false)
  final Iterable nullable;

  @JsonKey(defaultValue: [42, true, false, null])
  Iterable withDefault;

  SimpleClass(
    this.value,
    this.nullable,
  );

  factory SimpleClass.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassToJson(this);
}
