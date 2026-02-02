// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/json_serializable.dart';
import 'package:json_serializable/src/settings.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_json_enum_default_rename_test_input.dart',
  );

  group('enum_field_rename from build config', () {
    test(
      'config enum_field_rename: pascal applies to enum without fieldRename',
      () async {
        final generator = JsonEnumGenerator(
          Settings(
            config: const JsonSerializable(enumFieldRename: FieldRename.pascal),
          ),
        );
        final output = await generateForElement(
          generator,
          reader,
          'EnumForDefaultRename',
        );

        expect(output, contains("'FirstValue'"));
        expect(output, contains("'SecondValue'"));
        expect(output, contains("'ThirdValue'"));
        expect(output, contains('EnumForDefaultRename.firstValue:'));
        expect(output, contains('EnumForDefaultRename.secondValue:'));
        expect(output, contains('EnumForDefaultRename.thirdValue:'));
      },
    );

    test(
      'default config (none) produces identity names for same enum',
      () async {
        final generator = JsonEnumGenerator(Settings());
        final output = await generateForElement(
          generator,
          reader,
          'EnumForDefaultRename',
        );

        expect(output, contains("'firstValue'"));
        expect(output, contains("'secondValue'"));
        expect(output, contains("'thirdValue'"));
        expect(output, isNot(contains("'FirstValue'")));
      },
    );
  });

  group('annotation overrides config', () {
    test('@JsonEnum(fieldRename: kebab) wins when config is pascal', () async {
      final generator = JsonEnumGenerator(
        Settings(
          config: const JsonSerializable(enumFieldRename: FieldRename.pascal),
        ),
      );
      final output = await generateForElement(
        generator,
        reader,
        'EnumWithKebabOverride',
      );

      expect(output, contains("'foo-bar'"));
      expect(output, contains("'baz-qux'"));
      expect(output, isNot(contains("'FooBar'")));
    });
  });
}
