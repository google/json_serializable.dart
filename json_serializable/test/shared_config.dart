// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

final jsonSerializableFields = generatorConfigDefaultJson.keys.toList();

final generatorConfigDefaultJson = Map<String, dynamic>.unmodifiable(
    const JsonSerializable().withDefaults().toJson());

final generatorConfigNonDefaultJson =
    Map<String, dynamic>.unmodifiable(const JsonSerializable(
  anyMap: true,
  checked: true,
  createFactory: false,
  createToJson: false,
  disallowUnrecognizedKeys: true,
  explicitToJson: true,
  fieldRename: FieldRename.kebab,
  includeIfNull: false,
  nullable: false,
).toJson());

// TODO(kevmoo): remove all of this logic once json_annotation v3 exists
void expectMapMatchExcludingDeprecated(
    Map<String, dynamic> actual, Map<String, dynamic> expected) {
  Map<String, dynamic> exclude(Map<String, dynamic> source) => Map.fromEntries(
      source.entries.where((e) => !deprecatedKeys.contains(e.key)));

  expect(
    exclude(actual),
    exclude(expected),
  );
}

const deprecatedKeys = {
  'encode_empty_collection',
  'generate_to_json_function',
  'use_wrappers',
};
