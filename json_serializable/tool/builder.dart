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

      for (var entry in config.entries) {
        replacements
            .addAll(_optionReplacement(baseName, entry.key, entry.value));
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
  String baseName,
  String optionKey,
  bool value,
) sync* {
  switch (optionKey) {
    case 'any_map':
      if (value) {
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
      }
      break;
    case 'checked':
      if (value) {
        yield _Replacement.addJsonSerializableKey('checked', true);
        if (baseName == 'kitchen_sink') {
          yield _Replacement(
            'bool get checked => false;',
            'bool get checked => true;',
          );
        }
      }
      break;
    case 'non_nullable':
      if (value) {
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
      }
      break;
    case 'use_wrappers':
      if (value) {
        yield _Replacement.addJsonSerializableKey('useWrappers', true);
      }
      break;
    default:
      throw UnimplementedError('not yet!: $optionKey');
  }
}

String _configToExtension(Map<String, dynamic> config) =>
    '.g_${_configToName(config)}.dart';

String _configToName(Map<String, dynamic> config) =>
    (config.entries.where((e) => e.value != false).map((e) => e.key).toList()
          ..sort())
        .join('__');

const _options = <String, List<bool>>{
  'any_map': [false, true],
  'checked': [false, true],
  'use_wrappers': [false, true],
  'non_nullable': [false, true],
};

Iterable<Map<String, bool>> allConfigurations({
  Map<String, bool> parts = const {},
}) sync* {
  assert(parts.length <= _options.length);
  if (parts.length == _options.length) {
    if (parts.values.any((v) => v)) {
      yield parts;
    }
  } else {
    final entry = _options.entries.skip(parts.length).first;
    for (var option in entry.value) {
      final newMap = Map.of(parts);
      assert(!newMap.containsKey(entry.key));
      newMap[entry.key] = option;
      yield* allConfigurations(parts: newMap);
    }
  }
}

List<String> get _fileConfigurations => _fileConfigurationMap.values
    .expand((v) => v)
    .map(_configToExtension)
    .toSet()
    .toList();

const _fileConfigurationMap = {
  'kitchen_sink': [
    {'any_map': true},
    {'any_map': true, 'checked': true, 'non_nullable': true},
    {'any_map': true, 'non_nullable': true},
    {'any_map': true, 'non_nullable': true, 'use_wrappers': true},
    {'any_map': true, 'use_wrappers': true},
  ],
  'default_value': [
    {'any_map': true, 'checked': true},
  ],
  'generic_class': [
    {'use_wrappers': true},
  ],
  'json_test_example': [
    {'non_nullable': true, 'use_wrappers': true},
    {'non_nullable': true},
    {'use_wrappers': true},
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
