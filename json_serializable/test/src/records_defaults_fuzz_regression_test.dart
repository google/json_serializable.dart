// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'package:json_serializable/src/json_serializable_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

const _imports = [
  "import 'dart:convert';",
  "import 'package:collection/collection.dart';",
  "import 'package:json_annotation/json_annotation.dart';",
];

const _preamble = r'''
const bool kCondTrue = true;
''';

List<CodegenCase>
_buildRecordsAndDefaultsRegressionCases() => const <CodegenCase>[
  // 1a: Conditional expression (? :) in bool constructor default
  CodegenCase(
    id: 'issue1606_01a_ctor_conditional_bool',
    elementName: 'CtorConditionalBool',
    declarations: r'''
@JsonSerializable()
class CtorConditionalBool {
  final bool flag;
  CtorConditionalBool({this.flag = kCondTrue ? false : true});
  factory CtorConditionalBool.fromJson(Map<String, dynamic> json) =>
      _$CtorConditionalBoolFromJson(json);
  Map<String, dynamic> toJson() => _$CtorConditionalBoolToJson(this);
}
''',
    runtimeCheck: r'''
final decoded = CtorConditionalBool.fromJson({'flag': true});
if (!decoded.flag) {
  throw StateError('Expected true, got false due to unparenthesized ?? vs ?:');
}
final fromEmpty = CtorConditionalBool.fromJson(<String, dynamic>{});
if (fromEmpty.flag) {
  throw StateError('Expected default false, got true');
}
''',
  ),
  // 1b: Conditional expression (? :) in int constructor default
  CodegenCase(
    id: 'issue1606_01b_ctor_conditional_int',
    elementName: 'CtorConditionalInt',
    declarations: r'''
@JsonSerializable()
class CtorConditionalInt {
  final int x;
  CtorConditionalInt({this.x = kCondTrue ? 10 : 20});
  factory CtorConditionalInt.fromJson(Map<String, dynamic> json) =>
      _$CtorConditionalIntFromJson(json);
  Map<String, dynamic> toJson() => _$CtorConditionalIntToJson(this);
}
''',
    runtimeCheck: r'''
final decoded = CtorConditionalInt.fromJson({'x': 99});
if (decoded.x != 99) throw StateError('Expected 99, got ${decoded.x}');
final fromEmpty = CtorConditionalInt.fromJson(<String, dynamic>{});
if (fromEmpty.x != 10) throw StateError('Expected 10, got ${fromEmpty.x}');
''',
  ),
  // 2a: Nullable empty record when null
  CodegenCase(
    id: 'bug_nullable_empty_record_when_null',
    elementName: 'NullableEmptyRecordCase',
    declarations: r'''
@JsonSerializable()
class NullableEmptyRecordCase {
  final ()? emptyRec;
  NullableEmptyRecordCase(this.emptyRec);
  factory NullableEmptyRecordCase.fromJson(Map<String, dynamic> json) =>
      _$NullableEmptyRecordCaseFromJson(json);
  Map<String, dynamic> toJson() => _$NullableEmptyRecordCaseToJson(this);
}
''',
    runtimeCheck: r'''
final instance = NullableEmptyRecordCase(null);
final encoded = instance.toJson();
final decoded = NullableEmptyRecordCase.fromJson(encoded);
if (decoded.emptyRec != null) {
  throw StateError('Expected null emptyRec, got: ${decoded.emptyRec}');
}
final nonNullInstance = NullableEmptyRecordCase(());
final decodedNonNull =
    NullableEmptyRecordCase.fromJson(nonNullInstance.toJson());
if (decodedNonNull.emptyRec != ()) {
  throw StateError('Expected () emptyRec, got: ${decodedNonNull.emptyRec}');
}
''',
  ),
  // 2b: Nullable empty record with default value
  CodegenCase(
    id: 'bug_nullable_empty_record_with_default',
    elementName: 'NullableEmptyRecordDefaultCase',
    declarations: r'''
@JsonSerializable()
class NullableEmptyRecordDefaultCase {
  final ()? emptyRec;
  NullableEmptyRecordDefaultCase({this.emptyRec = ()});
  factory NullableEmptyRecordDefaultCase.fromJson(Map<String, dynamic> json) =>
      _$NullableEmptyRecordDefaultCaseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$NullableEmptyRecordDefaultCaseToJson(this);
}
''',
    runtimeCheck: r'''
final decoded = NullableEmptyRecordDefaultCase.fromJson(<String, dynamic>{});
if (decoded.emptyRec != ()) {
  throw StateError('Expected () default, got: ${decoded.emptyRec}');
}
''',
  ),
  // 3: Non-nullable record with default value
  CodegenCase(
    id: 'bug_non_nullable_record_with_default',
    elementName: 'RecordWithDefaultCase',
    declarations: r'''
@JsonSerializable()
class RecordWithDefaultCase {
  final (int, String) pair;
  RecordWithDefaultCase({this.pair = (42, 'hello')});
  factory RecordWithDefaultCase.fromJson(Map<String, dynamic> json) =>
      _$RecordWithDefaultCaseFromJson(json);
  Map<String, dynamic> toJson() => _$RecordWithDefaultCaseToJson(this);
}
''',
    runtimeCheck: r'''
final decoded = RecordWithDefaultCase.fromJson(<String, dynamic>{});
if (decoded.pair != (42, 'hello')) {
  throw StateError('Expected default (42, hello), got: ${decoded.pair}');
}
''',
  ),
  // 4: Single-positional Record constructor default const (7,) loses comma
  CodegenCase(
    id: 'issue1606_19_single_pos_record_ctor_default',
    elementName: 'SinglePosRecDefault',
    declarations: r'''
@JsonSerializable()
class SinglePosRecDefault {
  final (int,)? value;
  final (int,) cond;
  final (int,) parenCond;
  final List<(int,)> nestedList;
  const SinglePosRecDefault({
    this.value = const (7,),
    this.cond = kCondTrue ? (1,) : (2,),
    this.parenCond = (kCondTrue) ? (3,) : (4,),
    this.nestedList = const [(7,)],
  });
  factory SinglePosRecDefault.fromJson(Map<String, dynamic> json) =>
      _$SinglePosRecDefaultFromJson(json);
  Map<String, dynamic> toJson() => _$SinglePosRecDefaultToJson(this);
}
''',
    runtimeCheck: r'''
final decoded = SinglePosRecDefault.fromJson(<String, dynamic>{});
if (decoded.value != const (7,) ||
    decoded.cond != const (1,) ||
    decoded.parenCond != const (3,) ||
    decoded.nestedList.single != const (7,)) {
  throw StateError(
    'Unexpected defaults: ${decoded.value}, ${decoded.cond}, '
    '${decoded.parenCond}, ${decoded.nestedList}',
  );
}
''',
  ),
  // 5: @JsonKey(defaultValue: (1, 'a')) Record literal
  CodegenCase(
    id: 'issue1606_20a_json_key_default_record_literal',
    elementName: 'JsonKeyDefaultRecord',
    declarations: r'''
@JsonSerializable()
class JsonKeyDefaultRecord {
  @JsonKey(defaultValue: (1, 'a'))
  final (int, String) rec;
  const JsonKeyDefaultRecord(this.rec);
  factory JsonKeyDefaultRecord.fromJson(Map<String, dynamic> json) =>
      _$JsonKeyDefaultRecordFromJson(json);
  Map<String, dynamic> toJson() => _$JsonKeyDefaultRecordToJson(this);
}
''',
    runtimeCheck: r'''
final decoded = JsonKeyDefaultRecord.fromJson(<String, dynamic>{});
if (decoded.rec != (1, 'a')) {
  throw StateError('Expected (1, a), got: ${decoded.rec}');
}
''',
  ),
  // 6: @JsonKey(defaultValue: <int, String>{1: 'one'}) int-keyed Map literal
  CodegenCase(
    id: 'issue1606_20b_json_key_default_int_map_literal',
    elementName: 'JsonKeyDefaultIntMap',
    declarations: r'''
@JsonSerializable()
class JsonKeyDefaultIntMap {
  @JsonKey(defaultValue: <int, String>{1: 'one'})
  final Map<int, String> map;
  const JsonKeyDefaultIntMap(this.map);
  factory JsonKeyDefaultIntMap.fromJson(Map<String, dynamic> json) =>
      _$JsonKeyDefaultIntMapFromJson(json);
  Map<String, dynamic> toJson() => _$JsonKeyDefaultIntMapToJson(this);
}
''',
    runtimeCheck: r'''
final decoded = JsonKeyDefaultIntMap.fromJson(<String, dynamic>{});
if (decoded.map[1] != 'one') {
  throw StateError('Expected {1: one}, got: ${decoded.map}');
}
''',
  ),
  // 7: Nullable Record in List or PerFieldToJson avoids unnecessary `!`
  CodegenCase(
    id: 'issue1606_24_nullable_record_unnecessary_bang',
    elementName: 'NullableRecSerialize',
    declarations: r'''
@JsonSerializable(createPerFieldToJson: true)
class NullableRecSerialize {
  final (int, String)? direct;
  final List<(int, String)?> inList;
  const NullableRecSerialize(this.direct, this.inList);
  factory NullableRecSerialize.fromJson(Map<String, dynamic> json) =>
      _$NullableRecSerializeFromJson(json);
  Map<String, dynamic> toJson() => _$NullableRecSerializeToJson(this);
}
''',
    runtimeCheck: r'''
final inst = NullableRecSerialize((1, 'a'), [null, (2, 'b')]);
final decoded = NullableRecSerialize.fromJson(inst.toJson());
if (decoded.direct != (1, 'a') ||
    decoded.inList.first != null ||
    decoded.inList[1] != (2, 'b')) {
  throw StateError('Round-trip failed: ${decoded.toJson()}');
}
''',
  ),
];

void main() {
  test('records, default literals, and conditional defaults', () async {
    final cases = _buildRecordsAndDefaultsRegressionCases();
    expect(cases.length, 9);

    final report = await verifyGeneratorBatch(
      generator: JsonSerializableGenerator(),
      imports: _imports,
      preamble: _preamble,
      cases: cases,
    );

    expect(report.passedCases, report.totalCases);
    expect(report.issues, isEmpty);
  });
}
