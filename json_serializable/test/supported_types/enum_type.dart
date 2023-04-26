// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

enum EnumType { alpha, beta, gamma, delta }

class FromJsonDynamicParam {
  FromJsonDynamicParam({required this.value});

  final int value;

  factory FromJsonDynamicParam.fromJson(dynamic json) =>
      FromJsonDynamicParam(value: json as int);

  dynamic toJson() => null;
}

class FromJsonNullableObjectParam {
  FromJsonNullableObjectParam({required this.value});

  final int value;

  factory FromJsonNullableObjectParam.fromJson(Object? json) =>
      FromJsonNullableObjectParam(value: json as int);

  Object? toJson() => null;
}

class FromJsonObjectParam {
  FromJsonObjectParam({required this.value});

  final int value;

  factory FromJsonObjectParam.fromJson(Object json) =>
      FromJsonObjectParam(value: json as int);

  dynamic toJson() => null;
}
