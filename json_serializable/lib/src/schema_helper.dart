// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'field_helpers.dart';
import 'helper_core.dart';
import 'json_key_utils.dart';
import 'json_literal_generator.dart';
import 'shared_checkers.dart';
import 'type_helpers/config_types.dart';
import 'utils.dart';

mixin SchemaHelper implements HelperCore {
  String createJsonSchema() {
    final properties = _doPropertyThingy(element);
    final schema = _generateJsonSchema(element, properties);
    final name = '_\$${element.name}JsonSchema';
    return 'const $name = ${jsonLiteralAsDart(schema)};';
  }

  Iterable<PropertyInfo> _doPropertyThingy(ClassElement element) {
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

    return properties;
  }

  Map<String, dynamic> _generateJsonSchema(
    ClassElement element,
    Iterable<PropertyInfo> properties,
  ) {
    final generatedSchemas = <String, Map<String, dynamic>>{};
    final mainSchema = _generateSchemaForProperties(
      properties,
      element.displayName,
      generatedSchemas,
      isRoot: true,
      seenTypes: {element.thisType},
    );

    return {
      r'$schema': 'https://json-schema.org/draft/2020-12/schema',
      ...mainSchema,
      if (generatedSchemas.isNotEmpty) r'$defs': generatedSchemas,
    };
  }

  Map<String, dynamic> _getPropertySchema(
    DartType type,
    Map<String, Map<String, dynamic>> generatedSchemas, {
    bool isRoot = false,
    Set<DartType> seenTypes = const {},
  }) {
    if (!isRoot && seenTypes.contains(type)) {
      final element = type.element;
      if (element != null) {
        return {r'$ref': '#/\$defs/${element.displayName}'};
      }
    }

    final newSeenTypes = {...seenTypes, type};

    if (coreStringTypeChecker.isExactlyType(type)) {
      return {'type': 'string'};
    }
    if (type.isDartCoreInt ||
        coreBigIntTypeChecker.isAssignableFromType(type)) {
      return {'type': 'integer'};
    }
    if (type.isDartCoreDouble || type.isDartCoreNum) {
      return {'type': 'number'};
    }
    if (type.isDartCoreBool) {
      return {'type': 'boolean'};
    }
    if (coreDateTimeTypeChecker.isExactlyType(type)) {
      return {'type': 'string', 'format': 'date-time'};
    }
    if (coreUriTypeChecker.isExactlyType(type)) {
      return {'type': 'string', 'format': 'uri'};
    }

    if (coreIterableTypeChecker.isAssignableFromType(type)) {
      return {
        'type': 'array',
        'items': _getPropertySchema(
          coreIterableGenericType(type),
          generatedSchemas,
          seenTypes: newSeenTypes,
        ),
      };
    }
    if (coreMapTypeChecker.isAssignableFromType(type)) {
      final typeArgs = type.typeArgumentsOf(coreMapTypeChecker);
      assert(typeArgs != null);
      assert(typeArgs!.length == 2);
      return {
        'type': 'object',
        'additionalProperties': _getPropertySchema(
          typeArgs![1],
          generatedSchemas,
          seenTypes: newSeenTypes,
        ),
      };
    }

    if (type is InterfaceType && !type.isDartCoreObject) {
      return _generateComplexTypeSchema(
        type,
        generatedSchemas,
        isRoot,
        newSeenTypes,
      );
    }

    return {'type': 'object'};
  }

  Map<String, dynamic> _generateComplexTypeSchema(
    InterfaceType type,
    Map<String, Map<String, dynamic>> generatedSchemas,
    bool isRoot,
    Set<DartType> seenTypes,
  ) {
    final element = type.element;
    final typeName = element.displayName;

    if (!isRoot && generatedSchemas.containsKey(typeName)) {
      return {r'$ref': '#/\$defs/$typeName'};
    }

    final classElement = element;
    if (classElement is! ClassElement) {
      return {'type': 'object'};
    }

    // We only have properties for the ROOT object passed in from
    // GeneratorHelper. For nested objects, we'd need to invoke the same logic,
    // but GeneratorHelper generates one class at a time. To properly support
    // nested objects with full schema fidelity, we would need to inspect them
    // similarly. However, since we are decoupling, we will make a best-effort
    // inspection of fields here strictly for nested types, ignoring specific
    // json_serializable overrides (renames) unless we duplicate that logic or
    // accept simple names. Given the request for "Separation of Concerns" and
    // "DRY", fully supporting nested objects with complex configuration without
    // circular dependency on GeneratorHelper is tricky.
    //
    // Compromise: Use simple field inspection for nested types, as they are
    // "refs". Or, better, if a type is encountered that we don't have explicit
    // properties for, we just emit a ref if possible or a basic object
    // structure.
    //
    // For now, let's implement basic recursion that just looks at public
    // fields.

    if (!isRoot) {
      // Create a simplified schema for nested objects
      final annotation = jsonSerializableChecker.firstAnnotationOfExact(
        classElement,
        throwOnUnresolved: false,
      );
      var config = ClassConfig.defaults;
      if (annotation != null) {
        config = mergeConfig(
          config,
          ConstantReader(annotation),
          classElement: classElement,
        );
      }

      final properties = classElement.fields
          .map((f) => (field: f, jsonKey: jsonKeyForField(f, config)))
          .where((record) {
            final (:field, :jsonKey) = record;

            if (field.isStatic || !field.isPublic) return false;

            if (jsonKey.explicitNoToJson) {
              return false;
            }

            // If no JsonKey on the field/getter, check validity
            // Logic from SchemaHelper.createJsonSchema
            // If the field is writable (has a setter), it's fine.
            if (field.setter != null) return true;

            // If NO annotation exists, we skip synthetic fields (getters).
            if (!hasJsonKeyAnnotation(field) && field.isSynthetic) {
              return false;
            }

            return true;
          })
          .map(
            (record) => PropertyInfo(
              record.jsonKey.name,
              record.field.type,
              isRequired:
                  record.jsonKey.required || !record.field.type.isNullableType,
              defaultValue: record.field.computeConstantValue(), // Best effort
            ),
          );

      final schema = _generateSchemaForProperties(
        properties,
        typeName,
        generatedSchemas,
        isRoot: false,
        seenTypes: seenTypes,
      );
      generatedSchemas[typeName] = schema;
      return {r'$ref': '#/\$defs/$typeName'};
    }

    // This path shouldn't be reached for isRoot=false usually due to check
    // above.
    return {'type': 'object'};
  }

  Map<String, dynamic> _generateSchemaForProperties(
    Iterable<PropertyInfo> properties,
    String typeName,
    Map<String, Map<String, dynamic>> generatedSchemas, {
    required bool isRoot,
    required Set<DartType> seenTypes,
  }) {
    final schemaProperties = <String, dynamic>{};
    final required = <String>[];

    for (final property in properties) {
      final propertySchema = _getPropertySchema(
        property.type,
        generatedSchemas,
        seenTypes: seenTypes,
      );

      if (property.description != null) {
        propertySchema['description'] = property.description;
      }

      // Default value handling
      if (property.defaultValue != null) {
        final defaultValue = _defaultValue(
          property.defaultValue!,
          property.type,
        );
        if (defaultValue != _noMatch) {
          propertySchema['default'] = defaultValue;
        }
      }

      schemaProperties[property.name] = propertySchema;

      if (property.isRequired) {
        required.add(property.name);
      }
    }

    return {
      'type': 'object',
      'properties': schemaProperties,
      if (required.isNotEmpty) 'required': required,
    };
  }
}

Object? _defaultValue(DartObject defaultValue, DartType type) => switch (type) {
  _ when coreStringTypeChecker.isAssignableFromType(type) =>
    defaultValue.toStringValue(),
  _ when type.isDartCoreInt => defaultValue.toIntValue(),
  _ when type.isDartCoreDouble || type.isDartCoreNum =>
    defaultValue.toDoubleValue(),
  _ when type.isDartCoreBool => defaultValue.toBoolValue(),
  _ when coreIterableTypeChecker.isAssignableFromType(type) =>
    defaultValue.toListValue(),
  _ when coreMapTypeChecker.isAssignableFromType(type) =>
    defaultValue.toMapValue(),
  _ => _noMatch,
};

/// Sentinel value used to indicate that no default value could be determined.
final _noMatch = Object();

/// Property information used to generate the JSON Schema.
class PropertyInfo {
  final String name;
  final DartType type;
  final bool isRequired;
  final DartObject? defaultValue;
  final String? description;

  const PropertyInfo(
    this.name,
    this.type, {
    required this.isRequired,
    this.defaultValue,
    this.description,
  });
}
