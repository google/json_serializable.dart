// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/analyzer.dart';
import 'package:source_gen/source_gen.dart';

import 'json_serializable.dart';
import 'type_helper.dart';
import 'type_helpers/date_time_helper.dart';
import 'type_helpers/iterable_helper.dart';
import 'type_helpers/json_helper.dart';
import 'type_helpers/map_helper.dart';
import 'type_helpers/value_helper.dart';
import 'utils.dart';

// TODO: toJson option to omit null/empty values
class JsonSerializableGenerator
    extends GeneratorForAnnotation<JsonSerializable> {
  static const _coreHelpers = const [
    const IterableHelper(),
    const MapHelper(),
    const ValueHelper()
  ];

  static const _defaultHelpers = const [
    const JsonHelper(),
    const DateTimeHelper(),
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
    var fieldsList = classElement.fields.where((e) => !e.isStatic).toList();

    var undefinedFields =
        fieldsList.where((fe) => fe.type.isUndefined).toList();
    if (undefinedFields.isNotEmpty) {
      var description =
          undefinedFields.map((fe) => "`${fe.displayName}`").join(', ');

      throw new InvalidGenerationSourceError(
          'At least one field has an invalid type: $description.',
          todo: 'Check names and imports.');
    }

    // Sort these in the order in which they appear in the class
    // Sadly, `classElement.fields` puts properties after fields
    fieldsList.sort((a, b) => a.nameOffset.compareTo(b.nameOffset));

    // Explicitly using `LinkedHashMap` – we want these ordered.
    var fields = new LinkedHashMap<String, FieldElement>.fromIterable(
        fieldsList,
        key: (FieldElement f) => f.name);

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
        try {
          pairs.add("'${_fieldToJsonMapKey(fieldName, field)}': "
              "${_serialize(field.type, fieldName )}");
        } on UnsupportedTypeError {
          throw new InvalidGenerationSourceError(
              "Could not generate `toJson` code for `${friendlyNameForElement(field)}`.",
              todo: "Make sure all of the types are serializable.");
        }
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

    var undefinedArgs = [ctorArguments, ctorNamedArguments]
        .expand((l) => l)
        .where((pe) => pe.type.isUndefined)
        .toList();
    if (undefinedArgs.isNotEmpty) {
      var description =
          undefinedArgs.map((fe) => "`${fe.displayName}`").join(', ');

      throw new InvalidGenerationSourceError(
          'At least one constructor argument has an invalid type: $description.',
          todo: 'Check names and imports.');
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
    buffer
        .writeln('$className ${prefix}FromJson(Map<String, dynamic> json) =>');
    buffer.write('    new $className(');
    buffer.writeAll(
        ctorArguments.map((paramElement) => _deserializeForField(
            paramElement.name, fields[paramElement.name],
            ctorParam: paramElement)),
        ', ');
    if (ctorArguments.isNotEmpty && ctorNamedArguments.isNotEmpty) {
      buffer.write(', ');
    }
    buffer.writeAll(
        ctorNamedArguments.map((paramElement) =>
            '${paramElement.name}: ' +
            _deserializeForField(paramElement.name, fields[paramElement.name],
                ctorParam: paramElement)),
        ', ');

    buffer.write(')');
    if (fieldsToSet.isEmpty) {
      buffer.writeln(';');
    } else {
      fieldsToSet.forEach((name, field) {
        buffer.writeln();
        buffer.write("      ..${name} = ");
        buffer.write(_deserializeForField(name, field));
      });
      buffer.writeln(';');
    }
    buffer.writeln();

    return finalFields;
  }

  Iterable<TypeHelper> get _allHelpers =>
      [_typeHelpers, _coreHelpers].expand((e) => e);

  /// [expression] may be just the name of the field or it may an expression
  /// representing the serialization of a value.
  String _serialize(DartType targetType, String expression) => _allHelpers
      .map((h) => h.serialize(targetType, expression, _serialize))
      .firstWhere((r) => r != null,
          orElse: () => throw new UnsupportedTypeError(targetType, expression));

  String _deserializeForField(String name, FieldElement field,
      {ParameterElement ctorParam}) {
    name = _fieldToJsonMapKey(name, field);

    var targetType = ctorParam?.type ?? field.type;

    try {
      return _deserialize(targetType, "json['$name']");
    } on UnsupportedTypeError {
      throw new InvalidGenerationSourceError(
          "Could not generate fromJson code for `${friendlyNameForElement(field)}`.",
          todo: "Make sure all of the types are serializable.");
    }
  }

  String _deserialize(DartType targetType, String expression) => _allHelpers
      .map((th) => th.deserialize(targetType, expression, _deserialize))
      .firstWhere((r) => r != null,
          orElse: () => throw new UnsupportedTypeError(targetType, expression));
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
