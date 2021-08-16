// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'default_container.dart';
import 'helper_core.dart';
import 'json_literal_generator.dart';
import 'type_helpers/generic_factory_helper.dart';
import 'unsupported_type_error.dart';
import 'utils.dart';

class CreateFactoryResult {
  final String output;
  final Set<String> usedFields;

  CreateFactoryResult(this.output, this.usedFields);
}

abstract class DecodeHelper implements HelperCore {
  CreateFactoryResult createFactory(
    Map<String, FieldElement> accessibleFields,
    Map<String, String> unavailableReasons,
  ) {
    assert(config.createFactory);
    final buffer = StringBuffer();

    final mapType = config.anyMap ? 'Map' : 'Map<String, dynamic>';
    buffer.write('$targetClassReference '
        '${prefix}FromJson${genericClassArgumentsImpl(true)}'
        '($mapType json');

    if (config.genericArgumentFactories) {
      for (var arg in element.typeParameters) {
        final helperName = fromJsonForType(
          arg.instantiate(nullabilitySuffix: NullabilitySuffix.none),
        );

        buffer.write(', ${arg.name} Function(Object? json) $helperName');
      }
      if (element.typeParameters.isNotEmpty) {
        buffer.write(',');
      }
    }

    buffer.write(')');

    final fromJsonLines = <String>[];

    String deserializeFun(String paramOrFieldName,
            {ParameterElement? ctorParam}) =>
        _deserializeForField(accessibleFields[paramOrFieldName]!,
            ctorParam: ctorParam);

    final data = _writeConstructorInvocation(
      element,
      accessibleFields.keys,
      accessibleFields.values
          .where((fe) => element.lookUpSetter(fe.name, element.library) != null)
          .map((fe) => fe.name)
          .toList(),
      unavailableReasons,
      deserializeFun,
    );

    final checks = _checkKeys(
      accessibleFields.values
          .where((fe) => data.usedCtorParamsAndFields.contains(fe.name)),
    ).toList();

    if (config.checked) {
      final classLiteral = escapeDartString(element.name);

      final sectionBuffer = StringBuffer()..write('''
  \$checkedCreate(
    $classLiteral,
    json,
    (\$checkedConvert) {\n''')..write(checks.join())..write('''
    final val = ${data.content};''');

      for (final field in data.fieldsToSet) {
        sectionBuffer.writeln();
        final safeName = safeNameAccess(accessibleFields[field]!);
        sectionBuffer
          ..write('''
    \$checkedConvert($safeName, (v) => ''')
          ..write('val.$field = ')
          ..write(_deserializeForField(accessibleFields[field]!,
              checkedProperty: true))
          ..write(');');
      }

      sectionBuffer.write('''\n    return val;
  }''');

      final fieldKeyMap = Map.fromEntries(data.usedCtorParamsAndFields
          .map((k) => MapEntry(k, nameAccess(accessibleFields[k]!)))
          .where((me) => me.key != me.value));

      String fieldKeyMapArg;
      if (fieldKeyMap.isEmpty) {
        fieldKeyMapArg = '';
      } else {
        final mapLiteral = jsonMapAsDart(fieldKeyMap);
        fieldKeyMapArg = ', fieldKeyMap: const $mapLiteral';
      }

      sectionBuffer..write(fieldKeyMapArg)..write(',);');
      fromJsonLines.add(sectionBuffer.toString());
    } else {
      fromJsonLines.addAll(checks);

      final sectionBuffer = StringBuffer()..write('''
  ${data.content}''');
      for (final field in data.fieldsToSet) {
        sectionBuffer
          ..writeln()
          ..write('    ..$field = ')
          ..write(deserializeFun(field));
      }
      sectionBuffer.writeln(';');
      fromJsonLines.add(sectionBuffer.toString());
    }

    if (fromJsonLines.length == 1) {
      buffer..write('=>')..write(fromJsonLines.single);
    } else {
      buffer
        ..write('{')
        ..writeAll(fromJsonLines.take(fromJsonLines.length - 1))
        ..write('return ')
        ..write(fromJsonLines.last)
        ..write('}');
    }

    return CreateFactoryResult(buffer.toString(), data.usedCtorParamsAndFields);
  }

  Iterable<String> _checkKeys(Iterable<FieldElement> accessibleFields) sync* {
    final args = <String>[];

    String constantList(Iterable<FieldElement> things) =>
        'const ${jsonLiteralAsDart(things.map(nameAccess).toList())}';

    if (config.disallowUnrecognizedKeys) {
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
      yield '\$checkKeys(json, ${args.map((e) => '$e, ').join()});\n';
    }
  }

  String _deserializeForField(
    FieldElement field, {
    ParameterElement? ctorParam,
    bool checkedProperty = false,
  }) {
    final jsonKeyName = safeNameAccess(field);
    final targetType = ctorParam?.type ?? field.type;
    final contextHelper = getHelperContext(field);
    final jsonKey = jsonKeyFor(field);
    final defaultValue = jsonKey.defaultValue;
    final defaultProvided = defaultValue != null;

    String deserialize(String expression) {
      final value = contextHelper.deserialize(
        targetType,
        expression,
        defaultProvided: defaultProvided,
      )!;

      return DefaultContainer.encode(
        value,
        nullable: targetType.isNullableType,
        defaultValue: defaultValue,
      );
    }

    String value;
    try {
      if (config.checked) {
        value = deserialize('v');
        if (!checkedProperty) {
          value = '\$checkedConvert($jsonKeyName, (v) => $value)';
        }
      } else {
        assert(
          !checkedProperty,
          'should only be true if `_generator.checked` is true.',
        );
        value = deserialize('json[$jsonKeyName]');
      }
    } on UnsupportedTypeError catch (e) // ignore: avoid_catching_errors
    {
      throw createInvalidGenerationError('fromJson', field, e);
    }

    if (defaultProvided) {
      if (jsonKey.disallowNullValue && jsonKey.required) {
        log.warning('The `defaultValue` on field `${field.name}` will have no '
            'effect because both `disallowNullValue` and `required` are set to '
            '`true`.');
      }
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
  String Function(String paramOrFieldName, {ParameterElement ctorParam})
      deserializeForField,
) {
  final className = classElement.name;

  final ctor = unnamedConstructorOrError(classElement);

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

  final buffer = StringBuffer()
    ..write('$className${genericClassArguments(classElement, false)}(');
  if (constructorArguments.isNotEmpty) {
    buffer
      ..writeln()
      ..writeAll(constructorArguments.map((paramElement) {
        final content =
            deserializeForField(paramElement.name, ctorParam: paramElement);
        return '      $content,\n';
      }));
  }
  if (namedConstructorArguments.isNotEmpty) {
    buffer
      ..writeln()
      ..writeAll(namedConstructorArguments.map((paramElement) {
        final value =
            deserializeForField(paramElement.name, ctorParam: paramElement);
        return '      ${paramElement.name}: $value,\n';
      }));
  }

  buffer.write(')');

  usedCtorParamsAndFields.addAll(remainingFieldsForInvocationBody);

  return _ConstructorData(
    buffer.toString(),
    remainingFieldsForInvocationBody,
    usedCtorParamsAndFields,
  );
}

class _ConstructorData {
  final String content;
  final Set<String> fieldsToSet;
  final Set<String> usedCtorParamsAndFields;

  _ConstructorData(
    this.content,
    this.fieldsToSet,
    this.usedCtorParamsAndFields,
  );
}
