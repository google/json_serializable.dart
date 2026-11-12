// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

@TestOn('vm')
library;

import 'package:js_codable/js_codable.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

const _sharedImports = [
  "import 'dart:js_interop';",
  "import 'dart:js_interop_unsafe';",
  "import 'package:json_annotation/json_annotation.dart';",
  "import 'aux_types.dart';",
];

const _auxFiles = {
  'aux_types.dart': '''
import 'package:json_annotation/json_annotation.dart';

typedef CrossLibId<T> = T;
typedef CrossLibNullable<T> = T?;
typedef CrossLibList<T> = List<T>;
typedef CrossLibMap<V> = Map<String, V>;

@JsonSerializable()
class AuxModel {
  final String title;
  AuxModel(this.title);
}
''',
};

const _sharedPreamble = r'''
typedef LocalId<T> = T;
typedef _PrivateIntAlias = int;

enum FuzzStatus {
  active,
  paused,
  @JsonValue('custom_done')
  done,
}

enum FuzzIntEnum {
  @JsonValue(10)
  ten,
  @JsonValue(20)
  twenty,
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
    (json as num?)?.toInt() ?? bonus;
Object? customToJson(int value, [bool wrap = false]) => wrap ? [value] : value;

int typedFromJsonInt(int json) => json + 1;
int typedToJsonInt(int value) => value - 1;

int? nullableTypedFromJsonInt(int? json) => json;
int? nullableTypedToJsonInt(int? value) => value;

Map<String, dynamic> mapFromJson(Map<String, dynamic> json) => json;
Map<String, dynamic> mapToJson(Map<String, dynamic> value) => value;

List<dynamic> listFromJson(List<dynamic> json) => json;
List<dynamic> listToJson(List<dynamic> value) => value;

class FuzzSuper<T> {
  final T ctorItem;
  T? mutableItem;
  FuzzSuper(this.ctorItem);
}

mixin FuzzMixin {
  int mixinCount = 3;
}

@JsonSerializable()
class NestedPayload {
  final String label;
  final int count;
  const NestedPayload(this.label, this.count);
}

extension type const NestedPayloadJS._(JSObject _) implements JSObject {
  external factory NestedPayloadJS({required String label, required int count});
  external String get label;
  external int get count;
}

NestedPayload $NestedPayloadFromJs(NestedPayloadJS js) =>
    NestedPayload(js.label, js.count);

NestedPayloadJS $NestedPayloadToJs(NestedPayload instance) =>
    NestedPayloadJS(label: instance.label, count: instance.count);

class CustomVal {
  final int id;
  const CustomVal(this.id);
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

class CustomValMapConverter
    implements JsonConverter<CustomVal, Map<String, dynamic>> {
  const CustomValMapConverter();

  @override
  CustomVal fromJson(Map<String, dynamic> json) =>
      CustomVal((json['id'] as num).toInt());

  @override
  Map<String, dynamic> toJson(CustomVal object) => {'id': object.id};
}

class CustomValListConverter
    implements JsonConverter<CustomVal, List<dynamic>> {
  const CustomValListConverter();

  @override
  CustomVal fromJson(List<dynamic> json) =>
      CustomVal((json.first as num).toInt());

  @override
  List<dynamic> toJson(CustomVal object) => [object.id];
}

class BoundedGenericConverter<T extends Object>
    implements JsonConverter<T, String> {
  const BoundedGenericConverter();

  @override
  T fromJson(String json) => json as T;

  @override
  String toJson(T object) => object.toString();
}
''';

class _FieldTypeSpec {
  final String key;
  final String nonNullType;
  final String nullableType;
  final String? constDefaultCode;

  const _FieldTypeSpec({
    required this.key,
    required this.nonNullType,
    required this.nullableType,
    this.constDefaultCode,
  });
}

const _coreTypeSpecs = <_FieldTypeSpec>[
  _FieldTypeSpec(
    key: 'int',
    nonNullType: 'int',
    nullableType: 'int?',
    constDefaultCode: '7',
  ),
  _FieldTypeSpec(
    key: 'double',
    nonNullType: 'double',
    nullableType: 'double?',
    constDefaultCode: '1.5',
  ),
  _FieldTypeSpec(
    key: 'num',
    nonNullType: 'num',
    nullableType: 'num?',
    constDefaultCode: '0',
  ),
  _FieldTypeSpec(
    key: 'string',
    nonNullType: 'String',
    nullableType: 'String?',
    constDefaultCode: "'default_str'",
  ),
  _FieldTypeSpec(
    key: 'bool',
    nonNullType: 'bool',
    nullableType: 'bool?',
    constDefaultCode: 'false',
  ),
  _FieldTypeSpec(key: 'object', nonNullType: 'Object', nullableType: 'Object?'),
  _FieldTypeSpec(
    key: 'dynamic',
    nonNullType: 'dynamic',
    nullableType: 'dynamic',
  ),
  _FieldTypeSpec(
    key: 'dateTime',
    nonNullType: 'DateTime',
    nullableType: 'DateTime?',
  ),
  _FieldTypeSpec(
    key: 'duration',
    nonNullType: 'Duration',
    nullableType: 'Duration?',
    constDefaultCode: 'Duration.zero',
  ),
  _FieldTypeSpec(key: 'bigInt', nonNullType: 'BigInt', nullableType: 'BigInt?'),
  _FieldTypeSpec(key: 'uri', nonNullType: 'Uri', nullableType: 'Uri?'),
  _FieldTypeSpec(
    key: 'enumString',
    nonNullType: 'FuzzStatus',
    nullableType: 'FuzzStatus?',
    constDefaultCode: 'FuzzStatus.active',
  ),
  _FieldTypeSpec(
    key: 'enumInt',
    nonNullType: 'FuzzIntEnum',
    nullableType: 'FuzzIntEnum?',
    constDefaultCode: 'FuzzIntEnum.ten',
  ),
  _FieldTypeSpec(
    key: 'enumNullableVal',
    nonNullType: 'FuzzNullValEnum',
    nullableType: 'FuzzNullValEnum?',
  ),
  _FieldTypeSpec(
    key: 'nestedModel',
    nonNullType: 'NestedPayload',
    nullableType: 'NestedPayload?',
    constDefaultCode: "const NestedPayload('def', 0)",
  ),
  _FieldTypeSpec(
    key: 'listInt',
    nonNullType: 'List<int>',
    nullableType: 'List<int?>?',
    constDefaultCode: 'const [9]',
  ),
  _FieldTypeSpec(
    key: 'listNestedModel',
    nonNullType: 'List<NestedPayload>',
    nullableType: 'List<NestedPayload?>?',
  ),
  _FieldTypeSpec(
    key: 'listDateTime',
    nonNullType: 'List<DateTime>',
    nullableType: 'List<DateTime?>?',
  ),
  _FieldTypeSpec(
    key: 'listEnum',
    nonNullType: 'List<FuzzStatus>',
    nullableType: 'List<FuzzStatus?>?',
  ),
  _FieldTypeSpec(
    key: 'listCustomVal',
    nonNullType: 'List<CustomVal>',
    nullableType: 'List<CustomVal?>?',
  ),
  _FieldTypeSpec(
    key: 'listDynamic',
    nonNullType: 'List<dynamic>',
    nullableType: 'List<dynamic>?',
  ),
  _FieldTypeSpec(
    key: 'mapStringDynamic',
    nonNullType: 'Map<String, dynamic>',
    nullableType: 'Map<String, dynamic>?',
  ),
  _FieldTypeSpec(
    key: 'nestedList',
    nonNullType: 'List<List<int>>',
    nullableType: 'List<List<int?>?>?',
  ),
  _FieldTypeSpec(
    key: 'setString',
    nonNullType: 'Set<String>',
    nullableType: 'Set<String?>?',
    constDefaultCode: "const {'z'}",
  ),
  _FieldTypeSpec(
    key: 'iterableInt',
    nonNullType: 'Iterable<int>',
    nullableType: 'Iterable<int?>?',
    constDefaultCode: 'const [0]',
  ),
  _FieldTypeSpec(
    key: 'mapStringInt',
    nonNullType: 'Map<String, int>',
    nullableType: 'Map<String, int?>?',
    constDefaultCode: "const {'def': 1}",
  ),
  _FieldTypeSpec(
    key: 'mapStringNested',
    nonNullType: 'Map<String, NestedPayload>',
    nullableType: 'Map<String, NestedPayload?>?',
  ),
  _FieldTypeSpec(
    key: 'mapStringListMap',
    nonNullType: 'Map<String, List<Map<String, NestedPayload>>>',
    nullableType: 'Map<String, List<Map<String, NestedPayload?>?>?>?',
  ),
  _FieldTypeSpec(
    key: 'mapEnumInt',
    nonNullType: 'Map<FuzzStatus, int>',
    nullableType: 'Map<FuzzStatus, int?>?',
    constDefaultCode: 'const {FuzzStatus.paused: 0}',
  ),
  _FieldTypeSpec(
    key: 'mapIntEnum',
    nonNullType: 'Map<FuzzIntEnum, int>',
    nullableType: 'Map<FuzzIntEnum, int?>?',
  ),
  _FieldTypeSpec(
    key: 'mapIntString',
    nonNullType: 'Map<int, String>',
    nullableType: 'Map<int, String?>?',
    constDefaultCode: "const {0: 'zero'}",
  ),
  _FieldTypeSpec(
    key: 'mapBigIntString',
    nonNullType: 'Map<BigInt, String>',
    nullableType: 'Map<BigInt, String?>?',
  ),
  _FieldTypeSpec(
    key: 'mapDateTimeInt',
    nonNullType: 'Map<DateTime, int>',
    nullableType: 'Map<DateTime, int?>?',
  ),
  _FieldTypeSpec(
    key: 'mapUriInt',
    nonNullType: 'Map<Uri, int>',
    nullableType: 'Map<Uri, int?>?',
  ),
  _FieldTypeSpec(
    key: 'mapObjectInt',
    nonNullType: 'Map<Object, int>',
    nullableType: 'Map<Object, int?>?',
  ),
  _FieldTypeSpec(
    key: 'mapDynamicInt',
    nonNullType: 'Map<dynamic, int>',
    nullableType: 'Map<dynamic, int?>?',
  ),
];

List<CodegenCase> _buildSlice1CoreAndContainers() {
  final matrix = cartesianProduct<String, String>({
    'specIndex': [for (var i = 0; i < _coreTypeSpecs.length; i++) '$i'],
    'nullability': ['nonNull', 'nullable', 'defaulted'],
    'mutability': ['finalField', 'mutableField'],
    'includeIfNull': ['null', 'true', 'false'],
  });

  final cases = <CodegenCase>[];
  for (var i = 0; i < matrix.length; i++) {
    final row = matrix[i];
    final spec = _coreTypeSpecs[int.parse(row['specIndex']!)];
    final nullMode = row['nullability']!;
    final isMutable = row['mutability'] == 'mutableField';
    final inc = row['includeIfNull']!;

    if (nullMode == 'defaulted' && spec.constDefaultCode == null) {
      continue;
    }
    if (isMutable && inc == 'false' && i.isOdd) {
      continue;
    }

    final isNullable = nullMode == 'nullable';
    final hasDefault = nullMode == 'defaulted';
    final fieldType = isNullable ? spec.nullableType : spec.nonNullType;
    final fieldMod = isMutable ? '' : 'final ';
    final ctorParam = hasDefault
        ? '{this.value = ${spec.constDefaultCode}}'
        : isNullable && isMutable
        ? '[this.value]'
        : 'this.value';
    final incArg = inc == 'null' ? '' : 'includeIfNull: $inc,';
    final fieldJsonKey = inc == 'true' && isNullable
        ? '@JsonKey(includeIfNull: true)'
        : '';
    final className = 'JsCoreFuzz$i';

    cases.add(
      CodegenCase(
        id: 'js_core_${i}_${spec.key}_${nullMode}_${row['mutability']}_inc$inc',
        elementName: className,
        declarations:
            '''
@CustomValConverter()
@JsonSerializable($incArg)
class $className {
  $fieldJsonKey
  $fieldMod$fieldType value;
  $className($ctorParam);
}
''',
      ),
    );
  }
  return cases;
}

List<CodegenCase> _buildSlice2HierarchyAndShapes() {
  final matrix = cartesianProduct<String, String>({
    'shape': [
      'regularField',
      'mutableNoCtorField',
      'getterSetter',
      'getterOnly',
      'superField',
      'mixinProperty',
      'crossLibTypedef',
      'privateTypedef',
    ],
    'nullability': ['nonNull', 'nullable'],
    'createMode': ['both', 'fromOnly', 'toOnly', 'neither'],
    'fieldRename': ['none', 'snake', 'kebab', 'pascal', 'screamingSnake'],
  });

  final cases = <CodegenCase>[];
  for (var i = 0; i < matrix.length; i++) {
    final row = matrix[i];
    final shape = row['shape']!;
    final isNullable = row['nullability'] == 'nullable';
    final createMode = row['createMode']!;
    final rename = row['fieldRename']!;

    if ((i % 3 != 0) &&
        rename != 'none' &&
        rename != 'snake' &&
        rename != 'kebab') {
      continue;
    }

    final createFactory = createMode == 'both' || createMode == 'fromOnly';
    final createToJson = createMode == 'both' || createMode == 'toOnly';
    final className = 'JsHierFuzz$i';

    final effectiveType = switch (shape) {
      'crossLibTypedef' =>
        isNullable ? 'CrossLibNullable<int>' : 'CrossLibId<int>',
      'privateTypedef' => isNullable ? '_PrivateIntAlias?' : '_PrivateIntAlias',
      _ => isNullable ? 'int?' : 'int',
    };

    final classHeader = switch (shape) {
      'superField' => 'class $className extends FuzzSuper<$effectiveType>',
      'mixinProperty' => 'class $className with FuzzMixin',
      _ => 'class $className',
    };

    final bodyMembers = switch (shape) {
      'regularField' || 'crossLibTypedef' || 'privateTypedef' =>
        '''
  final $effectiveType firstName;
  $className(this.firstName);
''',
      'mutableNoCtorField' =>
        '''
  ${isNullable ? '' : 'late '}$effectiveType firstName;
  $className();
''',
      'getterSetter' =>
        '''
  $effectiveType get firstName => ${isNullable ? 'null' : '1'};
  set firstName($effectiveType v) {}
  $className();
''',
      'getterOnly' =>
        '''
  $effectiveType get firstName => ${isNullable ? 'null' : '1'};
  $className();
''',
      'superField' =>
        '''
  $className(super.ctorItem);
''',
      'mixinProperty' =>
        '''
  final $effectiveType firstName;
  $className(this.firstName);
''',
      _ => throw StateError('Unknown shape: $shape'),
    };

    cases.add(
      CodegenCase(
        id: 'js_hier_${i}_${shape}_${row['nullability']}_${createMode}_$rename',
        elementName: className,
        declarations:
            '''
@JsonSerializable(
  fieldRename: FieldRename.$rename,
  createFactory: $createFactory,
  createToJson: $createToJson,
)
$classHeader {
$bodyMembers
}
''',
      ),
    );
  }
  return cases;
}

List<CodegenCase> _buildSlice3ConvertersAndCallbacks() {
  final matrix = cartesianProduct<String, String>({
    'converterMode': [
      'intConverter',
      'nullableObjectConverter',
      'mapConverter',
      'listConverter',
      'topLevelConstConverter',
      'boundedGenericConverter',
      'dynamicFromToJson',
      'typedIntFromToJson',
      'nullableTypedIntFromToJson',
      'mapFromToJson',
      'listFromToJson',
      'unknownEnumFallback',
      'nullForUndefinedEnum',
    ],
    'container': ['scalar', 'list', 'nullableList', 'mapValue'],
    'nullability': ['nonNull', 'nullable', 'defaulted'],
  });

  final cases = <CodegenCase>[];
  for (var i = 0; i < matrix.length; i++) {
    final row = matrix[i];
    final mode = row['converterMode']!;
    final container = row['container']!;
    final nullMode = row['nullability']!;
    final isNullable = nullMode == 'nullable';
    final hasDefault = nullMode == 'defaulted';
    final className = 'JsConvFuzz$i';

    final isCallbackMode = mode.endsWith('FromToJson');
    if (isCallbackMode && container != 'scalar') continue;
    if (mode == 'nullForUndefinedEnum' && !isNullable) continue;

    var classAnnotations = '';
    var fieldAnnotations = '';
    String baseType;
    String defaultExpr;

    switch (mode) {
      case 'intConverter':
        fieldAnnotations = '@CustomValConverter()';
        baseType = 'CustomVal';
        defaultExpr = 'const CustomVal(1)';
      case 'nullableObjectConverter':
        fieldAnnotations = '@CustomValNullableJsonConverter()';
        baseType = 'CustomVal';
        defaultExpr = 'const CustomVal(1)';
      case 'mapConverter':
        fieldAnnotations = '@CustomValMapConverter()';
        baseType = 'CustomVal';
        defaultExpr = 'const CustomVal(1)';
      case 'listConverter':
        fieldAnnotations = '@CustomValListConverter()';
        baseType = 'CustomVal';
        defaultExpr = 'const CustomVal(1)';
      case 'topLevelConstConverter':
        fieldAnnotations = '@topLevelCustomValConverter';
        baseType = 'CustomVal';
        defaultExpr = 'const CustomVal(1)';
      case 'boundedGenericConverter':
        classAnnotations = '@BoundedGenericConverter<String>()';
        baseType = 'String';
        defaultExpr = "'def'";
      case 'dynamicFromToJson':
        if (isNullable) continue;
        fieldAnnotations =
            '@JsonKey(fromJson: customFromJson, toJson: customToJson)';
        baseType = 'int';
        defaultExpr = '5';
      case 'typedIntFromToJson':
        if (isNullable) continue;
        fieldAnnotations =
            '@JsonKey(fromJson: typedFromJsonInt, toJson: typedToJsonInt)';
        baseType = 'int';
        defaultExpr = '5';
      case 'nullableTypedIntFromToJson':
        if (!isNullable) continue;
        fieldAnnotations =
            '@JsonKey(fromJson: nullableTypedFromJsonInt, toJson: nullableTypedToJsonInt)';
        baseType = 'int';
        defaultExpr = '5';
      case 'mapFromToJson':
        if (isNullable) continue;
        fieldAnnotations = '@JsonKey(fromJson: mapFromJson, toJson: mapToJson)';
        baseType = 'Map<String, dynamic>';
        defaultExpr = 'const {}';
      case 'listFromToJson':
        if (isNullable) continue;
        fieldAnnotations =
            '@JsonKey(fromJson: listFromJson, toJson: listToJson)';
        baseType = 'List<dynamic>';
        defaultExpr = 'const []';
      case 'unknownEnumFallback':
        fieldAnnotations = '@JsonKey(unknownEnumValue: FuzzStatus.active)';
        baseType = 'FuzzStatus';
        defaultExpr = 'FuzzStatus.active';
      case 'nullForUndefinedEnum':
        fieldAnnotations =
            '@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)';
        baseType = 'FuzzStatus';
        defaultExpr = 'FuzzStatus.active';
      default:
        throw StateError('Unknown mode: $mode');
    }

    final elemType = isNullable ? '$baseType?' : baseType;
    final fieldType = switch (container) {
      'scalar' => elemType,
      'list' => 'List<$elemType>',
      'nullableList' => 'List<$elemType>?',
      'mapValue' => 'Map<String, $elemType>',
      _ => throw StateError('Unknown container: $container'),
    };
    final ctorDefault = switch (container) {
      'scalar' => defaultExpr,
      'list' || 'nullableList' => 'const []',
      'mapValue' => 'const {}',
      _ => defaultExpr,
    };
    final ctorParam = hasDefault ? '{this.value = $ctorDefault}' : 'this.value';

    cases.add(
      CodegenCase(
        id: 'js_conv_${i}_${mode}_${container}_$nullMode',
        elementName: className,
        declarations:
            '''
$classAnnotations
@JsonSerializable()
class $className {
  $fieldAnnotations
  final $fieldType value;
  $className($ctorParam);
}
''',
      ),
    );
  }
  return cases;
}

List<CodegenCase> _buildSlice4CtorWireKeysAndFieldInclusion() {
  final cases = <CodegenCase>[];

  // 4A: Wire key names x mutability x nullability x includeIfNull
  final wireKeyMatrix = cartesianProduct<String, String>({
    'wireKey': [
      'normalKey',
      r'dollar$Key',
      'kebab-key',
      '123numeric',
      'space key',
    ],
    'mutability': ['finalField', 'mutableField'],
    'nullability': ['nonNull', 'nullable', 'defaulted'],
    'includeIfNull': ['false', 'true'],
  });

  for (var i = 0; i < wireKeyMatrix.length; i++) {
    final row = wireKeyMatrix[i];
    final wireKey = row['wireKey']!;
    final wireKeyCode = wireKey.replaceAll(r'$', r'\$');
    final isMutable = row['mutability'] == 'mutableField';
    final nullMode = row['nullability']!;
    final inc = row['includeIfNull']!;
    final isNullable = nullMode == 'nullable';
    final hasDefault = nullMode == 'defaulted';
    final className = 'JsWireKeyFuzz$i';

    final typeStr = isNullable ? 'String?' : 'String';
    final modStr = isMutable ? '' : 'final ';
    final ctorStr = hasDefault
        ? "{this.prop = 'def'}"
        : isNullable
        ? '[this.prop]'
        : 'this.prop';

    cases.add(
      CodegenCase(
        id: 'js_wire_${i}_${wireKey.replaceAll(' ', '_')}_${row['mutability']}_${nullMode}_inc$inc',
        elementName: className,
        declarations:
            '''
@JsonSerializable(includeIfNull: $inc)
class $className {
  @JsonKey(name: '$wireKeyCode', includeIfNull: $inc)
  $modStr$typeStr prop;
  $className($ctorStr);
}
''',
      ),
    );
  }

  // 4B: Public field x includeFromJson x includeToJson x mutability
  final incMatrix = cartesianProduct<String, String>({
    'includeFromJson': ['null', 'true', 'false'],
    'includeToJson': ['null', 'true', 'false'],
    'mutability': ['finalField', 'mutableField'],
    'wireShape': ['validId', 'kebab-id'],
  });

  for (var i = 0; i < incMatrix.length; i++) {
    final row = incMatrix[i];
    final fromStr = row['includeFromJson']!;
    final toStr = row['includeToJson']!;
    final isMutable = row['mutability'] == 'mutableField';
    final isKebab = row['wireShape'] == 'kebab-id';
    final className = 'JsIncFuzz$i';

    final keyArgs = <String>[
      if (fromStr != 'null') 'includeFromJson: $fromStr',
      if (toStr != 'null') 'includeToJson: $toStr',
      if (isKebab) "name: 'special-field'",
    ];
    final keyAnnot = keyArgs.isEmpty ? '' : '@JsonKey(${keyArgs.join(', ')})';
    final effectiveFrom = fromStr == 'null' ? true : fromStr == 'true';
    final fieldDecl = !effectiveFrom && !isMutable
        ? 'final int targetField = 42;'
        : isMutable
        ? 'int? targetField;'
        : 'final int? targetField;';
    final ctorDecl = !effectiveFrom || isMutable
        ? '$className({this.keep = 1});'
        : '$className(this.targetField, {this.keep = 1});';

    cases.add(
      CodegenCase(
        id: 'js_inc_${i}_from${fromStr}_to${toStr}_${row['mutability']}_${row['wireShape']}',
        elementName: className,
        declarations:
            '''
@JsonSerializable()
class $className {
  final int keep;
  $keyAnnot
  $fieldDecl
  $ctorDecl
}
''',
      ),
    );
  }

  // 4C: Constructor parameter vs field type differences & private field ignore
  cases.addAll(const [
    CodegenCase(
      id: 'js_ctor_nullable_param_non_null_field',
      elementName: 'JsCtorNullableParamNonNullField',
      declarations: '''
@JsonSerializable()
class JsCtorNullableParamNonNullField {
  final int count;
  final DateTime createdAt;
  final NestedPayload payload;
  JsCtorNullableParamNonNullField(
    int? count,
    DateTime? createdAt, {
    NestedPayload? payload,
  }) : count = count ?? 0,
       createdAt = createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
       payload = payload ?? const NestedPayload('fallback', 0);
}
''',
    ),
    CodegenCase(
      id: 'js_ctor_PrivateFieldIgnoredByDefault',
      elementName: 'JsPrivateFieldIgnoredByDefault',
      declarations: '''
@JsonSerializable()
class JsPrivateFieldIgnoredByDefault {
  final int publicVal;
  final int _privateVal = 99;
  JsPrivateFieldIgnoredByDefault(this.publicVal);
  int get readPriv => _privateVal;
}
''',
    ),
  ]);

  return cases;
}

List<CodegenCase> _buildSlice5NegativeDiagnostics() => const <CodegenCase>[
  CodegenCase(
    id: 'neg_private_class',
    elementName: '_PrivateJsClass',
    declarations: '''
@JsonSerializable()
class _PrivateJsClass {
  final int x;
  _PrivateJsClass(this.x);
}
''',
    expectedError: 'must be public',
  ),
  CodegenCase(
    id: 'neg_private_ctor',
    elementName: 'PrivateCtorJsClass',
    declarations: '''
@JsonSerializable(constructor: '_internal')
class PrivateCtorJsClass {
  final int x;
  PrivateCtorJsClass._internal(this.x);
}
''',
    expectedError: 'is private and cannot be invoked',
  ),
  CodegenCase(
    id: 'neg_private_from_json_fn',
    elementName: 'PrivateFromJsonClass',
    declarations: '''
int _privFromJson(int v) => v;
@JsonSerializable()
class PrivateFromJsonClass {
  @JsonKey(fromJson: _privFromJson)
  final int x;
  PrivateFromJsonClass(this.x);
}
''',
    expectedError: 'is private and cannot be accessed',
  ),
  CodegenCase(
    id: 'neg_generic_argument_factories',
    elementName: 'GenericArgFactoriesJsClass',
    declarations: '''
@JsonSerializable(genericArgumentFactories: true)
class GenericArgFactoriesJsClass<T> {
  final T value;
  GenericArgFactoriesJsClass(this.value);
}
''',
    expectedError:
        '`genericArgumentFactories: true` is not supported by `js_codable`',
  ),
  CodegenCase(
    id: 'neg_duplicate_json_key',
    elementName: 'DupeJsonKeyJsClass',
    declarations: '''
@JsonSerializable()
class DupeJsonKeyJsClass {
  @JsonKey(name: 'same')
  final int a;
  @JsonKey(name: 'same')
  final int b;
  DupeJsonKeyJsClass(this.a, this.b);
}
''',
    expectedError: 'More than one field has the JSON key for name "same".',
  ),
];

void main() {
  group('JsCodableGenerator AST combinatorial fuzz suite', () {
    test('Slice 1: Core types, containers, nullability & mutability', () async {
      final cases = _buildSlice1CoreAndContainers();
      final report = await verifyGeneratorBatch(
        generator: JsCodableGenerator(),
        imports: _sharedImports,
        preamble: _sharedPreamble,
        auxiliaryFiles: _auxFiles,
        cases: cases,
      );
      expect(report.issues, isEmpty);
    }, timeout: const Timeout(Duration(minutes: 2)));

    test(
      'Slice 2: Hierarchy, property shapes, createFactory/createToJson & FieldRename',
      () async {
        final cases = _buildSlice2HierarchyAndShapes();
        final report = await verifyGeneratorBatch(
          generator: JsCodableGenerator(),
          imports: _sharedImports,
          preamble: _sharedPreamble,
          auxiliaryFiles: _auxFiles,
          cases: cases,
        );
        expect(report.issues, isEmpty);
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test(
      'Slice 3: JsonConverter, fromJson/toJson callbacks & enum handling',
      () async {
        final cases = _buildSlice3ConvertersAndCallbacks();
        final report = await verifyGeneratorBatch(
          generator: JsCodableGenerator(),
          imports: _sharedImports,
          preamble: _sharedPreamble,
          auxiliaryFiles: _auxFiles,
          cases: cases,
        );
        expect(report.issues, isEmpty);
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test(
      'Slice 4: Wire keys, includeFromJson/includeToJson & constructor shapes',
      () async {
        final cases = _buildSlice4CtorWireKeysAndFieldInclusion();
        final report = await verifyGeneratorBatch(
          generator: JsCodableGenerator(),
          imports: _sharedImports,
          preamble: _sharedPreamble,
          auxiliaryFiles: _auxFiles,
          cases: cases,
        );
        expect(report.issues, isEmpty);
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test('Slice 5: Negative diagnostics & unsupported options', () async {
      final cases = _buildSlice5NegativeDiagnostics();
      final report = await verifyGeneratorBatch(
        generator: JsCodableGenerator(),
        imports: _sharedImports,
        preamble: _sharedPreamble,
        auxiliaryFiles: _auxFiles,
        cases: cases,
      );
      expect(report.issues, isEmpty);
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}
