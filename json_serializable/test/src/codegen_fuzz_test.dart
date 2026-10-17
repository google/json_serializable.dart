// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'package:analyzer/dart/element/element.dart';
import 'package:json_serializable/src/json_serializable_generator.dart';
import 'package:json_serializable/src/type_helpers/map_helper.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

import '../../tool/readme_builder.dart';
import '../shared_config.dart';

const _sharedImports = [
  "import 'dart:convert';",
  "import 'package:collection/collection.dart';",
  "import 'package:json_annotation/json_annotation.dart';",
  "import 'aux_types.dart';",
];

const _auxFiles = {
  'aux_types.dart': '''
typedef CrossLibId<T> = T;
typedef CrossLibNullable<T> = T?;
typedef CrossLibList<T> = List<T>;
typedef CrossLibMap<V> = Map<String, V>;
''',
};

const _sharedPreamble = '''
typedef LocalId<T> = T;
typedef _PrivateIntAlias = int;

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

FuzzStatus defaultFuzzStatus() => FuzzStatus.active;
int defaultIntVal() => 7;
Object defaultObjectVal() => 'fallback';

int customFromJson(Object? json, [int bonus = 0]) =>
    (json as num).toInt() + bonus;
Object? customToJson(int value, [bool wrap = false]) => wrap ? [value] : value;

Object? readNestedOrDirect(Map<dynamic, dynamic> map, String key) =>
    map[key] ?? (map['nested'] is Map ? (map['nested'] as Map)[key] : null);

class FuzzSuper<T> {
  final T ctorItem;
  T? mutableItem;
  FuzzSuper(this.ctorItem);
}

mixin FuzzMixin {
  int mixinCount = 3;
}

class NestedPayload {
  final String label;
  final int count;
  const NestedPayload(this.label, this.count);

  factory NestedPayload.fromJson(Map<String, dynamic> json) =>
      NestedPayload(json['label'] as String, (json['count'] as num).toInt());

  Map<String, dynamic> toJson() => <String, dynamic>{
    'label': label,
    'count': count,
  };

  @override
  bool operator ==(Object other) =>
      other is NestedPayload && other.label == label && other.count == count;

  @override
  int get hashCode => Object.hash(label, count);
}

class CustomVal {
  final int id;
  const CustomVal(this.id);

  @override
  bool operator ==(Object other) => other is CustomVal && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class CustomValConverter implements JsonConverter<CustomVal, int> {
  const CustomValConverter();

  @override
  CustomVal fromJson(int json) => CustomVal(json);

  @override
  int toJson(CustomVal object) => object.id;
}

const topLevelCustomValConverter = CustomValConverter();

class CustomValNullableJsonConverter
    implements JsonConverter<CustomVal, Object?> {
  const CustomValNullableJsonConverter();

  @override
  CustomVal fromJson(Object? json) => CustomVal((json as num?)?.toInt() ?? -1);

  @override
  Object? toJson(CustomVal object) => object.id;
}

class CustomValDoubleConverter implements JsonConverter<CustomVal, double> {
  const CustomValDoubleConverter();

  @override
  CustomVal fromJson(double json) => CustomVal(json.toInt());

  @override
  double toJson(CustomVal object) => object.id.toDouble();
}

class BoundedGenericConverter<T extends Object>
    implements JsonConverter<T, String> {
  const BoundedGenericConverter();

  @override
  T fromJson(String json) => json as T;

  @override
  String toJson(T object) => object.toString();
}

class PatchBox<T> {
  final T? value;
  const PatchBox(this.value);

  @override
  bool operator ==(Object other) => other is PatchBox<T> && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

PatchBox<int>? patchBoxFromJson(Object? json) =>
    PatchBox<int>((json as num?)?.toInt());
Object? patchBoxToJson(PatchBox<int>? box) => box?.value;

class ScalarWrapper<T> {
  final T value;
  const ScalarWrapper(this.value);
  factory ScalarWrapper.fromJson(T json) => ScalarWrapper(json);
  T toJson() => value;
}

class MapWrapper<T> {
  final Map<String, T> map;
  const MapWrapper(this.map);
  factory MapWrapper.fromJson(Map<String, T> json) => MapWrapper(json);
  Map<String, T> toJson() => map;
}

class BadRecordCallbackHolder {
  const BadRecordCallbackHolder();
  factory BadRecordCallbackHolder.fromJson(Map<String, dynamic> json) =>
      const BadRecordCallbackHolder();
  Map<String, dynamic> toJson(
    Object? Function((int, String) pair) toJsonPair,
  ) => <String, dynamic>{};
}

class UnserializableType {
  final int x;
  const UnserializableType(this.x);
}

class DuplicateCustomValConverter implements JsonConverter<CustomVal, int> {
  const DuplicateCustomValConverter();

  @override
  CustomVal fromJson(int json) => CustomVal(json);

  @override
  int toJson(CustomVal object) => object.id;
}

class CtorArgConverter implements JsonConverter<CustomVal, int> {
  final int offset;
  const CtorArgConverter(this.offset);

  @override
  CustomVal fromJson(int json) => CustomVal(json + offset);

  @override
  int toJson(CustomVal object) => object.id - offset;
}

class MultiTypeParamConverter<T, S> implements JsonConverter<T, S> {
  const MultiTypeParamConverter();

  @override
  T fromJson(S json) => json as T;

  @override
  S toJson(T object) => object as S;
}

enum OtherEnum { x, y }

int badFromJsonZeroParams() => 0;
int badFromJsonNamedParam({int a = 0}) => a;
int badFromJsonTwoRequired(Object? a, Object? b) => 0;
String badFromJsonWrongReturn(Object? a) => '';
Object? badToJsonWrongParam(String a) => a;

bool jsonRoundTripEquals(Object? a, Object? b) =>
    const DeepCollectionEquality().equals(
      jsonDecode(jsonEncode(a)),
      jsonDecode(jsonEncode(b)),
    );
''';

class _FieldTypeSpec {
  final String key;
  final String supportedTypeName;
  final String? mapKeyTypeName;
  final String nonNullType;
  final String nullableType;
  final String sampleExpr;
  final String? constDefaultCode;

  const _FieldTypeSpec({
    required this.key,
    required this.supportedTypeName,
    this.mapKeyTypeName,
    required this.nonNullType,
    required this.nullableType,
    required this.sampleExpr,
    this.constDefaultCode,
  });
}

const _coreTypeSpecs = <_FieldTypeSpec>[
  _FieldTypeSpec(
    key: 'int',
    supportedTypeName: 'int',
    nonNullType: 'int',
    nullableType: 'int?',
    sampleExpr: '42',
    constDefaultCode: '7',
  ),
  _FieldTypeSpec(
    key: 'double',
    supportedTypeName: 'double',
    nonNullType: 'double',
    nullableType: 'double?',
    sampleExpr: '3.25',
    constDefaultCode: '1.5',
  ),
  _FieldTypeSpec(
    key: 'num',
    supportedTypeName: 'num',
    nonNullType: 'num',
    nullableType: 'num?',
    sampleExpr: '99.5',
    constDefaultCode: '0',
  ),
  _FieldTypeSpec(
    key: 'string',
    supportedTypeName: 'String',
    nonNullType: 'String',
    nullableType: 'String?',
    sampleExpr: "'hello'",
    constDefaultCode: "'default_str'",
  ),
  _FieldTypeSpec(
    key: 'bool',
    supportedTypeName: 'bool',
    nonNullType: 'bool',
    nullableType: 'bool?',
    sampleExpr: 'true',
    constDefaultCode: 'false',
  ),
  _FieldTypeSpec(
    key: 'object',
    supportedTypeName: 'Object',
    nonNullType: 'Object',
    nullableType: 'Object?',
    sampleExpr: "'obj_val'",
  ),
  _FieldTypeSpec(
    key: 'dateTime',
    supportedTypeName: 'DateTime',
    nonNullType: 'DateTime',
    nullableType: 'DateTime?',
    sampleExpr: 'DateTime.utc(2026, 5, 10, 12, 30)',
  ),
  _FieldTypeSpec(
    key: 'duration',
    supportedTypeName: 'Duration',
    nonNullType: 'Duration',
    nullableType: 'Duration?',
    sampleExpr: 'const Duration(seconds: 45)',
    constDefaultCode: 'Duration.zero',
  ),
  _FieldTypeSpec(
    key: 'bigInt',
    supportedTypeName: 'BigInt',
    nonNullType: 'BigInt',
    nullableType: 'BigInt?',
    sampleExpr: "BigInt.parse('12345678901234567890')",
  ),
  _FieldTypeSpec(
    key: 'uri',
    supportedTypeName: 'Uri',
    nonNullType: 'Uri',
    nullableType: 'Uri?',
    sampleExpr: "Uri.parse('https://dart.dev/path?q=1')",
  ),
  _FieldTypeSpec(
    key: 'enum',
    supportedTypeName: 'EnumType',
    nonNullType: 'FuzzStatus',
    nullableType: 'FuzzStatus?',
    sampleExpr: 'FuzzStatus.done',
    constDefaultCode: 'FuzzStatus.active',
  ),
  _FieldTypeSpec(
    key: 'listInt',
    supportedTypeName: 'List',
    nonNullType: 'List<int>',
    nullableType: 'List<int?>?',
    sampleExpr: 'const [1, 2, 3]',
    constDefaultCode: 'const [9]',
  ),
  _FieldTypeSpec(
    key: 'setString',
    supportedTypeName: 'Set',
    nonNullType: 'Set<String>',
    nullableType: 'Set<String>?',
    sampleExpr: "const {'a', 'b'}",
    constDefaultCode: "const {'z'}",
  ),
  _FieldTypeSpec(
    key: 'iterableInt',
    supportedTypeName: 'Iterable',
    nonNullType: 'Iterable<int>',
    nullableType: 'Iterable<int>?',
    sampleExpr: 'const [4, 5]',
    constDefaultCode: 'const [0]',
  ),
  _FieldTypeSpec(
    key: 'mapStringInt',
    supportedTypeName: 'Map',
    mapKeyTypeName: 'String',
    nonNullType: 'Map<String, int>',
    nullableType: 'Map<String, int?>?',
    sampleExpr: "const {'k1': 10, 'k2': 20}",
    constDefaultCode: "const {'def': 1}",
  ),
  _FieldTypeSpec(
    key: 'mapEnumInt',
    supportedTypeName: 'Map',
    mapKeyTypeName: 'enum',
    nonNullType: 'Map<FuzzStatus, int>',
    nullableType: 'Map<FuzzStatus, int>?',
    sampleExpr: 'const {FuzzStatus.active: 1, FuzzStatus.done: 2}',
    constDefaultCode: 'const {FuzzStatus.paused: 0}',
  ),
  _FieldTypeSpec(
    key: 'mapIntString',
    supportedTypeName: 'Map',
    mapKeyTypeName: 'int',
    nonNullType: 'Map<int, String>',
    nullableType: 'Map<int, String>?',
    sampleExpr: "const {1: 'one', 2: 'two'}",
    constDefaultCode: "const {0: 'zero'}",
  ),
  _FieldTypeSpec(
    key: 'mapBigIntString',
    supportedTypeName: 'Map',
    mapKeyTypeName: 'BigInt',
    nonNullType: 'Map<BigInt, String>',
    nullableType: 'Map<BigInt, String>?',
    sampleExpr: "{BigInt.from(7): 'seven'}",
  ),
  _FieldTypeSpec(
    key: 'mapDateTimeInt',
    supportedTypeName: 'Map',
    mapKeyTypeName: 'DateTime',
    nonNullType: 'Map<DateTime, int>',
    nullableType: 'Map<DateTime, int>?',
    sampleExpr: '{DateTime.utc(2026, 1, 2): 9}',
  ),
  _FieldTypeSpec(
    key: 'mapUriInt',
    supportedTypeName: 'Map',
    mapKeyTypeName: 'Uri',
    nonNullType: 'Map<Uri, int>',
    nullableType: 'Map<Uri, int>?',
    sampleExpr: "{Uri.parse('https://dart.dev'): 3}",
  ),
  _FieldTypeSpec(
    key: 'mapObjectInt',
    supportedTypeName: 'Map',
    mapKeyTypeName: 'Object',
    nonNullType: 'Map<Object, int>',
    nullableType: 'Map<Object, int>?',
    sampleExpr: "const <Object, int>{'objKey': 4}",
  ),
  _FieldTypeSpec(
    key: 'mapDynamicInt',
    supportedTypeName: 'Map',
    mapKeyTypeName: 'dynamic',
    nonNullType: 'Map<dynamic, int>',
    nullableType: 'Map<dynamic, int>?',
    sampleExpr: "const <dynamic, int>{'dynKey': 5}",
  ),
  _FieldTypeSpec(
    key: 'recordPositional',
    supportedTypeName: 'Record',
    nonNullType: '(int, String)',
    nullableType: '(int, String)?',
    sampleExpr: "(11, 'rec')",
  ),
  _FieldTypeSpec(
    key: 'recordNamed',
    supportedTypeName: 'Record',
    nonNullType: '({int a, String b})',
    nullableType: '({int a, String b})?',
    sampleExpr: "(a: 22, b: 'named')",
  ),
];

List<CodegenCase> _buildCoreAndContainerCases() {
  final matrix = cartesianProduct<String, String>({
    'specIndex': [for (var i = 0; i < _coreTypeSpecs.length; i++) '$i'],
    'nullability': ['nonNull', 'nullableVal', 'nullableNull'],
    'includeIfNull': ['true', 'false'],
    'checked': ['false', 'true'],
    'anyMap': ['false', 'true'],
  });

  final cases = <CodegenCase>[];
  for (var i = 0; i < matrix.length; i++) {
    final row = matrix[i];
    final spec = _coreTypeSpecs[int.parse(row['specIndex']!)];
    final nullMode = row['nullability']!;
    final isNullable = nullMode != 'nonNull';
    final useNullSample = nullMode == 'nullableNull';
    final includeIfNull = row['includeIfNull']!;
    final checked = row['checked']!;
    final anyMap = row['anyMap']!;

    // Keep the batch fast and focused (~220 cases) by sampling checked/anyMap
    // orthogonally across indices while covering every type and nullability.
    if ((i + int.parse(row['specIndex']!)) % 2 != 0 &&
        checked == 'true' &&
        anyMap == 'true') {
      continue;
    }

    final fieldType = isNullable ? spec.nullableType : spec.nonNullType;
    final hasDefault = !useNullSample && spec.constDefaultCode != null;
    final ctorParam = hasDefault
        ? '{this.value = ${spec.constDefaultCode}}'
        : 'this.value';
    final sampleArg = useNullSample
        ? 'null'
        : hasDefault
        ? 'value: ${spec.sampleExpr}'
        : spec.sampleExpr;
    final mapParamType = anyMap == 'true' ? 'Map' : 'Map<String, dynamic>';
    final dateTimeUtcArg = spec.key == 'dateTime'
        ? 'dateTimeUtc: $checked,'
        : '';
    final className = 'CoreFuzz$i';
    final idSuffix = 'inc${includeIfNull}_chk${checked}_any$anyMap';

    cases.add(
      CodegenCase(
        id: 'core_${i}_${spec.key}_${nullMode}_$idSuffix',
        elementName: className,
        declarations:
            '''
@JsonSerializable(
  includeIfNull: $includeIfNull,
  checked: $checked,
  anyMap: $anyMap,
  $dateTimeUtcArg
)
class $className {
  final $fieldType value;
  $className($ctorParam);
  factory $className.fromJson($mapParamType json) =>
      _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);
}
''',
        runtimeCheck:
            '''
final instance = $className($sampleArg);
final rawJson = jsonEncode(instance.toJson());
final encoded = jsonDecode(rawJson) as Map<String, dynamic>;
final decoded = $className.fromJson(encoded);
if (!jsonRoundTripEquals(decoded.toJson(), instance.toJson())) {
  throw StateError('Round-trip mismatch for $className');
}
${hasDefault ? '''
final fromEmpty = $className.fromJson(<String, dynamic>{});
final expectedDefault = $className();
if (!jsonRoundTripEquals(fromEmpty.toJson(), expectedDefault.toJson())) {
  throw StateError('Default mismatch for $className');
}
''' : ''}
''',
      ),
    );
  }
  return cases;
}

List<CodegenCase> _buildHierarchyGenericAndTypedefCases() {
  final matrix = cartesianProduct<String, String>({
    'shape': [
      'regularField',
      'mutableField',
      'getterSetter',
      'superField',
      'mixinProperty',
      'crossLibTypedef',
      'privateTypedef',
    ],
    'genericMode': [
      'concrete',
      'unboundedGeneric',
      'boundedObjectGeneric',
      'boundedNumGeneric',
    ],
    'nullability': ['nonNull', 'nullable'],
    'checked': ['false', 'true'],
  });

  final cases = <CodegenCase>[];
  for (var i = 0; i < matrix.length; i++) {
    final row = matrix[i];
    final shape = row['shape']!;
    final genericMode = row['genericMode']!;
    final isNullable = row['nullability'] == 'nullable';
    final checked = row['checked']!;
    final className = 'HierFuzz$i';

    final isGeneric = genericMode != 'concrete';
    final typeParamDecl = switch (genericMode) {
      'concrete' => '',
      'unboundedGeneric' => '<T>',
      'boundedObjectGeneric' => '<T extends Object>',
      'boundedNumGeneric' => '<T extends num>',
      _ => throw StateError('Unknown mode: $genericMode'),
    };
    final typeParamRef = isGeneric ? '<T>' : '';
    final concreteTypeArg = isGeneric ? '<int>' : '';

    final baseType = isGeneric ? 'T' : 'int';
    final effectiveType = switch (shape) {
      'crossLibTypedef' =>
        isNullable ? 'CrossLibNullable<$baseType>' : 'CrossLibId<$baseType>',
      'privateTypedef' => isNullable ? '_PrivateIntAlias?' : '_PrivateIntAlias',
      _ => isNullable ? '$baseType?' : baseType,
    };

    // Private typedef shape is non-generic int.
    if (shape == 'privateTypedef' && isGeneric) {
      continue;
    }

    final fromJsonSig = isGeneric
        ? 'Map<String, dynamic> json, T Function(Object? json) fromJsonT'
        : 'Map<String, dynamic> json';
    final fromJsonCall = isGeneric
        ? '_\$${className}FromJson(json, fromJsonT)'
        : '_\$${className}FromJson(json)';
    final toJsonSig = isGeneric ? 'Object? Function(T value) toJsonT' : '';
    final toJsonCall = isGeneric
        ? '_\$${className}ToJson(this, toJsonT)'
        : '_\$${className}ToJson(this)';

    final classHeader = switch (shape) {
      'superField' =>
        'class $className$typeParamDecl extends FuzzSuper<$effectiveType>',
      'mixinProperty' => 'class $className$typeParamDecl with FuzzMixin',
      _ => 'class $className$typeParamDecl',
    };

    final bodyMembers = switch (shape) {
      'regularField' || 'crossLibTypedef' || 'privateTypedef' =>
        '''
  final $effectiveType item;
  $className(this.item);
''',
      'mutableField' =>
        '''
  ${isNullable ? '' : 'late '}$effectiveType item;
  $className();
''',
      'getterSetter' =>
        '''
  ${isNullable ? '' : 'late '}$effectiveType _item;
  $effectiveType get item => _item;
  set item($effectiveType v) => _item = v;
  $className();
''',
      'superField' =>
        '''
  $className(super.ctorItem);
''',
      'mixinProperty' =>
        '''
  final $effectiveType item;
  $className(this.item);
''',
      _ => throw StateError('Unknown shape: $shape'),
    };

    final sampleVal = isNullable ? 'null' : '17';
    final createExpr = switch (shape) {
      'mutableField' ||
      'getterSetter' => '$className$concreteTypeArg()..item = $sampleVal',
      'superField' =>
        '$className$concreteTypeArg($sampleVal)..mutableItem = $sampleVal',
      _ => '$className$concreteTypeArg($sampleVal)',
    };
    final encodeCall = isGeneric
        ? 'instance.toJson((v) => v)'
        : 'instance.toJson()';
    final decodeCall = isGeneric
        ? '$className$concreteTypeArg.fromJson('
              'encoded, (v) => (v as num).toInt())'
        : '$className.fromJson(encoded)';
    final reEncodeCall = isGeneric
        ? 'decoded.toJson((v) => v)'
        : 'decoded.toJson()';

    cases.add(
      CodegenCase(
        id:
            'hier_${i}_${shape}_${genericMode}_'
            '${row['nullability']}_chk$checked',
        elementName: className,
        declarations:
            '''
@JsonSerializable(
  checked: $checked,
  genericArgumentFactories: $isGeneric,
)
$classHeader {
$bodyMembers
  factory $className.fromJson($fromJsonSig) => $fromJsonCall;
  Map<String, dynamic> toJson($toJsonSig) => $toJsonCall;
}
''',
        runtimeCheck:
            '''
final instance = $createExpr;
final rawJson = jsonEncode($encodeCall);
final encoded = jsonDecode(rawJson) as Map<String, dynamic>;
final decoded = $decodeCall;
if (!jsonRoundTripEquals($reEncodeCall, $encodeCall)) {
  throw StateError('Hierarchy round-trip failed for $className$typeParamRef');
}
''',
      ),
    );
  }
  return cases;
}

// #CHANGE WHEN UPDATING json_annotation
class _FeatureSpec {
  final String key;
  final String classAnnotationExtra;
  final String fieldDeclarations;
  final String sampleArgs;
  final String secondParamType;
  final bool supportsJsonSchema;

  const _FeatureSpec({
    required this.key,
    this.classAnnotationExtra = '',
    required this.fieldDeclarations,
    required this.sampleArgs,
    this.secondParamType = 'int?',
    this.supportsJsonSchema = true,
  });
}

const _featureSpecs = <_FeatureSpec>[
  _FeatureSpec(
    key: 'fieldConverter',
    fieldDeclarations: '''
  @CustomValConverter()
  final CustomVal firstValue;
  @CustomValConverter()
  final CustomVal? secondValue;
''',
    sampleArgs: 'const CustomVal(10), null',
    secondParamType: 'CustomVal?',
  ),
  _FeatureSpec(
    key: 'classConverter',
    classAnnotationExtra: 'converters: [CustomValConverter()],',
    fieldDeclarations: '''
  final CustomVal firstValue;
  final CustomVal? secondValue;
''',
    sampleArgs: 'const CustomVal(10), null',
    secondParamType: 'CustomVal?',
  ),
  _FeatureSpec(
    key: 'topLevelConstConverter',
    fieldDeclarations: '''
  @topLevelCustomValConverter
  final CustomVal firstValue;
  @topLevelCustomValConverter
  final CustomVal? secondValue;
''',
    sampleArgs: 'const CustomVal(10), null',
    secondParamType: 'CustomVal?',
  ),
  _FeatureSpec(
    key: 'customFromToJson',
    fieldDeclarations: '''
  @JsonKey(fromJson: customFromJson, toJson: customToJson)
  final int firstValue;
  final int? secondValue;
''',
    sampleArgs: '25, 30',
  ),
  _FeatureSpec(
    key: 'readValueHook',
    fieldDeclarations: '''
  @JsonKey(readValue: readNestedOrDirect)
  final int firstValue;
  final int? secondValue;
''',
    sampleArgs: '25, 30',
  ),
  _FeatureSpec(
    key: 'nestedSerializable',
    fieldDeclarations: '''
  final NestedPayload firstValue;
  final NestedPayload? secondValue;
''',
    sampleArgs: "const NestedPayload('item', 4), null",
    secondParamType: 'NestedPayload?',
  ),
  _FeatureSpec(
    key: 'patchTriStateCustom',
    fieldDeclarations: '''
  @JsonKey(
    explicitJsonNullWhenNonNullField: true,
    fromJson: patchBoxFromJson,
    toJson: patchBoxToJson,
  )
  final PatchBox<int>? firstValue;
  final int? secondValue;
''',
    sampleArgs: 'const PatchBox<int>(null), 5',
    supportsJsonSchema: false,
  ),
  _FeatureSpec(
    key: 'jsonKeyConstraintsAndDefaults',
    fieldDeclarations: '''
  @JsonKey(
    name: 'custom_first',
    defaultValue: 11,
    required: true,
    disallowNullValue: true,
  )
  final int firstValue;
  @JsonKey(
    includeIfNull: false,
    unknownEnumValue: FuzzStatus.active,
  )
  final FuzzStatus? secondValue;
''',
    sampleArgs: '25, FuzzStatus.done',
    secondParamType: 'FuzzStatus?',
  ),
];

List<CodegenCase> _buildConverterConfigAndAuxCases() {
  final matrix = cartesianProduct<String, String>({
    'specIndex': [for (var i = 0; i < _featureSpecs.length; i++) '$i'],
    'fieldRename': ['none', 'snake', 'kebab', 'pascal', 'screamingSnake'],
    'auxMode': ['none', 'allAux', 'schemaOnly'],
    'explicitToJson': ['false', 'true'],
  });

  final cases = <CodegenCase>[];
  for (var i = 0; i < matrix.length; i++) {
    final row = matrix[i];
    final spec = _featureSpecs[int.parse(row['specIndex']!)];
    final feature = spec.key;
    final rename = row['fieldRename']!;
    final auxMode = row['auxMode']!;
    final explicitToJson = row['explicitToJson']!;

    // Keep slice size around ~115 cases while covering all combinations of
    // feature x fieldRename and feature x auxMode x explicitToJson.
    if (explicitToJson == 'true' &&
        rename != 'none' &&
        rename != 'snake' &&
        auxMode == 'none') {
      continue;
    }

    final createFieldMap = auxMode == 'allAux';
    final createJsonKeys = auxMode == 'allAux';
    final createPerFieldToJson = auxMode == 'allAux';
    final createJsonSchema =
        (auxMode == 'allAux' || auxMode == 'schemaOnly') &&
        spec.supportsJsonSchema;
    final className = 'CfgFuzz$i';

    final auxGetters = [
      if (createFieldMap)
        'static Map<String, String> get fieldMap => _\$${className}FieldMap;',
      if (createJsonKeys)
        'static String get firstKey => _\$${className}JsonKeys.firstValue;',
      if (createPerFieldToJson)
        'static Object? encodeSecond(${spec.secondParamType} v) => '
            '_\$${className}PerFieldToJson.secondValue(v);',
      if (createJsonSchema)
        'static Map<String, Object?> get schema => _\$${className}JsonSchema;',
    ].join('\n  ');

    final auxChecks = [
      if (createFieldMap)
        "if ($className.fieldMap['firstValue'] == null) "
            "throw StateError('Missing fieldMap entry');",
      if (createJsonKeys)
        'if ($className.firstKey.isEmpty) '
            "throw StateError('Empty JsonKeys entry');",
      if (createPerFieldToJson)
        'if ($className.encodeSecond(null) != null) '
            "throw StateError('Expected null per-field encode');",
      if (createJsonSchema)
        "if ($className.schema['type'] != 'object') "
            "throw StateError('Invalid schema root');",
    ].join('\n');

    cases.add(
      CodegenCase(
        id: 'cfg_${i}_${feature}_${rename}_${auxMode}_exp$explicitToJson',
        elementName: className,
        declarations:
            '''
@JsonSerializable(
  fieldRename: FieldRename.$rename,
  explicitToJson: $explicitToJson,
  disallowUnrecognizedKeys: true,
  createFieldMap: $createFieldMap,
  createJsonKeys: $createJsonKeys,
  createPerFieldToJson: $createPerFieldToJson,
  createJsonSchema: $createJsonSchema,
  ${spec.classAnnotationExtra}
)
class $className {
${spec.fieldDeclarations}
  $className(this.firstValue, this.secondValue);
  factory $className.fromJson(Map<String, dynamic> json) =>
      _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);
  $auxGetters
}
''',
        runtimeCheck:
            '''
final instance = $className(${spec.sampleArgs});
final rawJson = jsonEncode(instance.toJson());
final encoded = jsonDecode(rawJson) as Map<String, dynamic>;
final decoded = $className.fromJson(encoded);
if (decoded.firstValue != instance.firstValue ||
    decoded.secondValue != instance.secondValue) {
  throw StateError('Mismatch in $className');
}
$auxChecks
''',
      ),
    );
  }
  return cases;
}

List<CodegenCase> _buildNegativeDiagnosticCases() => const <CodegenCase>[
  CodegenCase(
    id: 'neg_enum_target',
    elementName: 'BadEnumTarget',
    declarations: '''
@JsonSerializable()
enum BadEnumTarget { a, b }
''',
    expectedError: '`@JsonSerializable` can only be used on classes.',
  ),
  CodegenCase(
    id: 'neg_missing_default_ctor',
    elementName: 'MissingDefaultCtor',
    declarations: '''
@JsonSerializable()
class MissingDefaultCtor {
  final int x;
  MissingDefaultCtor.named(this.x);
}
''',
    expectedError: 'The class `MissingDefaultCtor` has no default constructor.',
  ),
  CodegenCase(
    id: 'neg_missing_named_ctor',
    elementName: 'MissingNamedCtor',
    declarations: '''
@JsonSerializable(constructor: 'missing')
class MissingNamedCtor {
  final int x;
  MissingNamedCtor(this.x);
}
''',
    expectedError:
        'The class `MissingNamedCtor` does not have a constructor with the '
        'name `missing`.',
  ),
  CodegenCase(
    id: 'neg_ctor_param_private_field',
    elementName: 'PrivateFieldCtorParam',
    declarations: '''
@JsonSerializable()
class PrivateFieldCtorParam {
  final int _secret;
  PrivateFieldCtorParam(this._secret);
  int get readSecret => _secret;
}
''',
    expectedError:
        'Cannot populate the required constructor argument: _secret. It is '
        'assigned to a private field.',
  ),
  CodegenCase(
    id: 'neg_ctor_param_setter_only',
    elementName: 'SetterOnlyCtorParam',
    declarations: '''
@JsonSerializable()
class SetterOnlyCtorParam {
  int _x = 0;
  set x(int v) => _x = v;
  SetterOnlyCtorParam(int x) : _x = x;
  int get readX => _x;
}
''',
    expectedError:
        'Cannot populate the required constructor argument: x. Setter-only '
        'properties are not supported.',
  ),
  CodegenCase(
    id: 'neg_ctor_param_excluded_from_json',
    elementName: 'ExcludedFromJsonCtorParam',
    declarations: '''
@JsonSerializable()
class ExcludedFromJsonCtorParam {
  @JsonKey(includeFromJson: false)
  final int x;
  ExcludedFromJsonCtorParam(this.x);
}
''',
    expectedError:
        'Cannot populate the required constructor argument: x. It is assigned '
        'to a field not meant to be used in fromJson.',
  ),
  CodegenCase(
    id: 'neg_ctor_param_unbound',
    elementName: 'UnboundCtorParam',
    declarations: '''
@JsonSerializable()
class UnboundCtorParam {
  final int x;
  UnboundCtorParam(this.x, int orphan);
}
''',
    expectedError:
        'Cannot populate the required constructor argument: orphan. It does '
        'not correspond to any field or getter on the class.',
  ),
  CodegenCase(
    id: 'neg_duplicate_json_key_collision',
    elementName: 'DuplicateKeyCollision',
    declarations: '''
@JsonSerializable()
class DuplicateKeyCollision {
  @JsonKey(name: 'same')
  final int a;
  @JsonKey(name: 'same')
  final int b;
  DuplicateKeyCollision(this.a, this.b);
}
''',
    expectedError: 'More than one field has the JSON key for name "same".',
  ),
  CodegenCase(
    id: 'neg_ignore_and_include_from_json',
    elementName: 'IgnoreAndIncludeFromJson',
    declarations: '''
@JsonSerializable()
class IgnoreAndIncludeFromJson {
  // ignore: deprecated_member_use
  @JsonKey(ignore: true, includeFromJson: true)
  int? x;
  IgnoreAndIncludeFromJson();
}
''',
    expectedError:
        'Cannot use both `ignore` and `includeFromJson` on the same field.',
  ),
  CodegenCase(
    id: 'neg_ignore_and_include_to_json',
    elementName: 'IgnoreAndIncludeToJson',
    declarations: '''
@JsonSerializable()
class IgnoreAndIncludeToJson {
  // ignore: deprecated_member_use
  @JsonKey(ignore: true, includeToJson: true)
  int? x;
  IgnoreAndIncludeToJson();
}
''',
    expectedError:
        'Cannot use both `ignore` and `includeToJson` on the same field.',
  ),
  CodegenCase(
    id: 'neg_disallow_null_and_include_if_null',
    elementName: 'DisallowAndIncludeNull',
    declarations: '''
@JsonSerializable()
class DisallowAndIncludeNull {
  @JsonKey(disallowNullValue: true, includeIfNull: true)
  final int? x;
  DisallowAndIncludeNull(this.x);
}
''',
    expectedError:
        'Cannot set both `disallowNullValue` and `includeIfNull` to `true`.',
  ),
  CodegenCase(
    id: 'neg_patch_tri_state_non_nullable_field',
    elementName: 'PatchTriStateNonNull',
    declarations: '''
@JsonSerializable()
class PatchTriStateNonNull {
  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final int x;
  PatchTriStateNonNull(this.x);
}
''',
    expectedError:
        'Fields with `explicitJsonNullWhenNonNullField` must be nullable',
  ),
  CodegenCase(
    id: 'neg_patch_tri_state_with_disallow_null',
    elementName: 'PatchTriStateDisallowNull',
    declarations: '''
@JsonSerializable()
class PatchTriStateDisallowNull {
  @JsonKey(explicitJsonNullWhenNonNullField: true, disallowNullValue: true)
  final int? x;
  PatchTriStateDisallowNull(this.x);
}
''',
    expectedError:
        'Cannot set both `explicitJsonNullWhenNonNullField` and '
        '`disallowNullValue` to `true`.',
  ),
  CodegenCase(
    id: 'neg_patch_tri_state_with_required',
    elementName: 'PatchTriStateRequired',
    declarations: '''
@JsonSerializable()
class PatchTriStateRequired {
  @JsonKey(explicitJsonNullWhenNonNullField: true, required: true)
  final int? x;
  PatchTriStateRequired(this.x);
}
''',
    expectedError:
        'Cannot set both `explicitJsonNullWhenNonNullField` and `required` to '
        '`true`.',
  ),
  CodegenCase(
    id: 'neg_patch_tri_state_with_default_value',
    elementName: 'PatchTriStateDefaultValue',
    declarations: '''
@JsonSerializable()
class PatchTriStateDefaultValue {
  @JsonKey(explicitJsonNullWhenNonNullField: true, defaultValue: 1)
  final int? x;
  PatchTriStateDefaultValue(this.x);
}
''',
    expectedError:
        'Cannot set `defaultValue` when `explicitJsonNullWhenNonNullField` is '
        '`true`.',
  ),
  CodegenCase(
    id: 'neg_patch_tri_state_with_read_value',
    elementName: 'PatchTriStateReadValue',
    declarations: '''
@JsonSerializable()
class PatchTriStateReadValue {
  @JsonKey(
    explicitJsonNullWhenNonNullField: true,
    readValue: readNestedOrDirect,
  )
  final int? x;
  PatchTriStateReadValue(this.x);
}
''',
    expectedError:
        'Cannot set `readValue` when `explicitJsonNullWhenNonNullField` is '
        '`true`.',
  ),
  CodegenCase(
    id: 'neg_patch_tri_state_non_nullable_converter',
    elementName: 'PatchTriStateNonNullConverter',
    declarations: '''
@CustomValConverter()
@JsonSerializable()
class PatchTriStateNonNullConverter {
  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final CustomVal? x;
  PatchTriStateNonNullConverter(this.x);
}
''',
    expectedError:
        'Fields with `explicitJsonNullWhenNonNullField` require the '
        '`JsonConverter` `fromJson` input type to be nullable',
  ),
  CodegenCase(
    id: 'neg_patch_tri_state_nested_non_nullable_from_json',
    elementName: 'PatchTriStateNestedFromJson',
    declarations: '''
@JsonSerializable()
class PatchTriStateNestedFromJson {
  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final NestedPayload? payload;
  PatchTriStateNestedFromJson(this.payload);
}
''',
    expectedError:
        'Fields with `explicitJsonNullWhenNonNullField` cannot deserialize '
        'explicit JSON `null` through `NestedPayload.fromJson`',
  ),
  CodegenCase(
    id: 'neg_null_for_undefined_enum_as_default_value',
    elementName: 'NullForUndefinedInDefault',
    declarations: '''
@JsonSerializable()
class NullForUndefinedInDefault {
  @JsonKey(defaultValue: JsonKey.nullForUndefinedEnumValue)
  final FuzzStatus? status;
  NullForUndefinedInDefault(this.status);
}
''',
    expectedError:
        '`JsonKey.nullForUndefinedEnumValue` cannot be used with '
        '`JsonKey.defaultValue`.',
  ),
  CodegenCase(
    id: 'neg_null_for_undefined_enum_on_non_nullable',
    elementName: 'NullForUndefinedOnNonNull',
    declarations: '''
@JsonSerializable()
class NullForUndefinedOnNonNull {
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final FuzzStatus status;
  NullForUndefinedOnNonNull(this.status);
}
''',
    expectedError:
        '`JsonKey.nullForUndefinedEnumValue` cannot be used with '
        '`JsonKey.unknownEnumValue` unless the field is nullable.',
  ),
  CodegenCase(
    id: 'neg_unknown_enum_wrong_enum_type',
    elementName: 'UnknownEnumWrongType',
    declarations: '''
@JsonSerializable()
class UnknownEnumWrongType {
  @JsonKey(unknownEnumValue: OtherEnum.x)
  final FuzzStatus status;
  UnknownEnumWrongType(this.status);
}
''',
    expectedError:
        '`unknownEnumValue` has type `FuzzStatus`, but the provided '
        'unknownEnumValue is of type `OtherEnum`.',
  ),
  CodegenCase(
    id: 'neg_unknown_enum_on_int_field',
    elementName: 'UnknownEnumOnInt',
    declarations: '''
@JsonSerializable()
class UnknownEnumOnInt {
  @JsonKey(unknownEnumValue: FuzzStatus.active)
  final int status;
  UnknownEnumOnInt(this.status);
}
''',
    expectedError:
        '`unknownEnumValue` can only be set on fields of type enum or on '
        'Iterable, List, Set or Map instances of an enum type.',
  ),
  CodegenCase(
    id: 'neg_default_value_symbol_literal',
    elementName: 'DefaultValueSymbolCase',
    declarations: '''
@JsonSerializable()
class DefaultValueSymbolCase {
  @JsonKey(defaultValue: #badSymbol)
  final Object? x;
  DefaultValueSymbolCase(this.x);
}
''',
    expectedError: '`defaultValue` is `Symbol`, it must be a literal.',
  ),
  CodegenCase(
    id: 'neg_default_value_type_literal',
    elementName: 'DefaultValueTypeCase',
    declarations: '''
@JsonSerializable()
class DefaultValueTypeCase {
  @JsonKey(defaultValue: String)
  final Object? x;
  DefaultValueTypeCase(this.x);
}
''',
    expectedError: '`defaultValue` is `Type`, it must be a literal.',
  ),
  CodegenCase(
    id: 'neg_from_json_zero_params',
    elementName: 'FromJsonZeroParamsCase',
    declarations: '''
@JsonSerializable()
class FromJsonZeroParamsCase {
  @JsonKey(fromJson: badFromJsonZeroParams)
  final int x;
  FromJsonZeroParamsCase(this.x);
}
''',
    expectedError:
        'The `fromJson` function `badFromJsonZeroParams` must have one '
        'positional parameter.',
  ),
  CodegenCase(
    id: 'neg_from_json_named_param',
    elementName: 'FromJsonNamedParamCase',
    declarations: '''
@JsonSerializable()
class FromJsonNamedParamCase {
  @JsonKey(fromJson: badFromJsonNamedParam)
  final int x;
  FromJsonNamedParamCase(this.x);
}
''',
    expectedError:
        'The `fromJson` function `badFromJsonNamedParam` must have one '
        'positional parameter.',
  ),
  CodegenCase(
    id: 'neg_from_json_two_required_params',
    elementName: 'FromJsonTwoRequiredCase',
    declarations: '''
@JsonSerializable()
class FromJsonTwoRequiredCase {
  @JsonKey(fromJson: badFromJsonTwoRequired)
  final int x;
  FromJsonTwoRequiredCase(this.x);
}
''',
    expectedError:
        'The `fromJson` function `badFromJsonTwoRequired` must have one '
        'positional parameter.',
  ),
  CodegenCase(
    id: 'neg_from_json_incompatible_return_type',
    elementName: 'FromJsonBadReturnCase',
    declarations: '''
@JsonSerializable()
class FromJsonBadReturnCase {
  @JsonKey(fromJson: badFromJsonWrongReturn)
  final int x;
  FromJsonBadReturnCase(this.x);
}
''',
    expectedError:
        'The `fromJson` function `badFromJsonWrongReturn` return type '
        '`String` is not compatible with field type `int`.',
  ),
  CodegenCase(
    id: 'neg_to_json_incompatible_param_type',
    elementName: 'ToJsonBadParamCase',
    declarations: '''
@JsonSerializable()
class ToJsonBadParamCase {
  @JsonKey(toJson: badToJsonWrongParam)
  final int x;
  ToJsonBadParamCase(this.x);
}
''',
    expectedError:
        'The `toJson` function `badToJsonWrongParam` argument type `String` '
        'is not compatible with field type `int`.',
  ),
  CodegenCase(
    id: 'neg_unsupported_field_type',
    elementName: 'UnsupportedFieldTypeCase',
    declarations: '''
@JsonSerializable()
class UnsupportedFieldTypeCase {
  final UnserializableType bad;
  UnsupportedFieldTypeCase(this.bad);
}
''',
    expectedError: 'Could not generate `fromJson` code for `bad`.',
  ),
  CodegenCase(
    id: 'neg_unconfigured_type_parameter',
    elementName: 'UnconfiguredTypeParamCase',
    declarations: '''
@JsonSerializable()
class UnconfiguredTypeParamCase<T> {
  final T item;
  UnconfiguredTypeParamCase(this.item);
}
''',
    expectedError:
        'Could not generate `fromJson` code for `item` because of type `T` '
        '(type parameter).',
  ),
  CodegenCase(
    id: 'neg_unsupported_map_key_bool',
    elementName: 'UnsupportedMapKeyBoolCase',
    declarations: '''
@JsonSerializable()
class UnsupportedMapKeyBoolCase {
  final Map<bool, int> map;
  UnsupportedMapKeyBoolCase(this.map);
}
''',
    expectedError: 'Map keys must be one of: Object, dynamic, enum, String',
  ),
  CodegenCase(
    id: 'neg_unsupported_map_key_nullable_string',
    elementName: 'UnsupportedMapKeyNullableStringCase',
    declarations: '''
@JsonSerializable()
class UnsupportedMapKeyNullableStringCase {
  final Map<String?, int> map;
  UnsupportedMapKeyNullableStringCase(this.map);
}
''',
    expectedError: 'Map keys must be one of: Object, dynamic, enum, String',
  ),
  CodegenCase(
    id: 'neg_duplicate_matching_converters',
    elementName: 'DuplicateConvertersCase',
    declarations: '''
@CustomValConverter()
@DuplicateCustomValConverter()
@JsonSerializable()
class DuplicateConvertersCase {
  final CustomVal val;
  DuplicateConvertersCase(this.val);
}
''',
    expectedError: 'Found more than one matching converter for `CustomVal`.',
  ),
  CodegenCase(
    id: 'neg_converter_with_ctor_args',
    elementName: 'ConverterWithCtorArgsCase',
    declarations: '''
@CtorArgConverter(5)
@JsonSerializable()
class ConverterWithCtorArgsCase {
  final CustomVal val;
  ConverterWithCtorArgsCase(this.val);
}
''',
    expectedError: 'Generators with constructor arguments are not supported.',
  ),
  CodegenCase(
    id: 'neg_converter_multi_type_params',
    elementName: 'ConverterMultiTypeParamsCase',
    declarations: '''
@MultiTypeParamConverter()
@JsonSerializable()
class ConverterMultiTypeParamsCase<T> {
  final T val;
  ConverterMultiTypeParamsCase(this.val);
}
''',
    expectedError:
        '`JsonConverter` implementations can have no more than one type '
        'argument.',
  ),
];

List<CodegenCase> _buildFieldMatrixAndExtraMapCases() {
  final matrix = cartesianProduct<String, String>({
    'isPublic': ['true', 'false'],
    'includeToJson': ['null', 'true', 'false'],
    'includeFromJson': ['null', 'true', 'false'],
  });

  String pascal(String value) => value[0].toUpperCase() + value.substring(1);

  final cases = <CodegenCase>[];
  for (final row in matrix) {
    final isPublic = row['isPublic'] == 'true';
    final includeToJsonStr = row['includeToJson']!;
    final includeFromJsonStr = row['includeFromJson']!;
    final includeToJson = includeToJsonStr == 'null'
        ? null
        : includeToJsonStr == 'true';
    final includeFromJson = includeFromJsonStr == 'null'
        ? null
        : includeFromJsonStr == 'true';

    final className =
        'ToJson${pascal(includeToJsonStr)}'
        'FromJson${pascal(includeFromJsonStr)}'
        '${isPublic ? 'Public' : 'Private'}';
    final fieldName = isPublic ? 'field' : '_field';

    final bits = [
      if (includeFromJson != null) 'includeFromJson: $includeFromJson',
      if (includeToJson != null) 'includeToJson: $includeToJson',
      if (!isPublic) "name: 'field'",
    ];
    final fieldAnnotation = bits.isEmpty ? '' : '@JsonKey(${bits.join(', ')})';

    final effectiveFromJson = includeFromJson ?? isPublic;
    final effectiveToJson = includeToJson ?? includeFromJson ?? isPublic;
    final expectedFieldVal = effectiveFromJson ? 42 : null;
    final expectedWithMapCode = effectiveToJson
        ? "<String, dynamic>{'aField': null, "
              "'field': $expectedFieldVal, 'zField': null}"
        : "<String, dynamic>{'aField': null, 'zField': null}";
    final expectedWithoutMapCode = effectiveToJson
        ? "<String, dynamic>{'aField': null, 'field': null, 'zField': null}"
        : "<String, dynamic>{'aField': null, 'zField': null}";

    cases.add(
      CodegenCase(
        id:
            'field_matrix_${isPublic ? 'public' : 'private'}_'
            'to_${includeToJsonStr}_from_$includeFromJsonStr',
        elementName: className,
        declarations:
            '''
@JsonSerializable()
class $className {
  $className();

  int? aField;

  $fieldAnnotation
  int? $fieldName;

  int? zField;

  factory $className.fromJson(Map<String, dynamic> json) =>
      _\$${className}FromJson(json);

  Map<String, dynamic> toJson() => _\$${className}ToJson(this);

  @override
  String toString() => '$className: $fieldName: \$$fieldName';
}
''',
        runtimeCheck:
            '''
final withInstance = $className.fromJson(<String, dynamic>{'field': 42});
final withoutInstance = $className.fromJson(<String, dynamic>{});
if (withInstance.toString() != '$className: $fieldName: $expectedFieldVal') {
  throw StateError('Unexpected toString for $className');
}
if (!jsonRoundTripEquals(withInstance.toJson(), $expectedWithMapCode)) {
  throw StateError('Unexpected with toJson for $className');
}
if (!jsonRoundTripEquals(withoutInstance.toJson(), $expectedWithoutMapCode)) {
  throw StateError('Unexpected without toJson for $className');
}
''',
      ),
    );
  }

  cases.addAll(const <CodegenCase>[
    CodegenCase(
      id: 'extra_map_string_to_nullable_string',
      elementName: 'ExtraMapStringToNullableString',
      declarations: '''
@JsonSerializable()
class ExtraMapStringToNullableString {
  final Map<String, String?> value;
  ExtraMapStringToNullableString(this.value);
  factory ExtraMapStringToNullableString.fromJson(Map<String, dynamic> json) =>
      _\$ExtraMapStringToNullableStringFromJson(json);
  Map<String, dynamic> toJson() => _\$ExtraMapStringToNullableStringToJson(this);
}
''',
      runtimeCheck: '''
for (final input in const <Map<String, Object?>>[
  {'value': <String, Object?>{}},
  {
    'value': <String, Object?>{'key': 'value'},
  },
  {
    'value': <String, Object?>{'key': null},
  },
]) {
  final object = ExtraMapStringToNullableString.fromJson(input);
  final encoded = jsonEncode(object.toJson());
  if (encoded != jsonEncode(input)) {
    throw StateError('Mismatch for ExtraMapStringToNullableString: \$encoded');
  }
  final object2 = ExtraMapStringToNullableString.fromJson(
    jsonDecode(encoded) as Map<String, Object?>,
  );
  if (jsonEncode(object2.toJson()) != encoded) {
    throw StateError('Round-trip mismatch for ExtraMapStringToNullableString');
  }
}
''',
    ),
    CodegenCase(
      id: 'extra_map_string_to_double',
      elementName: 'ExtraMapStringToDouble',
      declarations: '''
@JsonSerializable()
class ExtraMapStringToDouble {
  final Map<String, double> value;
  ExtraMapStringToDouble(this.value);
  factory ExtraMapStringToDouble.fromJson(Map<String, dynamic> json) =>
      _\$ExtraMapStringToDoubleFromJson(json);
  Map<String, dynamic> toJson() => _\$ExtraMapStringToDoubleToJson(this);
}
''',
      runtimeCheck: '''
const input = <String, Object?>{
  'value': <String, Object?>{'double': 1.0, 'int': 1},
};
final object = ExtraMapStringToDouble.fromJson(input);
final encoded = const JsonEncoder.withIndent(' ').convert(object);
final expected = const JsonEncoder.withIndent(' ').convert(const {
  'value': {'double': 1.0, 'int': 1.0},
});
if (encoded != expected) {
  throw StateError('Expected int 1 encoded as double 1.0, got: \$encoded');
}
final object2 = ExtraMapStringToDouble.fromJson(
  jsonDecode(encoded) as Map<String, Object?>,
);
if (const JsonEncoder.withIndent(' ').convert(object2) != encoded) {
  throw StateError('Round-trip mismatch for ExtraMapStringToDouble');
}
''',
    ),
    CodegenCase(
      id: 'extra_map_string_to_int',
      elementName: 'ExtraMapStringToInt',
      declarations: '''
@JsonSerializable()
class ExtraMapStringToInt {
  final Map<String, int> value;
  ExtraMapStringToInt(this.value);
  factory ExtraMapStringToInt.fromJson(Map<String, dynamic> json) =>
      _\$ExtraMapStringToIntFromJson(json);
  Map<String, dynamic> toJson() => _\$ExtraMapStringToIntToJson(this);
}
''',
      runtimeCheck: '''
const input = <String, Object?>{
  'value': <String, Object?>{'int': 1},
};
final object = ExtraMapStringToInt.fromJson(input);
final encoded = const JsonEncoder.withIndent(' ').convert(object);
if (encoded != const JsonEncoder.withIndent(' ').convert(input)) {
  throw StateError('Mismatch for ExtraMapStringToInt: \$encoded');
}
final object2 = ExtraMapStringToInt.fromJson(
  jsonDecode(encoded) as Map<String, Object?>,
);
if (const JsonEncoder.withIndent(' ').convert(object2) != encoded) {
  throw StateError('Round-trip mismatch for ExtraMapStringToInt');
}
''',
    ),
    CodegenCase(
      id: 'extra_map_string_to_num',
      elementName: 'ExtraMapStringToNum',
      declarations: '''
@JsonSerializable()
class ExtraMapStringToNum {
  final Map<String, num> value;
  ExtraMapStringToNum(this.value);
  factory ExtraMapStringToNum.fromJson(Map<String, dynamic> json) =>
      _\$ExtraMapStringToNumFromJson(json);
  Map<String, dynamic> toJson() => _\$ExtraMapStringToNumToJson(this);
}
''',
      runtimeCheck: '''
const input = <String, Object?>{
  'value': <String, Object?>{'double': 1.0, 'int': 1},
};
final object = ExtraMapStringToNum.fromJson(input);
final encoded = const JsonEncoder.withIndent(' ').convert(object);
if (encoded != const JsonEncoder.withIndent(' ').convert(input)) {
  throw StateError('Mismatch for ExtraMapStringToNum: \$encoded');
}
final object2 = ExtraMapStringToNum.fromJson(
  jsonDecode(encoded) as Map<String, Object?>,
);
if (const JsonEncoder.withIndent(' ').convert(object2) != encoded) {
  throw StateError('Round-trip mismatch for ExtraMapStringToNum');
}
''',
    ),
    CodegenCase(
      id: 'extra_map_string_to_record',
      elementName: 'ExtraMapStringToRecord',
      declarations: '''
@JsonSerializable()
class ExtraMapStringToRecord {
  final Map<String, (int, String, {bool truth})> value;
  ExtraMapStringToRecord(this.value);
  factory ExtraMapStringToRecord.fromJson(Map<String, dynamic> json) =>
      _\$ExtraMapStringToRecordFromJson(json);
  Map<String, dynamic> toJson() => _\$ExtraMapStringToRecordToJson(this);
}
''',
      runtimeCheck: r'''
const input = <String, Object?>{
  'value': <String, Object?>{
    'key': <String, Object?>{r'$1': 1, r'$2': 'string', 'truth': false},
  },
};
final object = ExtraMapStringToRecord.fromJson(input);
final encoded = const JsonEncoder.withIndent(' ').convert(object);
if (encoded != const JsonEncoder.withIndent(' ').convert(input)) {
  throw StateError('Mismatch for ExtraMapStringToRecord: $encoded');
}
final object2 = ExtraMapStringToRecord.fromJson(
  jsonDecode(encoded) as Map<String, Object?>,
);
if (const JsonEncoder.withIndent(' ').convert(object2) != encoded) {
  throw StateError('Round-trip mismatch for ExtraMapStringToRecord');
}
''',
    ),
    CodegenCase(
      id: 'extra_custom_constructor_and_ignore_unannotated',
      elementName: 'ExtraCustomCtorIgnoreUnannotated',
      declarations: '''
@JsonSerializable(
  constructor: 'custom',
  ignoreUnannotated: true,
)
class ExtraCustomCtorIgnoreUnannotated {
  @JsonKey()
  final int kept;
  int ignored = 99;
  ExtraCustomCtorIgnoreUnannotated.custom(this.kept);
  factory ExtraCustomCtorIgnoreUnannotated.fromJson(
    Map<String, dynamic> json,
  ) => _\$ExtraCustomCtorIgnoreUnannotatedFromJson(json);
  Map<String, dynamic> toJson() =>
      _\$ExtraCustomCtorIgnoreUnannotatedToJson(this);
}
''',
      runtimeCheck: '''
final decoded = ExtraCustomCtorIgnoreUnannotated.fromJson(<String, dynamic>{
  'kept': 7,
  'ignored': 123,
});
if (decoded.kept != 7 || decoded.ignored != 99) {
  throw StateError('Unexpected ExtraCustomCtorIgnoreUnannotated fields');
}
if (!jsonRoundTripEquals(decoded.toJson(), const <String, dynamic>{'kept': 7})) {
  throw StateError('Unexpected ExtraCustomCtorIgnoreUnannotated toJson');
}
''',
    ),
    CodegenCase(
      id: 'extra_create_factory_false',
      elementName: 'ExtraCreateFactoryFalse',
      declarations: '''
@JsonSerializable(
  createFactory: false,
  createToJson: true,
)
class ExtraCreateFactoryFalse {
  final int x;
  ExtraCreateFactoryFalse(this.x);
  Map<String, dynamic> toJson() => _\$ExtraCreateFactoryFalseToJson(this);
}
''',
      runtimeCheck: '''
if (!jsonRoundTripEquals(
  ExtraCreateFactoryFalse(5).toJson(),
  const <String, dynamic>{'x': 5},
)) {
  throw StateError('Unexpected ExtraCreateFactoryFalse toJson');
}
''',
    ),
    CodegenCase(
      id: 'extra_create_to_json_false',
      elementName: 'ExtraCreateToJsonFalse',
      declarations: '''
@JsonSerializable(
  createFactory: true,
  createToJson: false,
)
class ExtraCreateToJsonFalse {
  final int x;
  ExtraCreateToJsonFalse(this.x);
  factory ExtraCreateToJsonFalse.fromJson(Map<String, dynamic> json) =>
      _\$ExtraCreateToJsonFalseFromJson(json);
}
''',
      runtimeCheck: '''
final decoded = ExtraCreateToJsonFalse.fromJson(const <String, dynamic>{'x': 9});
if (decoded.x != 9) {
  throw StateError('Unexpected ExtraCreateToJsonFalse.x: \${decoded.x}');
}
''',
    ),
    CodegenCase(
      id: 'extra_json_enum_options',
      elementName: 'ExtraJsonEnumOptions',
      declarations: '''
@JsonEnum(
  alwaysCreate: true,
  fieldRename: FieldRename.kebab,
)
enum FuzzKebabEnum { firstEntry, secondEntry }

@JsonEnum(
  valueField: 'code',
)
enum FuzzValueFieldEnum {
  alpha('a_code'),
  beta('b_code');

  final String code;
  const FuzzValueFieldEnum(this.code);
}

@JsonSerializable()
class ExtraJsonEnumOptions {
  final FuzzKebabEnum kebab;
  final FuzzValueFieldEnum byField;
  ExtraJsonEnumOptions(this.kebab, this.byField);
  factory ExtraJsonEnumOptions.fromJson(Map<String, dynamic> json) =>
      _\$ExtraJsonEnumOptionsFromJson(json);
  Map<String, dynamic> toJson() => _\$ExtraJsonEnumOptionsToJson(this);
}
''',
      runtimeCheck: '''
final instance = ExtraJsonEnumOptions(
  FuzzKebabEnum.firstEntry,
  FuzzValueFieldEnum.beta,
);
final encoded = instance.toJson();
if (encoded['kebab'] != 'first-entry' || encoded['byField'] != 'b_code') {
  throw StateError('Unexpected ExtraJsonEnumOptions encoding: \$encoded');
}
final decoded = ExtraJsonEnumOptions.fromJson(encoded);
if (decoded.kebab != instance.kebab || decoded.byField != instance.byField) {
  throw StateError('ExtraJsonEnumOptions round-trip mismatch');
}
''',
    ),
  ]);

  return cases;
}

const _driftRemediationHint = '''
How to update test/src/codegen_fuzz_test.dart:
- New supported type or map key type -> add a `_FieldTypeSpec` entry to
  `_coreTypeSpecs` (Slice 1).
- New @JsonKey or converter feature -> add a `_FeatureSpec` entry to
  `_featureSpecs` (Slice 3).
- New asymmetric @JsonSerializable or @JsonEnum option -> add a `CodegenCase` to
  `_buildFieldMatrixAndExtraMapCases` (Slice 5).

This suite uses `verifyGeneratorBatch` from `package:source_gen_test`.
If using an AI agent, load the bundled `source-gen-test-fuzz` skill
(`dart run skills@ get` or see `skills/source-gen-test-fuzz/SKILL.md` in
`package:source_gen_test`).''';

Set<String> _extractExercisedAnnotationArgs(
  Iterable<CodegenCase> cases,
  String annotationName,
) {
  final pattern = RegExp('@$annotationName\\s*\\(([^)]*)\\)', multiLine: true);
  final argNamePattern = RegExp(r'(\b\w+)\s*:');
  final found = <String>{};
  for (final c in cases) {
    for (final match in pattern.allMatches(c.declarations)) {
      for (final argMatch in argNamePattern.allMatches(match.group(1)!)) {
        found.add(argMatch.group(1)!);
      }
    }
  }
  return found;
}

void main() {
  group(
    'JsonSerializableGenerator combinatorial soundness (source-gen-fuzz)',
    () {
      // #CHANGE WHEN UPDATING json_annotation
      test(
        'surface area drift guard: all supported types, map keys, and '
        'annotation parameters are exercised in positive fuzz cases',
        () async {
          final positiveCases = <CodegenCase>[
            ..._buildCoreAndContainerCases(),
            ..._buildHierarchyGenericAndTypedefCases(),
            ..._buildConverterConfigAndAuxCases(),
            ..._buildFieldMatrixAndExtraMapCases(),
          ];

          expect(
            _coreTypeSpecs.map((s) => s.supportedTypeName).toSet(),
            unorderedEquals(supportedTypes().toSet()),
            reason:
                'Every type in supportedTypes() (tool/readme_builder.dart) '
                'must have a `_FieldTypeSpec` in `_coreTypeSpecs`.\n'
                '$_driftRemediationHint',
          );

          expect(
            _coreTypeSpecs.map((s) => s.mapKeyTypeName).nonNulls.toSet(),
            unorderedEquals(allowedMapKeyTypes.toSet()),
            reason:
                'Every type in allowedMapKeyTypes (map_helper.dart) must have '
                'a map `_FieldTypeSpec` in `_coreTypeSpecs`.\n'
                '$_driftRemediationHint',
          );

          final reader = await initializeLibraryReader({
            'annotation_surface.dart': '''
export 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey, JsonEnum;
''',
          }, 'annotation_surface.dart');

          final exported = reader.element.exportNamespace.definedNames2;
          for (final annotationName in const [
            'JsonSerializable',
            'JsonKey',
            'JsonEnum',
          ]) {
            final cls = exported[annotationName] as ClassElement;
            final expectedParams = {
              for (final param in cls.unnamedConstructor!.formalParameters)
                if (!param.metadata.hasDeprecated) param.name!,
            };
            final exercisedParams = _extractExercisedAnnotationArgs(
              positiveCases,
              annotationName,
            );

            expect(
              exercisedParams,
              containsAll(expectedParams),
              reason:
                  'Every non-deprecated parameter on @$annotationName '
                  '(missing: ${expectedParams.difference(exercisedParams)}) '
                  'must be exercised in at least one positive CodegenCase.\n'
                  '$_driftRemediationHint',
            );
          }

          // Also cross-check against build.yaml config keys from shared_config.
          expect(
            generatorConfigDefaultJson.keys.length,
            16,
            reason:
                'If build.yaml config keys changed in json_annotation, ensure '
                'they are exercised in test/src/codegen_fuzz_test.dart.\n'
                '$_driftRemediationHint',
          );
        },
      );

      test(
        'slice 1: core scalars, dates, enums, collections, and records',
        () async {
          final cases = _buildCoreAndContainerCases();
          expect(cases.length, greaterThanOrEqualTo(200));

          final report = await verifyGeneratorBatch(
            generator: JsonSerializableGenerator(),
            imports: _sharedImports,
            preamble: _sharedPreamble,
            auxiliaryFiles: _auxFiles,
            cases: cases,
          );

          expect(report.passedCases, report.totalCases);
          expect(report.issues, isEmpty);
        },
      );

      test(
        'slice 2: origins, inheritance, mixins, generics, and typedefs',
        () async {
          final cases = _buildHierarchyGenericAndTypedefCases();
          expect(cases.length, greaterThanOrEqualTo(100));

          final report = await verifyGeneratorBatch(
            generator: JsonSerializableGenerator(),
            imports: _sharedImports,
            preamble: _sharedPreamble,
            auxiliaryFiles: _auxFiles,
            cases: cases,
          );

          expect(report.passedCases, report.totalCases);
          expect(report.issues, isEmpty);
        },
      );

      test(
        'slice 3: converters, callbacks, fieldRename, and auxiliary outputs',
        () async {
          final cases = _buildConverterConfigAndAuxCases();
          expect(cases.length, greaterThanOrEqualTo(100));

          final report = await verifyGeneratorBatch(
            generator: JsonSerializableGenerator(),
            imports: _sharedImports,
            preamble: _sharedPreamble,
            auxiliaryFiles: _auxFiles,
            cases: cases,
          );

          expect(report.passedCases, report.totalCases);
          expect(report.issues, isEmpty);
        },
      );

      test('slice 4: negative expectedError diagnostic contracts', () async {
        final cases = _buildNegativeDiagnosticCases();
        expect(cases.length, 36);

        final report = await verifyGeneratorBatch(
          generator: JsonSerializableGenerator(),
          imports: _sharedImports,
          preamble: _sharedPreamble,
          auxiliaryFiles: _auxFiles,
          cases: cases,
        );

        expect(report.passedCases, report.totalCases);
        expect(report.issues, isEmpty);
      });

      test(
        'slice 5: field matrix visibility/inclusion and extra map edge cases',
        () async {
          final cases = _buildFieldMatrixAndExtraMapCases();
          expect(cases.length, 27);

          final report = await verifyGeneratorBatch(
            generator: JsonSerializableGenerator(),
            imports: _sharedImports,
            preamble: _sharedPreamble,
            auxiliaryFiles: _auxFiles,
            cases: cases,
          );

          expect(report.passedCases, report.totalCases);
          expect(report.issues, isEmpty);
        },
      );
    },
  );
}
