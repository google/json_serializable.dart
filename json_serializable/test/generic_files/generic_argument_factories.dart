// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'generic_argument_factories.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericClassWithHelpers<T, S> {
  final T value;

  final List<T> list;

  final Set<S> someSet;

  GenericClassWithHelpers(
    this.value,
    this.list,
    this.someSet,
  );

  factory GenericClassWithHelpers.fromJson(
    Map<String, dynamic> json,
    T Function(Object json) helperForT,
    S Function(Object json) helperForS,
  ) =>
      _$GenericClassWithHelpersFromJson(json, helperForT, helperForS);

  Map<String, dynamic> toJson(
    Object Function(T value) helperForT,
    Object Function(S value) helperForS,
  ) =>
      _$GenericClassWithHelpersToJson(this, helperForT, helperForS);
}
