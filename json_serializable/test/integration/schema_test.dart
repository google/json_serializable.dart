import 'dart:convert';

import 'package:json_schema/json_schema.dart';
import 'package:test/test.dart';

import 'schema_example.dart';

void main() {
  group('SchemaExample', () {
    late JsonSchema schema;

    setUpAll(() {
      schema = JsonSchema.create(SchemaExample.schema);
    });

    test('valid instance', () {
      final instance = SchemaExample(
        <SchemaExample>[
          SchemaExample(
            <SchemaExample>[],
            0.5,
            requiredName: 1.0,
            nullableRequiredName: 2.0,
            optionalNullableFieldWithJsonKeyDefault: 3.14,
            branch: const Branch(length: 1.0, branch: <Branch>[]),
            nested: ComprehensiveNested(),
          )..propExtraFieldRequired = true,
        ],
        0.5,
        requiredName: 1.0,
        nullableRequiredName: 2.0,
        optionalNullableFieldWithJsonKeyDefault: 3.14,
        branch: const Branch(length: 1.0, branch: <Branch>[]),
        nested: ComprehensiveNested(),
      )..propExtraFieldRequired = true;

      final json = jsonDecode(jsonEncode(instance));
      final validation = schema.validate(json);
      expect(validation.isValid, isTrue, reason: validation.errors.toString());
    });

    test('invalid instance - missing required', () {
      final json = <String, dynamic>{
        'requiredName': 1.0,
        // 'nullableRequiredPositional' is missing
        'nullableRequiredName': 2.0,
        'requiredBranch': <dynamic>[],
        'branch': <String, dynamic>{'length': 1.0, 'branch': <dynamic>[]},
        'propExtraFieldRequired': true,
      };

      final validation = schema.validate(json);
      expect(validation.isValid, isFalse);
      expect(
        validation.errors.any((e) => e.message.contains('required')),
        isTrue,
      );
    });

    test('invalid instance - wrong type', () {
      final json = <String, dynamic>{
        'requiredName': 'not a number',
        'nullableRequiredPositional': 0.5,
        'nullableRequiredName': 2.0,
        'requiredBranch': <dynamic>[],
        'branch': <String, dynamic>{'length': 1.0, 'branch': <dynamic>[]},
        'propExtraFieldRequired': true,
      };

      final validation = schema.validate(json);
      expect(validation.isValid, isFalse);
      expect(
        validation.errors.any((e) => e.message.contains('number')),
        isTrue,
      );
    });
  });

  group('ComprehensiveNested', () {
    late JsonSchema schema;

    setUpAll(() {
      schema = JsonSchema.create(ComprehensiveNested.schema);
    });

    test('valid instance', () {
      final instance = ComprehensiveNested()
        ..writableField = 10
        ..renamedField = 20;

      final json = instance.toJson();
      final validation = schema.validate(json);
      expect(validation.isValid, isTrue, reason: validation.errors.toString());
    });

    test('invalid instance', () {
      final json = {'renamed_field': 'not an int'};

      final validation = schema.validate(json);
      expect(validation.isValid, isFalse);
    });

    test('validates doc comment extraction', () {
      final properties =
          schema.schemaMap!['properties'] as Map<String, dynamic>;
      final regexChecks = properties['regexChecks'] as Map<String, dynamic>;
      expect(
        regexChecks['description'],
        'Description with a multiplication: a * b',
      );
    });
  });
}
