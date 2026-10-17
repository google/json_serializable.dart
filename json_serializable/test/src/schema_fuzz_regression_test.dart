// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_serializable/src/json_serializable_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

const _imports = ["import 'package:json_annotation/json_annotation.dart';"];

const _preamble = '''
enum FuzzStatus {
  active,
  paused,
  @JsonValue('custom_done')
  done,
}

FuzzStatus defaultFuzzStatus() => FuzzStatus.active;
int defaultIntVal() => 7;
''';

const _cases = <CodegenCase>[
  CodegenCase(
    id: 'bug_schema_non_empty_list_default',
    elementName: 'SchemaNonEmptyListDefaultCase',
    declarations: r'''
@JsonSerializable(createJsonSchema: true)
class SchemaNonEmptyListDefaultCase {
  final List<int> items;
  SchemaNonEmptyListDefaultCase({this.items = const [1, 2]});
  factory SchemaNonEmptyListDefaultCase.fromJson(Map<String, dynamic> json) =>
      _$SchemaNonEmptyListDefaultCaseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SchemaNonEmptyListDefaultCaseToJson(this);
  static Map<String, Object?> get schema =>
      _$SchemaNonEmptyListDefaultCaseJsonSchema;
}
''',
    runtimeCheck: r'''
final props = SchemaNonEmptyListDefaultCase.schema['properties'] as Map;
final itemsSchema = props['items'] as Map;
final def = itemsSchema['default'];
if (def is! List || def.length != 2 || def[0] != 1 || def[1] != 2) {
  throw StateError('Expected default [1, 2], got: $itemsSchema');
}
''',
  ),
  CodegenCase(
    id: 'bug_schema_non_empty_map_default',
    elementName: 'SchemaNonEmptyMapDefaultCase',
    declarations: r'''
@JsonSerializable(createJsonSchema: true)
class SchemaNonEmptyMapDefaultCase {
  final Map<String, int> counts;
  SchemaNonEmptyMapDefaultCase({this.counts = const {'a': 1}});
  factory SchemaNonEmptyMapDefaultCase.fromJson(Map<String, dynamic> json) =>
      _$SchemaNonEmptyMapDefaultCaseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SchemaNonEmptyMapDefaultCaseToJson(this);
  static Map<String, Object?> get schema =>
      _$SchemaNonEmptyMapDefaultCaseJsonSchema;
}
''',
    runtimeCheck: r'''
final props = SchemaNonEmptyMapDefaultCase.schema['properties'] as Map;
final countsSchema = props['counts'] as Map;
final def = countsSchema['default'];
if (def is! Map || def['a'] != 1) {
  throw StateError('Expected default {a: 1}, got: $countsSchema');
}
''',
  ),
  CodegenCase(
    id: 'bug_schema_enum_function_default',
    elementName: 'SchemaEnumFuncDefaultCase',
    declarations: r'''
@JsonSerializable(createJsonSchema: true)
class SchemaEnumFuncDefaultCase {
  @JsonKey(defaultValue: defaultFuzzStatus)
  final FuzzStatus status;
  SchemaEnumFuncDefaultCase(this.status);
  factory SchemaEnumFuncDefaultCase.fromJson(Map<String, dynamic> json) =>
      _$SchemaEnumFuncDefaultCaseFromJson(json);
  Map<String, dynamic> toJson() => _$SchemaEnumFuncDefaultCaseToJson(this);
  static Map<String, Object?> get schema =>
      _$SchemaEnumFuncDefaultCaseJsonSchema;
}
''',
    runtimeCheck: r'''
final props = SchemaEnumFuncDefaultCase.schema['properties'] as Map;
final statusSchema = props['status'] as Map;
if (statusSchema.containsKey('default')) {
  throw StateError(
    'Expected function tear-off default to be omitted, got: $statusSchema',
  );
}
''',
  ),
  CodegenCase(
    id: 'bug_schema_num_with_int_default',
    elementName: 'SchemaNumIntDefaultCase',
    declarations: r'''
@JsonSerializable(createJsonSchema: true)
class SchemaNumIntDefaultCase {
  final num score;
  SchemaNumIntDefaultCase({this.score = 10});
  factory SchemaNumIntDefaultCase.fromJson(Map<String, dynamic> json) =>
      _$SchemaNumIntDefaultCaseFromJson(json);
  Map<String, dynamic> toJson() => _$SchemaNumIntDefaultCaseToJson(this);
  static Map<String, Object?> get schema =>
      _$SchemaNumIntDefaultCaseJsonSchema;
}
''',
    runtimeCheck: r'''
final props = SchemaNumIntDefaultCase.schema['properties'] as Map;
final scoreSchema = props['score'] as Map;
if (scoreSchema['default'] != 10) {
  throw StateError('Expected default 10 for num field, got: $scoreSchema');
}
''',
  ),
  CodegenCase(
    id: 'bug_schema_set_default_value',
    elementName: 'SchemaSetDefaultCase',
    declarations: r'''
@JsonSerializable(createJsonSchema: true)
class SchemaSetDefaultCase {
  final Set<int> tags;
  SchemaSetDefaultCase({this.tags = const {1, 2}});
  factory SchemaSetDefaultCase.fromJson(Map<String, dynamic> json) =>
      _$SchemaSetDefaultCaseFromJson(json);
  Map<String, dynamic> toJson() => _$SchemaSetDefaultCaseToJson(this);
  static Map<String, Object?> get schema => _$SchemaSetDefaultCaseJsonSchema;
}
''',
    runtimeCheck: r'''
final props = SchemaSetDefaultCase.schema['properties'] as Map;
final tagsSchema = props['tags'] as Map;
final def = tagsSchema['default'];
if (def is! List || def.length != 2 || def[0] != 1 || def[1] != 2) {
  throw StateError('Expected Set default [1, 2] in schema, got: $tagsSchema');
}
''',
  ),
  CodegenCase(
    id: 'bug_schema_int_function_default',
    elementName: 'SchemaIntFuncDefaultCase',
    declarations: r'''
@JsonSerializable(createJsonSchema: true)
class SchemaIntFuncDefaultCase {
  @JsonKey(defaultValue: defaultIntVal)
  final int count;
  SchemaIntFuncDefaultCase(this.count);
  factory SchemaIntFuncDefaultCase.fromJson(Map<String, dynamic> json) =>
      _$SchemaIntFuncDefaultCaseFromJson(json);
  Map<String, dynamic> toJson() => _$SchemaIntFuncDefaultCaseToJson(this);
  static Map<String, Object?> get schema =>
      _$SchemaIntFuncDefaultCaseJsonSchema;
}
''',
    runtimeCheck: r'''
final props = SchemaIntFuncDefaultCase.schema['properties'] as Map;
final countSchema = props['count'] as Map;
if (countSchema.containsKey('default')) {
  throw StateError('Function defaultValue emitted default: $countSchema');
}
''',
  ),
  CodegenCase(
    id: 'bug_schema_nullable_self_ref',
    elementName: 'SelfNode',
    declarations: r'''
@JsonSerializable(createJsonSchema: true)
class SelfNode {
  final String id;
  final SelfNode? next;
  SelfNode(this.id, this.next);
  factory SelfNode.fromJson(Map<String, dynamic> json) =>
      _$SelfNodeFromJson(json);
  Map<String, dynamic> toJson() => _$SelfNodeToJson(this);
  static Map<String, Object?> get schema => _$SelfNodeJsonSchema;
}
''',
    runtimeCheck: r'''
final props = SelfNode.schema['properties'] as Map;
final nextSchema = props['next'] as Map;
if (nextSchema[r'$ref'] != '#' || SelfNode.schema.containsKey(r'$defs')) {
  throw StateError('Expected self-ref # for SelfNode?, got: ${SelfNode.schema}');
}
''',
  ),
  CodegenCase(
    id: 'issue1606_22c_schema_leaks_private_mutable_field',
    elementName: 'SchemaPrivateFieldLeak',
    declarations: r'''
@JsonSerializable(createJsonSchema: true)
class SchemaPrivateFieldLeak {
  final int publicId;
  int _privateCache = 0;
  SchemaPrivateFieldLeak(this.publicId);
  int get cache => _privateCache;
  factory SchemaPrivateFieldLeak.fromJson(Map<String, dynamic> json) =>
      _$SchemaPrivateFieldLeakFromJson(json);
  Map<String, dynamic> toJson() => _$SchemaPrivateFieldLeakToJson(this);
  static Map<String, Object?> get schema => _$SchemaPrivateFieldLeakJsonSchema;
}
''',
    runtimeCheck: r'''
final props = SchemaPrivateFieldLeak.schema['properties'] as Map;
if (props.containsKey('_privateCache') || !props.containsKey('publicId')) {
  throw StateError('Private field _privateCache leaked into schema: $props');
}
''',
  ),
];

void main() {
  test(
    'SchemaHelper fuzz regression cases pass verifyGeneratorBatch',
    () async {
      final report = await verifyGeneratorBatch(
        generator: JsonSerializableGenerator(),
        imports: _imports,
        preamble: _preamble,
        cases: _cases,
      );

      expect(report.issues, isEmpty, reason: formatCodegenBatchReport(report));
      expect(report.passedCases, _cases.length);
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
