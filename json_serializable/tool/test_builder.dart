// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

final _formatter = DartFormatter();

Builder internal([_]) {
  const builder = _SmartBuilder();
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

    final factories =
        SplayTreeMap.from({'$_kitchenSinkBaseName.dart': 'normal'});

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

      if (baseName == _kitchenSinkBaseName) {
        final description = _configToName(config.toSet());
        replacements.add(_Replacement(
          "String get description => '--defaults--';",
          "String get description => '$description';",
        ));

        factories['$baseName$partName.dart'] = description;
      }

      for (var entry in config) {
        replacements.addAll(_optionReplacement(baseName, entry));
      }

      final content = _Replacement.generate(sourceContent, replacements);

      await buildStep.writeAsString(newId, _formatter.format(content));
    }

    if (baseName == _kitchenSinkBaseName) {
      final newId = buildStep.inputId.changeExtension('.factories.dart');

      final lines = <String>[
        ...factories.entries.map((e) => "import '${e.key}' as ${e.value};"),
        'const factories = [',
        ...factories.values.map((e) => '$e.factory,'),
        '];',
      ];

      await buildStep.writeAsString(newId, _formatter.format(lines.join('\n')));
    }
  }

  @override
  Map<String, List<String>> get buildExtensions =>
      {'.dart': _fileConfigurations};
}

const _configReplacements = {
  'any_map': _Replacement.addJsonSerializableKey('anyMap', true),
  'checked': _Replacement.addJsonSerializableKey('checked', true),
  'non_nullable': _Replacement.addJsonSerializableKey('nullable', false),
  'explicit_to_json':
      _Replacement.addJsonSerializableKey('explicitToJson', true),
  'exclude_null': _Replacement.addJsonSerializableKey('includeIfNull', false),
};

const _kitchenSinkReplacements = {
  'any_map': [
    _Replacement(
      'bool get anyMap => false;',
      'bool get anyMap => true;',
    ),
    _Replacement(
      'class _Factory implements k.KitchenSinkFactory<String, dynamic>',
      'class _Factory implements k.KitchenSinkFactory<dynamic, dynamic>',
    ),
    _Replacement(
      'k.KitchenSink fromJson(Map<String, dynamic> json)',
      'k.KitchenSink fromJson(Map json)',
    ),
    _Replacement(
      'factory KitchenSink.fromJson(Map<String, dynamic> json)',
      'factory KitchenSink.fromJson(Map json)',
    ),
  ],
  'checked': [
    _Replacement(
      'bool get checked => false;',
      'bool get checked => true;',
    )
  ],
  'exclude_null': [
    _Replacement(
      'bool get excludeNull => false;',
      'bool get excludeNull => true;',
    ),
  ],
  'explicit_to_json': [
    _Replacement(
      'bool get explicitToJson => false;',
      'bool get explicitToJson => true;',
    ),
  ],
  'non_nullable': [
    _Replacement(
      'bool get nullable => true;',
      'bool get nullable => false;',
    ),
    _Replacement(
      'List<T> _defaultList<T>() => null;',
      'List<T> _defaultList<T>() => <T>[];',
    ),
    _Replacement(
      'Set<T> _defaultSet<T>() => null;',
      'Set<T> _defaultSet<T>() => <T>{};',
    ),
    _Replacement(
      'Map<K, V> _defaultMap<K, V>() => null;',
      'Map<String, T> _defaultMap<T>() => <String, T>{};',
    ),
    _Replacement(
      'SimpleObject _defaultSimpleObject() => null;',
      'SimpleObject _defaultSimpleObject() => SimpleObject(42);',
    ),
    _Replacement(
      'StrictKeysObject _defaultStrictKeysObject() => null;',
      'StrictKeysObject _defaultStrictKeysObject() => '
          "StrictKeysObject(10, 'cool');",
    ),
    _Replacement(
      'DateTime dateTime;',
      'DateTime dateTime = DateTime(1981, 6, 5);',
    ),
    _Replacement(
      'BigInt bigInt;',
      "BigInt bigInt = BigInt.parse('10000000000000000000');",
    ),
  ],
};

Iterable<_Replacement> _optionReplacement(
    String baseName, String optionKey) sync* {
  yield _configReplacements[optionKey];

  if (baseName == _kitchenSinkBaseName &&
      _kitchenSinkReplacements.containsKey(optionKey)) {
    yield* _kitchenSinkReplacements[optionKey];
  }
}

String _configToExtension(Iterable<String> config) =>
    '.g_${_configToName(config.toSet())}.dart';

String _configToName(Set<String> config) =>
    (config.toList()..sort()).join('__');

List<String> get _fileConfigurations => _fileConfigurationMap.values
    .expand((v) => v)
    .map(_configToExtension)
    .followedBy(['.factories.dart'])
    .toSet()
    .toList()
      ..sort();

const _kitchenSinkBaseName = 'kitchen_sink';

const _fileConfigurationMap = <String, Set<Set<String>>>{
  _kitchenSinkBaseName: {
    {'any_map', 'checked', 'non_nullable'},
    {'any_map', 'non_nullable'},
    {'any_map'},
    {'exclude_null'},
    {'non_nullable'},
    {'exclude_null', 'non_nullable'},
    {'explicit_to_json'},
  },
  'default_value': {
    {'any_map', 'checked'},
  },
  'generic_class': <Set<String>>{},
  'json_test_example': {
    {'any_map'},
    {'non_nullable'},
  }
};

class _Replacement {
  final Pattern existing;
  final String replacement;

  const _Replacement(this.existing, this.replacement);

  const _Replacement.addJsonSerializableKey(String key, bool value)
      : existing = '@JsonSerializable(',
        replacement = '@JsonSerializable(\n  $key: $value,';

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

    return outputContent.replaceAll(',)', ',\n)');
  }
}
