// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

final _copyrightContent =
    '''// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
''';

final copyrightHeader = '$_copyrightContent\n$defaultFileHeader';

LibraryBuilder _builder(_ReplaceGenerator generator) => LibraryBuilder(
      generator,
      generatedExtension: '.${generator.gName}.dart',
      header: copyrightHeader,
      formatOutput: (a) => a,
    );

Builder nonNull([_]) => _builder(_NonNullableGenerator());

Builder wrapped([_]) => _builder(_WrappedGenerator());

Builder checked([_]) => _builder(_CheckedGenerator());

abstract class _ReplaceGenerator extends Generator {
  final String gName;

  _ReplaceGenerator(this.gName);

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final path = buildStep.inputId.path;
    final baseName = p.basenameWithoutExtension(path);

    final content = await buildStep.readAsString(buildStep.inputId);

    return _Replacement.generate(content, createReplacements(baseName));
  }

  Iterable<_Replacement> createReplacements(String baseName) sync* {
    yield _Replacement(_copyrightContent, '');

    yield _Replacement(
      "part '$baseName.g.dart",
      "part '$baseName.$gName.g.dart",
    );
  }
}

class _NonNullableGenerator extends _ReplaceGenerator {
  _NonNullableGenerator() : super('non_nullable');

  @override
  Iterable<_Replacement> createReplacements(String baseName) sync* {
    yield* super.createReplacements(baseName);

    yield _Replacement.addJsonSerializableKey('nullable', false);

    if (baseName == 'kitchen_sink') {
      yield _Replacement('List<T> _defaultList<T>() => null;',
          'List<T> _defaultList<T>() => <T>[];');
      yield _Replacement('Set<T> _defaultSet<T>() => null;',
          'Set<T> _defaultSet<T>() => Set<T>();');
      yield _Replacement('Map<K, V> _defaultMap<K, V>() => null;',
          'Map<String, T> _defaultMap<T>() => <String, T>{};');
      yield _Replacement('SimpleObject _defaultSimpleObject() => null;',
          'SimpleObject _defaultSimpleObject() => SimpleObject(42);');
      yield _Replacement(
          'StrictKeysObject _defaultStrictKeysObject() => null;',
          'StrictKeysObject _defaultStrictKeysObject() => '
          "StrictKeysObject(10, 'cool');");
      yield _Replacement(
          'DateTime dateTime;', 'DateTime dateTime = DateTime(1981, 6, 5);');
    }
  }
}

class _CheckedGenerator extends _ReplaceGenerator {
  _CheckedGenerator() : super('checked');

  @override
  Iterable<_Replacement> createReplacements(String baseName) sync* {
    yield* super.createReplacements(baseName);

    yield _Replacement.addJsonSerializableKey('checked', true);

    if (baseName == 'default_value') {
      yield _Replacement.addJsonSerializableKey('anyMap', true);
    }
  }
}

class _WrappedGenerator extends _ReplaceGenerator {
  _WrappedGenerator() : super('wrapped');

  @override
  Iterable<_Replacement> createReplacements(String baseName) sync* {
    yield* super.createReplacements(baseName);

    yield _Replacement.addJsonSerializableKey('useWrappers', true);
  }
}

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
        throw StateError(
            'Input string did not contain `${r.existing}` as expected.');
      }
      outputContent = outputContent.replaceAll(r.existing, r.replacement);
    }

    outputContent = outputContent.replaceAll(',)', ',\n)');

    return outputContent;
  }
}
