// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

// ignore: implementation_imports
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart'
    show InheritanceManager;

import 'package:source_gen/source_gen.dart';

bool isEnum(DartType targetType) =>
    targetType is InterfaceType && targetType.element.isEnum;

/// Returns a quoted String literal for [value] that can be used in generated
/// Dart code.
String escapeDartString(String value) {
  var hasSingleQuote = false;
  var hasDoubleQuote = false;
  var hasDollar = false;
  var canBeRaw = true;

  value = value.replaceAllMapped(_escapeRegExp, (match) {
    var value = match[0];
    if (value == "'") {
      hasSingleQuote = true;
      return value;
    } else if (value == '"') {
      hasDoubleQuote = true;
      return value;
    } else if (value == r'$') {
      hasDollar = true;
      return value;
    }

    canBeRaw = false;
    return _escapeMap[value] ?? _getHexLiteral(value);
  });

  if (!hasDollar) {
    if (hasSingleQuote) {
      if (!hasDoubleQuote) {
        return '"$value"';
      }
      // something
    } else {
      // trivial!
      return "'$value'";
    }
  }

  if (hasDollar && canBeRaw) {
    if (hasSingleQuote) {
      if (!hasDoubleQuote) {
        // quote it with single quotes!
        return 'r"$value"';
      }
    } else {
      // quote it with single quotes!
      return "r'$value'";
    }
  }

  // The only safe way to wrap the content is to escape all of the
  // problematic characters - `$`, `'`, and `"`
  var string = value.replaceAll(_dollarQuoteRegexp, r'\');
  return "'$string'";
}

final _dollarQuoteRegexp = new RegExp(r"""(?=[$'"])""");

/// A [Map] between whitespace characters & `\` and their escape sequences.
const _escapeMap = const {
  '\b': r'\b', // 08 - backspace
  '\t': r'\t', // 09 - tab
  '\n': r'\n', // 0A - new line
  '\v': r'\v', // 0B - vertical tab
  '\f': r'\f', // 0C - form feed
  '\r': r'\r', // 0D - carriage return
  '\x7F': r'\x7F', // delete
  r'\': r'\\' // backslash
};

final _escapeMapRegexp = _escapeMap.keys.map(_getHexLiteral).join();

/// A [RegExp] that matches whitespace characters that should be escaped and
/// single-quote, double-quote, and `$`
final _escapeRegExp =
    new RegExp('[\$\'"\\x00-\\x07\\x0E-\\x1F$_escapeMapRegexp]');

/// Given single-character string, return the hex-escaped equivalent.
String _getHexLiteral(String input) {
  var rune = input.runes.single;
  var value = rune.toRadixString(16).toUpperCase().padLeft(2, '0');
  return '\\x$value';
}

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

/// Returns a [Set] of all instance [FieldElement] items for [element] and
/// super classes, sorted first by their location in the inheritance hierarchy
/// (super first) and then by their location in the source file.
Set<FieldElement> createSortedFieldSet(ClassElement element) {
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

  return fieldsList.toSet();
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

/// Writes the invocation of the default constructor – `new Class(...)` for the
/// type defined in [classElement] to the provided [buffer].
///
/// If an parameter is required to invoke the constructor,
/// [availableConstructorParameters] is checked to see if it is available. If
/// [availableConstructorParameters] does not contain the parameter name,
/// an [UnsupportedError] is thrown.
///
/// To improve the error details, [unavailableReasons] is checked for the
/// unavailable constructor parameter. If the value is not `null`, it is
/// included in the [UnsupportedError] message.
///
/// [writeableFields] are also populated, but only if they have not already
/// been defined by a constructor parameter with the same name.
///
/// Set set of all constructor parameters and and fields that are populated is
/// returned.
Set<String> writeConstructorInvocation(
    StringBuffer buffer,
    ClassElement classElement,
    Iterable<String> availableConstructorParameters,
    Iterable<String> writeableFields,
    Map<String, String> unavailableReasons,
    String deserializeForField(String paramOrFieldName,
        {ParameterElement ctorParam})) {
  var className = classElement.displayName;

  var ctor = classElement.unnamedConstructor;
  if (ctor == null) {
    // TODO(kevmoo): support using another ctor - dart-lang/json_serializable#50
    throw new UnsupportedError(
        'The class `$className` has no default constructor.');
  }

  var usedCtorParamsAndFields = new Set<String>();
  var constructorArguments = <ParameterElement>[];
  var namedConstructorArguments = <ParameterElement>[];

  for (var arg in ctor.parameters) {
    if (!availableConstructorParameters.contains(arg.name)) {
      // ignore: deprecated_member_use
      if (arg.parameterKind == ParameterKind.REQUIRED) {
        var msg = 'Cannot populate the required constructor '
            'argument: ${arg.displayName}.';

        var additionalInfo = unavailableReasons[arg.name];

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
      namedConstructorArguments.add(arg);
    } else {
      constructorArguments.add(arg);
    }
    usedCtorParamsAndFields.add(arg.name);
  }

  _validateConstructorArguments(
      constructorArguments.followedBy(namedConstructorArguments));

  // fields that aren't already set by the constructor and that aren't final
  var remainingFieldsForInvocationBody =
      writeableFields.toSet().difference(usedCtorParamsAndFields);

  //
  // Generate the static factory method
  //
  buffer.write('new $className(');
  buffer.writeAll(
      constructorArguments.map((paramElement) =>
          deserializeForField(paramElement.name, ctorParam: paramElement)),
      ', ');
  if (constructorArguments.isNotEmpty && namedConstructorArguments.isNotEmpty) {
    buffer.write(', ');
  }
  buffer.writeAll(namedConstructorArguments.map((paramElement) {
    var value = deserializeForField(paramElement.name, ctorParam: paramElement);
    return '${paramElement.name}: $value';
  }), ', ');

  buffer.write(')');
  if (remainingFieldsForInvocationBody.isEmpty) {
    buffer.writeln(';');
  } else {
    for (var field in remainingFieldsForInvocationBody) {
      buffer.writeln();
      buffer.write('      ..$field = ');
      buffer.write(deserializeForField(field));
      usedCtorParamsAndFields.add(field);
    }
    buffer.writeln(';');
  }
  buffer.writeln();

  return usedCtorParamsAndFields;
}

void _validateConstructorArguments(
    Iterable<ParameterElement> constructorArguments) {
  var undefinedArgs =
      constructorArguments.where((pe) => pe.type.isUndefined).toList();
  if (undefinedArgs.isNotEmpty) {
    var description =
        undefinedArgs.map((fe) => '`${fe.displayName}`').join(', ');

    throw new InvalidGenerationSourceError(
        'At least one constructor argument has an invalid type: $description.',
        todo: 'Check names and imports.');
  }
}
