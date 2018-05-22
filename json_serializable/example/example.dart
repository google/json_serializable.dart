// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides, hash_and_equals
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable(nullable: false)
class Person extends Object with _$PersonSerializerMixin {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  Person({this.firstName, this.lastName, this.dateOfBirth});
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
