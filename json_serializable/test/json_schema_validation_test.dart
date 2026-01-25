@TestOn('vm')
library;

import 'package:analyzer/dart/element/element.dart' as analyzer;
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:json_schema/json_schema.dart' as js;
import 'package:json_serializable/src/json_schema_generator.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart' as source_gen;
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_json_schema_test_input.dart',
  );

  test('generated schemas are valid JSON schemas', () async {
    const checker = source_gen.TypeChecker.any([
      source_gen.TypeChecker.fromUrl(
        'package:json_annotation/json_annotation.dart#JsonSerializable',
      ),
      source_gen.TypeChecker.fromUrl(
        'package:json_annotation/src/json_serializable.dart#JsonSerializable',
      ),
    ]);

    var count = 0;

    for (final element in reader.allElements) {
      if (element is analyzer.ClassElement) {
        if (checker.hasAnnotationOf(element)) {
          // Use hasAnnotationOf (looser)
          final annotation = checker.firstAnnotationOf(element);
          final createJsonSchema =
              annotation?.getField('createJsonSchema')?.toBoolValue() ?? false;

          if (!createJsonSchema) continue;

          count++;
          // print('Testing schema validity for ${element.name}');

          final properties = element.fields
              .where((f) => !f.isStatic && f.isPublic)
              .map(
                (f) => PropertyInfo(
                  f.name!,
                  f.type,
                  isRequired:
                      f.type.nullabilitySuffix == NullabilitySuffix.none,
                ),
              );

          final generator = JsonSchemaGenerator();
          final schemaMap = generator.generateSchema(element, properties);

          try {
            // Validate that the generated map is a valid JSON Schema
            final schema = js.JsonSchema.create(schemaMap);
            expect(schema, isNotNull);
          } catch (e) {
            print('Failed schema for ${element.name}: $schemaMap');
            fail('Schema validation failed for ${element.name}: $e');
          }
        } else {
          // Debugging why skipping
          // print('Skipped ${element.name}');
        }
      }
    }

    if (count == 0) {
      fail('No classes found with createJsonSchema: true (Checked $count)');
    }
  });
}
