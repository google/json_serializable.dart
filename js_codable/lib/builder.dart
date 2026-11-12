// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Configuration for using `package:build`-compatible build systems with
/// `package:js_codable`.
library;

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'src/js_codable_generator.dart';

/// Supports `package:build_runner` creation and configuration of `js_codable`.
Builder jsCodableBuilder(BuilderOptions options) {
  try {
    var configJson = options.config;
    if (configJson.containsKey('run_only_if_triggered')) {
      configJson = Map.of(configJson)..remove('run_only_if_triggered');
    }
    final config = JsonSerializable.fromJson(configJson);
    return LibraryBuilder(
      JsCodableGenerator(config: config),
      generatedExtension: '.js_codable.dart',
      header: '$defaultFileHeader\n// ignore_for_file: type=lint',
      formatOutput: (code, languageVersion) =>
          DartFormatter(languageVersion: languageVersion).format(code),
    );
  } on CheckedFromJsonException catch (e) {
    final lines = <String>[
      'Could not parse the options provided for `js_codable`.',
    ];

    if (e.key != null) {
      lines.add('There is a problem with "${e.key}".');
    }
    if (e.message != null) {
      lines.add(e.message!);
    } else if (e.innerError != null) {
      lines.add(e.innerError.toString());
    }

    throw StateError(lines.join('\n'));
  }
}
