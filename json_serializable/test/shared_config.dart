// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/src/generator_config.dart';

const jsonSerializableFields = [
  'create_factory',
  'create_to_json',
  'disallow_unrecognized_keys',
  'include_if_null',
  'nullable',
  'field_rename',
];

final generatorConfigDefaultJson =
    Map<String, dynamic>.unmodifiable(const GeneratorConfig().toJson());

final generatorConfigNonDefaultJson = Map<String, dynamic>.unmodifiable(
    const GeneratorConfig(
            createFactory: false,
            fieldRename: FieldRename.kebab,
            disallowUnrecognizedKeys: true,
            nullable: false,
            includeIfNull: false,
            createToJson: false,
            useWrappers: true,
            explicitToJson: true,
            generateToJsonFunction: false,
            checked: true,
            anyMap: true)
        .toJson());
