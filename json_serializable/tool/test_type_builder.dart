// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:json_serializable/src/type_helpers/map_helper.dart';

import 'shared.dart';
import 'test_type_data.dart';

const _trivialTypesToTest = {
  'BigInt': TestTypeData.defaultFunc(
    jsonExpression: "'12345'",
    altJsonExpression: "'67890'",
  ),
  'bool': TestTypeData(defaultExpression: 'true', altJsonExpression: 'false'),
  'DateTime': TestTypeData.defaultFunc(
    jsonExpression: "'2020-01-01T00:00:00.000'",
    altJsonExpression: "'2018-01-01T00:00:00.000'",
  ),
  'double': TestTypeData(defaultExpression: '3.14', altJsonExpression: '6.28'),
  'Duration': TestTypeData(jsonExpression: '1234', altJsonExpression: '2345'),
  customEnumType: TestTypeData(
    defaultExpression: '$customEnumType.alpha',
    jsonExpression: "'alpha'",
    altJsonExpression: "'beta'",
  ),
  'int': TestTypeData(defaultExpression: '42', altJsonExpression: '43'),
  'num': TestTypeData(defaultExpression: '88.6', altJsonExpression: '29'),
  'Object': TestTypeData(defaultExpression: "'o1'", altJsonExpression: "'o2'"),
  'String': TestTypeData(
    defaultExpression: "'a string'",
    altJsonExpression: "'another string'",
  ),
  'Uri': TestTypeData.defaultFunc(
    jsonExpression: "'https://example.com'",
    altJsonExpression: "'https://dart.dev'",
  ),
};

Iterable<String> supportedTypes() => _allTypes.keys;

Iterable<String> collectionTypes() => _collectionTypes.keys;

final _collectionTypes = {
  'Map': TestTypeData(
    defaultExpression: "{'a': 1}",
    altJsonExpression: "{'b': 2}",
    genericArgs: _iterableGenericArgs
        .expand((v) => mapKeyTypes.map((k) => '$k,$v'))
        .toSet(),
  ),
  'List': TestTypeData(
    defaultExpression: '[$_defaultCollectionExpressions]',
    altJsonExpression: '[$_altCollectionExpressions]',
    genericArgs: _iterableGenericArgs,
  ),
  'Set': TestTypeData(
    defaultExpression: '{$_defaultCollectionExpressions}',
    jsonExpression: '[$_defaultCollectionExpressions]',
    altJsonExpression: '[$_altCollectionExpressions]',
    genericArgs: _iterableGenericArgs,
  ),
  'Iterable': TestTypeData(
    defaultExpression: '[$_defaultCollectionExpressions]',
    altJsonExpression: '[$_altCollectionExpressions]',
    genericArgs: _iterableGenericArgs,
  ),
  recordType: TestTypeData(
    altJsonExpression: '{}',
    genericArgs: _iterableGenericArgs,
  ),
};

final _allTypes = {..._trivialTypesToTest, ..._collectionTypes};

final _typesToTest = Map.of(_allTypes)..remove(recordType);

Iterable<String> get mapKeyTypes =>
    allowedMapKeyTypes.map((e) => e == 'enum' ? customEnumType : e).toList()
      ..sort(compareAsciiLowerCase);

final _iterableGenericArgs = ([
  ..._trivialTypesToTest.keys,
  ..._trivialTypesToTest.keys.map((e) => '$e?'),
  'FromJsonDynamicParam',
  'FromJsonNullableObjectParam',
  'FromJsonObjectParam',
  'dynamic',
  recordType,
]..sort(compareAsciiLowerCase)).toSet();

const _defaultCollectionExpressions = '42, true, false, null';
const _altCollectionExpressions = '43, false';

Builder typeBuilder([BuilderOptions? _]) =>
    validate('_type_builder', const _TypeBuilder());

class _TypeBuilder implements Builder {
  const _TypeBuilder();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final formatter = await buildStep.formatter();

    final inputId = buildStep.inputId;

    final sourceContent = await buildStep.readAsString(inputId);

    for (var entry in _allTypes.entries) {
      final type = entry.key;
      final newId = buildStep.inputId.changeExtension(toTypeExtension(type));

      await buildStep.writeAsString(
        newId,
        formatter.format(entry.value.libContent(sourceContent, type)),
      );
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    '.dart': _allTypes.keys.map(toTypeExtension).toSet().toList()..sort(),
  };
}

Builder typeTestBuilder([BuilderOptions? _]) =>
    validate('_type_test_builder', const _TypeTestBuilder());

class _TypeTestBuilder implements Builder {
  const _TypeTestBuilder();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    final sourceContent = await buildStep.readAsString(inputId);

    for (var entry in _typesToTest.entries) {
      final type = entry.key;
      final newId = buildStep.inputId.changeExtension(
        _toTypeTestExtension(type),
      );

      await buildStep.writeAsString(
        newId,
        entry.value.testContent(sourceContent, type),
      );
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    '.dart': _typesToTest.keys.map(_toTypeTestExtension).toSet().toList()
      ..sort(),
  };
}

String _toTypeTestExtension(String e) => '.${typeToPathPart(e)}_test.dart';
