// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'package:json_serializable/src/json_enum_generator.dart';
import 'package:json_serializable/src/json_serializable_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

const _sharedImports = [
  "import 'dart:convert';",
  "import 'package:json_annotation/json_annotation.dart';",
];

const _sharedPreamble = '''
enum FuzzStatus {
  active,
  paused,
  @JsonValue('custom_done')
  done,
}

enum FuzzNullValEnum {
  normal,
  @JsonValue(null)
  nullEncoded,
}

enum EnumIntVal {
  @JsonValue(10)
  a,
  @JsonValue(20)
  b,
}

@JsonEnum(valueField: 'getterV')
enum EnumGetterVal {
  a,
  b;

  int get getterV => index + 100;
}

@JsonEnum(valueField: 'name', fieldRename: FieldRename.kebab)
enum Audit38dEnum { firstVal, secondVal }

class EpochDateTimeConverter implements JsonConverter<DateTime, String> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(String json) =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(json), isUtc: true);

  @override
  String toJson(DateTime object) => object.millisecondsSinceEpoch.toString();
}

class EpochIntConverter implements JsonConverter<DateTime, int> {
  const EpochIntConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json, isUtc: true);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
''';

void main() {
  test('maps and enums fuzz regressions', () async {
    const cases = <CodegenCase>[
      CodegenCase(
        id: 'bug_map_datetime_key_ignores_utc',
        elementName: 'FuzzMapDateTimeUtc',
        declarations: r'''
@JsonSerializable(dateTimeUtc: true)
class FuzzMapDateTimeUtc {
  final Map<DateTime, int> events;

  FuzzMapDateTimeUtc({required this.events});

  factory FuzzMapDateTimeUtc.fromJson(Map<String, dynamic> json) =>
      _$FuzzMapDateTimeUtcFromJson(json);

  Map<String, dynamic> toJson() => _$FuzzMapDateTimeUtcToJson(this);
}
''',
        runtimeCheck: r'''
final localDt = DateTime(2025, 6, 15, 12, 30);
final instance = FuzzMapDateTimeUtc(events: {localDt: 1});
final json = instance.toJson();
final eventsMap = json['events'] as Map<String, dynamic>;
for (final key in eventsMap.keys) {
  if (!key.endsWith('Z')) {
    throw StateError(
      'Expected Map<DateTime, int> key to be UTC with dateTimeUtc: true, '
      'got $key',
    );
  }
}
final roundTripped = FuzzMapDateTimeUtc.fromJson(
  jsonDecode(jsonEncode(json)) as Map<String, dynamic>,
);
if (roundTripped.events[localDt.toUtc()] != 1) {
  throw StateError('Expected round-tripped value 1');
}
''',
      ),
      CodegenCase(
        id: 'issue1606_11b_map_key_custom_converter',
        elementName: 'MapWithCustomDateTimeKey',
        declarations: r'''
@JsonSerializable()
@EpochDateTimeConverter()
class MapWithCustomDateTimeKey {
  final Map<DateTime, int> items;

  MapWithCustomDateTimeKey(this.items);

  factory MapWithCustomDateTimeKey.fromJson(Map<String, dynamic> json) =>
      _$MapWithCustomDateTimeKeyFromJson(json);

  Map<String, dynamic> toJson() => _$MapWithCustomDateTimeKeyToJson(this);
}
''',
        runtimeCheck: r'''
final dt = DateTime.utc(2025, 1, 1);
final inst = MapWithCustomDateTimeKey({dt: 42});
final json = inst.toJson();
final mapJson = json['items'] as Map<String, dynamic>;
final expectedKey = dt.millisecondsSinceEpoch.toString();
if (!mapJson.containsKey(expectedKey)) {
  throw StateError(
    'Expected custom converter key $expectedKey, got ${mapJson.keys}',
  );
}
final decoded = MapWithCustomDateTimeKey.fromJson(
  jsonDecode(jsonEncode(json)) as Map<String, dynamic>,
);
if (decoded.items[dt] != 42) {
  throw StateError('Round-trip mismatch: ${decoded.items}');
}
''',
      ),
      CodegenCase(
        id: 'issue1606_12_int_enum_map_key_round_trip',
        elementName: 'EnumIntMapKey',
        declarations: r'''
@JsonSerializable()
class EnumIntMapKey {
  final Map<EnumIntVal, String> a;

  EnumIntMapKey(this.a);

  factory EnumIntMapKey.fromJson(Map<String, dynamic> json) =>
      _$EnumIntMapKeyFromJson(json);

  Map<String, dynamic> toJson() => _$EnumIntMapKeyToJson(this);
}
''',
        runtimeCheck: r'''
final inst = EnumIntMapKey({EnumIntVal.a: 'hello', EnumIntVal.b: 'world'});
final json = inst.toJson();
final directDecoded = EnumIntMapKey.fromJson(json);
if (directDecoded.a[EnumIntVal.a] != 'hello' ||
    directDecoded.a[EnumIntVal.b] != 'world') {
  throw StateError('Direct round-trip mismatch: ${directDecoded.a}');
}
final jsonDecoded = EnumIntMapKey.fromJson(
  jsonDecode(jsonEncode(json)) as Map<String, dynamic>,
);
if (jsonDecoded.a[EnumIntVal.a] != 'hello' ||
    jsonDecoded.a[EnumIntVal.b] != 'world') {
  throw StateError('JSON round-trip mismatch: ${jsonDecoded.a}');
}
''',
      ),
      CodegenCase(
        id: 'issue1606_13a_object_key_map_any_map_false',
        elementName: 'ObjectKeyMapFalse',
        declarations: r'''
@JsonSerializable(anyMap: false)
class ObjectKeyMapFalse {
  final Map<Object, double> a;

  ObjectKeyMapFalse(this.a);

  factory ObjectKeyMapFalse.fromJson(Map<String, dynamic> json) =>
      _$ObjectKeyMapFalseFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectKeyMapFalseToJson(this);
}
''',
        runtimeCheck: r'''
final inst = ObjectKeyMapFalse({'k': 1.5});
final decoded = ObjectKeyMapFalse.fromJson(inst.toJson());
if (decoded.a['k'] != 1.5) {
  throw StateError('Direct round-trip mismatch: ${decoded.a}');
}
final jsonDecoded = ObjectKeyMapFalse.fromJson(
  jsonDecode(jsonEncode(inst.toJson())) as Map<String, dynamic>,
);
if (jsonDecoded.a['k'] != 1.5) {
  throw StateError('JSON round-trip mismatch: ${jsonDecoded.a}');
}
''',
      ),
      CodegenCase(
        id: 'issue1606_13b_object_key_map_any_map_true',
        elementName: 'ObjectKeyMapTrue',
        declarations: r'''
@JsonSerializable(anyMap: true)
class ObjectKeyMapTrue {
  final Map<Object, int> a;

  ObjectKeyMapTrue(this.a);

  factory ObjectKeyMapTrue.fromJson(Map json) => _$ObjectKeyMapTrueFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectKeyMapTrueToJson(this);
}
''',
        runtimeCheck: r'''
final inst = ObjectKeyMapTrue({1: 42});
final decoded = ObjectKeyMapTrue.fromJson(inst.toJson());
if (decoded.a[1] != 42) {
  throw StateError('Expected 42 for key 1, got ${decoded.a}');
}
''',
      ),
      CodegenCase(
        id: 'issue1606_11c_map_key_non_string_converter_ignored_for_key',
        elementName: 'MapWithIntDateTimeConverter',
        declarations: r'''
@JsonSerializable()
@EpochIntConverter()
class MapWithIntDateTimeConverter {
  final Map<DateTime, DateTime> items;

  MapWithIntDateTimeConverter(this.items);

  factory MapWithIntDateTimeConverter.fromJson(Map<String, dynamic> json) =>
      _$MapWithIntDateTimeConverterFromJson(json);

  Map<String, dynamic> toJson() => _$MapWithIntDateTimeConverterToJson(this);
}
''',
        runtimeCheck: r'''
final k = DateTime.utc(2025, 1, 1);
final v = DateTime.utc(2025, 6, 1);
final inst = MapWithIntDateTimeConverter({k: v});
final json = jsonDecode(jsonEncode(inst.toJson())) as Map<String, dynamic>;
final decoded = MapWithIntDateTimeConverter.fromJson(json);
if (decoded.items[k] != v) {
  throw StateError('Expected ${ {k: v} }, got ${decoded.items}');
}
''',
      ),
      CodegenCase(
        id: 'bug_enum_with_null_json_value_and_default_round_trip',
        elementName: 'FuzzNullJsonValueWithDefaultHolder',
        declarations: r'''
@JsonSerializable()
class FuzzNullJsonValueWithDefaultHolder {
  final FuzzNullValEnum status;

  FuzzNullJsonValueWithDefaultHolder({
    this.status = FuzzNullValEnum.normal,
  });

  factory FuzzNullJsonValueWithDefaultHolder.fromJson(
    Map<String, dynamic> json,
  ) => _$FuzzNullJsonValueWithDefaultHolderFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FuzzNullJsonValueWithDefaultHolderToJson(this);
}
''',
        runtimeCheck: r'''
final nullInst = FuzzNullJsonValueWithDefaultHolder(
  status: FuzzNullValEnum.nullEncoded,
);
final encodedNull =
    jsonDecode(jsonEncode(nullInst.toJson())) as Map<String, dynamic>;
final decodedNull = FuzzNullJsonValueWithDefaultHolder.fromJson(encodedNull);
if (decodedNull.status != FuzzNullValEnum.nullEncoded) {
  throw StateError('Expected nullEncoded on explicit null, got ${decodedNull.status}');
}
final fromEmpty =
    FuzzNullJsonValueWithDefaultHolder.fromJson(<String, dynamic>{});
if (fromEmpty.status != FuzzNullValEnum.normal) {
  throw StateError('Expected default normal on missing key, got ${fromEmpty.status}');
}
''',
      ),
      CodegenCase(
        id: 'bug_enum_with_null_json_value_round_trip',
        elementName: 'FuzzNullJsonValueEnumHolder',
        declarations: r'''
@JsonSerializable()
class FuzzNullJsonValueEnumHolder {
  final FuzzNullValEnum status;

  FuzzNullJsonValueEnumHolder({required this.status});

  factory FuzzNullJsonValueEnumHolder.fromJson(Map<String, dynamic> json) =>
      _$FuzzNullJsonValueEnumHolderFromJson(json);

  Map<String, dynamic> toJson() => _$FuzzNullJsonValueEnumHolderToJson(this);
}
''',
        runtimeCheck: r'''
final instance = FuzzNullJsonValueEnumHolder(
  status: FuzzNullValEnum.nullEncoded,
);
final json = jsonDecode(jsonEncode(instance.toJson())) as Map<String, dynamic>;
if (!json.containsKey('status') || json['status'] != null) {
  throw StateError('Expected status: null in json, got $json');
}
final decoded = FuzzNullJsonValueEnumHolder.fromJson(json);
if (decoded.status != FuzzNullValEnum.nullEncoded) {
  throw StateError('Expected nullEncoded, got ${decoded.status}');
}
final normalInstance = FuzzNullJsonValueEnumHolder(
  status: FuzzNullValEnum.normal,
);
final normalDecoded = FuzzNullJsonValueEnumHolder.fromJson(
  jsonDecode(jsonEncode(normalInstance.toJson())) as Map<String, dynamic>,
);
if (normalDecoded.status != FuzzNullValEnum.normal) {
  throw StateError('Expected normal, got ${normalDecoded.status}');
}
''',
      ),
      CodegenCase(
        id: 'issue1606_09_enum_getter_value_field',
        elementName: 'EnumGetterValModel',
        declarations: r'''
@JsonSerializable()
class EnumGetterValModel {
  final EnumGetterVal a;

  EnumGetterValModel(this.a);
}
''',
        expectedError:
            '`JsonEnum.valueField` was set to "getterV", but that is not a '
            'valid, instance field on `EnumGetterVal`.',
      ),
      CodegenCase(
        id: 'audit_38d_json_enum_value_field_name_in_class',
        elementName: 'Audit38d',
        declarations: r'''
@JsonSerializable()
class Audit38d {
  final Audit38dEnum a;

  Audit38d(this.a);

  factory Audit38d.fromJson(Map<String, dynamic> json) =>
      _$Audit38dFromJson(json);

  Map<String, dynamic> toJson() => _$Audit38dToJson(this);
}
''',
        runtimeCheck: r'''
final inst = Audit38d(Audit38dEnum.firstVal);
final json = inst.toJson();
if (json['a'] != 'firstVal') {
  throw StateError('Expected firstVal, got ${json['a']}');
}
final decoded = Audit38d.fromJson(json);
if (decoded.a != Audit38dEnum.firstVal) {
  throw StateError('Expected Audit38dEnum.firstVal, got ${decoded.a}');
}
''',
      ),
      CodegenCase(
        id: 'neg_unknown_enum_on_int_field',
        elementName: 'BadUnknownEnumOnInt',
        declarations: r'''
@JsonSerializable()
class BadUnknownEnumOnInt {
  @JsonKey(unknownEnumValue: FuzzStatus.active)
  final int x;

  BadUnknownEnumOnInt({required this.x});
}
''',
        expectedError: 'unknownEnumValue',
      ),
    ];

    final report = await verifyGeneratorBatch(
      generator: JsonSerializableGenerator(),
      imports: _sharedImports,
      preamble: _sharedPreamble,
      cases: cases,
    );

    expect(report.passedCases, report.totalCases);
    expect(report.issues, isEmpty);

    const enumCases = <CodegenCase>[
      CodegenCase(
        id: 'audit_38d_json_enum_value_field_name',
        elementName: 'EnumValueFieldName',
        declarations: r'''
@JsonEnum(valueField: 'name', alwaysCreate: true)
enum EnumValueFieldName { alpha, beta }
''',
      ),
    ];

    final enumReport = await verifyGeneratorBatch(
      generator: const JsonEnumGenerator(),
      imports: _sharedImports,
      preamble: _sharedPreamble,
      cases: enumCases,
    );

    expect(enumReport.passedCases, enumReport.totalCases);
    expect(enumReport.issues, isEmpty);
  });
}
