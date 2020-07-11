// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:meta/meta.dart';

import 'shared.dart';

const _typesToTest = {
  'BigInt': _TestType(
    jsonExpression: "'12345'",
    altJsonExpression: "'67890'",
  ),
  'bool': _TestType(
    defaultExpression: 'true',
    altJsonExpression: 'false',
  ),
  'DateTime': _TestType(
    jsonExpression: "'2020-01-01T00:00:00.000'",
    altJsonExpression: "'2018-01-01T00:00:00.000'",
  ),
  'double': _TestType(
    defaultExpression: '3.14',
    altJsonExpression: '6.28',
  ),
  'Duration': _TestType(
    jsonExpression: '1234',
    altJsonExpression: '2345',
  ),
  'dynamic': _TestType(
    altJsonExpression: "'dynamic'",
  ),
  'num': _TestType(
    defaultExpression: '88.6',
    altJsonExpression: '29',
  ),
  'Object': _TestType(
    altJsonExpression: "'Object'",
  ),
  'String': _TestType(
    defaultExpression: "'a string'",
    altJsonExpression: "'another string'",
  ),
  'Uri': _TestType(
    jsonExpression: "'https://example.com'",
    altJsonExpression: "'https://dart.dev'",
  ),
  'MyEnum': _TestType(
    defaultExpression: 'MyEnum.alpha',
    jsonExpression: "'alpha'",
    altJsonExpression: "'beta'",
    replacements: [
      Replacement(
        '@JsonSerializable()',
        '''
enum MyEnum { alpha, beta, gamma, delta }

@JsonSerializable()''',
      )
    ],
  ),
  //
  // Collection types
  //
  'Map': _TestType(
    defaultExpression: "{'a': 1}",
    altJsonExpression: "{'b': 2}",
  ),
  'List': _TestType(
    defaultExpression: '[$_defaultCollectionExpressions]',
    altJsonExpression: '[$_altCollectionExpressions]',
  ),
  'Set': _TestType(
    defaultExpression: '{$_defaultCollectionExpressions}',
    jsonExpression: '[$_defaultCollectionExpressions]',
    altJsonExpression: '[$_altCollectionExpressions]',
  ),
  'Iterable': _TestType(
    defaultExpression: '[$_defaultCollectionExpressions]',
    altJsonExpression: '[$_altCollectionExpressions]',
  ),
};

const _defaultCollectionExpressions = '42, true, false, null';
const _altCollectionExpressions = '43, false';

Builder typeBuilder([_]) => validate('_type_builder', const _TypeBuilder());

class _TypeBuilder implements Builder {
  const _TypeBuilder();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    final sourceContent = await buildStep.readAsString(inputId);

    for (var entry in _typesToTest.entries) {
      final type = entry.key;
      final newId = buildStep.inputId.changeExtension(_toTypeExtension(type));

      await buildStep.writeAsString(
        newId,
        Replacement.generate(
          sourceContent,
          entry.value.replacements(type),
        ),
      );
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': _typesToTest.keys.map(_toTypeExtension).toSet().toList()
          ..sort()
      };
}

Builder typeTestBuilder([_]) =>
    validate('_type_test_builder', const _TypeTestBuilder());

class _TypeTestBuilder implements Builder {
  const _TypeTestBuilder();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    final sourceContent = await buildStep.readAsString(inputId);

    for (var entry in _typesToTest.entries) {
      final type = entry.key;
      final newId =
          buildStep.inputId.changeExtension(_toTypeTestExtension(type));

      await buildStep.writeAsString(
        newId,
        Replacement.generate(
          sourceContent,
          entry.value.testReplacements(type),
        ),
      );
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': _typesToTest.keys.map(_toTypeTestExtension).toSet().toList()
          ..sort()
      };
}

String _typeToPathPart(String type) => type.toLowerCase();

String _toTypeExtension(String e, {bool includeDotDart = true}) =>
    '.type_${_typeToPathPart(e)}${includeDotDart ? '.dart' : ''}';

String _toTypeTestExtension(String e) => '.${_typeToPathPart(e)}_test.dart';

class _TestType {
  final List<Replacement> _replacements;
  final String defaultExpression;
  final String jsonExpression;
  final String altJsonExpression;

  const _TestType({
    List<Replacement> replacements,
    this.defaultExpression,
    String jsonExpression,
    @required String altJsonExpression,
  })  : _replacements = replacements ?? const [],
        jsonExpression = jsonExpression ?? defaultExpression,
        altJsonExpression =
            altJsonExpression ?? jsonExpression ?? defaultExpression;

  Iterable<Replacement> replacements(String type) sync* {
    final newPart = _toTypeExtension(type, includeDotDart: false);

    yield Replacement(
      "part 'input.g.dart';",
      "part 'input$newPart.g.dart';",
    );
    yield Replacement(
      'final int value;',
      'final $type value;',
    );
    yield Replacement(
      'final int nullable;',
      'final $type nullable;',
    );

    yield* _replacements;

    final defaultReplacement = defaultExpression == null
        ? ''
        : _defaultSource
            .replaceFirst('42', defaultExpression)
            .replaceFirst('int', type);

    yield Replacement(
      _defaultSource,
      defaultReplacement,
    );
  }

  Iterable<Replacement> testReplacements(String type) sync* {
    yield Replacement(
      "import 'input.dart';",
      "import 'input.type_${_typeToPathPart(type)}.dart';",
    );

    yield Replacement(
      '''
final _defaultValue = 42;
final _altValue = 43;
''',
      '''
final _defaultValue = $jsonExpression;
final _altValue = $altJsonExpression;
''',
    );

    if (defaultExpression == null) {
      yield const Replacement(
        "  'withDefault': _defaultValue,\n",
        '',
      );
      yield const Replacement(
        "  'withDefault': _altValue,\n",
        '',
      );
    }
  }

  static const _defaultSource = r'''
  @JsonKey(defaultValue: 42)
  int withDefault;

''';
}
