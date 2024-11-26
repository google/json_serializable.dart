// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable()
class A {
  final StatusCode? statusCode;
  final StatusCode2 statusCode2;
  final StatusCode3 statusCode3;

  A(this.statusCode, this.statusCode2, this.statusCode3);

  factory A.fromJson(Map<String, dynamic> json) => _$AFromJson(json);

  Map<String, dynamic> toJson() => _$AToJson(this);
}

enum StatusCode {
  @JsonValue(200, aliases: [201, 202])
  success,
  @JsonValue(301)
  movedPermanently,
  @JsonValue(302)
  found,
  @JsonValue(500)
  internalServerError,
}

@JsonEnum(valueField: 'code')
enum StatusCode2 {
  success(200),
  movedPermanently(301),
  found(302),
  internalServerError(500);

  const StatusCode2(this.code);

  final int code;
}

@JsonEnum(valueField: 'code')
enum StatusCode3 {
  success(200),
  movedPermanently(301),
  @JsonValue(1000)
  found(302),
  internalServerError(500);

  const StatusCode3(this.code);

  final int code;
}
