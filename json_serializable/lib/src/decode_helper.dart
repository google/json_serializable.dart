// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'helper_core.dart';
import 'json_literal_generator.dart';
import 'type_helper.dart';
import 'utils.dart';

class CreateFactoryResult {
  final String output;
  final Set<String> usedFields;

  CreateFactoryResult(this.output, this.usedFields);
}

abstract class DecodeHelper implements HelperCore {
  final StringBuffer _buffer = StringBuffer();

  CreateFactoryResult createFactory(Map<String, FieldElement> accessibleFields,
      Map<String, String> unavailableReasons) {
    assert(config.createFactory);
    assert(_buffer.isEmpty);

    final mapType = config.anyMap ? 'Map' : 'Map<String, dynamic>';
    _buffer.write('$targetClassReference '
        '${prefix}FromJson${genericClassArgumentsImpl(true)}'
        '($mapType json) {\n');

    String deserializeFun(String paramOrFieldName,
            {ParameterElement ctorParam}) =>
        _deserializeForField(accessibleFields[paramOrFieldName],
            ctorParam: ctorParam);

    _ConstructorData data;
    if (config.checked) {
      final classLiteral = escapeDartString(element.name);

      _buffer.write('''
  return \$checkedNew(
    $classLiteral,
    json,
    () {\n''');

      data = _writeConstructorInvocation(
          element,
          accessibleFields.keys,
          accessibleFields.values
              .where((fe) => !fe.isFinal)
              .map((fe) => fe.name)
              .toList(),
          unavailableReasons,
          deserializeFun);

      _writeChecks(
          6,
          config,
          accessibleFields.values
              .where((fe) => data.usedCtorParamsAndFields.contains(fe.name)));
      _buffer.write('''
    final val = ${data.content};''');

      for (final field in data.fieldsToSet) {
        _buffer.writeln();
        final safeName = safeNameAccess(accessibleFields[field]);
        _buffer.write('''
    \$checkedConvert(json, $safeName, (v) => ''');
        _buffer.write('val.$field = ');
        _buffer.write(_deserializeForField(accessibleFields[field],
            checkedProperty: true));
        _buffer.write(');');
      }

      _buffer.write('''\n    return val;
  }''');

      final fieldKeyMap = Map.fromEntries(data.usedCtorParamsAndFields
          .map((k) => MapEntry(k, nameAccess(accessibleFields[k])))
          .where((me) => me.key != me.value));

      String fieldKeyMapArg;
      if (fieldKeyMap.isEmpty) {
        fieldKeyMapArg = '';
      } else {
        final mapLiteral = jsonMapAsDart(fieldKeyMap);
        fieldKeyMapArg = ', fieldKeyMap: const $mapLiteral';
      }

      _buffer.write(fieldKeyMapArg);

      _buffer.write(')');
    } else {
      data = _writeConstructorInvocation(
          element,
          accessibleFields.keys,
          accessibleFields.values
              .where((fe) => !fe.isFinal)
              .map((fe) => fe.name)
              .toList(),
          unavailableReasons,
          deserializeFun);

      _writeChecks(
          2,
          config,
          accessibleFields.values
              .where((fe) => data.usedCtorParamsAndFields.contains(fe.name)));

      _buffer.write('''
  return ${data.content}''');
      for (final field in data.fieldsToSet) {
        _buffer.writeln();
        _buffer.write('    ..$field = ');
        _buffer.write(deserializeFun(field));
      }
    }
    _buffer.writeln(';\n}');
    _buffer.writeln();

    return CreateFactoryResult(
        _buffer.toString(), data.usedCtorParamsAndFields);
  }

  void _writeChecks(int indent, JsonSerializable classAnnotation,
      Iterable<FieldElement> accessibleFields) {
    final args = <String>[];

    String constantList(Iterable<FieldElement> things) =>
        'const ${jsonLiteralAsDart(things.map(nameAccess).toList())}';

    if (classAnnotation.disallowUnrecognizedKeys) {
      final allowKeysLiteral = constantList(accessibleFields);

      args.add('allowedKeys: $allowKeysLiteral');
    }

    final requiredKeys =
        accessibleFields.where((fe) => jsonKeyFor(fe).required).toList();
    if (requiredKeys.isNotEmpty) {
      final requiredKeyLiteral = constantList(requiredKeys);

      args.add('requiredKeys: $requiredKeyLiteral');
    }

    final disallowNullKeys = accessibleFields
        .where((fe) => jsonKeyFor(fe).disallowNullValue)
        .toList();
    if (disallowNullKeys.isNotEmpty) {
      final disallowNullKeyLiteral = constantList(disallowNullKeys);

      args.add('disallowNullValues: $disallowNullKeyLiteral');
    }

    if (args.isNotEmpty) {
      _buffer.writeln('${' ' * indent}\$checkKeys(json, ${args.join(', ')});');
    }
  }

  String _deserializeForField(FieldElement field,
      {ParameterElement ctorParam, bool checkedProperty}) {
    checkedProperty ??= false;
    final jsonKeyName = safeNameAccess(field);
    final targetType = ctorParam?.type ?? field.type;
    final contextHelper = getHelperContext(field);

    String value;
    try {
      if (config.checked) {
        value = contextHelper.deserialize(targetType, 'v').toString();
        if (!checkedProperty) {
          value = '\$checkedConvert(json, $jsonKeyName, (v) => $value)';
        }
      } else {
        assert(!checkedProperty,
            'should only be true if `_generator.checked` is true.');

        value = contextHelper
            .deserialize(targetType, 'json[$jsonKeyName]')
            .toString();
      }
    } on UnsupportedTypeError catch (e) {
      throw createInvalidGenerationError('fromJson', field, e);
    }

    final jsonKey = jsonKeyFor(field);
    final defaultValue = jsonKey.defaultValue;
    if (defaultValue != null) {
      if (!contextHelper.nullable) {
        throwUnsupported(field,
            'Cannot use `defaultValue` on a field with `nullable` false.');
      }
      if (jsonKey.disallowNullValue && jsonKey.required) {
        log.warning('The `defaultValue` on field `${field.name}` will have no '
            'effect because both `disallowNullValue` and `required` are set to '
            '`true`.');
      }
      if (contextHelper.deserializeConvertData != null) {
        log.warning('The field `${field.name}` has both `defaultValue` and '
            '`fromJson` defined which likely won\'t work for your scenario.\n'
            'Instead of using `defaultValue`, set `nullable: false` and handle '
            '`null` in the `fromJson` function.');
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
/// [writableFields] are also populated, but only if they have not already
/// been defined by a constructor parameter with the same name.
_ConstructorData _writeConstructorInvocation(
    ClassElement classElement,
    Iterable<String> availableConstructorParameters,
    Iterable<String> writableFields,
    Map<String, String> unavailableReasons,
    String deserializeForField(String paramOrFieldName,
        {ParameterElement ctorParam})) {
  final className = classElement.name;

  final ctor = classElement.unnamedConstructor;
  if (ctor == null) {
    // TODO(kevmoo): support using another ctor - dart-lang/json_serializable#50
    throw InvalidGenerationSourceError(
        'The class `$className` has no default constructor.',
        element: classElement);
  }

  final usedCtorParamsAndFields = <String>{};
  final constructorArguments = <ParameterElement>[];
  final namedConstructorArguments = <ParameterElement>[];

  for (final arg in ctor.parameters) {
    if (!availableConstructorParameters.contains(arg.name)) {
      if (arg.isNotOptional) {
        var msg = 'Cannot populate the required constructor '
            'argument: ${arg.name}.';

        final additionalInfo = unavailableReasons[arg.name];

        if (additionalInfo != null) {
          msg = '$msg $additionalInfo';
        }

        throw InvalidGenerationSourceError(msg, element: ctor);
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

  // fields that aren't already set by the constructor and that aren't final
  final remainingFieldsForInvocationBody =
      writableFields.toSet().difference(usedCtorParamsAndFields);

  final buffer = StringBuffer();
  buffer.write('$className${genericClassArguments(classElement, false)}(');
  if (constructorArguments.isNotEmpty) {
    buffer.writeln();
    buffer.writeAll(constructorArguments.map((paramElement) {
      final content =
          deserializeForField(paramElement.name, ctorParam: paramElement);
      return '      $content,\n';
    }));
  }
  if (namedConstructorArguments.isNotEmpty) {
    buffer.writeln();
    buffer.writeAll(namedConstructorArguments.map((paramElement) {
      final value =
          deserializeForField(paramElement.name, ctorParam: paramElement);
      return '      ${paramElement.name}: $value,\n';
    }));
  }

  buffer.write(')');

  usedCtorParamsAndFields.addAll(remainingFieldsForInvocationBody);

  return _ConstructorData(buffer.toString(), remainingFieldsForInvocationBody,
      usedCtorParamsAndFields);
}

class _ConstructorData {
  final String content;
  final Set<String> fieldsToSet;
  final Set<String> usedCtorParamsAndFields;

  _ConstructorData(
      this.content, this.fieldsToSet, this.usedCtorParamsAndFields);
}
