// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'helper_core.dart';
import 'json_literal_generator.dart';
import 'type_helper.dart';
import 'utils.dart';

abstract class DecodeHelper implements HelperCore {
  final StringBuffer _buffer = new StringBuffer();

  String writeCtor(Map<String, FieldElement> accessibleFields,
      Map<String, String> unavailableReasons) {
    assert(annotation.createFactory);
    assert(_buffer.isEmpty);

    var mapType = generator.anyMap ? 'Map' : 'Map<String, dynamic>';
    _buffer.write('$targetClassReference '
        '${prefix}FromJson${genericClassArgumentsImpl(true)}'
        '($mapType json) {\n');

    String deserializeFun(String paramOrFieldName,
            {ParameterElement ctorParam}) =>
        _deserializeForField(accessibleFields[paramOrFieldName],
            ctorParam: ctorParam);

    Set<String> fieldsSetByFactory;
    if (generator.checked) {
      var classLiteral = escapeDartString(element.name);

      _buffer.write('''
  return \$checkedNew(
    $classLiteral,
    json,
    () {\n''');

      var data = _writeConstructorInvocation(
          element,
          accessibleFields.keys,
          accessibleFields.values
              .where((fe) => !fe.isFinal)
              .map((fe) => fe.name)
              .toList(),
          unavailableReasons,
          deserializeFun);

      fieldsSetByFactory = data.usedCtorParamsAndFields;

      _writeChecks(6, annotation, accessibleFields);
      _buffer.write('''
    var val = ${data.content};''');

      for (var field in data.fieldsToSet) {
        _buffer.writeln();
        var safeName = safeNameAccess(accessibleFields[field]);
        _buffer.write('''
    \$checkedConvert(json, $safeName, (v) => ''');
        _buffer.write('val.$field = ');
        _buffer.write(_deserializeForField(accessibleFields[field],
            checkedProperty: true));
        _buffer.write(');');
      }

      _buffer.write('''\n    return val;
  }''');

      var fieldKeyMap = new Map.fromEntries(fieldsSetByFactory
          .map((k) => new MapEntry(k, nameAccess(accessibleFields[k])))
          .where((me) => me.key != me.value));

      String fieldKeyMapArg;
      if (fieldKeyMap.isEmpty) {
        fieldKeyMapArg = '';
      } else {
        var mapLiteral = jsonMapAsDart(fieldKeyMap, true);
        fieldKeyMapArg = ', fieldKeyMap: $mapLiteral';
      }

      _buffer.write(fieldKeyMapArg);

      _buffer.write(')');
    } else {
      var data = _writeConstructorInvocation(
          element,
          accessibleFields.keys,
          accessibleFields.values
              .where((fe) => !fe.isFinal)
              .map((fe) => fe.name)
              .toList(),
          unavailableReasons,
          deserializeFun);

      fieldsSetByFactory = data.usedCtorParamsAndFields;

      _writeChecks(2, annotation, accessibleFields);

      _buffer.write('''
  return ${data.content}''');
      for (var field in data.fieldsToSet) {
        _buffer.writeln();
        _buffer.write('    ..$field = ');
        _buffer.write(deserializeFun(field));
      }
    }
    _buffer.writeln(';\n}');
    _buffer.writeln();

    // If there are fields that are final – that are not set via the generated
    // constructor, then don't output them when generating the `toJson` call.
    accessibleFields
        .removeWhere((name, fe) => !fieldsSetByFactory.contains(name));

    return _buffer.toString();
  }

  void _writeChecks(int indent, JsonSerializable classAnnotation,
      Map<String, FieldElement> accessibleFields) {
    var args = <String>[];

    if (classAnnotation.disallowUnrecognizedKeys) {
      var allowKeysLiteral = jsonLiteralAsDart(
          accessibleFields.values.map(nameAccess).toList(), true);

      args.add('allowedKeys: $allowKeysLiteral');
    }

    var requiredKeys =
        accessibleFields.values.where((fe) => jsonKeyFor(fe).required).toList();
    if (requiredKeys.isNotEmpty) {
      var requiredKeyLiteral =
          jsonLiteralAsDart(requiredKeys.map(nameAccess).toList(), true);

      args.add('requiredKeys: $requiredKeyLiteral');
    }

    var disallowNullKeys = accessibleFields.values
        .where((fe) => jsonKeyFor(fe).disallowNullValue)
        .toList();
    if (disallowNullKeys.isNotEmpty) {
      var dissallowNullKeyLiteral =
          jsonLiteralAsDart(disallowNullKeys.map(nameAccess).toList(), true);

      args.add('disallowNullValues: $dissallowNullKeyLiteral');
    }

    if (args.isNotEmpty) {
      _buffer.writeln('${' ' * indent}\$checkKeys(json, ${args.join(', ')});');
    }
  }

  String _deserializeForField(FieldElement field,
      {ParameterElement ctorParam, bool checkedProperty}) {
    checkedProperty ??= false;
    var jsonKeyName = safeNameAccess(field);
    var targetType = ctorParam?.type ?? field.type;
    var contextHelper = getHelperContext(field);

    String value;
    try {
      if (generator.checked) {
        value = contextHelper.deserialize(targetType, 'v');
        if (!checkedProperty) {
          value = '\$checkedConvert(json, $jsonKeyName, (v) => $value)';
        }
      } else {
        assert(!checkedProperty,
            'should only be true if `_generator.checked` is true.');

        value = contextHelper.deserialize(targetType, 'json[$jsonKeyName]');
      }
    } on UnsupportedTypeError catch (e) {
      throw createInvalidGenerationError('fromJson', field, e);
    }

    var defaultValue = jsonKeyFor(field).defaultValue;
    if (defaultValue != null) {
      if (!contextHelper.nullable) {
        throwUnsupported(field,
            'Cannot use `defaultValue` on a field with `nullable` false.');
      }

      value = '$value ?? $defaultValue';
    }
    return value;
  }
}

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
_CtorData _writeConstructorInvocation(
    ClassElement classElement,
    Iterable<String> availableConstructorParameters,
    Iterable<String> writeableFields,
    Map<String, String> unavailableReasons,
    String deserializeForField(String paramOrFieldName,
        {ParameterElement ctorParam})) {
  var className = classElement.name;

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
      if (arg.isNotOptional) {
        var msg = 'Cannot populate the required constructor '
            'argument: ${arg.name}.';

        var additionalInfo = unavailableReasons[arg.name];

        if (additionalInfo != null) {
          msg = '$msg $additionalInfo';
        }

        throw new UnsupportedError(msg);
      }

      continue;
    }

    // TODO: validate that the types match!
    if (arg.isNamed) {
      namedConstructorArguments.add(arg);
    } else {
      constructorArguments.add(arg);
    }
    usedCtorParamsAndFields.add(arg.name);
  }

  _validateConstructorArguments(
      classElement, constructorArguments.followedBy(namedConstructorArguments));

  // fields that aren't already set by the constructor and that aren't final
  var remainingFieldsForInvocationBody =
      writeableFields.toSet().difference(usedCtorParamsAndFields);

  var buffer = new StringBuffer();
  buffer.write('new $className${genericClassArguments(classElement, false)}(');
  if (constructorArguments.isNotEmpty) {
    buffer.writeln();
    buffer.writeAll(constructorArguments.map((paramElement) {
      var content =
          deserializeForField(paramElement.name, ctorParam: paramElement);
      return '      $content';
    }), ',\n');
    if (namedConstructorArguments.isNotEmpty) {
      buffer.write(',');
    }
  }
  if (namedConstructorArguments.isNotEmpty) {
    buffer.writeln();
    buffer.writeAll(namedConstructorArguments.map((paramElement) {
      var value =
          deserializeForField(paramElement.name, ctorParam: paramElement);
      return '      ${paramElement.name}: $value';
    }), ',\n');
  }

  buffer.write(')');

  usedCtorParamsAndFields.addAll(remainingFieldsForInvocationBody);

  return new _CtorData(buffer.toString(), remainingFieldsForInvocationBody,
      usedCtorParamsAndFields);
}

class _CtorData {
  final String content;
  final Set<String> fieldsToSet;
  final Set<String> usedCtorParamsAndFields;
  _CtorData(this.content, this.fieldsToSet, this.usedCtorParamsAndFields);
}

void _validateConstructorArguments(
    ClassElement element, Iterable<ParameterElement> constructorArguments) {
  var undefinedArgs =
      constructorArguments.where((pe) => pe.type.isUndefined).toList();
  if (undefinedArgs.isNotEmpty) {
    var description = undefinedArgs.map((fe) => '`${fe.name}`').join(', ');

    throw new InvalidGenerationSourceError(
        'At least one constructor argument has an invalid type: $description.',
        todo: 'Check names and imports.',
        element: element);
  }
}
