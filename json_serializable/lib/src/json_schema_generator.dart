import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import 'shared_checkers.dart';

/// Generates a JSON Schema for a [ClassElement].
class JsonSchemaGenerator {
  final _generatedSchemas = <String, Map<String, dynamic>>{};

  /// Generates the schema string literal.
  Map<String, dynamic> generateSchema(
    ClassElement element,
    Iterable<PropertyInfo> properties,
  ) {
    _generatedSchemas.clear();
    final mainSchema = _generateSchemaForProperties(
      properties,
      element.displayName,
      isRoot: true,
      seenTypes: {element.thisType},
    );

    return {
      r'$schema': 'https://json-schema.org/draft/2020-12/schema',
      ...mainSchema,
      if (_generatedSchemas.isNotEmpty) r'$defs': _generatedSchemas,
    };
  }

  Map<String, dynamic> _getPropertySchema(
    DartType type, {
    bool isRoot = false,
    Set<DartType> seenTypes = const {},
  }) {
    if (!isRoot && seenTypes.contains(type)) {
      final element = type.element;
      if (element != null) {
        return {r'$ref': '#/\$defs/${element.displayName}'};
      }
    }

    final newSeenTypes = Set<DartType>.from(seenTypes)..add(type);

    if (coreStringTypeChecker.isExactlyType(type)) {
      return {'type': 'string'};
    }
    if (type.isDartCoreInt) {
      return {'type': 'integer'};
    }
    if (type.isDartCoreDouble || type.isDartCoreNum) {
      return {'type': 'number'};
    }
    if (type.isDartCoreBool) {
      return {'type': 'boolean'};
    }
    if (coreIterableTypeChecker.isAssignableFromType(type)) {
      final itemType = coreIterableGenericType(type);
      return {
        'type': 'array',
        'items': _getPropertySchema(itemType, seenTypes: newSeenTypes),
      };
    }
    if (coreMapTypeChecker.isAssignableFromType(type)) {
      final valueType = (type as InterfaceType).typeArguments.length > 1
          ? type.typeArguments[1]
          : type.typeArguments.first;
      return {
        'type': 'object',
        'additionalProperties': _getPropertySchema(
          valueType,
          seenTypes: newSeenTypes,
        ),
      };
    }

    // Check for DateTime/Uri which might have specialized checkers in
    // shared_checkers or not. shared_checkers doesn't have dateTime/uri, so we
    // check conventionally.
    if (type.element?.name == 'DateTime' &&
        type.element?.library?.name == 'dart.core') {
      return {'type': 'string', 'format': 'date-time'};
    }
    if (type.element?.name == 'Uri' &&
        type.element?.library?.name == 'dart.core') {
      return {'type': 'string', 'format': 'uri'};
    }

    if (type is InterfaceType && !type.isDartCoreObject) {
      return _generateComplexTypeSchema(type, isRoot, newSeenTypes);
    }

    return {'type': 'object'};
  }

  Map<String, dynamic> _generateComplexTypeSchema(
    InterfaceType type,
    bool isRoot,
    Set<DartType> seenTypes,
  ) {
    final element = type.element;
    final typeName = element.displayName;

    if (!isRoot && _generatedSchemas.containsKey(typeName)) {
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
      final properties = classElement.fields
          .where((f) => !f.isStatic && f.isPublic)
          .map(
            (f) => PropertyInfo(
              f.name!,
              f.type,
              isRequired: !f.type.isNullableType,
            ), // basic guess
          );

      // Note: This ignores JsonKey configuration on nested objects. To fix this
      // properly, we'd need access to KeyConfig for arbitrary types, which
      // resides in json_key_utils. But we don't need to over-engineer right now
      // (YAGNI).

      final schema = _generateSchemaForProperties(
        properties,
        typeName,
        isRoot: false,
        seenTypes: seenTypes,
      );
      _generatedSchemas[typeName] = schema;
      return {r'$ref': '#/\$defs/$typeName'};
    }

    // This path shouldn't be reached for isRoot=false usually due to check
    // above.
    return {'type': 'object'};
  }

  Map<String, dynamic> _generateSchemaForProperties(
    Iterable<PropertyInfo> properties,
    String typeName, {
    required bool isRoot,
    required Set<DartType> seenTypes,
  }) {
    final schemaProperties = <String, dynamic>{};
    final required = <String>[];

    for (final property in properties) {
      final propertySchema = _getPropertySchema(
        property.type,
        seenTypes: seenTypes,
      );

      if (property.description != null) {
        propertySchema['description'] = property.description;
      }

      // Default value handling
      if (property.defaultValue != null) {
        _applyDefaultValue(
          propertySchema,
          property.defaultValue!,
          property.type,
        );
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

  void _applyDefaultValue(
    Map<String, dynamic> schema,
    DartObject defaultValue,
    DartType type,
  ) {
    if (coreStringTypeChecker.isAssignableFromType(type)) {
      schema['default'] = defaultValue.toStringValue();
    } else if (type.isDartCoreInt) {
      schema['default'] = defaultValue.toIntValue();
    } else if (type.isDartCoreDouble || type.isDartCoreNum) {
      schema['default'] = defaultValue.toDoubleValue();
    } else if (type.isDartCoreBool) {
      schema['default'] = defaultValue.toBoolValue();
    } else if (coreIterableTypeChecker.isAssignableFromType(type)) {
      schema['default'] = defaultValue.toListValue();
    } else if (coreMapTypeChecker.isAssignableFromType(type)) {
      schema['default'] = defaultValue.toMapValue();
    }
  }
}

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
