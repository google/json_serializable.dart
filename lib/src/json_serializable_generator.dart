// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/analyzer.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen/src/utils.dart' show friendlyNameForElement;

import 'json_serializable.dart';
import 'type_helper.dart';

// TODO: toJson option to omit null/empty values
class JsonSerializableGenerator
    extends GeneratorForAnnotation<JsonSerializable> {
  static const _defaultHelpers = const [
    const JsonHelper(),
    const DateTimeHelper()
  ];

  final List<TypeHelper> _typeHelpers;

  /// Creates an instance of [JsonSerializableGenerator].
  ///
  /// If [typeHelpers] is not provided, two built-in helpers are used:
  /// [JsonHelper] and [DateTimeHelper].
  const JsonSerializableGenerator({List<TypeHelper> typeHelpers})
      : this._typeHelpers = typeHelpers ?? _defaultHelpers;

  /// Creates an instance of [JsonSerializableGenerator].
  ///
  /// [typeHelpers] provides a set of [TypeHelper] that will be used along with
  /// the built-in helpers: [JsonHelper] and [DateTimeHelper].
  factory JsonSerializableGenerator.withDefaultHelpers(
          Iterable<TypeHelper> typeHelpers) =>
      new JsonSerializableGenerator(
          typeHelpers: new List.unmodifiable(
              [typeHelpers, _defaultHelpers].expand((e) => e)));

  @override
  Future<String> generateForAnnotatedElement(
      Element element, JsonSerializable annotation, _) async {
    if (element is! ClassElement) {
      var friendlyName = friendlyNameForElement(element);
      throw new InvalidGenerationSourceError(
          'Generator cannot target `$friendlyName`.',
          todo: 'Remove the JsonSerializable annotation from `$friendlyName`.');
    }

    var classElement = element as ClassElement;
    var className = classElement.name;

    // Get all of the fields that need to be assigned
    // TODO: support overriding the field set with an annotation option
    var fields = classElement.fields.fold(<String, FieldElement>{},
        (Map<String, FieldElement> map, field) {
      map[field.name] = field;
      return map;
    });

    // Get the constructor to use for the factory

    var prefix = '_\$${className}';

    var buffer = new StringBuffer();

    if (annotation.createFactory) {
      var toSkip = _writeFactory(buffer, classElement, fields, prefix);

      // If there are fields that are final – that are not set via the generated
      // constructor, then don't output them when generating the `toJson` call.
      for (var field in toSkip) {
        fields.remove(field.name);
      }
    }

    if (annotation.createToJson) {
      //
      // Generate the mixin class
      //
      buffer.writeln('abstract class ${prefix}SerializerMixin {');

      // write fields
      fields.forEach((name, field) {
        //TODO - handle aliased imports
        buffer.writeln('  ${field.type} get $name;');
      });

      // write toJson method
      buffer.writeln('  Map<String, dynamic> toJson() => <String, dynamic>{');

      var pairs = <String>[];
      fields.forEach((fieldName, field) {
        pairs.add("'${_fieldToJsonMapKey(fieldName, field)}': "
            "${_fieldToJsonMapValue(fieldName, field.type)}");
      });
      buffer.writeln(pairs.join(','));

      buffer.writeln('  };');

      buffer.write('}');
    }

    return buffer.toString();
  }

  /// Returns the set of fields that are not written to via constructors.
  Set<FieldElement> _writeFactory(
      StringBuffer buffer,
      ClassElement classElement,
      Map<String, FieldElement> fields,
      String prefix) {
    // creating a copy so it can be mutated
    var fieldsToSet = new Map<String, FieldElement>.from(fields);
    var className = classElement.displayName;
    // Create the factory method

    // Get the default constructor
    // TODO: allow overriding the ctor used for the factory
    var ctor = classElement.unnamedConstructor;

    var ctorArguments = <ParameterElement>[];
    var ctorNamedArguments = <ParameterElement>[];

    for (var arg in ctor.parameters) {
      var field = fields[arg.name];

      if (field == null) {
        if (arg.parameterKind == ParameterKind.REQUIRED) {
          throw new UnsupportedError('Cannot populate the required constructor '
              'argument: ${arg.displayName}.');
        }
        continue;
      }

      // TODO: validate that the types match!
      if (arg.parameterKind == ParameterKind.NAMED) {
        ctorNamedArguments.add(arg);
      } else {
        ctorArguments.add(arg);
      }
      fieldsToSet.remove(arg.name);
    }

    // these are fields to skip – now to find them
    var finalFields =
        fieldsToSet.values.where((field) => field.isFinal).toSet();

    for (var finalField in finalFields) {
      var value = fieldsToSet.remove(finalField.name);
      assert(value == finalField);
    }

    //
    // Generate the static factory method
    //
    buffer.writeln();
    buffer.writeln('$className ${prefix}FromJson(Map json) =>');
    buffer.write('    new $className(');
    buffer.writeAll(
        ctorArguments.map((paramElement) => _jsonMapAccessToField(
            paramElement.name, fields[paramElement.name],
            ctorParam: paramElement)),
        ', ');
    if (ctorArguments.isNotEmpty && ctorNamedArguments.isNotEmpty) {
      buffer.write(', ');
    }
    buffer.writeAll(
        ctorNamedArguments.map((paramElement) =>
            '${paramElement.name}: ' +
            _jsonMapAccessToField(paramElement.name, fields[paramElement.name],
                ctorParam: paramElement)),
        ', ');

    buffer.write(')');
    if (fieldsToSet.isEmpty) {
      buffer.writeln(';');
    } else {
      fieldsToSet.forEach((name, field) {
        buffer.writeln();
        buffer.write("      ..${name} = ");
        buffer.write(_jsonMapAccessToField(name, field));
      });
      buffer.writeln(';');
    }
    buffer.writeln();

    return finalFields;
  }

  /// [expression] may be just the name of the field or it may an expression
  /// representing the serialization of a value.
  String _fieldToJsonMapValue(String expression, DartType fieldType,
      [int depth = 0]) {
    for (var helper in _typeHelpers) {
      if (helper.canSerialize(fieldType)) {
        return helper.serialize(fieldType, expression);
      }
    }

    var isList = false;
    if (_coreIterableChecker.isAssignableFromType(fieldType)) {
      if (_coreListChecker.isAssignableFromType(fieldType)) {
        isList = true;
      }
      var substitute = "v$depth";
      var subFieldValue = _fieldToJsonMapValue(substitute,
          _getIterableGenericType(fieldType as InterfaceType), depth + 1);

      // In the case of trivial JSON types (int, String, etc), `subFieldValue`
      // will be identical to `substitute` – so no explicit mapping is needed.
      // If they are not equal, then we to write out the substitution.
      if (subFieldValue != substitute) {
        // TODO: the type could be imported from a library with a prefix!
        expression = "${expression}?.map(($substitute) => $subFieldValue)";

        // expression now represents an Iterable (even if it started as a List
        // ...resetting `isList` to `false`.
        isList = false;
      }
    }

    if (!isList && _coreIterableChecker.isAssignableFromType(fieldType)) {
      // Then we need to add `?.toList()
      expression += "?.toList()";
    }

    return expression;
  }

  String _jsonMapAccessToField(String name, FieldElement field,
      {ParameterElement ctorParam}) {
    name = _fieldToJsonMapKey(name, field);
    var result = "json['$name']";
    return _writeAccessToJsonValue(result, field.type, ctorParam: ctorParam);
  }

  String _writeAccessToJsonValue(String varExpression, DartType searchType,
      {ParameterElement ctorParam, int depth: 0}) {
    if (ctorParam != null) {
      searchType = ctorParam.type as InterfaceType;
    }

    for (var helper in _typeHelpers) {
      if (helper.canDeserialize(searchType)) {
        return "$varExpression == null ? null : "
            "${helper.deserialize(searchType, varExpression)}";
      }
    }

    if (_coreIterableChecker.isAssignableFromType(searchType)) {
      var iterableGenericType =
          _getIterableGenericType(searchType as InterfaceType);

      var itemVal = "v$depth";
      var itemSubVal = _writeAccessToJsonValue(itemVal, iterableGenericType,
          depth: depth + 1);

      // If `itemSubVal` is the same, then we don't need to do anything fancy
      if (itemVal == itemSubVal) {
        return varExpression;
      }

      var output = "($varExpression as List)?.map(($itemVal) => "
          "${_writeAccessToJsonValue(itemVal, iterableGenericType, depth: depth+1)}"
          ")";

      if (_coreListChecker.isAssignableFromType(searchType)) {
        output += "?.toList()";
      }

      return output;
    }

    if (!searchType.isDynamic && !searchType.isObject) {
      return "$varExpression as $searchType";
    }

    return varExpression;
  }
}

/// Returns the JSON map `key` to be used when (de)serializing [field].
///
/// [fieldName] is used, unless [field] is annotated with [JsonKey], in which
/// case [JsonKey.jsonName] is used.
String _fieldToJsonMapKey(String fieldName, FieldElement field) {
  const $JsonKey = const TypeChecker.fromRuntime(JsonKey);
  var jsonKey = $JsonKey.firstAnnotationOf(field);
  if (jsonKey != null) {
    var jsonName = jsonKey.getField('jsonName').toStringValue();
    return jsonName;
  }
  return fieldName;
}

DartType _getIterableGenericType(InterfaceType type) {
  var iterableImplementation =
      _getImplementationType(type, _coreIterableChecker) as InterfaceType;

  return iterableImplementation.typeArguments.single;
}

DartType _getImplementationType(DartType type, TypeChecker checker) {
  if (checker.isExactlyType(type)) return type;

  if (type is InterfaceType) {
    var match = [type.interfaces, type.mixins]
        .expand((e) => e)
        .map((type) => _getImplementationType(type, checker))
        .firstWhere((value) => value != null, orElse: () => null);

    if (match != null) return match;

    if (type.superclass != null) {
      return _getImplementationType(type.superclass, checker);
    }
  }
  return null;
}

final _coreIterableChecker = const TypeChecker.fromUrl('dart:core#Iterable');

final _coreListChecker = const TypeChecker.fromUrl('dart:core#List');
