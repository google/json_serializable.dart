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
      new LibraryBuilder(
          new _TestBoilerplateGenerator('test/test_files/kitchen_sink.dart'),
          generatedExtension: '.non_nullable.dart',
          additionalOutputExtensions: _TestBoilerplateGenerator.extensions,
          header: _copyrightHeader),
      'json_serializable',
      inputs: const ['test/test_files/*.dart']),
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

class _TestBoilerplateGenerator extends Generator {
  static final extensions = const ['.nullable.dart'];
  final String path;
  final String _baseFileName;

  _TestBoilerplateGenerator(this.path)
      : _baseFileName = p.basenameWithoutExtension(path) {
    assert(p.extension(path) == '.dart');
    assert(!_baseFileName.contains('.'));
  }

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    if (buildStep.inputId.path != path) {
      return null;
    }

    // 1) - source file
    final f1Content = await buildStep.readAsString(buildStep.inputId);
    final f1LibraryDirective =
        'library ${buildStep.inputId.package}.test.$_baseFileName';
    assert(f1Content.contains(f1LibraryDirective));
    final f1PartDirective = "part '${_baseFileName}.g.dart";
    assert(f1Content.contains(f1PartDirective));

    var replacements = <Replacement>[
      new Replacement(_copyrightContent, ''),
      new Replacement(f1LibraryDirective,
          'library ${buildStep.inputId.package}.test.${_baseFileName}_nullable'),
      new Replacement(
        f1PartDirective,
        "part '${_baseFileName}.non_nullable.g.dart",
      ),
      new Replacement("import 'test_files_util.dart';",
          "import 'kitchen_sink.dart';\nimport 'test_files_util.dart';"),
      new Replacement('List<T> _defaultList<T>() => null;',
          'List<T> _defaultList<T>() => <T>[];'),
      new Replacement('Map _defaultMap() => null;', 'Map _defaultMap() => {};'),
      new Replacement(
          '@JsonSerializable()', '@JsonSerializable(nullable: false)'),
      new Replacement('KitchenSink', 'KitchenSinkNonNullable', false),
      new Replacement(r'with _$KitchenSinkNonNullableSerializerMixin {',
          r'with _$KitchenSinkNonNullableSerializerMixin implements KitchenSink {'),
      new Replacement(
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

  @override
  String toString() => 'Test Boilerplate generator';
}

class Replacement {
  final String existing;
  final String replacement;
  final bool single;

  Replacement(this.existing, this.replacement, [this.single = true]);
}
