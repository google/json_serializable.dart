// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'input.type_object.g.dart';

@JsonSerializable()
class SimpleClass {
  final Object value;

  @JsonKey(defaultValue: 'o1')
  Object withDefault;

  SimpleClass(this.value, this.withDefault);

  factory SimpleClass.fromJson(Map<String, Object?> json) =>
      _$SimpleClassFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassToJson(this);
}

@JsonSerializable()
class SimpleClassNullable {
  final Object? value;

  @JsonKey(defaultValue: 'o1')
  Object? withDefault;

  SimpleClassNullable(this.value, this.withDefault);

  factory SimpleClassNullable.fromJson(Map<String, Object?> json) =>
      _$SimpleClassNullableFromJson(json);

  Map<String, Object?> toJson() => _$SimpleClassNullableToJson(this);
}
