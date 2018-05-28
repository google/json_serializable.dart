// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../test_utils.dart';
import 'build_config.dart';

final _root = p.join('test', 'yaml');

List<String> _getTests() => new Directory(_root)
    .listSync()
    .where((fse) => fse is File && p.extension(fse.path) == '.yaml')
    .map((fse) => fse.path)
    .toList();

void main() {
  group('valid configurations', () {
    for (var filePath in _getTests()) {
      test(p.basenameWithoutExtension(filePath), () {
        var content = new File(filePath).readAsStringSync();
        var yamlContent = loadYaml(content, sourceUrl: filePath) as YamlMap;

        try {
          var config = new Config.fromJson(yamlContent);
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
    for (var entry in _badConfigs.entries) {
      test('${index++}', () {
        var yamlContent =
            loadYaml(entry.key, sourceUrl: 'file.yaml') as YamlMap;

        expect(yamlContent, isNotNull);
        printOnFailure(entry.key);

        try {
          var config = new Config.fromJson(yamlContent);
          print(loudEncode(config));
          fail('parse should fail');
        } on CheckedFromJsonException catch (e) {
          var prettyOutput = _prettyPrintCheckedFromJsonException(e);
          printOnFailure(prettyOutput);
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
line 1, column 1 of file.yaml: Could not create `Config`. Unsupported value for `builders`.
builders:
^^^^^^^^''',
  r'''
builders:
  a:
    target: 42
  ''': r'''
line 3, column 5 of file.yaml: Could not create `Builder`. Unsupported value for `target`.
    target: 42
    ^^^^^^''',
  r'''
builders:
  a:
    target: "a target"
    auto_apply: unsupported
''': r'''
line 4, column 5 of file.yaml: Could not create `Builder`. Unsupported value for `auto_apply`. "unsupported" is not in the supported set: "none", "dependents", "all_packages", "root_package".
    auto_apply: unsupported
    ^^^^^^^^^^''',
  r'''
builders:
  a:
    builder_factories: []
  ''': r'''
line 3, column 5 of file.yaml: Could not create `Builder`. Unsupported value for `builder_factories`. Must have at least one value.
    builder_factories: []
    ^^^^^^^^^^^^^^^^^''',
};

String _prettyPrintCheckedFromJsonException(CheckedFromJsonException err) {
  var yamlMap = err.map as YamlMap;

  var yamlKey = yamlMap.nodes.keys.singleWhere(
      (k) => (k as YamlScalar).value == err.key,
      orElse: () => null) as YamlScalar;

  var message = 'Could not create `${err.className}`.';
  if (yamlKey == null) {
    assert(err.key == null);
    message = '${yamlMap.span.message(message)} ${err.innerError}';
  } else {
    message = '$message Unsupported value for `${err.key}`.';
    if (err.message != null) {
      message = '$message ${err.message}';
    }
    message = yamlKey.span.message(message);
  }

  return message;
}
