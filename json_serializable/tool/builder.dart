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

Builder nonNull([_]) => LibraryBuilder(_NonNullableGenerator(),
    generatedExtension: '.non_nullable.dart', header: copyrightHeader);

Builder wrapped([_]) => LibraryBuilder(_WrappedGenerator(),
    generatedExtension: '.wrapped.dart', header: copyrightHeader);

Builder checked([_]) => LibraryBuilder(_CheckedGenerator(),
    generatedExtension: '.checked.dart', header: copyrightHeader);

class _NonNullableGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final path = buildStep.inputId.path;
    final baseName = p.basenameWithoutExtension(path);

    final content = await buildStep.readAsString(buildStep.inputId);
    final replacements = [
      _Replacement(_copyrightContent, ''),
      _Replacement(
        "part '$baseName.g.dart",
        "part '$baseName.non_nullable.g.dart",
      ),
      _Replacement('@JsonSerializable()', '@JsonSerializable(nullable: false)'),
    ];

    if (baseName == 'kitchen_sink') {
      replacements.addAll([
        _Replacement('List<T> _defaultList<T>() => null;',
            'List<T> _defaultList<T>() => <T>[];'),
        _Replacement('Set<T> _defaultSet<T>() => null;',
            'Set<T> _defaultSet<T>() => Set<T>();'),
        _Replacement('Map _defaultMap() => null;',
            'Map<String, T> _defaultMap<T>() => <String, T>{};'),
        _Replacement('SimpleObject _defaultSimpleObject() => null;',
            'SimpleObject _defaultSimpleObject() => SimpleObject(42);'),
        _Replacement(
            'StrictKeysObject _defaultStrictKeysObject() => null;',
            'StrictKeysObject _defaultStrictKeysObject() => '
            "StrictKeysObject(10, 'cool');"),
        _Replacement(
            'DateTime dateTime;', 'DateTime dateTime = DateTime(1981, 6, 5);')
      ]);
    }

    return _Replacement.generate(content, replacements);
  }
}

class _CheckedGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final path = buildStep.inputId.path;
    final baseName = p.basenameWithoutExtension(path);

    final content = await buildStep.readAsString(buildStep.inputId);
    final replacements = [
      _Replacement(_copyrightContent, ''),
      _Replacement(
        "part '$baseName.g.dart",
        "part '$baseName.checked.g.dart",
      ),
    ];

    return _Replacement.generate(content, replacements);
  }
}

class _WrappedGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final path = buildStep.inputId.path;
    final baseName = p.basenameWithoutExtension(path);

    final content = await buildStep.readAsString(buildStep.inputId);
    final replacements = [
      _Replacement(_copyrightContent, ''),
      _Replacement(
        "part '$baseName.g.dart",
        "part '$baseName.wrapped.g.dart",
      ),
    ];

    return _Replacement.generate(content, replacements);
  }
}

class _Replacement {
  final Pattern existing;
  final String replacement;

  _Replacement(this.existing, this.replacement);

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

    return outputContent;
  }
}
