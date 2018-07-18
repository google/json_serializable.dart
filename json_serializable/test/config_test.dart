// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')

import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:json_serializable/builder.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'test_utils.dart';

void main() {
  StreamSubscription sub;
  final records = <LogRecord>[];

  setUpAll(() {
    sub = log.onRecord.listen(records.add);
  });

  tearDownAll(() async {
    await sub.cancel();
  });

  setUp(records.clear);

  test('empty', () async {
    var builder = jsonSerializable(BuilderOptions.empty);
    expect(builder, isNotNull);
    expect(records, isEmpty);
  });

  test('valid config', () async {
    var builder =
        jsonSerializable(const BuilderOptions(_validConfig));
    expect(builder, isNotNull);

    expect(records, isEmpty);
  });

  test('readme config', () async {
    var configExampleContent = new File('README.md')
        .readAsLinesSync()
        .skipWhile((line) => line != '```yaml')
        .skip(1)
        .takeWhile((line) => line != '```')
        .join('\n');

    var yaml = loadYaml(configExampleContent) as YamlMap;

    for (var key in [
      'targets',
      r'$default',
      'builders',
      'json_serializable',
      'options'
    ]) {
      yaml = yaml[key] as YamlMap;
    }

    var config = new Map<String, dynamic>.from(yaml);

    expect(config.keys, unorderedEquals(_validConfig.keys));

    var builder = jsonSerializable(new BuilderOptions(config));
    expect(builder, isNotNull);
    expect(records, isEmpty);
  });

  test('unsupported configuration', () async {
    var builder =
        jsonSerializable(const BuilderOptions(const {'unsupported': 'config'}));
    expect(builder, isNotNull);

    expect(records.single.message,
        'These options were ignored: `{unsupported: config}`.');
  });

  group('invalid config', () {
    for (var entry in _invalidConfig.entries) {
      test(entry.key, () {
        var config = new Map<String, dynamic>.from(_validConfig);
        config[entry.key] = entry.value;

        expect(() => jsonSerializable(new BuilderOptions(config)),
            throwsCastError);
      });
    }
  });
}

const _validConfig = const {
  'use_wrappers': true,
  'any_map': true,
  'checked': true,
  'explicit_to_json': true,
  'generate_to_json_function': false,
};

const _invalidConfig = const {
  'use_wrappers': 42,
  'any_map': 42,
  'checked': 42,
  'explicit_to_json': 42,
  'generate_to_json_function': 42,
};
