// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

final _formatter = DartFormatter();

Builder internal([_]) {
  final builder = const _SmartBuilder();
  _validateBuilder(builder);
  return builder;
}

// Until we have verification in pkg:build and friends
// https://github.com/dart-lang/build/issues/590
void _validateBuilder(_SmartBuilder builder) {
  var buildYaml = loadYaml(
    File('build.yaml').readAsStringSync(),
    sourceUrl: 'build.yaml',
  ) as YamlMap;

  for (var key in ['builders', '_internal', 'build_extensions']) {
    buildYaml = buildYaml[key] as YamlMap;
  }

  final extensions = Set<String>.from(buildYaml['.dart'] as YamlList);

  final codedExtensions = builder.buildExtensions['.dart'].toSet();

  final tooMany = extensions.difference(codedExtensions);
  if (tooMany.isNotEmpty) {
    log.warning('Too many extensions in build.yaml:\n${tooMany.join('\n')}');
  }

  final missing = codedExtensions.difference(extensions);
  if (missing.isNotEmpty) {
    log.warning('Missing extensions in build.yaml:\n${missing.join('\n')}');
  }
}

class _SmartBuilder implements Builder {
  const _SmartBuilder();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final baseName = p.basenameWithoutExtension(buildStep.inputId.path);

    final sourceContent = await buildStep.readAsString(buildStep.inputId);

    for (var config in _fileConfigurationMap[baseName]) {
      final extension = _configToExtension(config);
      final newId = buildStep.inputId.changeExtension(extension);

      final partName = extension.substring(0, extension.length - 5);

      final replacements = <_Replacement>[
        _Replacement(
          "part '$baseName.g.dart';",
          "part '$baseName$partName.g.dart';",
        )
      ];

      if (baseName == 'kitchen_sink') {
        final description = _configToName(config.toSet());
        replacements.add(_Replacement(
          "String get description => '--defaults--';",
          "String get description => '$description';",
        ));
      }

      for (var entry in config) {
        replacements.addAll(_optionReplacement(baseName, entry));
      }

      final content = _Replacement.generate(sourceContent, replacements);

      await buildStep.writeAsString(newId, _formatter.format(content));
    }
  }

  @override
  Map<String, List<String>> get buildExtensions =>
      {'.dart': _fileConfigurations};
}

Iterable<_Replacement> _optionReplacement(
    String baseName, String optionKey) sync* {
  switch (optionKey) {
    case 'any_map':
      yield _Replacement.addJsonSerializableKey('anyMap', true);

      if (baseName == 'kitchen_sink') {
        yield _Replacement(
          'return KitchenSink.fromJson(json.cast<String, dynamic>());',
          'return KitchenSink.fromJson(json);',
        );
        yield _Replacement(
          'factory KitchenSink.fromJson(Map<String, dynamic> json)',
          'factory KitchenSink.fromJson(Map json)',
        );
      }
      break;
    case 'checked':
      yield _Replacement.addJsonSerializableKey('checked', true);
      if (baseName == 'kitchen_sink') {
        yield _Replacement(
          'bool get checked => false;',
          'bool get checked => true;',
        );
      }
      break;
    case 'non_nullable':
      yield _Replacement.addJsonSerializableKey('nullable', false);

      if (baseName == 'kitchen_sink') {
        yield _Replacement(
          'List<T> _defaultList<T>() => null;',
          'List<T> _defaultList<T>() => <T>[];',
        );
        yield _Replacement(
          'Set<T> _defaultSet<T>() => null;',
          'Set<T> _defaultSet<T>() => Set<T>();',
        );
        yield _Replacement(
          'Map<K, V> _defaultMap<K, V>() => null;',
          'Map<String, T> _defaultMap<T>() => <String, T>{};',
        );
        yield _Replacement(
          'SimpleObject _defaultSimpleObject() => null;',
          'SimpleObject _defaultSimpleObject() => SimpleObject(42);',
        );
        yield _Replacement(
          'StrictKeysObject _defaultStrictKeysObject() => null;',
          'StrictKeysObject _defaultStrictKeysObject() => '
              "StrictKeysObject(10, 'cool');",
        );
        yield _Replacement(
          'DateTime dateTime;',
          'DateTime dateTime = DateTime(1981, 6, 5);',
        );
        yield _Replacement(
          'bool get nullable => true;',
          'bool get nullable => false;',
        );
      }
      break;
    case 'use_wrappers':
      yield _Replacement.addJsonSerializableKey('useWrappers', true);
      break;
    default:
      throw UnimplementedError('not yet!: $optionKey');
  }
}

String _configToExtension(Iterable<String> config) =>
    '.g_${_configToName(config.toSet())}.dart';

String _configToName(Set<String> config) =>
    (config.toList()..sort()).join('__');

List<String> get _fileConfigurations => _fileConfigurationMap.values
    .expand((v) => v)
    .map(_configToExtension)
    .toSet()
    .toList();

// TODO: use a set of sets, once we're >=2.2.0
const _fileConfigurationMap = <String, List<List<String>>>{
  'kitchen_sink': [
    ['any_map'],
    ['any_map', 'checked', 'non_nullable'],
    ['any_map', 'non_nullable'],
    ['any_map', 'non_nullable', 'use_wrappers'],
    ['any_map', 'use_wrappers'],
  ],
  'default_value': [
    ['any_map', 'checked'],
  ],
  'generic_class': [
    ['use_wrappers'],
  ],
  'json_test_example': [
    ['non_nullable', 'use_wrappers'],
    ['non_nullable'],
    ['use_wrappers'],
  ]
};

class _Replacement {
  final Pattern existing;
  final String replacement;

  _Replacement(this.existing, this.replacement);

  factory _Replacement.addJsonSerializableKey(String key, bool value) =>
      _Replacement('@JsonSerializable(', '@JsonSerializable(\n  $key: $value,');

  static String generate(
      String inputContent, Iterable<_Replacement> replacements) {
    var outputContent = inputContent;

    for (final r in replacements) {
      if (!outputContent.contains(r.existing)) {
        print('Input string did not contain `${r.existing}` as expected.');
      } else {
        outputContent = outputContent.replaceAll(r.existing, r.replacement);
      }
    }

    outputContent = outputContent.replaceAll(',)', ',\n)');

    return outputContent;
  }
}
