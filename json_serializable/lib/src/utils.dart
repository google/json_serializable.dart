// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/element/element.dart';

// ignore: implementation_imports
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart'
    show InheritanceManager;

import 'package:source_gen/source_gen.dart';

String commonNullPrefix(
        bool nullable, String expression, String unsafeExpression) =>
    nullable
        ? '$expression == null ? null : $unsafeExpression'
        : unsafeExpression;

// Copied from pkg/source_gen - lib/src/utils.
String friendlyNameForElement(Element element) {
  var friendlyName = element.displayName;

  if (friendlyName == null) {
    throw new ArgumentError(
        'Cannot get friendly name for $element - ${element.runtimeType}.');
  }

  var names = <String>[friendlyName];
  if (element is ClassElement) {
    names.insert(0, 'class');
    if (element.isAbstract) {
      names.insert(0, 'abstract');
    }
  }
  if (element is VariableElement) {
    names.insert(0, element.type.toString());

    if (element.isConst) {
      names.insert(0, 'const');
    }

    if (element.isFinal) {
      names.insert(0, 'final');
    }
  }
  if (element is LibraryElement) {
    names.insert(0, 'library');
  }

  return names.join(' ');
}

/// Returns a list of all instance, [FieldElement] items for [element] and
/// super classes.
List<FieldElement> listFields(ClassElement element) {
  // Get all of the fields that need to be assigned
  // TODO: support overriding the field set with an annotation option
  var fieldsList = element.fields.where((e) => !e.isStatic).toList();

  var manager = new InheritanceManager(element.library);

  for (var v in manager.getMembersInheritedFromClasses(element).values) {
    assert(v is! FieldElement);
    if (_dartCoreObjectChecker.isExactly(v.enclosingElement)) {
      continue;
    }

    if (v is PropertyAccessorElement && v.variable is FieldElement) {
      fieldsList.add(v.variable as FieldElement);
    }
  }

  var undefinedFields = fieldsList.where((fe) => fe.type.isUndefined).toList();
  if (undefinedFields.isNotEmpty) {
    var description =
        undefinedFields.map((fe) => '`${fe.displayName}`').join(', ');

    throw new InvalidGenerationSourceError(
        'At least one field has an invalid type: $description.',
        todo: 'Check names and imports.');
  }

  // Sort these in the order in which they appear in the class
  // Sadly, `classElement.fields` puts properties after fields
  fieldsList.sort(_sortByLocation);

  return fieldsList;
}

int _sortByLocation(FieldElement a, FieldElement b) {
  var checkerA = new TypeChecker.fromStatic(a.enclosingElement.type);

  if (!checkerA.isExactly(b.enclosingElement)) {
    // in this case, you want to prioritize the enclosingElement that is more
    // "super".

    if (checkerA.isSuperOf(b.enclosingElement)) {
      return -1;
    }

    var checkerB = new TypeChecker.fromStatic(b.enclosingElement.type);

    if (checkerB.isSuperOf(a.enclosingElement)) {
      return 1;
    }
  }

  /// Returns the offset of given field/property in its source file – with a
  /// preference for the getter if it's defined.
  int _offsetFor(FieldElement e) {
    if (e.getter != null && e.getter.nameOffset != e.nameOffset) {
      assert(e.nameOffset == -1);
      return e.getter.nameOffset;
    }
    return e.nameOffset;
  }

  return _offsetFor(a).compareTo(_offsetFor(b));
}

final _dartCoreObjectChecker = const TypeChecker.fromRuntime(Object);

/// Returns the set of fields that are written to via factory.
/// Includes final fields that are written to in the constructor parameter list
/// Excludes remaining final fields, as they can't be set in the factory body
/// and shouldn't generated with toJson
Set<FieldElement> writeFactory(
    StringBuffer buffer,
    ClassElement classElement,
    Map<String, FieldElement> fields,
    String ignoreReason(String fieldName),
    String deserializeForField(FieldElement field,
        {ParameterElement ctorParam})) {
  var fieldsSetByFactory = new Set<FieldElement>();
  var className = classElement.displayName;
  // Create the factory method

  // Get the default constructor
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
      // ignore: deprecated_member_use
      if (arg.parameterKind == ParameterKind.REQUIRED) {
        var msg = 'Cannot populate the required constructor '
            'argument: ${arg.displayName}.';

        var additionalInfo = ignoreReason(arg.name);

        if (additionalInfo != null) {
          msg = '$msg $additionalInfo';
        }

        throw new UnsupportedError(msg);
      }

      continue;
    }

    // TODO: validate that the types match!
    // ignore: deprecated_member_use
    if (arg.parameterKind == ParameterKind.NAMED) {
      ctorNamedArguments.add(arg);
    } else {
      ctorArguments.add(arg);
    }
    fieldsSetByFactory.add(field);
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

  // find fields that aren't already set by the constructor and that aren't final
  var remainingFieldsForFactoryBody = fields.values
      .where((field) => !field.isFinal)
      .toSet()
      .difference(fieldsSetByFactory);

  //
  // Generate the static factory method
  //
  buffer.write('new $className(');
  buffer.writeAll(
      ctorArguments.map((paramElement) => deserializeForField(
          fields[paramElement.name],
          ctorParam: paramElement)),
      ', ');
  if (ctorArguments.isNotEmpty && ctorNamedArguments.isNotEmpty) {
    buffer.write(', ');
  }
  buffer.writeAll(ctorNamedArguments.map((paramElement) {
    var value =
        deserializeForField(fields[paramElement.name], ctorParam: paramElement);
    return '${paramElement.name}: $value';
  }), ', ');

  buffer.write(')');
  if (remainingFieldsForFactoryBody.isEmpty) {
    buffer.writeln(';');
  } else {
    for (var field in remainingFieldsForFactoryBody) {
      buffer.writeln();
      buffer.write('      ..${field.name} = ');
      buffer.write(deserializeForField(field));
      fieldsSetByFactory.add(field);
    }
    buffer.writeln(';');
  }
  buffer.writeln();

  return fieldsSetByFactory;
}
