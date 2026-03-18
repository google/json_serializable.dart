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
''')
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
''')
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
JsonSchemaDefaultsTest _$JsonSchemaDefaultsTestFromJson(
  Map<String, dynamic> json,
) => JsonSchemaDefaultsTest(
  (json['propAnnotatedDefaultValue'] as num?)?.toInt() ?? 42,
  propCtorDefaultValue: (json['propCtorDefaultValue'] as num?)?.toInt() ?? 42,
);

const _$JsonSchemaDefaultsTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'propAnnotatedDefaultValue': {'type': 'integer', 'default': 42},
    'propCtorDefaultValue': {
      'type': 'integer',
      'description': 'Default value is still required',
      'default': 42,
    },
  },
};
''')
@JsonSerializable(createJsonSchema: true, createToJson: false)
class JsonSchemaDefaultsTest {
  @JsonKey(defaultValue: 42)
  final int propAnnotatedDefaultValue;

  /// Default value is still required
  final int propCtorDefaultValue;

  JsonSchemaDefaultsTest(
    this.propAnnotatedDefaultValue, {
    this.propCtorDefaultValue = 42,
  });
}

@ShouldGenerate(r'''
JsonSchemaNullableTest _$JsonSchemaNullableTestFromJson(
  Map<String, dynamic> json,
) => JsonSchemaNullableTest(json['nullableStillRequired'] as String?);

const _$JsonSchemaNullableTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'nullableStillRequired': {
      'type': 'string',
      'description': 'Nullable field is still required!',
    },
  },
  'required': ['nullableStillRequired'],
};
''')
@JsonSerializable(createJsonSchema: true, createToJson: false)
class JsonSchemaNullableTest {
  /// Nullable field is still required!
  final String? nullableStillRequired;

  JsonSchemaNullableTest(this.nullableStillRequired);
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
''')
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

@ShouldGenerate(r'''
const _$JsonSchemaNonCollectionTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'intField': {'type': 'integer'},
    'doubleField': {'type': 'number'},
    'numField': {'type': 'number'},
    'boolField': {'type': 'boolean'},
    'stringField': {'type': 'string'},
    'dateTimeField': {'type': 'string', 'format': 'date-time'},
    'uriField': {'type': 'string', 'format': 'uri'},
    'bigIntField': {'type': 'integer'},
  },
};
''')
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaNonCollectionTest {
  final int? intField;
  final double? doubleField;
  final num? numField;
  final bool? boolField;
  final String? stringField;
  final DateTime? dateTimeField;
  final Uri? uriField;
  final BigInt? bigIntField;

  JsonSchemaNonCollectionTest({
    this.intField,
    this.doubleField,
    this.numField,
    this.boolField,
    this.stringField,
    this.dateTimeField,
    this.uriField,
    this.bigIntField,
  });
}

@ShouldGenerate(r'''
const _$JsonSchemaGetterTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'renamed_name': {'type': 'string'},
  },
  'required': ['renamed_name'],
};
''')
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaGetterTest {
  @JsonKey(name: 'renamed_name')
  final String name;

  // This getter should NOT be in the schema
  int get length => name.length;

  JsonSchemaGetterTest(this.name);
}

@ShouldGenerate(r'''
const _$JsonSchemaRecursiveListTestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'children': {
      'type': 'array',
      'items': {r'$ref': '#'},
    },
  },
  'required': ['children'],
};
''')
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaRecursiveListTest {
  final List<JsonSchemaRecursiveListTest> children;

  JsonSchemaRecursiveListTest(this.children);
}

@ShouldGenerate(r'''
const _$JsonSchemaRecursiveListIssueJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'alternates': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/JsonSchemaRecursiveListIssueA'},
    },
  },
  'required': ['alternates'],
  r'$defs': {
    'JsonSchemaRecursiveListIssueA': {
      'type': 'object',
      'properties': {
        'children': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/JsonSchemaRecursiveListIssueA'},
        },
      },
      'required': ['children'],
    },
  },
};
''')
@JsonSerializable(
  createJsonSchema: true,
  createFactory: false,
  createToJson: false,
)
class JsonSchemaRecursiveListIssue {
  final List<JsonSchemaRecursiveListIssueA> alternates;

  JsonSchemaRecursiveListIssue(this.alternates);
}

class JsonSchemaRecursiveListIssueA {
  final List<JsonSchemaRecursiveListIssueA> children;

  JsonSchemaRecursiveListIssueA(this.children);
}
