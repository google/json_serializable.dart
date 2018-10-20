// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  _expect('README.md');
  _expect('pubspec.yaml');
}

void _expect(String fileName) {
  test(fileName, () {
    final file = File(fileName);
    expect(file.readAsStringSync(), contains(_pubspecContent));
  });
}

final _pubspecContent = r'''
dependencies:
  json_annotation: ^1.2.0

dev_dependencies:
  build_runner: ^1.0.0
  json_serializable: ^1.5.1
''';
