// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../test_utils.dart';
import 'build_config.dart';

final _root = p.join('test', 'yaml');

List<String> _getTests() => Directory(_root)
    .listSync()
    .where((fse) => fse is File && p.extension(fse.path) == '.yaml')
    .map((fse) => fse.path)
    .toList();

void main() {
  group('valid configurations', () {
    for (final filePath in _getTests()) {
      test(p.basenameWithoutExtension(filePath), () {
        final content = File(filePath).readAsStringSync();
        final yamlContent = loadYaml(content, sourceUrl: filePath) as YamlMap;

        try {
          final config = Config.fromJson(yamlContent);
          expect(config, isNotNull);
        } on CheckedFromJsonException catch (e) {
          print(_prettyPrintCheckedFromJsonException(e));
          rethrow;
        }
      });
    }
  });

  group('bad configs', () {
    var index = 0;
    for (final entry in _badConfigs.entries) {
      test('${index++}', () {
        final yamlContent =
            loadYaml(entry.key, sourceUrl: 'file.yaml') as YamlMap;

        expect(yamlContent, isNotNull);
        printOnFailure(entry.key);

        try {
          final config = Config.fromJson(yamlContent);
          print(loudEncode(config));
          fail('parse should fail');
        } on CheckedFromJsonException catch (e) {
          final prettyOutput = _prettyPrintCheckedFromJsonException(e);
          printOnFailure("r'''\n$prettyOutput'''");
          expect(prettyOutput, entry.value);
        }
      });
    }
  });
}

final _badConfigs = const {
  r'''
builders:
- a
- b
''': r'''
line 2, column 1 of file.yaml: Could not create `Config`. Unsupported value for `builders`.
  ╷
2 │ ┌ - a
3 │ └ - b
  ╵''',
  r'''
builders:
  sample:
    defaultEnumTest: bob
''': r'''
line 3, column 22 of file.yaml: Could not create `Builder`. Unsupported value for `defaultEnumTest`. `bob` is not one of the supported values: none, dependents, all_packages, root_package
  ╷
3 │     defaultEnumTest: bob
  │                      ^^^
  ╵''',
  r'''
builders:
  a:
    target: 42
  ''': r'''
line 3, column 13 of file.yaml: Could not create `Builder`. Unsupported value for `target`.
  ╷
3 │     target: 42
  │             ^^
  ╵''',
  r'''
builders:
  a:
    target: "a target"
    auto_apply: unsupported
''': r'''
line 4, column 17 of file.yaml: Could not create `Builder`. Unsupported value for `auto_apply`. `unsupported` is not one of the supported values: none, dependents, all_packages, root_package
  ╷
4 │     auto_apply: unsupported
  │                 ^^^^^^^^^^^
  ╵''',
  r'''
builders:
  a:
    builder_factories: []
  ''': r'''
line 3, column 24 of file.yaml: Could not create `Builder`. Unsupported value for `builder_factories`. Must have at least one value.
  ╷
3 │     builder_factories: []
  │                        ^^
  ╵''',
  r'''
builders:
  a:
    foo: bar
    baz: zap
''': r'''
Could not create `Builder`.
Unrecognized keys: [baz, foo]; supported keys: [target, import, is_optional, configLocation, auto_apply, build_to, defaultEnumTest, builder_factories, applies_builders, required_inputs, build_extensions]

line 4, column 5 of file.yaml: Invalid key "baz"
  ╷
4 │     baz: zap
  │     ^^^
  ╵
line 3, column 5 of file.yaml: Invalid key "foo"
  ╷
3 │     foo: bar
  │     ^^^
  ╵''',
  r'''
  bob: cool''': r'''
Could not create `Config`.
line 1, column 3 of file.yaml: Required keys are missing: builders.
  ╷
1 │   bob: cool
  │   ^^^^^^^^^
  ╵''',
  r'''
builders:
  builder_name:
    auto_apply:''': '''
Could not create `Builder`.
line 3, column 5 of file.yaml: These keys had `null` values, which is not allowed: [auto_apply]
  ╷
3 │     auto_apply:
  │     ^^^^^^^^^^^
  ╵''',
  r'''
builders:
  builder_name:
    builder_factories: ["scssBuilder"]
    configLocation: "user@host:invalid/uri"''': '''
line 4, column 21 of file.yaml: Could not create `Builder`. Unsupported value for `configLocation`. Illegal scheme character at offset 4.
  ╷
4 │     configLocation: "user@host:invalid/uri"
  │                     ^^^^^^^^^^^^^^^^^^^^^^^
  ╵'''
};

String _prettyPrintCheckedFromJsonException(CheckedFromJsonException err) {
  final yamlMap = err.map as YamlMap;

  YamlScalar _getYamlKey(String key) {
    return yamlMap.nodes.keys.singleWhere((k) => (k as YamlScalar).value == key,
        orElse: () => null) as YamlScalar;
  }

  final innerError = err.innerError;

  var message = 'Could not create `${err.className}`.';
  if (innerError is BadKeyException) {
    expect(err.message, innerError.message);

    if (innerError is UnrecognizedKeysException) {
      message += '\n${innerError.message}\n';
      for (final key in innerError.unrecognizedKeys) {
        final yamlKey = _getYamlKey(key);
        assert(yamlKey != null);
        message += '\n${yamlKey.span.message('Invalid key "$key"')}';
      }
    } else if (innerError is MissingRequiredKeysException) {
      expect(err.key, innerError.missingKeys.first);
      message += '\n${yamlMap.span.message(innerError.message)}';
    } else if (innerError is DisallowedNullValueException) {
      expect(err.key, innerError.keysWithNullValues.first);
      message += '\n${yamlMap.span.message(innerError.message)}';
    } else {
      throw UnsupportedError('${innerError.runtimeType} is not supported.');
    }
  } else {
    final yamlValue = yamlMap.nodes[err.key];

    if (yamlValue == null) {
      assert(err.key == null);
      message = '${yamlMap.span.message(message)} ${err.innerError}';
    } else {
      message = '$message Unsupported value for `${err.key}`.';
      if (err.message != null) {
        message = '$message ${err.message}';
      }
      message = yamlValue.span.message(message);
    }
  }

  return message;
}
