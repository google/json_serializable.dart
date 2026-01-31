// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

import 'field_helpers.dart';
import 'helper_core.dart';
import 'json_literal_generator.dart';
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

      // If the field is writable (has a setter), it's fine.
      if (f.setter != null) return true;

      // If the field is read-only, we need to make sure it's in the constructor
      return config.ctorParams.any((p) => p.name == f.name);
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

      // If it's a constructor parameter, trust the parameter strictness.
      FormalParameterElement? param;
      for (final p in config.ctorParams) {
        if (p.name == field.name) {
          param = p;
          break;
        }
      }

      // Try reading default value from constructor if not on annotation
      if (defaultValueObj == null && param != null && param.hasDefaultValue) {
        defaultValueObj = param.computeConstantValue();
      }

      // Description
      final description = field.documentationComment
          ?.replaceAll(RegExp(r'^\s*/// ?', multiLine: true), '')
          .replaceAll(
            RegExp(r'^\s*\/\*\*\s*|\s*\*\/\s*$|\s*\*\s?', multiLine: true),
            '',
          )
          .trim();

      bool calculateIsRequired() {
        if (jsonKey.required) return true;
        if (defaultValueObj != null) return false;

        if (param != null) {
          // If param has default value -> it is optional.
          // (defaultValueObj check above handles this if we successfully read
          // it, but for safety/consistency with `param.hasDefaultValue`...)
          if (param.hasDefaultValue) return false;

          return param.isRequiredPositional || param.isRequiredNamed;
        }

        // If it has an initializer, it's not required.
        if (field.hasInitializer) return false;

        return field.type.nullabilitySuffix == NullabilitySuffix.none;
      }

      return PropertyInfo(
        name,
        field.type,
        isRequired: calculateIsRequired(),
        defaultValue: defaultValueObj,
        description: description,
      );
    }).whereType<PropertyInfo>();

    final schema = generateJsonSchema(element, properties);
    final name = '_\$${element.name}JsonSchema';
    return 'const $name = ${jsonLiteralAsDart(schema)};';
  }
}
