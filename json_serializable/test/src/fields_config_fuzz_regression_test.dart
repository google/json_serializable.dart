// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'package:json_serializable/src/json_serializable_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

const _imports = [
  "import 'dart:convert';",
  "import 'package:json_annotation/json_annotation.dart';",
];

const _preamble = '''
class BaseWithJsonKey {
  @JsonKey(name: 'renamed_x')
  Object? x;
  BaseWithJsonKey([this.x]);
}

class BaseMultiLevel {
  @JsonKey(name: 'when', defaultValue: 3)
  final num n;
  BaseMultiLevel([this.n = 3]);
}

class MiddleMultiLevel extends BaseMultiLevel {
  @override
  final int n;
  MiddleMultiLevel([this.n = 3]) : super(n);
}

class BaseWithGetterSetter {
  int _prop = 0;
  int get prop => _prop;
  set prop(int v) => _prop = v;
}
''';

const _cases = <CodegenCase>[
  // 1. Subclass overriding @JsonKey superclass field narrows type to DateTime
  CodegenCase(
    id: 'issue1606_05a_sub_narrowed_datetime',
    elementName: 'SubNarrowedDateTime',
    declarations: r'''
@JsonSerializable()
class SubNarrowedDateTime extends BaseWithJsonKey {
  @override
  final DateTime x;
  SubNarrowedDateTime(this.x) : super(x);
  factory SubNarrowedDateTime.fromJson(Map<String, dynamic> json) =>
      _$SubNarrowedDateTimeFromJson(json);
  Map<String, dynamic> toJson() => _$SubNarrowedDateTimeToJson(this);
}
''',
    runtimeCheck: r'''
final dt = DateTime.utc(2026, 1, 1);
final encoded = jsonDecode(jsonEncode(SubNarrowedDateTime(dt).toJson()))
    as Map<String, dynamic>;
final decoded = SubNarrowedDateTime.fromJson(encoded);
if (decoded.x != dt) throw StateError('Expected $dt, got ${decoded.x}');
''',
  ),
  // 1b. Two-level override chain (Base -> Middle -> Leaf) preserves Base
  // @JsonKey.
  CodegenCase(
    id: 'issue1606_05c_multi_level_override_chain',
    elementName: 'LeafMultiLevel',
    declarations: r'''
@JsonSerializable()
class LeafMultiLevel extends MiddleMultiLevel {
  @override
  final int n;
  LeafMultiLevel(this.n) : super(n);
  factory LeafMultiLevel.fromJson(Map<String, dynamic> json) =>
      _$LeafMultiLevelFromJson(json);
  Map<String, dynamic> toJson() => _$LeafMultiLevelToJson(this);
}
''',
    runtimeCheck: r'''
final encoded = LeafMultiLevel(42).toJson();
if (encoded['when'] != 42) {
  throw StateError('Expected key "when": 42, got $encoded');
}
final fromEmpty = LeafMultiLevel.fromJson(<String, dynamic>{});
if (fromEmpty.n != 3) {
  throw StateError('Expected default 3, got ${fromEmpty.n}');
}
''',
  ),
  // 2. Subclass overriding only setter of inherited getter/setter
  CodegenCase(
    id: 'issue1606_05b_sub_override_setter_only',
    elementName: 'SubOverrideSetterOnly',
    declarations: r'''
@JsonSerializable()
class SubOverrideSetterOnly extends BaseWithGetterSetter {
  SubOverrideSetterOnly();
  @override
  set prop(int v) => super.prop = v;
  factory SubOverrideSetterOnly.fromJson(Map<String, dynamic> json) =>
      _$SubOverrideSetterOnlyFromJson(json);
  Map<String, dynamic> toJson() => _$SubOverrideSetterOnlyToJson(this);
}
''',
    runtimeCheck: r'''
final inst = SubOverrideSetterOnly()..prop = 42;
final encoded = inst.toJson();
if (encoded['prop'] != 42) {
  throw StateError('Setter-overridden prop dropped from toJson: $encoded');
}
''',
  ),
  // 3. createFactory: false drops includeFromJson: false, includeToJson: true
  CodegenCase(
    id: 'issue1606_06_create_factory_false_include_to_json',
    elementName: 'CreateFactoryFalseIncludeToJson',
    declarations: r'''
@JsonSerializable(createFactory: false)
class CreateFactoryFalseIncludeToJson {
  @JsonKey(includeFromJson: false, includeToJson: true)
  final int x;
  CreateFactoryFalseIncludeToJson(this.x);
  Map<String, dynamic> toJson() => _$CreateFactoryFalseIncludeToJsonToJson(this);
}
''',
    runtimeCheck: r'''
final encoded = CreateFactoryFalseIncludeToJson(7).toJson();
if (encoded['x'] != 7) {
  throw StateError('Expected x: 7 in toJson(), got $encoded');
}
''',
  ),
  // 4. genericArgumentFactories + includeIfNull: false on bare T
  CodegenCase(
    id: 'issue1606_07_omit_null_generic_box',
    elementName: 'OmitNullGenericBox',
    declarations: r'''
@JsonSerializable(genericArgumentFactories: true, includeIfNull: false)
class OmitNullGenericBox<T> {
  final T value;
  OmitNullGenericBox(this.value);
  factory OmitNullGenericBox.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$OmitNullGenericBoxFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$OmitNullGenericBoxToJson(this, toJsonT);
}
''',
    runtimeCheck: r'''
final encoded = OmitNullGenericBox<int?>(null).toJson((v) => v);
if (encoded.containsKey('value')) {
  throw StateError('Expected null value to be omitted, got $encoded');
}
''',
  ),
  // 5. @override int get hashCode with createFactory: false,
  // createJsonKeys: true, createPerFieldToJson: true
  CodegenCase(
    id: 'issue1606_23_override_hash_code_create_factory_false',
    elementName: 'ValueClassWithHashCode',
    declarations: r'''
@JsonSerializable(
  createFactory: false,
  createJsonKeys: true,
  createPerFieldToJson: true,
)
class ValueClassWithHashCode {
  final int id;
  const ValueClassWithHashCode(this.id);
  Map<String, dynamic> toJson() => _$ValueClassWithHashCodeToJson(this);

  @override
  int get hashCode => id.hashCode;
}
''',
  ),
  // 6. Multiple fromJson fields reading the same JSON key when one sets
  // includeToJson: false (https://github.com/google/json_serializable.dart/issues/1622)
  CodegenCase(
    id: 'issue1622_duplicate_from_json_keys_with_include_to_json_false',
    elementName: 'DuplicateFromJsonKeys',
    declarations: r'''
int _countItems(List<dynamic>? items) => items?.length ?? 0;

@JsonSerializable(
  disallowUnrecognizedKeys: true,
  checked: true,
)
class DuplicateFromJsonKeys {
  final List<String> items;

  @JsonKey(
    name: 'items',
    fromJson: _countItems,
    includeToJson: false,
    required: true,
    disallowNullValue: true,
  )
  final int receivedCount;

  DuplicateFromJsonKeys({
    this.items = const [],
    this.receivedCount = 0,
  });

  factory DuplicateFromJsonKeys.fromJson(Map<String, dynamic> json) =>
      _$DuplicateFromJsonKeysFromJson(json);

  Map<String, dynamic> toJson() => _$DuplicateFromJsonKeysToJson(this);
}
''',
    runtimeCheck: r'''
final decoded = DuplicateFromJsonKeys.fromJson({
  'items': ['a', 'b', 'c'],
});
if (decoded.items.length != 3 || decoded.receivedCount != 3) {
  throw StateError(
    'Expected 3 items and receivedCount=3, got ${decoded.items} / ${decoded.receivedCount}',
  );
}
final encoded = decoded.toJson();
if (encoded.keys.single != 'items') {
  throw StateError('Expected only items key in toJson(), got $encoded');
}
''',
  ),
  // 7. Field named `Object` with createPerFieldToJson: true shadows Object?
  CodegenCase(
    id: 'issue1606_25b_per_field_to_json_shadows_object',
    elementName: 'PerFieldShadowObject',
    declarations: r'''
@JsonSerializable(createPerFieldToJson: true)
class PerFieldShadowObject {
  @JsonKey(name: 'obj')
  final String Object;
  PerFieldShadowObject(this.Object);
  factory PerFieldShadowObject.fromJson(Map<String, dynamic> json) =>
      _$PerFieldShadowObjectFromJson(json);
  Map<String, dynamic> toJson() => _$PerFieldShadowObjectToJson(this);
}
''',
  ),
  // 8. disallowUnrecognizedKeys: true allows keys with includeToJson: true
  CodegenCase(
    id: 'audit_37_disallow_unrecognized_keys_include_from_json_false',
    elementName: 'DisallowUnrecognizedIncludeFromJsonFalse',
    declarations: r'''
@JsonSerializable(disallowUnrecognizedKeys: true)
class DisallowUnrecognizedIncludeFromJsonFalse {
  final int id;
  @JsonKey(includeFromJson: false, includeToJson: true)
  int get computed => id * 2;
  DisallowUnrecognizedIncludeFromJsonFalse(this.id);
  factory DisallowUnrecognizedIncludeFromJsonFalse.fromJson(
    Map<String, dynamic> json,
  ) => _$DisallowUnrecognizedIncludeFromJsonFalseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$DisallowUnrecognizedIncludeFromJsonFalseToJson(this);
}
''',
    runtimeCheck: r'''
final inst = DisallowUnrecognizedIncludeFromJsonFalse(5);
final decoded = DisallowUnrecognizedIncludeFromJsonFalse.fromJson(inst.toJson());
if (decoded.id != 5) throw StateError('Mismatch');
''',
  ),
];

void main() {
  test(
    'field discovery, inheritance, and class config fuzz regressions',
    () async {
      final report = await verifyGeneratorBatch(
        generator: JsonSerializableGenerator(),
        imports: _imports,
        preamble: _preamble,
        cases: _cases,
      );
      expect(report.issues, isEmpty);
      expect(report.passedCases, _cases.length);
    },
  );
}
