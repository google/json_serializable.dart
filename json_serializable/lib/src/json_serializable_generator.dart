// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/analyzer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'type_helper.dart';
import 'type_helpers/date_time_helper.dart';
import 'type_helpers/enum_helper.dart';
import 'type_helpers/iterable_helper.dart';
import 'type_helpers/json_helper.dart';
import 'type_helpers/map_helper.dart';
import 'type_helpers/value_helper.dart';
import 'utils.dart';

class JsonSerializableGenerator
    extends GeneratorForAnnotation<JsonSerializable> {
  static const _coreHelpers = const [
    const IterableHelper(),
    const MapHelper(),
    const EnumHelper(),
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
      Element element, ConstantReader annotation, _) async {
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
          undefinedFields.map((fe) => '`${fe.displayName}`').join(', ');

      throw new InvalidGenerationSourceError(
          'At least one field has an invalid type: $description.',
          todo: 'Check names and imports.');
    }

    // Sort these in the order in which they appear in the class
    // Sadly, `classElement.fields` puts properties after fields
    fieldsList.sort((a, b) => _offsetFor(a).compareTo(_offsetFor(b)));

    // Explicitly using `LinkedHashMap` – we want these ordered.
    var fields = new LinkedHashMap<String, FieldElement>.fromIterable(
        fieldsList,
        key: (f) => (f as FieldElement).name);

    // Get the constructor to use for the factory

    var prefix = '_\$${className}';

    var buffer = new StringBuffer();

    final classAnnotation = _valueForAnnotation(annotation);

    if (classAnnotation.createFactory) {
      var toSkip = _writeFactory(
          buffer, classElement, fields, prefix, classAnnotation.nullable);

      // If there are fields that are final – that are not set via the generated
      // constructor, then don't output them when generating the `toJson` call.
      for (var field in toSkip) {
        fields.remove(field.name);
      }
    }

    // Now we check for duplicate JSON keys due to colliding annotations.
    // We do this now, since we have a final field list after any pruning done
    // by `createFactory`.

    fields.values.fold(new Set<String>(), (Set<String> set, fe) {
      var jsonKey = _jsonKeyFor(fe).name ?? fe.name;
      if (!set.add(jsonKey)) {
        throw new InvalidGenerationSourceError(
            'More than one field has the JSON key `$jsonKey`.',
            todo: 'Check the `JsonKey` annotations on fields.');
      }
      return set;
    });

    if (classAnnotation.createToJson) {
      var mixClassName = '${prefix}SerializerMixin';

      //
      // Generate the mixin class
      //
      buffer.writeln('abstract class $mixClassName {');

      // write copies of the fields - this allows the toJson method to access
      // the fields of the target class
      for (var field in fields.values) {
        //TODO - handle aliased imports
        buffer.writeln('  ${field.type} get ${field.name};');
      }

      buffer.writeln('  Map<String, dynamic> toJson() ');

      var writeNaive =
          fieldsList.every((e) => _writeJsonValueNaive(e, classAnnotation));

      if (writeNaive) {
        // write simple `toJson` method that includes all keys...
        _writeToJsonSimple(buffer, fields.values, classAnnotation.nullable);
      } else {
        // At least one field should be excluded if null
        _writeToJsonWithNullChecks(buffer, fields.values, classAnnotation);
      }

      // end of the mixin class
      buffer.writeln('}');
    }

    return buffer.toString();
  }

  void _writeToJsonWithNullChecks(StringBuffer buffer,
      Iterable<FieldElement> fields, JsonSerializable classAnnotation) {
    buffer.writeln('{');

    buffer.writeln('var $toJsonMapVarName = <String, dynamic>{');

    // Note that the map literal is left open above. As long as target fields
    // don't need to be intercepted by the `only if null` logic, write them
    // to the map literal directly. In theory, should allow more efficient
    // serialization.
    var directWrite = true;

    for (var field in fields) {
      var safeFieldAccess = field.name;
      var safeJsonKeyString = _safeNameAccess(field);

      // If `fieldName` collides with one of the local helpers, prefix
      // access with `this.`.
      if (safeFieldAccess == toJsonMapVarName ||
          safeFieldAccess == toJsonMapHelperName) {
        safeFieldAccess = 'this.$safeFieldAccess';
      }

      var expression = _serializeField(field, classAnnotation.nullable,
          accessOverride: safeFieldAccess);
      if (_writeJsonValueNaive(field, classAnnotation)) {
        if (directWrite) {
          buffer.writeln('$safeJsonKeyString : $expression,');
        } else {
          buffer
              .writeln('$toJsonMapVarName[$safeJsonKeyString] = $expression;');
        }
      } else {
        if (directWrite) {
          // close the still-open map literal
          buffer.writeln('};');
          buffer.writeln();

          // write the helper to be used by all following null-excluding
          // fields
          buffer.writeln('''
void $toJsonMapHelperName(String key, dynamic value) {
  if (value != null) {
    $toJsonMapVarName[key] = value;
  }
}''');
          directWrite = false;
        }
        buffer
            .writeln('$toJsonMapHelperName($safeJsonKeyString, $expression);');
      }
    }

    buffer.writeln('return $toJsonMapVarName;');

    buffer.writeln('}');
  }

  void _writeToJsonSimple(StringBuffer buffer, Iterable<FieldElement> fields,
      bool classSupportNullable) {
    buffer.writeln('=> <String, dynamic>{');

    var pairs = <String>[];
    for (var field in fields) {
      pairs.add(
          '${_safeNameAccess(field)}: ${_serializeField(field, classSupportNullable )}');
    }
    buffer.writeAll(pairs, ',\n');

    buffer.writeln('  };');
  }

  /// Returns the set of fields that are not written to via constructors.
  Set<FieldElement> _writeFactory(
      StringBuffer buffer,
      ClassElement classElement,
      Map<String, FieldElement> fields,
      String prefix,
      bool classSupportNullable) {
    // creating a copy so it can be mutated
    var fieldsToSet = new Map<String, FieldElement>.from(fields);
    var className = classElement.displayName;
    // Create the factory method

    // Get the default constructor
    // TODO: allow overriding the ctor used for the factory
    var ctor = classElement.unnamedConstructor;
    if (ctor == null) {
      throw new UnsupportedError(
          'The class `${classElement.name}` has no default constructor.');
    }

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
          undefinedArgs.map((fe) => '`${fe.displayName}`').join(', ');

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
            fields[paramElement.name], classSupportNullable,
            ctorParam: paramElement)),
        ', ');
    if (ctorArguments.isNotEmpty && ctorNamedArguments.isNotEmpty) {
      buffer.write(', ');
    }
    buffer.writeAll(
        ctorNamedArguments.map((paramElement) =>
            '${paramElement.name}: ' +
            _deserializeForField(
                fields[paramElement.name], classSupportNullable,
                ctorParam: paramElement)),
        ', ');

    buffer.write(')');
    if (fieldsToSet.isEmpty) {
      buffer.writeln(';');
    } else {
      for (var field in fieldsToSet.values) {
        buffer.writeln();
        buffer.write('      ..${field.name} = ');
        buffer.write(_deserializeForField(field, classSupportNullable));
      }
      buffer.writeln(';');
    }
    buffer.writeln();

    return finalFields;
  }

  Iterable<TypeHelper> get _allHelpers =>
      [_typeHelpers, _coreHelpers].expand((e) => e);

  String _serializeField(FieldElement field, bool classIncludeNullable,
      {String accessOverride}) {
    accessOverride ??= field.name;
    try {
      return _serialize(
          field.type, accessOverride, _nullable(field, classIncludeNullable));
    } on UnsupportedTypeError catch (e) {
      throw _createInvalidGenerationError('toJson', field, e);
    }
  }

  /// [expression] may be just the name of the field or it may an expression
  /// representing the serialization of a value.
  String _serialize(DartType targetType, String expression, bool nullable) =>
      _allHelpers
          .map((h) => h.serialize(targetType, expression, nullable, _serialize))
          .firstWhere((r) => r != null,
              orElse: () => throw new UnsupportedTypeError(
                  targetType, expression, _notSupportedWithTypeHelpersMsg));

  String _deserializeForField(FieldElement field, bool classSupportNullable,
      {ParameterElement ctorParam}) {
    var jsonKey = _safeNameAccess(field);

    var targetType = ctorParam?.type ?? field.type;

    try {
      return _deserialize(
          targetType, 'json[$jsonKey]', _nullable(field, classSupportNullable));
    } on UnsupportedTypeError catch (e) {
      throw _createInvalidGenerationError('fromJson', field, e);
    }
  }

  String _deserialize(DartType targetType, String expression, bool nullable) =>
      _allHelpers
          .map((th) =>
              th.deserialize(targetType, expression, nullable, _deserialize))
          .firstWhere((r) => r != null,
              orElse: () => throw new UnsupportedTypeError(
                  targetType, expression, _notSupportedWithTypeHelpersMsg));
}

String _safeNameAccess(FieldElement field) {
  var name = _jsonKeyFor(field).name ?? field.name;
  // TODO(kevmoo): JsonKey.name could also have quotes and other silly.
  return name.contains(r'$') ? "r'${name}'" : "'${name}'";
}

/// Returns `true` if the field should be treated as potentially nullable.
///
/// If no [JsonKey] annotation is present on the field, `true` is returned.
bool _nullable(FieldElement field, bool parentValue) =>
    _jsonKeyFor(field).nullable ?? parentValue;

/// Returns `true` if the field can be written to JSON 'naively' – meaning
/// we can avoid checking for `null`.
///
/// `true` if either:
///   `includeIfNull` is `true`
///   or
///   `nullable` is `false`.
bool _writeJsonValueNaive(
        FieldElement field, JsonSerializable parentAnnotation) =>
    (_jsonKeyFor(field).includeIfNull ?? parentAnnotation.includeIfNull) ||
    !_nullable(field, parentAnnotation.nullable);

JsonKey _jsonKeyFor(FieldElement element) {
  var key = _jsonKeyExpando[element];

  if (key == null) {
    // If an annotation exists on `element` the source is a 'real' field.
    // If the result is `null`, check the getter – it is a property.
    // TODO(kevmoo) setters: github.com/dart-lang/json_serializable/issues/24
    var obj = _jsonKeyChecker.firstAnnotationOfExact(element) ??
        _jsonKeyChecker.firstAnnotationOfExact(element.getter);

    _jsonKeyExpando[element] = key = obj == null
        ? const JsonKey()
        : new JsonKey(
            name: obj.getField('name').toStringValue(),
            nullable: obj.getField('nullable').toBoolValue(),
            includeIfNull: obj.getField('includeIfNull').toBoolValue());
  }

  return key;
}

JsonSerializable _valueForAnnotation(ConstantReader annotation) =>
    new JsonSerializable(
        createToJson: annotation.read('createToJson').boolValue,
        createFactory: annotation.read('createFactory').boolValue,
        nullable: annotation.read('nullable').boolValue,
        includeIfNull: annotation.read('includeIfNull').boolValue);

final _jsonKeyExpando = new Expando<JsonKey>();

final _jsonKeyChecker = new TypeChecker.fromRuntime(JsonKey);

/// Returns the offset of given field/property in its source file – with a
/// preference for the getter if it's defined.
int _offsetFor(FieldElement e) {
  if (e.getter != null && e.getter.nameOffset != e.nameOffset) {
    assert(e.nameOffset == -1);
    return e.getter.nameOffset;
  }
  return e.nameOffset;
}

final _notSupportedWithTypeHelpersMsg =
    'None of the provided `TypeHelper` instances support the defined type.';

InvalidGenerationSourceError _createInvalidGenerationError(
    String targetMember, FieldElement field, UnsupportedTypeError e) {
  var extra = (field.type != e.type) ? ' because of type `${e.type}`' : '';

  var message = 'Could not generate `$targetMember` code for '
      '`${friendlyNameForElement(field)}`$extra.\n${e.reason}';

  return new InvalidGenerationSourceError(message,
      todo: 'Make sure all of the types are serializable.');
}
