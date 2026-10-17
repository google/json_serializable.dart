// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_serializable/src/json_serializable_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

const _sharedImports = [
  "import 'package:collection/collection.dart';",
  "import 'package:json_annotation/json_annotation.dart';",
];

const _sharedPreamble = '''
void check(bool condition, [String message = 'Check failed']) {
  if (!condition) {
    throw StateError(message);
  }
}

void checkEquals(Object? actual, Object? expected) {
  if (!const DeepCollectionEquality().equals(actual, expected)) {
    throw StateError('Expected \$expected, got \$actual');
  }
}
''';

void main() {
  test(
    'Slice 6 converters, json_helper, custom from/toJson, and extension types',
    () async {
      final report = await verifyGeneratorBatch(
        generator: JsonSerializableGenerator(),
        imports: _sharedImports,
        preamble: _sharedPreamble,
        cases: const [
          // 1. json_converter_nullable_json_on_nullable_field (converter with
          // nullable jsonType receives `null` directly)
          CodegenCase(
            id: 'json_converter_nullable_json_on_nullable_field',
            elementName: 'NullableConverterField',
            declarations: r'''
class CustomVal1 {
  final String v;
  const CustomVal1(this.v);
}

class NullableJsonConverter1 implements JsonConverter<CustomVal1, Object?> {
  const NullableJsonConverter1();
  @override
  CustomVal1 fromJson(Object? json) =>
      CustomVal1(json?.toString() ?? 'was-null');
  @override
  Object? toJson(CustomVal1 object) => object.v;
}

@JsonSerializable()
@NullableJsonConverter1()
class NullableConverterField {
  final CustomVal1? nullableVal;
  final CustomVal1 nonNullVal;

  NullableConverterField({this.nullableVal, required this.nonNullVal});

  factory NullableConverterField.fromJson(Map<String, dynamic> json) =>
      _$NullableConverterFieldFromJson(json);
  Map<String, dynamic> toJson() => _$NullableConverterFieldToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = NullableConverterField.fromJson({
  'nullableVal': null,
  'nonNullVal': null,
});
checkEquals(decoded.nullableVal?.v, 'was-null');
checkEquals(decoded.nonNullVal.v, 'was-null');
checkEquals(
  decoded.toJson(),
  {'nullableVal': 'was-null', 'nonNullVal': 'was-null'},
);
''',
          ),

          // 2. bug_json_converter_double_on_nullable_field_with_int_json
          CodegenCase(
            id: 'bug_json_converter_double_on_nullable_field_with_int_json',
            elementName: 'DoubleConverterField',
            declarations: r'''
class CustomVal2 {
  final double v;
  const CustomVal2(this.v);
}

class DoubleJsonConverter2 implements JsonConverter<CustomVal2, double> {
  const DoubleJsonConverter2();
  @override
  CustomVal2 fromJson(double json) => CustomVal2(json);
  @override
  double toJson(CustomVal2 object) => object.v;
}

@JsonSerializable()
@DoubleJsonConverter2()
class DoubleConverterField {
  final CustomVal2? nullableVal;
  final CustomVal2 nonNullVal;

  DoubleConverterField({this.nullableVal, required this.nonNullVal});

  factory DoubleConverterField.fromJson(Map<String, dynamic> json) =>
      _$DoubleConverterFieldFromJson(json);
  Map<String, dynamic> toJson() => _$DoubleConverterFieldToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = DoubleConverterField.fromJson({
  'nullableVal': 2,
  'nonNullVal': 3,
});
checkEquals(decoded.nullableVal?.v, 2.0);
checkEquals(decoded.nonNullVal.v, 3.0);
final decodedNull = DoubleConverterField.fromJson({
  'nullableVal': null,
  'nonNullVal': 4,
});
check(decodedNull.nullableVal == null);
''',
          ),

          // 3. bug_generic_converter_bounded_object_on_nullable_field
          CodegenCase(
            id: 'bug_generic_converter_bounded_object_on_nullable_field',
            elementName: 'GenericWithBoundedConverter',
            declarations: r'''
class BoundedGenericConverter<T extends Object>
    implements JsonConverter<T, Map<String, Object?>> {
  const BoundedGenericConverter();

  @override
  T fromJson(Map<String, Object?> json) => json['v'] as T;

  @override
  Map<String, Object?> toJson(T object) => {'v': object};
}

@JsonSerializable()
@BoundedGenericConverter()
class GenericWithBoundedConverter<T extends Object> {
  final T nonNullField;
  final T? nullableField;

  GenericWithBoundedConverter({
    required this.nonNullField,
    this.nullableField,
  });

  factory GenericWithBoundedConverter.fromJson(Map<String, dynamic> json) =>
      _$GenericWithBoundedConverterFromJson(json);
  Map<String, dynamic> toJson() => _$GenericWithBoundedConverterToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = GenericWithBoundedConverter<int>.fromJson({
  'nonNullField': {'v': 1},
  'nullableField': {'v': 2},
});
checkEquals(decoded.nonNullField, 1);
checkEquals(decoded.nullableField, 2);

final decodedNull = GenericWithBoundedConverter<int>.fromJson({
  'nonNullField': {'v': 1},
  'nullableField': null,
});
check(decodedNull.nullableField == null);
checkEquals(decodedNull.toJson(), {
  'nonNullField': {'v': 1},
  'nullableField': null,
});
''',
          ),

          // 4. issue1606_21b_instantiated_generic_converter_on_concrete_field
          CodegenCase(
            id: 'issue1606_21b_instantiated_generic_converter',
            elementName: 'InstantiatedGenericConverterCase',
            declarations: r'''
class StringifyGenericConverter<T> implements JsonConverter<T, String> {
  const StringifyGenericConverter();

  @override
  T fromJson(String json) => int.parse(json.substring(4)) as T;

  @override
  String toJson(T object) => 'str:$object';
}

@JsonSerializable()
class InstantiatedGenericConverterCase {
  @StringifyGenericConverter<int>()
  final int value;

  InstantiatedGenericConverterCase(this.value);

  factory InstantiatedGenericConverterCase.fromJson(
    Map<String, dynamic> json,
  ) => _$InstantiatedGenericConverterCaseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InstantiatedGenericConverterCaseToJson(this);
}
''',
            runtimeCheck: r'''
final item = InstantiatedGenericConverterCase(42);
final encoded = item.toJson();
checkEquals(encoded['value'], 'str:42');
final decoded = InstantiatedGenericConverterCase.fromJson(encoded);
checkEquals(decoded.value, 42);
''',
          ),

          // 5. issue1606_21c_list_generic_converter_different_type_param
          CodegenCase(
            id: 'issue1606_21c_list_generic_converter_different_type_param',
            elementName: 'ListGenericConverterCase',
            declarations: r'''
class ListGenericConverter<S> implements JsonConverter<List<S>, List<Object?>> {
  const ListGenericConverter();

  @override
  List<S> fromJson(List<Object?> json) => json.cast<S>();

  @override
  List<Object?> toJson(List<S> object) => object;
}

@JsonSerializable()
// ignore: inference_failure_on_instance_creation
@ListGenericConverter()
class ListGenericConverterCase<T> {
  final List<T> items;

  ListGenericConverterCase(this.items);

  factory ListGenericConverterCase.fromJson(Map<String, dynamic> json) =>
      _$ListGenericConverterCaseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ListGenericConverterCaseToJson(this);
}
''',
            runtimeCheck: r'''
final item = ListGenericConverterCase<int>([1, 2, 3]);
final encoded = item.toJson();
final decoded = ListGenericConverterCase<int>.fromJson(encoded);
checkEquals(decoded.items, [1, 2, 3]);
''',
          ),

          // 6. issue1606_21d_top_level_const_generic_converter_assertion
          CodegenCase(
            id: 'issue1606_21d_top_level_const_generic_converter_assertion',
            elementName: 'ConstGenericConverterCase',
            declarations: r'''
class GenericValConverter<T> implements JsonConverter<T, Object?> {
  const GenericValConverter();

  @override
  T fromJson(Object? json) => json as T;

  @override
  Object? toJson(T object) => object;
}

// ignore: inference_failure_on_instance_creation
const genericValConverterConst = GenericValConverter();

@JsonSerializable()
class ConstGenericConverterCase<T> {
  @genericValConverterConst
  final T value;

  ConstGenericConverterCase(this.value);

  factory ConstGenericConverterCase.fromJson(Map<String, dynamic> json) =>
      _$ConstGenericConverterCaseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ConstGenericConverterCaseToJson(this);
}
''',
            runtimeCheck: r'''
final item = ConstGenericConverterCase<int>(42);
final encoded = item.toJson();
final decoded = ConstGenericConverterCase<int>.fromJson(encoded);
checkEquals(decoded.value, 42);
''',
          ),

          // 7. bug_nested_to_json_record_callback_npe
          CodegenCase(
            id: 'bug_nested_to_json_record_callback_npe',
            elementName: 'UsesWeirdBox',
            declarations: r'''
class WeirdBox {
  Map<String, dynamic> toJson(Object Function((int, int)) toJsonRecord) => {};
}

@JsonSerializable(createFactory: false)
class UsesWeirdBox {
  final WeirdBox box;
  UsesWeirdBox(this.box);
}
''',
            expectedError:
                'Expecting a `toJson` function with no required parameters.',
          ),

          // 8a. bug_nested_generic_wrapper_type_param_from_json
          CodegenCase(
            id: 'bug_nested_generic_wrapper_type_param_from_json',
            elementName: 'UsesScalarWrapper',
            declarations: r'''
class ScalarWrapper<T> {
  final T value;
  ScalarWrapper(this.value);

  factory ScalarWrapper.fromJson(T json) => ScalarWrapper(json);
  T toJson() => value;
}

@JsonSerializable(explicitToJson: true)
class UsesScalarWrapper {
  final ScalarWrapper<int> intWrap;
  final ScalarWrapper<double> doubleWrap;
  final ScalarWrapper<List<String>> listWrap;

  UsesScalarWrapper({
    required this.intWrap,
    required this.doubleWrap,
    required this.listWrap,
  });

  factory UsesScalarWrapper.fromJson(Map<String, dynamic> json) =>
      _$UsesScalarWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$UsesScalarWrapperToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = UsesScalarWrapper.fromJson({
  'intWrap': 42,
  'doubleWrap': 3,
  'listWrap': ['a', 'b'],
});
checkEquals(decoded.intWrap.value, 42);
checkEquals(decoded.doubleWrap.value, 3.0);
checkEquals(decoded.listWrap.value, ['a', 'b']);
checkEquals(decoded.toJson(), {
  'intWrap': 42,
  'doubleWrap': 3.0,
  'listWrap': ['a', 'b'],
});
''',
          ),

          // 8b. bug_nested_generic_map_wrapper_from_json
          CodegenCase(
            id: 'bug_nested_generic_map_wrapper_from_json',
            elementName: 'UsesMapWrapper',
            declarations: r'''
class MapWrapper<V> {
  final Map<String, V> map;
  MapWrapper(this.map);

  factory MapWrapper.fromJson(Map<String, V> json) => MapWrapper(json);
  Map<String, V> toJson() => map;
}

@JsonSerializable(explicitToJson: true)
class UsesMapWrapper {
  final MapWrapper<int> intMap;

  UsesMapWrapper({required this.intMap});

  factory UsesMapWrapper.fromJson(Map<String, dynamic> json) =>
      _$UsesMapWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$UsesMapWrapperToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = UsesMapWrapper.fromJson({
  'intMap': <String, dynamic>{'a': 1, 'b': 2},
});
checkEquals(decoded.intMap.map, {'a': 1, 'b': 2});
checkEquals(decoded.toJson(), {
  'intMap': {'a': 1, 'b': 2},
});
''',
          ),

          // 8c. issue1606_17c_custom_nullable_list_box
          CodegenCase(
            id: 'issue1606_17c_custom_nullable_list_box',
            elementName: 'CustomNullableListBoxHolder',
            declarations: r'''
class CustomNullableListBox<T> {
  final List<T?> items;
  CustomNullableListBox(this.items);

  factory CustomNullableListBox.fromJson(List<T?> json) =>
      CustomNullableListBox(json);

  List<T?> toJson() => items;
}

@JsonSerializable(explicitToJson: true)
class CustomNullableListBoxHolder {
  final CustomNullableListBox<int> box;

  CustomNullableListBoxHolder(this.box);

  factory CustomNullableListBoxHolder.fromJson(Map<String, dynamic> json) =>
      _$CustomNullableListBoxHolderFromJson(json);

  Map<String, dynamic> toJson() => _$CustomNullableListBoxHolderToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = CustomNullableListBoxHolder.fromJson({
  'box': <dynamic>[1, null, 3],
});
checkEquals(decoded.box.items, [1, null, 3]);
''',
          ),

          // 8d. issue1606_17d_child_opt_positional_from_json
          CodegenCase(
            id: 'issue1606_17d_child_opt_positional_from_json',
            elementName: 'ParentWithOptChild',
            declarations: r'''
class ChildWithOptFromJson {
  final int x;
  ChildWithOptFromJson(this.x);

  factory ChildWithOptFromJson.fromJson(
    Map<String, dynamic> json, [
    int bonus = 0,
  ]) => ChildWithOptFromJson((json['x'] as int) + bonus);

  Map<String, dynamic> toJson([int bonus = 0]) => {'x': x + bonus};
}

@JsonSerializable(explicitToJson: true)
class ParentWithOptChild {
  final ChildWithOptFromJson child;

  ParentWithOptChild(this.child);

  factory ParentWithOptChild.fromJson(Map<String, dynamic> json) =>
      _$ParentWithOptChildFromJson(json);

  Map<String, dynamic> toJson() => _$ParentWithOptChildToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = ParentWithOptChild.fromJson({
  'child': {'x': 10},
});
checkEquals(decoded.child.x, 10);
checkEquals(decoded.toJson(), {
  'child': {'x': 10},
});
''',
          ),

          // 9. issue1606_08_ctor_param_json_key_from_to_json
          CodegenCase(
            id: 'issue1606_08_ctor_param_json_key_from_to_json',
            elementName: 'CtorParamJsonKey',
            declarations: r'''
int plusOne(int v) => v + 1;
int minusOne(int v) => v - 1;

class BaseWithParamKey {
  final int baseVal;
  BaseWithParamKey(this.baseVal);
}

@JsonSerializable()
class CtorParamJsonKey extends BaseWithParamKey {
  final int x;

  CtorParamJsonKey(
    @JsonKey(name: 'custom_x', fromJson: plusOne, toJson: minusOne) this.x,
    @JsonKey(name: 'custom_base', fromJson: plusOne, toJson: minusOne)
    super.baseVal,
  );

  factory CtorParamJsonKey.fromJson(Map<String, dynamic> json) =>
      _$CtorParamJsonKeyFromJson(json);

  Map<String, dynamic> toJson() => _$CtorParamJsonKeyToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = CtorParamJsonKey.fromJson({'custom_x': 10, 'custom_base': 20});
checkEquals(decoded.x, 11);
checkEquals(decoded.baseVal, 21);

final encoded = decoded.toJson();
checkEquals(encoded, {'custom_x': 10, 'custom_base': 20});
''',
          ),

          // 10a. issue1606_15_nullable_field_non_null_from_json
          CodegenCase(
            id: 'issue1606_15_nullable_field_non_null_from_json',
            elementName: 'NullableFieldNonNullFromJson',
            declarations: r'''
int topFromJsonNonNull(int v) => v + 100;
int topToJsonNonNull(int? v) => (v ?? 0) - 100;

@JsonSerializable()
class NullableFieldNonNullFromJson {
  @JsonKey(fromJson: topFromJsonNonNull, toJson: topToJsonNonNull)
  final int? nullableWithNonNullFromJson;

  NullableFieldNonNullFromJson({this.nullableWithNonNullFromJson});

  factory NullableFieldNonNullFromJson.fromJson(Map<String, dynamic> json) =>
      _$NullableFieldNonNullFromJsonFromJson(json);

  Map<String, dynamic> toJson() => _$NullableFieldNonNullFromJsonToJson(this);
}
''',
            runtimeCheck: r'''
final decodedPresent = NullableFieldNonNullFromJson.fromJson({
  'nullableWithNonNullFromJson': 5,
});
checkEquals(decodedPresent.nullableWithNonNullFromJson, 105);

final decodedNull = NullableFieldNonNullFromJson.fromJson({
  'nullableWithNonNullFromJson': null,
});
check(decodedNull.nullableWithNonNullFromJson == null);
''',
          ),

          // 10b. issue1606_18a_nullable_from_json_with_json_key_default
          CodegenCase(
            id: 'issue1606_18a_nullable_from_json_with_json_key_default',
            elementName: 'NullableFromJsonWithJsonKeyDefault',
            declarations: r'''
int? topNullableReturnFromJson(Object? json) =>
    json is int ? json + 1 : null;

@JsonSerializable()
class NullableFromJsonWithJsonKeyDefault {
  @JsonKey(fromJson: topNullableReturnFromJson, defaultValue: 42)
  final int fieldA;

  @JsonKey(fromJson: topNullableReturnFromJson)
  final int fieldB;

  NullableFromJsonWithJsonKeyDefault({
    required this.fieldA,
    this.fieldB = 99,
  });

  factory NullableFromJsonWithJsonKeyDefault.fromJson(
    Map<String, dynamic> json,
  ) => _$NullableFromJsonWithJsonKeyDefaultFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NullableFromJsonWithJsonKeyDefaultToJson(this);
}
''',
            runtimeCheck: r'''
final decoded = NullableFromJsonWithJsonKeyDefault.fromJson({
  'fieldA': 'not-an-int',
  'fieldB': 'not-an-int',
});
checkEquals(decoded.fieldA, 42);
checkEquals(decoded.fieldB, 99);

final decodedValid = NullableFromJsonWithJsonKeyDefault.fromJson({
  'fieldA': 10,
  'fieldB': 20,
});
checkEquals(decodedValid.fieldA, 11);
checkEquals(decodedValid.fieldB, 21);
''',
          ),

          // 11. issue1606_21a_generic_tear_off_from_to_json
          CodegenCase(
            id: 'issue1606_21a_generic_tear_off_from_to_json',
            elementName: 'GenericTearOffCase',
            declarations: r'''
T genericId<T>(T v) => v;

@JsonSerializable()
class GenericTearOffCase {
  @JsonKey(fromJson: genericId, toJson: genericId)
  final int field;

  GenericTearOffCase(this.field);

  factory GenericTearOffCase.fromJson(Map<String, dynamic> json) =>
      _$GenericTearOffCaseFromJson(json);

  Map<String, dynamic> toJson() => _$GenericTearOffCaseToJson(this);
}
''',
            runtimeCheck: r'''
final item = GenericTearOffCase(42);
final encoded = item.toJson();
checkEquals(encoded, {'field': 42});
final decoded = GenericTearOffCase.fromJson(encoded);
checkEquals(decoded.field, 42);
''',
          ),

          // 12. issue1606_14_extension_types
          CodegenCase(
            id: 'issue1606_14_extension_types',
            elementName: 'ExtensionTypeModel',
            declarations: r'''
extension type const ExtInt(int value) implements int {}

extension type const ExtDouble(double value) implements double {}

extension type const TaggedId(int id) {
  factory TaggedId.fromJson(Map<String, dynamic> json) =>
      TaggedId(json['id'] as int);
  Map<String, dynamic> toJson() => {'id': id};
}

@JsonSerializable()
class ExtensionTypeModel {
  final ExtInt count;
  final ExtInt? optCount;
  final ExtDouble ratio;
  final TaggedId tagged;

  ExtensionTypeModel({
    required this.count,
    this.optCount,
    required this.ratio,
    required this.tagged,
  });

  factory ExtensionTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ExtensionTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionTypeModelToJson(this);
}
''',
            runtimeCheck: r'''
final model = ExtensionTypeModel(
  count: const ExtInt(7),
  optCount: null,
  ratio: const ExtDouble(2.5),
  tagged: const TaggedId(99),
);
final encoded = model.toJson();
checkEquals(encoded['tagged'], {'id': 99});
final decoded = ExtensionTypeModel.fromJson({
  'count': 7,
  'optCount': null,
  'ratio': 2,
  'tagged': {'id': 99},
});
checkEquals(decoded.count, const ExtInt(7));
check(decoded.optCount == null);
checkEquals(decoded.ratio, const ExtDouble(2.0));
checkEquals(decoded.tagged, const TaggedId(99));
''',
          ),
        ],
      );

      expect(report.passedCases, report.totalCases);
      expect(report.issues, isEmpty);
    },
  );
}
