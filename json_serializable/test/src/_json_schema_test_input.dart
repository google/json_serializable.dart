// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
const _$JsonSchemaDocsTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'name': {'type': 'string', 'description': 'The name of the item'},
  },
  'required': ['name'],
};
''', contains: true)
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaDocsTest {
  /// The name of the item
  final String name;

  JsonSchemaDocsTest(this.name);
}

@ShouldGenerate(r'''
const _$JsonSchemaCollectionsTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'tags': {
      'type': 'array',
      'items': {'type': 'string'},
    },
    'metadata': {
      'type': 'object',
      'additionalProperties': {'type': 'integer'},
    },
  },
  'required': ['tags', 'metadata'],
};
''', contains: true)
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaCollectionsTest {
  final List<String> tags;
  final Map<String, int> metadata;

  JsonSchemaCollectionsTest(this.tags, this.metadata);
}

@ShouldGenerate(r'''
const _$JsonSchemaDefaultsTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'count': {'type': 'integer', 'default': 42},
  },
  'required': ['count'],
};
''', contains: true)
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaDefaultsTest {
  @JsonKey(defaultValue: 42)
  final int count;

  JsonSchemaDefaultsTest(this.count);
}

@ShouldGenerate(r'''
const _$JsonSchemaNullableTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'description': {'type': 'string'},
  },
};
''', contains: true)
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaNullableTest {
  final String? description;

  JsonSchemaNullableTest(this.description);
}

@ShouldGenerate(r'''
const _$JsonSchemaNestedTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'inner': {r'$ref': r'#/$defs/InnerClass'},
  },
  'required': ['inner'],
  r'$defs': {
    'InnerClass': {
      'type': 'object',
      'properties': {
        'value': {'type': 'integer'},
      },
      'required': ['value'],
    },
  },
};
''', contains: true)
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaNestedTest {
  final InnerClass inner;

  JsonSchemaNestedTest(this.inner);
}

@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class InnerClass {
  final int value;

  InnerClass(this.value);
}
