import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:source_helper/source_helper.dart';

import 'field_helpers.dart';
import 'helper_core.dart';
import 'json_schema_generator.dart';
import 'utils.dart';

mixin SchemaHelper implements HelperCore {
  String createJsonSchema() {
    final accessibleFields = createSortedFieldSet(element).where((
      FieldElement f,
    ) {
      final jsonKey = jsonKeyFor(f);
      if (jsonKey.explicitNoToJson) return false;
      if (f.getter == null) return false;
      return true;
    });

    final properties = accessibleFields.map((FieldElement field) {
      final jsonKey = jsonKeyFor(field);
      final name = jsonKey.name;
      final annotations = jsonKeyAnnotation(field);

      // Default Value: jsonKeyForField logic uses `defaultValue`,
      // `ctorParamDefault`. KeyConfig has `defaultValue` (String source). We
      // want the `DartObject` value. This is tricky because `KeyConfig` stores
      // the *code* for the default value, not the object. But
      // `jsonKeyAnnotation(field)` gives us the `JsonKey` object which might
      // have a literal value. If the default value comes from the constructor,
      // we can't easily get the DartObject unless it's a const default.

      // Best effort: Try to read from JsonKey.defaultValue
      DartObject? defaultValueObj;
      if (!annotations.isNull) {
        final ignore =
            annotations.read('ignore').literalValue as bool? ?? false;
        if (ignore) return null;

        final defaultValueField = annotations.read('defaultValue');
        if (!defaultValueField.isNull) {
          defaultValueObj = defaultValueField.objectValue;
        }
      }

      // Description
      final description = field.documentationComment
          ?.replaceAll(RegExp(r'^\s*/// ?', multiLine: true), '')
          .replaceAll(
            RegExp(r'^\s*\/\*\*\s*|\s*\*\/\s*$|\s*\*\s?', multiLine: true),
            '',
          )
          .trim();

      return PropertyInfo(
        name,
        field.type,
        isRequired:
            field.type.nullabilitySuffix ==
            NullabilitySuffix.none, // Simplified check
        defaultValue: defaultValueObj,
        description: description,
      );
    }).whereType<PropertyInfo>();

    final schema = generateJsonSchema(element, properties);
    final name = '_\$${element.name}JsonSchema';
    return 'const $name = ${_toDartLiteral(schema)};';
  }

  String _toDartLiteral(Object? value) {
    if (value is Map) {
      final buffer = StringBuffer('{');
      for (final entry in value.entries) {
        buffer
          ..write(_toDartLiteral(entry.key))
          ..write(': ')
          ..write(_toDartLiteral(entry.value))
          ..write(', ');
      }
      buffer.write('}');
      return buffer.toString();
    } else if (value is List) {
      final buffer = StringBuffer('[');
      for (final item in value) {
        buffer
          ..write(_toDartLiteral(item))
          ..write(', ');
      }
      buffer.write(']');
      return buffer.toString();
    } else if (value is String) {
      return escapeDartString(value);
    } else {
      return value.toString();
    }
  }
}
