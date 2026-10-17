// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_serializable/src/json_serializable_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

const _imports = [
  "import 'dart:convert';",
  "import 'package:json_annotation/json_annotation.dart';",
];

const _preamble = r'''
Object? value(int? x) => x;
int? fromPatchInt(Object? v) => (v as num?)?.toInt();

typedef IntCallback = int Function(int);

class IntCallbackConverter implements JsonConverter<IntCallback, String> {
  const IntCallbackConverter();
  @override
  IntCallback fromJson(String json) => (x) => x;
  @override
  String toJson(IntCallback object) => 'fn';
}
''';

void main() {
  test(
    'PatchTriStateHelper & promoteNonNullable fuzz regression cases',
    () async {
      const cases = <CodegenCase>[
        CodegenCase(
          id: 'bug_patch_tri_state_record_promote_non_nullable',
          elementName: 'PatchTriStateRecordCase',
          declarations: r'''
@JsonSerializable()
class PatchTriStateRecordCase {
  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final (int,)? rec;
  PatchTriStateRecordCase(this.rec);
  factory PatchTriStateRecordCase.fromJson(Map<String, dynamic> json) =>
      _$PatchTriStateRecordCaseFromJson(json);
  Map<String, dynamic> toJson() => _$PatchTriStateRecordCaseToJson(this);
}
''',
          runtimeCheck: r'''
final omitted = PatchTriStateRecordCase(null).toJson();
if (omitted.containsKey('rec')) {
  throw StateError('Expected rec to be omitted when null: $omitted');
}
final present = PatchTriStateRecordCase((7,)).toJson();
if ((present['rec'] as Map)[r'$1'] != 7) {
  throw StateError('Unexpected serialized record: $present');
}
final decodedNull = PatchTriStateRecordCase.fromJson({'rec': null});
if (decodedNull.rec != null) {
  throw StateError('Expected null rec, got: ${decodedNull.rec}');
}
''',
        ),
        CodegenCase(
          id: 'audit_34_function_type_promote_non_nullable_converter',
          elementName: 'NullableFunctionTypeConverterCase',
          declarations: r'''
@IntCallbackConverter()
@JsonSerializable()
class NullableFunctionTypeConverterCase {
  final IntCallback? callback;
  NullableFunctionTypeConverterCase(this.callback);
  factory NullableFunctionTypeConverterCase.fromJson(
    Map<String, dynamic> json,
  ) => _$NullableFunctionTypeConverterCaseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$NullableFunctionTypeConverterCaseToJson(this);
}
''',
          runtimeCheck: r'''
final encodedNull = NullableFunctionTypeConverterCase(null).toJson();
if (encodedNull['callback'] != null) {
  throw StateError('Expected null callback, got: $encodedNull');
}
final decodedNull = NullableFunctionTypeConverterCase.fromJson(encodedNull);
if (decodedNull.callback != null) {
  throw StateError('Expected decoded null callback');
}
final inst = NullableFunctionTypeConverterCase((x) => x + 1);
final encodedFn = inst.toJson();
if (encodedFn['callback'] != 'fn') {
  throw StateError('Expected "fn", got: $encodedFn');
}
final decodedFn = NullableFunctionTypeConverterCase.fromJson(encodedFn);
if (decodedFn.callback!(5) != 5) {
  throw StateError('Unexpected callback result');
}
''',
        ),
        CodegenCase(
          id: 'bug_patch_tri_state_generic_factory_swallows_null',
          elementName: 'PatchTriStateGenericCase',
          declarations: r'''
@JsonSerializable(genericArgumentFactories: true)
class PatchTriStateGenericCase<T> {
  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final T? item;
  PatchTriStateGenericCase(this.item);
  factory PatchTriStateGenericCase.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PatchTriStateGenericCaseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PatchTriStateGenericCaseToJson(this, toJsonT);
}
''',
          runtimeCheck: r'''
final decodedNull = PatchTriStateGenericCase<int>.fromJson(
  <String, dynamic>{'item': null},
  (v) => v == null ? -1 : (v as num).toInt(),
);
if (decodedNull.item != -1) {
  throw StateError('Expected explicit null to invoke fromJsonT(null)');
}
final decodedAbsent = PatchTriStateGenericCase<int>.fromJson(
  <String, dynamic>{},
  (v) => throw StateError('Should not be called when absent'),
);
if (decodedAbsent.item != null) {
  throw StateError('Expected absent key to decode as null');
}
''',
        ),
        CodegenCase(
          id: 'bug_patch_tri_state_datetime_null_throws',
          elementName: 'PatchTriStateDateTimeCase',
          declarations: r'''
@JsonSerializable()
class PatchTriStateDateTimeCase {
  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final DateTime? updatedAt;
  PatchTriStateDateTimeCase(this.updatedAt);
  factory PatchTriStateDateTimeCase.fromJson(Map<String, dynamic> json) =>
      _$PatchTriStateDateTimeCaseFromJson(json);
  Map<String, dynamic> toJson() => _$PatchTriStateDateTimeCaseToJson(this);
}
''',
          runtimeCheck: r'''
final decoded = PatchTriStateDateTimeCase.fromJson(
  <String, dynamic>{'updatedAt': null},
);
if (decoded.updatedAt != null) {
  throw StateError('Expected null, got: ${decoded.updatedAt}');
}
final dt = DateTime.utc(2026, 5, 10, 12, 30);
final roundTrip = PatchTriStateDateTimeCase.fromJson(
  PatchTriStateDateTimeCase(dt).toJson(),
);
if (roundTrip.updatedAt != dt) {
  throw StateError('Expected $dt, got: ${roundTrip.updatedAt}');
}
''',
        ),
        CodegenCase(
          id: 'issue1606_04b_patch_to_json_shadow_value',
          elementName: 'PatchToJsonShadowValue',
          declarations: r'''
@JsonSerializable()
class PatchToJsonShadowValue {
  @JsonKey(
    explicitJsonNullWhenNonNullField: true,
    fromJson: fromPatchInt,
    toJson: value,
  )
  final int? x;
  PatchToJsonShadowValue({this.x});
  factory PatchToJsonShadowValue.fromJson(Map<String, dynamic> json) =>
      _$PatchToJsonShadowValueFromJson(json);
  Map<String, dynamic> toJson() => _$PatchToJsonShadowValueToJson(this);
}
''',
          runtimeCheck: r'''
final encoded = PatchToJsonShadowValue(x: 42).toJson();
if (encoded['x'] != 42) {
  throw StateError('Expected 42, got: $encoded');
}
final omitted = PatchToJsonShadowValue().toJson();
if (omitted.containsKey('x')) {
  throw StateError('Expected x to be omitted: $omitted');
}
''',
        ),
      ];

      final report = await verifyGeneratorBatch(
        generator: JsonSerializableGenerator(),
        imports: _imports,
        preamble: _preamble,
        cases: cases,
      );

      expect(report.passedCases, report.totalCases);
      expect(report.issues, isEmpty);
    },
  );
}
