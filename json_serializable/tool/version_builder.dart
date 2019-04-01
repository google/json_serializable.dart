// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:yaml/yaml.dart';

const jsonAnnotationVersionFile = 'doc/json_annotation_version.txt';

Builder buildVersion([BuilderOptions options]) => _VersionBuilder();

/// Extracts the version of `package:json_annotation` for the currently
/// solved version locally. Used to populate the currently versioned URL
/// when linked to docs.
class _VersionBuilder implements Builder {
  @override
  Future build(BuildStep buildStep) async {
    final assetId = AssetId(buildStep.inputId.package, 'pubspec.lock');

    final content = await buildStep.readAsString(assetId);

    final yaml = loadYaml(content, sourceUrl: assetId.uri);

    final pkgMap = yaml['packages'] as YamlMap;
    final jsonAnnotationMap = pkgMap['json_annotation'] as YamlMap;
    final version = jsonAnnotationMap['version'] as String;

    await buildStep.writeAsString(
        AssetId(buildStep.inputId.package, jsonAnnotationVersionFile), '''
$version
''');
  }

  @override
  final buildExtensions = const {
    r'lib/$lib$': [jsonAnnotationVersionFile]
  };
}
