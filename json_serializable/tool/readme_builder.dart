// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;

import 'shared.dart';

Builder readmeBuilder([_]) => _ReadmeBuilder();

class _ReadmeBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final templateAssetId =
        AssetId(buildStep.inputId.package, 'tool/readme/readme_template.md');
    final templateAssetContent = await buildStep.readAsString(templateAssetId);

    Future<String> getExampleContent(String fileName) async {
      final content = await buildStep.readAsString(
        AssetId(buildStep.inputId.package, p.join('example', fileName)),
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

    final replacements = {
      'api.md': await buildStep
          .readAsString(AssetId(buildStep.inputId.package, readmeApiPath)),
      'example.dart': await getExampleContent('example.dart'),
      'example.g.dart': await getExampleContent('example.g.dart'),
    };

    final expandedContent =
        templateAssetContent.replaceAllMapped(_replaceRegexp, (match) {
      final replacementKey = match.group(1)!;
      return replacements[replacementKey]!.trim();
    }).trim();

    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, _readmePath),
      '''
<!-- This content is generated. See $_templatePath -->
$expandedContent
''',
    );
  }

  @override
  final buildExtensions = const {
    readmeApiPath: [_readmePath]
  };
}

const _templatePath = 'tool/readme/readme_template.md';
const _readmePath = 'README.md';

final _replaceRegexp = RegExp(r'<!-- REPLACE ([\w\d\.]+) -->');
