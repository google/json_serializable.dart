// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.10

import 'package:json_annotation/json_annotation.dart';

part 'input.type_int.g.dart';

@JsonSerializable()
class SimpleClass {
  final int value;

  @JsonKey(nullable: false)
  final int nullable;

  @JsonKey(defaultValue: 42)
  int withDefault;

  SimpleClass(
    this.value,
    this.nullable,
    this.withDefault,
  );

  factory SimpleClass.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassToJson(this);
}

@JsonSerializable()
class SimpleClassNullable {
  final int? value;

  @JsonKey(nullable: false)
  final int? nullable;

  @JsonKey(defaultValue: 42)
  int? withDefault;

  SimpleClassNullable(
    this.value,
    this.nullable,
    this.withDefault,
  );

  factory SimpleClassNullable.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassNullableFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassNullableToJson(this);
}
