// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'dart:io';

import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/builder.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'test_utils.dart';

void main() {
  test('empty', () async {
    final builder = jsonSerializable(BuilderOptions.empty);
    expect(builder, isNotNull);
  });

  test('valid config', () async {
    final builder = jsonSerializable(const BuilderOptions(_validConfig));
    expect(builder, isNotNull);
  });

  test('readme config', () async {
    final configExampleContent = File('README.md')
        .readAsLinesSync()
        .skipWhile((line) => line != '```yaml')
        .skip(1)
        .takeWhile((line) => line != '```')
        .join('\n');

    var yaml = loadYaml(configExampleContent) as YamlMap;

    for (final key in [
      'targets',
      r'$default',
      'builders',
      'json_serializable',
      'options'
    ]) {
      yaml = yaml[key] as YamlMap;
    }

    final config = Map<String, dynamic>.from(yaml);

    expect(config.keys, unorderedEquals(_validConfig.keys));

    final builder = jsonSerializable(BuilderOptions(config));
    expect(builder, isNotNull);
  });

  test('unsupported configuration', () async {
    var matcher = const TypeMatcher<UnrecognizedKeysException>().having(
        (e) => e.unrecognizedKeys, 'unrecognizedKeys', [
      'unsupported'
    ]).having((e) => e.allowedKeys, 'allowedKeys',
        unorderedEquals(_validConfig.keys));

    expect(
        () => jsonSerializable(const BuilderOptions({'unsupported': 'config'})),
        throwsA(matcher));
  });

  group('invalid config', () {
    for (final entry in _invalidConfig.entries) {
      test(entry.key, () {
        final config = Map<String, dynamic>.from(_validConfig);
        config[entry.key] = entry.value;

        expect(() => jsonSerializable(BuilderOptions(config)), throwsCastError);
      });
    }
  });
}

const _validConfig = {
  'use_wrappers': true,
  'any_map': true,
  'checked': true,
  'explicit_to_json': true,
  'generate_to_json_function': false,
};

const _invalidConfig = {
  'use_wrappers': 42,
  'any_map': 42,
  'checked': 42,
  'explicit_to_json': 42,
  'generate_to_json_function': 42,
};
