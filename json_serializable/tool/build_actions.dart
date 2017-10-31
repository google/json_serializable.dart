// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';

import 'package:build_runner/build_runner.dart';
import 'package:json_serializable/generators.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

final List<BuildAction> buildActions = [
  new BuildAction(
      new LibraryBuilder(new _NonNullableGenerator(),
          generatedExtension: '.non_nullable.dart', header: _copyrightHeader),
      'json_serializable',
      inputs: const ['test/test_files/kitchen_sink.dart']),
  new BuildAction(
    new PartBuilder(
        const [const JsonSerializableGenerator(), const JsonLiteralGenerator()],
        header: _copyrightHeader),
    'json_serializable',
    inputs: const ['example/*.dart', 'test/test_files/*.dart'],
  )
];

final _copyrightContent =
    '''// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
''';

final _copyrightHeader = '$_copyrightContent\n$defaultFileHeader';

class _NonNullableGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final path = buildStep.inputId.path;
    final baseName = p.basenameWithoutExtension(path);

    // 1) - source file
    final f1Content = await buildStep.readAsString(buildStep.inputId);
    final f1LibraryDirective =
        'library ${buildStep.inputId.package}.test.$baseName';
    final f1PartDirective = "part '${baseName}.g.dart";

    var replacements = <_Replacement>[
      new _Replacement(_copyrightContent, ''),
      new _Replacement(f1LibraryDirective,
          'library ${buildStep.inputId.package}.test.${baseName}_non_nullable'),
      new _Replacement(
        f1PartDirective,
        "part '${baseName}.non_nullable.g.dart",
      ),
      new _Replacement("import 'test_files_util.dart';",
          "import 'kitchen_sink.dart' as k;\nimport 'test_files_util.dart';"),
      new _Replacement('List<T> _defaultList<T>() => null;',
          'List<T> _defaultList<T>() => <T>[];'),
      new _Replacement(
          'Map _defaultMap() => null;', 'Map _defaultMap() => {};'),
      new _Replacement(
          '@JsonSerializable()', '@JsonSerializable(nullable: false)'),
      new _Replacement(r'with _$KitchenSinkSerializerMixin {',
          r'with _$KitchenSinkSerializerMixin implements k.KitchenSink {'),
      new _Replacement(
          'DateTime dateTime;', 'DateTime dateTime = new DateTime(1981, 6, 5);')
    ];

    var f2Content = f1Content;

    for (var r in replacements) {
      if (!f2Content.contains(r.existing)) {
        throw new StateError(
            'Input string did not contain `${r.existing}` as expected.');
      }
      f2Content = r.single
          ? f2Content.replaceFirst(r.existing, r.replacement)
          : f2Content.replaceAll(r.existing, r.replacement);
    }

    return f2Content;
  }
}

class _Replacement {
  final Pattern existing;
  final String replacement;
  final bool single;

  _Replacement(this.existing, this.replacement, [this.single = true]);
}
