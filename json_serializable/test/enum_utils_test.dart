// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/src/enum_utils.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_json_enum_default_rename_test_input.dart',
  );

  EnumElement? enumForDefaultRenameElement;
  EnumElement? enumWithKebabOverrideElement;

  for (final element in reader.allElements) {
    if (element is EnumElement) {
      if (element.name == 'EnumForDefaultRename') {
        enumForDefaultRenameElement = element;
      } else if (element.name == 'EnumWithKebabOverride') {
        enumWithKebabOverrideElement = element;
      }
    }
  }

  group('enumValueMapFromType with defaultEnumFieldRename', () {
    test('defaultEnumFieldRename: pascal produces PascalCase values', () {
      expect(
        enumForDefaultRenameElement,
        isNotNull,
        reason: 'EnumForDefaultRename not found in test input',
      );
      final type = enumForDefaultRenameElement!.thisType;
      final result = enumValueMapFromType(
        type,
        defaultEnumFieldRename: FieldRename.pascal,
      );

      expect(result, isNotNull);
      expect(result!, contains("'FirstValue'"));
      expect(result, contains("'SecondValue'"));
      expect(result, contains("'ThirdValue'"));
    });

    test('defaultEnumFieldRename: null produces identity names', () {
      expect(
        enumForDefaultRenameElement,
        isNotNull,
        reason: 'EnumForDefaultRename not found in test input',
      );
      final type = enumForDefaultRenameElement!.thisType;
      final result = enumValueMapFromType(type);

      expect(result, isNotNull);
      expect(result!, contains("'firstValue'"));
      expect(result, contains("'secondValue'"));
      expect(result, contains("'thirdValue'"));
    });

    test(
      '@JsonEnum(fieldRename: kebab) overrides defaultEnumFieldRename pascal',
      () {
        expect(
          enumWithKebabOverrideElement,
          isNotNull,
          reason: 'EnumWithKebabOverride not found in test input',
        );
        final type = enumWithKebabOverrideElement!.thisType;
        final result = enumValueMapFromType(
          type,
          defaultEnumFieldRename: FieldRename.pascal,
        );

        expect(result, isNotNull);
        expect(result!, contains("'foo-bar'"));
        expect(result, contains("'baz-qux'"));
        expect(result, isNot(contains("'FooBar'")));
      },
    );
  });
}
