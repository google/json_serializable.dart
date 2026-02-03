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
    final generatedSchemas = <String, Map<String, dynamic>>{};
    final mainSchema = _generateSchemaForProperties(
      element,
      config,
      element.displayName,
      generatedSchemas,
      seenTypes: {element.thisType},
    );

    final schema = {
      r'$schema': 'https://json-schema.org/draft/2020-12/schema',
      ...mainSchema,
      if (generatedSchemas.isNotEmpty) r'$defs': generatedSchemas,
    };

    final name = '_\$${element.name}JsonSchema';
    return 'const $name = ${jsonLiteralAsDart(schema)};';
  }
}

Iterable<_PropertyInfo> _propertiesFor(
  ClassElement element,
  ClassConfig config,
) {
  final accessibleFields = createSortedFieldSet(element).where((
    FieldElement f,
  ) {
    final jsonKey = jsonKeyForField(f, config);

    if (jsonKey.explicitNoToJson) {
      return false;
    }

    // If the field is writable (has a setter), it's fine.
    if (f.setter != null) return true;

    // If NO annotation exists, we skip synthetic fields (getters).
    // This matches the behavior in `_generateComplexTypeSchema` before
    // refactoring, ensuring we don't accidentally include pure getters unless
    // they are in the constructor (checked below) or explicitly annotated
    // (checked above via jsonKey).
    //
    // Check previous `_generateComplexTypeSchema` logic:
    // if (jsonKey.explicitNoToJson) return false;
    // if (f.setter != null) return true;
    // if (!hasJsonKeyAnnotation(field) && field.isSynthetic) return false;
    // return true;
    //
    // Revised logic for `_propertiesFor`:
    if (jsonKey.explicitNoToJson) return false;
    if (f.getter == null) return false;
    if (f.setter != null) return true;
    if (jsonKey.includeToJson == true) {
      return true; // Allow explicitly included getters
    }
    return config.ctorParams.any((p) => p.name == f.name);
  });

  return accessibleFields.map((FieldElement field) {
    final jsonKey = jsonKeyForField(field, config);
    final name = jsonKey.name;
    final annotations = jsonKeyAnnotation(field);

    // Default Value validation logic...
    DartObject? defaultValueObj;
    if (!annotations.isNull) {
      final ignore = annotations.read('ignore').literalValue as bool? ?? false;
      if (ignore) return null;

      final defaultValueField = annotations.read('defaultValue');
      if (!defaultValueField.isNull) {
        defaultValueObj = defaultValueField.objectValue;
      }
    }

    // Constructor param default
    FormalParameterElement? param;
    for (final p in config.ctorParams) {
      if (p.name == field.name) {
        param = p;
        break;
      }
    }

    if (defaultValueObj == null && param != null && param.hasDefaultValue) {
      defaultValueObj = param.computeConstantValue();
    }

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
        if (param.hasDefaultValue) return false;
        return param.isRequiredPositional || param.isRequiredNamed;
      }
      if (field.hasInitializer) return false;
      return field.type.nullabilitySuffix == NullabilitySuffix.none;
    }

    return _PropertyInfo(
      name,
      field.type,
      isRequired: calculateIsRequired(),
      defaultValue: defaultValueObj,
      description: description,
    );
  }).whereType<_PropertyInfo>();
}

Map<String, dynamic> _generateSchemaForProperties(
  ClassElement element,
  ClassConfig config,
  String typeName,
  Map<String, Map<String, dynamic>> generatedSchemas, {
  required Set<DartType> seenTypes,
}) {
  final schemaProperties = <String, dynamic>{};
  final required = <String>[];

  final properties = _propertiesFor(element, config);

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
      final defaultValue = _defaultValue(property.defaultValue!, property.type);
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

Map<String, dynamic> _getPropertySchema(
  DartType type,
  Map<String, Map<String, dynamic>> generatedSchemas, {
  Set<DartType> seenTypes = const {},
}) {
  if (seenTypes.contains(type)) {
    final element = type.element;
    if (element != null) {
      return {r'$ref': '#/\$defs/${element.displayName}'};
    }
  }

  final newSeenTypes = {...seenTypes, type};

  if (coreStringTypeChecker.isExactlyType(type)) {
    return {'type': 'string'};
  }
  if (type.isDartCoreInt || coreBigIntTypeChecker.isAssignableFromType(type)) {
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
    return _generateComplexTypeSchema(type, generatedSchemas, newSeenTypes);
  }

  return {'type': 'object'};
}

Map<String, dynamic> _generateComplexTypeSchema(
  InterfaceType type,
  Map<String, Map<String, dynamic>> generatedSchemas,
  Set<DartType> seenTypes,
) {
  final element = type.element;
  final typeName = element.displayName;

  if (generatedSchemas.containsKey(typeName)) {
    return {r'$ref': '#/\$defs/$typeName'};
  }

  final classElement = element;
  if (classElement is! ClassElement) {
    return {'type': 'object'};
  }

  // Create a simplified schema for nested objects
  final annotation = jsonSerializableChecker.firstAnnotationOfExact(
    classElement,
    throwOnUnresolved: false,
  );

  // TODO(kevmoo): make this use the generator settings
  // - need to make all of the functions "instance"
  // - need to expose the config via `HelperCore`
  // - test the generator with a custom, global config!
  var config = ClassConfig.defaults;
  if (annotation != null) {
    config = mergeConfig(
      config,
      ConstantReader(annotation),
      classElement: classElement,
    );
  } else {
    // TOOD(kevmoo): test for nested types that are NOT annotated!

    // Try to find default constructor parameters even if not annotated
    final ctor = classElement.unnamedConstructor;
    if (ctor != null) {
      // Create a copy of defaults with ctorParams
      config = config.copyWith(ctorParams: [...ctor.formalParameters]);
    }
  }

  final schema = _generateSchemaForProperties(
    classElement,
    config,
    typeName,
    generatedSchemas,
    seenTypes: seenTypes,
  );
  generatedSchemas[typeName] = schema;
  return {r'$ref': '#/\$defs/$typeName'};
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
class _PropertyInfo {
  final String name;
  final DartType type;
  final bool isRequired;
  final DartObject? defaultValue;
  final String? description;

  const _PropertyInfo(
    this.name,
    this.type, {
    required this.isRequired,
    this.defaultValue,
    this.description,
  });
}
