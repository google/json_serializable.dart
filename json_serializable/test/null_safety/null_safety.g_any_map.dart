// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.10

import 'package:json_annotation/json_annotation.dart';

part 'null_safety.g_any_map.g.dart';

@JsonSerializable(
  anyMap: true,
)
class Person {
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;

  List<int?>? nullableListOfNullableInt;

  Person({
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
