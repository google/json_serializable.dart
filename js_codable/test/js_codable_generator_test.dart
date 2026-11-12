// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

@TestOn('vm')
library;

import 'dart:io';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:js_codable/builder.dart';
import 'package:js_codable/js_codable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

import 'fixtures/models.dart' as fixtures;

Future<String> _generateFormatted(
  String source, {
  JsonSerializable? config,
  Map<String, String> extraFiles = const {},
}) async {
  final files = <String, String>{'test_lib.dart': source, ...extraFiles};
  final reader = await initializeLibraryReader(files, 'test_lib.dart');
  final raw = JsCodableGenerator(
    config: config,
  ).generateForLibraryReader(reader);
  if (raw.isEmpty) return '';
  return DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format(raw);
}

void main() {
  late String validModelsOutput;

  setUpAll(() async {
    validModelsOutput = await _generateFormatted(
      _allValidModelsSource,
      extraFiles: {
        'child_lib.dart': '''
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ExternalChild {
  final String name;
  ExternalChild({required this.name});
}
''',
      },
    );
  });

  group('JsCodableGenerator VM code generation', () {
    test(
      'primitives, nullables, constructor defaults, and @JsonKey(defaultValue)',
      () {
        expect(
          validModelsOutput,
          contains(
            'extension type const PrimitiveModelJS._(JSObject _) '
            'implements JSObject',
          ),
        );
        expect(validModelsOutput, contains('required String name,'));
        expect(validModelsOutput, contains('required int count,'));
        expect(validModelsOutput, contains('required double ratio,'));
        expect(validModelsOutput, contains('required num genericNum,'));
        expect(validModelsOutput, contains('required bool flag,'));
        expect(validModelsOutput, contains('String? optName,'));
        expect(validModelsOutput, contains('int? optCount,'));
        expect(validModelsOutput, contains('required int defaultedCount,'));
        expect(
          validModelsOutput,
          contains('required String annotatedDefault,'),
        );

        // Getters for defaulted fields must be nullable on the JS extension
        // type so omitted JS `undefined` properties fall back to defaultValue.
        expect(validModelsOutput, contains('external String get name;'));
        expect(
          validModelsOutput,
          contains('external int? get defaultedCount;'),
        );
        expect(
          validModelsOutput,
          contains('external String? get annotatedDefault;'),
        );

        // Decode must apply default values and zero redundant primitive casts.
        expect(validModelsOutput, contains('name: js.name,'));
        expect(
          validModelsOutput,
          contains('defaultedCount: js.defaultedCount ?? 42,'),
        );
        expect(
          validModelsOutput,
          contains("annotatedDefault: js.annotatedDefault ?? 'fallback',"),
        );
        expect(validModelsOutput, isNot(contains(' as String')));
        expect(validModelsOutput, isNot(contains(' as int')));
        expect(validModelsOutput, isNot(contains(' as double')));
        expect(validModelsOutput, isNot(contains(' as num')));
        expect(validModelsOutput, isNot(contains(' as bool')));
      },
    );

    test('core types (DateTime, Uri, BigInt, Duration) with zero casts '
        'and single-read nullable switches', () {
      expect(validModelsOutput, contains('external String get createdAt;'));
      expect(validModelsOutput, contains('external String? get updatedAt;'));
      expect(validModelsOutput, contains('external String get endpoint;'));
      expect(validModelsOutput, contains('external String? get redirectUri;'));
      expect(validModelsOutput, contains('external String get bigValue;'));
      expect(validModelsOutput, contains('external String? get optBigValue;'));
      expect(validModelsOutput, contains('external int get timeout;'));
      expect(validModelsOutput, contains('external int? get optTimeout;'));

      // Non-nullable conversions.
      expect(
        validModelsOutput,
        contains('createdAt: DateTime.parse(js.createdAt),'),
      );
      expect(validModelsOutput, contains('endpoint: Uri.parse(js.endpoint),'));
      expect(
        validModelsOutput,
        contains('bigValue: BigInt.parse(js.bigValue),'),
      );
      expect(
        validModelsOutput,
        contains('timeout: Duration(microseconds: js.timeout),'),
      );

      // Nullable single-read pattern switch (avoiding unpromotable external
      // getter re-reads).
      expect(
        validModelsOutput,
        contains('''
  updatedAt: switch (js.updatedAt) {
    final v? => DateTime.parse(v),
    null => null,
  },'''),
      );
      expect(
        validModelsOutput,
        contains('''
  optTimeout: switch (js.optTimeout) {
    final v? => Duration(microseconds: v),
    null => null,
  },'''),
      );

      // Serialization.
      expect(
        validModelsOutput,
        contains('createdAt: instance.createdAt.toIso8601String(),'),
      );
      expect(
        validModelsOutput,
        contains('updatedAt: instance.updatedAt?.toIso8601String(),'),
      );
      expect(
        validModelsOutput,
        contains('endpoint: instance.endpoint.toString(),'),
      );
      expect(
        validModelsOutput,
        contains('redirectUri: instance.redirectUri?.toString(),'),
      );
      expect(
        validModelsOutput,
        contains('bigValue: instance.bigValue.toString(),'),
      );
      expect(
        validModelsOutput,
        contains('timeout: instance.timeout.inMicroseconds,'),
      );
      expect(
        validModelsOutput,
        contains('optTimeout: instance.optTimeout?.inMicroseconds,'),
      );
    });

    test('enums with string and int @JsonValue / @JsonEnum', () {
      expect(
        validModelsOutput,
        contains("import 'package:json_annotation/json_annotation.dart';"),
      );
      expect(validModelsOutput, contains('external String get status;'));
      expect(validModelsOutput, contains('external String? get optStatus;'));
      expect(validModelsOutput, contains('external int? get level;'));
      expect(
        validModelsOutput,
        contains(r'status: $enumDecode(_$StatusEnumMap, js.status),'),
      );
      expect(
        validModelsOutput,
        contains(
          r'optStatus: $enumDecodeNullable(_$StatusEnumMap, js.optStatus),',
        ),
      );
      expect(
        validModelsOutput,
        contains(
          r'level: $enumDecodeNullable(_$LevelEnumMap, js.level) ?? Level.low,',
        ),
      );
      expect(
        validModelsOutput,
        contains(r'status: _$StatusEnumMap[instance.status]!,'),
      );
      expect(
        validModelsOutput,
        contains(r'optStatus: _$StatusEnumMap[instance.optStatus],'),
      );
      expect(
        validModelsOutput,
        contains(r'level: _$LevelEnumMap[instance.level]!,'),
      );
      expect(validModelsOutput, contains(r'const _$StatusEnumMap = {'));
      expect(validModelsOutput, contains(r'const _$LevelEnumMap = {'));
    });

    test(
      'renamed keys (FieldRename.snake, @JsonKey) and non-identifier wire keys '
      '(kebab-case, dot.key)',
      () {
        // Valid JS identifiers with renamed wire keys get @JS(...) on both
        // external factory parameters and external getters.
        expect(
          validModelsOutput,
          contains('''
  external factory KeyNamingModelJS({
    @JS('first_name') required String firstName,
    @JS('custom_wire') required int customField,
  });'''),
        );
        expect(
          validModelsOutput,
          contains('''
  @JS('first_name')
  external String get firstName;'''),
        );
        expect(
          validModelsOutput,
          contains('''
  @JS('custom_wire')
  external int get customField;'''),
        );

        // Non-identifier wire keys are omitted from external factory and get
        // setters.
        expect(
          validModelsOutput,
          contains('''
  @JS('kebab-key')
  external String get kebabKey;'''),
        );
        expect(
          validModelsOutput,
          contains('''
  @JS('kebab-key')
  external set kebabKey(String value);'''),
        );

        // Dot-containing wire keys use getProperty / setProperty instead of
        // @JS('nested.dot').
        expect(validModelsOutput, contains("import 'dart:js_interop_unsafe';"));
        expect(
          validModelsOutput,
          contains(
            'int get dotKey => '
            "_.getProperty<JSNumber>('nested.dot'.toJS).toDartInt;",
          ),
        );
        expect(
          validModelsOutput,
          contains(
            'set dotKey(int value) => '
            "_.setProperty('nested.dot'.toJS, value.toJS);",
          ),
        );

        // $ToJs cascades non-identifier wire keys.
        expect(validModelsOutput, contains('..kebabKey = instance.kebabKey'));
        expect(validModelsOutput, contains('..dotKey = instance.dotKey'));
      },
    );

    test(
      'nested @JsonSerializable classes, List<Child>, List<String>, List<int>, '
      'and Set<String>',
      () {
        expect(validModelsOutput, contains('external ChildItemJS get child;'));
        expect(
          validModelsOutput,
          contains('external ChildItemJS? get optChild;'),
        );
        expect(
          validModelsOutput,
          contains('external JSArray<ChildItemJS> get children;'),
        );
        expect(
          validModelsOutput,
          contains('external JSArray<JSString> get strings;'),
        );
        expect(
          validModelsOutput,
          contains('external JSArray<JSNumber> get ints;'),
        );
        expect(
          validModelsOutput,
          contains('external JSArray<JSString> get tagSet;'),
        );

        // Decode.
        expect(
          validModelsOutput,
          contains(r'child: $ChildItemFromJs(js.child),'),
        );
        expect(
          validModelsOutput,
          contains(r'''
  optChild: switch (js.optChild) {
    final v? => $ChildItemFromJs(v),
    null => null,
  },'''),
        );
        expect(
          validModelsOutput,
          contains(
            r'children: js.children.toDart.map($ChildItemFromJs).toList(),',
          ),
        );
        expect(
          validModelsOutput,
          contains('strings: js.strings.toDart.map((e) => e.toDart).toList(),'),
        );
        expect(
          validModelsOutput,
          contains('ints: js.ints.toDart.map((e) => e.toDartInt).toList(),'),
        );
        expect(
          validModelsOutput,
          contains('tagSet: js.tagSet.toDart.map((e) => e.toDart).toSet(),'),
        );

        // Encode.
        expect(
          validModelsOutput,
          contains(r'child: $ChildItemToJs(instance.child),'),
        );
        expect(
          validModelsOutput,
          contains(
            r'children: instance.children.map($ChildItemToJs).toList().toJS,',
          ),
        );
        expect(
          validModelsOutput,
          contains(
            'strings: instance.strings.map((e) => e.toJS).toList().toJS,',
          ),
        );
        expect(
          validModelsOutput,
          contains('ints: instance.ints.map((e) => e.toJS).toList().toJS,'),
        );
        expect(
          validModelsOutput,
          contains('tagSet: instance.tagSet.map((e) => e.toJS).toList().toJS,'),
        );
      },
    );

    test('Map<String, int> and Map<String, Child> use Object.keys + '
        'getProperty/setProperty (never .dartify())', () {
      expect(validModelsOutput, contains("import 'dart:js_interop_unsafe';"));
      expect(
        validModelsOutput,
        contains('''
@JS('Object.keys')
external JSArray<JSString> _\$jsObjectKeys(JSObject obj);'''),
      );
      expect(validModelsOutput, contains('external JSObject get counts;'));
      expect(validModelsOutput, contains('external JSObject get nodes;'));
      expect(
        validModelsOutput,
        contains('m.getProperty<JSNumber>(k).toDartInt'),
      );
      expect(
        validModelsOutput,
        contains(r'$ChildNodeFromJs(m.getProperty<ChildNodeJS>(k))'),
      );
      expect(
        validModelsOutput,
        contains(r'$map.setProperty(key.toJS, value.toJS);'),
      );
      expect(
        validModelsOutput,
        contains(r'$map.setProperty(key.toJS, $ChildNodeToJs(value));'),
      );
    });

    test('custom @JsonConverter<T, S> and @JsonKey(fromJson, toJson) for '
        'primitive S and Map S', () {
      // Primitive wire types S (String, int) appear directly on the
      // extension type.
      expect(validModelsOutput, contains('external String get token;'));
      expect(validModelsOutput, contains('external int get timestamp;'));
      // Map<String, dynamic> wire type S uses JSObject on the extension type.
      expect(validModelsOutput, contains('external JSObject get bag;'));

      // Decode.
      expect(
        validModelsOutput,
        contains('token: const TokenConverter().fromJson(js.token),'),
      );
      expect(
        validModelsOutput,
        contains('timestamp: fromEpoch(js.timestamp),'),
      );
      expect(
        validModelsOutput,
        contains(
          'bag: const BagConverter().fromJson(\n'
          '    (js.bag.dartify() as Map).cast<String, dynamic>(),\n'
          '  ),',
        ),
      );

      // Encode.
      expect(
        validModelsOutput,
        contains('token: const TokenConverter().toJson(instance.token),'),
      );
      expect(
        validModelsOutput,
        contains('timestamp: toEpoch(instance.timestamp),'),
      );
      expect(
        validModelsOutput,
        contains(
          'bag: (const BagConverter().toJson(instance.bag).jsify() '
          'as JSObject),',
        ),
      );
    });

    test('inheritance (InheritanceManager3 subclass overriding superclass '
        'fields/getters)', () {
      expect(
        validModelsOutput,
        contains('''
  @JS('custom_id')
  external String get id;'''),
      );
      expect(
        validModelsOutput,
        contains('''
  @JS('inherited_count')
  external int? get inheritedCount;'''),
      );
      expect(
        validModelsOutput,
        contains('''
  @JS('sub_label')
  external String get subLabel;'''),
      );
      expect(validModelsOutput, contains('id: js.id,'));
      expect(
        validModelsOutput,
        contains('inheritedCount: js.inheritedCount ?? 5,'),
      );
      expect(validModelsOutput, contains('subLabel: js.subLabel,'));
    });

    test('cross-library nested @JsonSerializable class imports companion '
        '.js_codable.dart', () {
      expect(validModelsOutput, contains("import 'child_lib.dart';"));
      expect(
        validModelsOutput,
        contains("import 'child_lib.js_codable.dart';"),
      );
      expect(validModelsOutput, contains("import 'test_lib.dart';"));
      expect(
        validModelsOutput,
        contains('external ExternalChildJS get child;'),
      );
      expect(
        validModelsOutput,
        contains(r'ParentLibModel(child: $ExternalChildFromJs(js.child))'),
      );
      expect(
        validModelsOutput,
        contains(
          r'ParentLibModelJS(child: $ExternalChildToJs(instance.child))',
        ),
      );
    });

    test('jsCodableBuilder creates a LibraryBuilder for .js_codable.dart', () {
      final builder = jsCodableBuilder(
        const BuilderOptions({
          'field_rename': 'snake',
          'run_only_if_triggered': true,
        }),
      );
      expect(
        builder.buildExtensions,
        equals({
          '.dart': ['.js_codable.dart'],
        }),
      );
    });

    test(
      'mutable fields, createToJson: false views, doc comments, and '
      '@JsonKey(includeIfNull: true) required nullable factory params',
      () async {
        final output = await _generateFormatted('''
import 'package:json_annotation/json_annotation.dart';

/// In-place mutated view model.
@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
  createToJson: false,
)
class MutableView {
  /// Read-only identifier.
  final String itemId;

  /// Mutated in place.
  double lineTotal;

  MutableView({
    required this.itemId,
    this.lineTotal = 0,
  });
}

@JsonSerializable(createFactory: false)
class OutputResult {
  final int totalRows;

  @JsonKey(includeIfNull: true)
  final String? firstRowId;

  final String? optionalNote;

  const OutputResult({
    required this.totalRows,
    required this.firstRowId,
    this.optionalNote,
  });
}
''');

        expect(output, contains('/// In-place mutated view model.'));
        expect(output, contains('/// Read-only identifier.'));
        expect(
          output,
          contains('''
  @JS('item_id')
  external String get itemId;'''),
        );
        expect(output, isNot(contains('set itemId(')));
        expect(
          output,
          contains('''
  @JS('line_total')
  external double? get lineTotal;
  @JS('line_total')
  external set lineTotal(double? value);'''),
        );
        expect(output, isNot(contains('external factory MutableViewJS(')));

        expect(
          output,
          contains('''
  external factory OutputResultJS({
    required int totalRows,
    required String? firstRowId,
    String? optionalNote,
  });'''),
        );
      },
    );
  });

  group('error handling & validation', () {
    test('rejects private @JsonSerializable class', () async {
      await expectLater(
        _generateFormatted('''
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class _PrivateClass {
  final String a;
  _PrivateClass(this.a);
}
'''),
        throwsA(
          isA<InvalidGenerationSourceError>().having(
            (e) => e.message,
            'message',
            contains('must be public'),
          ),
        ),
      );
    });

    test('rejects private constructor', () async {
      await expectLater(
        _generateFormatted('''
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(constructor: '_internal')
class PrivateCtorClass {
  final String a;
  PrivateCtorClass._internal(this.a);
}
'''),
        throwsA(
          isA<InvalidGenerationSourceError>().having(
            (e) => e.message,
            'message',
            contains('is private and cannot be invoked'),
          ),
        ),
      );
    });

    test('rejects private fromJson function', () async {
      await expectLater(
        _generateFormatted('''
import 'package:json_annotation/json_annotation.dart';

String _privateFromJson(String s) => s;

@JsonSerializable()
class PrivateFnClass {
  @JsonKey(fromJson: _privateFromJson)
  final String a;
  PrivateFnClass(this.a);
}
'''),
        throwsA(
          isA<InvalidGenerationSourceError>().having(
            (e) => e.message,
            'message',
            contains('is private and cannot be accessed'),
          ),
        ),
      );
    });

    test('rejects unsupported field type', () async {
      await expectLater(
        _generateFormatted('''
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BadFieldClass {
  final Stopwatch watch;
  BadFieldClass(this.watch);
}
'''),
        throwsA(
          isA<InvalidGenerationSourceError>().having(
            (e) => e.message,
            'message',
            contains('Could not generate `fromJson` code for `watch`'),
          ),
        ),
      );
    });

    test('rejects invalid BuilderOptions in jsCodableBuilder', () {
      expect(
        () => jsCodableBuilder(const BuilderOptions({'unknown_option': true})),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('Could not parse the options provided for `js_codable`.'),
          ),
        ),
      );
    });

    test(
      'rejects genericArgumentFactories: true with explicit message',
      () async {
        await expectLater(
          _generateFormatted('''
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericBox<T> {
  final T value;
  GenericBox(this.value);
}
'''),
          throwsA(
            isA<InvalidGenerationSourceError>().having(
              (e) => e.message,
              'message',
              contains(
                '`genericArgumentFactories: true` is not supported by '
                '`js_codable`',
              ),
            ),
          ),
        );
      },
    );
  });

  group('test/fixtures/models.dart pure-Dart VM & codegen sync', () {
    test(
      'models.dart has zero dart:js_interop imports and runs on the Dart VM',
      () {
        final modelsSource = File(
          p.join('test', 'fixtures', 'models.dart'),
        ).readAsStringSync();
        expect(modelsSource, isNot(contains('dart:js_interop')));

        const child = fixtures.Child(id: 'c1', count: 3, label: 'three');
        const derived = fixtures.DerivedEntity(
          id: 'd1',
          baseScore: 20,
          title: 'Derived',
          version: 2,
        );
        expect(child.id, 'c1');
        expect(derived.id, 'd1');
        expect(derived.baseScore, 20);
      },
    );

    test('models.js_codable.dart matches JsCodableGenerator output for '
        'models.dart', () async {
      final reader = await initializeLibraryReaderForDirectory(
        p.join('test', 'fixtures'),
        'models.dart',
      );
      final raw = JsCodableGenerator().generateForLibraryReader(reader);
      final formatter = DartFormatter(
        languageVersion: DartFormatter.latestLanguageVersion,
      );
      final formatted =
          '// GENERATED CODE - DO NOT MODIFY BY HAND\n\n'
          '${formatter.format(raw)}';

      final generatedFile = File(
        p.join('test', 'fixtures', 'models.js_codable.dart'),
      );
      expect(generatedFile.readAsStringSync(), formatted);
    });
  });
}

const _allValidModelsSource = '''
import 'package:json_annotation/json_annotation.dart';
import 'child_lib.dart';

@JsonSerializable()
class PrimitiveModel {
  final String name;
  final int count;
  final double ratio;
  final num genericNum;
  final bool flag;
  final String? optName;
  final int? optCount;
  final int defaultedCount;
  @JsonKey(defaultValue: 'fallback')
  final String annotatedDefault;

  PrimitiveModel({
    required this.name,
    required this.count,
    required this.ratio,
    required this.genericNum,
    required this.flag,
    this.optName,
    this.optCount,
    this.defaultedCount = 42,
    required this.annotatedDefault,
  });
}

@JsonSerializable()
class CoreTypesModel {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Uri endpoint;
  final Uri? redirectUri;
  final BigInt bigValue;
  final BigInt? optBigValue;
  final Duration timeout;
  final Duration? optTimeout;

  CoreTypesModel({
    required this.createdAt,
    this.updatedAt,
    required this.endpoint,
    this.redirectUri,
    required this.bigValue,
    this.optBigValue,
    required this.timeout,
    this.optTimeout,
  });
}

enum Status {
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
}

@JsonEnum(valueField: 'code')
enum Level {
  low(10),
  high(20);

  const Level(this.code);
  final int code;
}

@JsonSerializable()
class EnumModel {
  final Status status;
  final Status? optStatus;
  final Level level;

  EnumModel({
    required this.status,
    this.optStatus,
    this.level = Level.low,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
class KeyNamingModel {
  final String firstName;
  @JsonKey(name: 'custom_wire')
  final int customField;
  @JsonKey(name: 'kebab-key')
  final String kebabKey;
  @JsonKey(name: 'nested.dot')
  final int dotKey;

  KeyNamingModel({
    required this.firstName,
    required this.customField,
    required this.kebabKey,
    required this.dotKey,
  });
}

@JsonSerializable()
class ChildItem {
  final String id;
  ChildItem({required this.id});
}

@JsonSerializable()
class ContainerModel {
  final ChildItem child;
  final ChildItem? optChild;
  final List<ChildItem> children;
  final List<String> strings;
  final List<int> ints;
  final Set<String> tagSet;

  ContainerModel({
    required this.child,
    this.optChild,
    required this.children,
    required this.strings,
    required this.ints,
    required this.tagSet,
  });
}

@JsonSerializable()
class ChildNode {
  final int v;
  ChildNode({required this.v});
}

@JsonSerializable()
class MapModel {
  final Map<String, int> counts;
  final Map<String, ChildNode> nodes;

  MapModel({required this.counts, required this.nodes});
}

class Token {
  final String raw;
  const Token(this.raw);
}

class TokenConverter extends JsonConverter<Token, String> {
  const TokenConverter();
  @override
  Token fromJson(String json) => Token(json);
  @override
  String toJson(Token object) => object.raw;
}

class Bag {
  final Map<String, dynamic> map;
  const Bag(this.map);
}

class BagConverter extends JsonConverter<Bag, Map<String, dynamic>> {
  const BagConverter();
  @override
  Bag fromJson(Map<String, dynamic> json) => Bag(json);
  @override
  Map<String, dynamic> toJson(Bag object) => object.map;
}

DateTime fromEpoch(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);
int toEpoch(DateTime dt) => dt.millisecondsSinceEpoch;

@JsonSerializable()
@TokenConverter()
@BagConverter()
class ConverterModel {
  final Token token;
  final Bag bag;
  @JsonKey(fromJson: fromEpoch, toJson: toEpoch)
  final DateTime timestamp;

  ConverterModel({
    required this.token,
    required this.bag,
    required this.timestamp,
  });
}

class SuperBase {
  final String id;
  final int inheritedCount;
  SuperBase({required this.id, required this.inheritedCount});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SubClass extends SuperBase {
  @JsonKey(name: 'custom_id')
  @override
  String get id => super.id;

  final String subLabel;

  SubClass({
    required super.id,
    super.inheritedCount = 5,
    required this.subLabel,
  });
}

@JsonSerializable()
class ParentLibModel {
  final ExternalChild child;
  ParentLibModel({required this.child});
}
''';
