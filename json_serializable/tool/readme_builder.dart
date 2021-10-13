// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

import 'test_type_builder.dart';
import 'test_type_data.dart';

Builder readmeBuilder([_]) => _ReadmeBuilder();

class _ReadmeBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final templateAssetId =
        buildStep.assetIdForInputPackage('tool/readme/readme_template.md');

    final replacements = {
      'example.dart': await buildStep.getExampleContent('example.dart'),
      'example.g.dart': await buildStep.getExampleContent('example.g.dart'),
      'supported_types': _classCleanAndSort(supportedTypes()),
      'collection_types': _classCleanAndSort(collectionTypes()),
      'map_key_types': _classCleanAndSort(mapKeyTypes),
    };

    final availableKeys = replacements.keys.toSet();

    final jsonAnnotationVersion = await buildStep.jsonAnnotationVersion();
    final jsonAnnotationBaseUri =
        'https://pub.dev/documentation/json_annotation/$jsonAnnotationVersion/json_annotation';

    String jsonAnnotationUri(String className, [String? member]) =>
        member == null
            ? '$jsonAnnotationBaseUri/$className-class.html'
            : '$jsonAnnotationBaseUri/$className/$member.html';

    final foundClasses = SplayTreeMap<String, String>(compareAsciiLowerCase);

    final theMap = <Pattern, String Function(Match)>{
      RegExp(r'<!-- REPLACE ([\w\d\.]+) -->'): (match) {
        final replacementKey = match.group(1)!;
        availableKeys.remove(replacementKey);
        return (replacements[replacementKey] ?? '*MISSING! `$replacementKey`*')
            .trim();
      },
      RegExp(r'`(\w+):(\w+)(\.\w+)?`'): (match) {
        final context = match.group(1)!;
        final className = match.group(2)!;
        final memberName = match.group(3);
        final linkContent = '[`$className${memberName ?? ''}`]';
        String linkValue;
        switch (context) {
          case 'core':
            linkValue = _coreTypeUri(className);
            break;
          case 'ja':
            linkValue = jsonAnnotationUri(className, memberName?.substring(1));
            break;
          default:
            linkValue = 'https://unknown.com/$context/$className';
        }
        foundClasses[linkContent] = linkValue;
        return linkContent;
      }
    };

    var content = (await buildStep.readAsString(templateAssetId)).trim();

    for (var entry in theMap.entries) {
      content = content.replaceAllMapped(entry.key, entry.value);
    }

    if (availableKeys.isNotEmpty) {
      log.warning(
        'Some parsed replacements where not used: ${availableKeys.join(', ')}',
      );
    }

    content = '''
<!-- This content is generated. See $_templatePath -->
$content
${foundClasses.entries.map((e) => '${e.key}: ${e.value}').join('\n')}
''';

    await buildStep.writeAsString(
      buildStep.assetIdForInputPackage(_readmePath),
      content,
    );
  }

  @override
  final buildExtensions = const {
    _templatePath: [_readmePath]
  };
}

const _templatePath = 'tool/readme/readme_template.md';
const _readmePath = 'README.md';

String _coreTypeUri(String type) =>
    'https://api.dart.dev/stable/dart-core/$type-class.html';

String _classCleanAndSort(Iterable<String> classes) {
  final initial = (classes.map((e) => e == customEnumType ? 'Enum' : e).toList()
        ..sort(compareAsciiLowerCase))
      // Dropping `dynamic` – it's not linkable!
      .where((element) => element != 'dynamic')
      // Start by mapping to the output format – so we wrap correctly
      .map((e) => '[`$e`]')
      .join(', ');

  if (initial.length <= 80) {
    return initial;
  }

  final splits = initial.split(' ');
  final lines = <String>[];
  String? currentLine;
  for (var split in splits) {
    if (currentLine == null) {
      currentLine = split;
    } else {
      final option = '$currentLine $split';
      if (option.length > 80) {
        lines.add(currentLine);
        currentLine = split;
      } else {
        currentLine = option;
      }
    }
    if (currentLine.length > 80) {
      lines.add(currentLine);
      currentLine = null;
    }
  }

  if (currentLine != null) {
    lines.add(currentLine);
  }

  return lines.join('\n').replaceAllMapped(
        // Now put in the core: logic so we autolink correctly
        RegExp(r'\[`(\w+)`\]'),
        (match) => '`core:${match[1]}`',
      );
}

extension on BuildStep {
  AssetId assetIdForInputPackage(String path) => AssetId(inputId.package, path);

  Future<String> jsonAnnotationVersion() async {
    final lockFileAssetId = assetIdForInputPackage('pubspec.lock');
    final lockFileContent = await readAsString(lockFileAssetId);
    final lockFileYaml =
        loadYaml(lockFileContent, sourceUrl: lockFileAssetId.uri) as YamlMap;
    final pkgMap = lockFileYaml['packages'] as YamlMap;
    final jsonAnnotationMap = pkgMap['json_annotation'] as YamlMap;
    final jsonAnnotationVersionString = jsonAnnotationMap['version'] as String;

    final jsonAnnotationVersion =
        Version.parse(jsonAnnotationVersionString.trim());

    final targetVersion = jsonAnnotationVersion.isPreRelease
        ? 'latest'
        : jsonAnnotationVersion.toString();

    return targetVersion;
  }

  Future<String> getExampleContent(String fileName) async {
    final content = await readAsString(
      assetIdForInputPackage(p.join('example', fileName)),
    );

    final lines = LineSplitter.split(content);

    var lastHadContent = false;

    // All lines with content, except those starting with `/`.
    // Also exclude blank lines that follow other blank lines
    final cleanedSource = lines.where((l) {
      if (l.startsWith(r'/')) {
        return false;
      }

      if (l.trim().isNotEmpty) {
        lastHadContent = true;
        return true;
      }

      if (lastHadContent) {
        lastHadContent = false;
        return true;
      }

      return false;
    }).join('\n');

    return '''
```dart
$cleanedSource
```''';
  }
}
