// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')

import 'dart:io';

import 'package:test/test.dart';
import 'package:path/path.dart' as p;

void main() {
  test('README example', () {
    var readmeContent = new File('README.md').readAsStringSync();

    var exampleContent = _getExampleContent('example.dart');
    expect(readmeContent, contains(exampleContent));

    var exampleGeneratedContent = _getExampleContent('example.g.dart');
    expect(readmeContent, contains(exampleGeneratedContent));
  });
}

String _getExampleContent(String fileName) {
  var lines = new File(p.join('example', fileName)).readAsLinesSync();

  var lastHadContent = false;

  // All lines with content, except those starting with `/`.
  // Also exclude blank lines that follow other blank lines
  var cleanedSource = lines.where((l) {
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
