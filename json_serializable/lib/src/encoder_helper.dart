// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_helper/source_helper.dart';

import 'enum_utils.dart';
import 'helper_core.dart';
import 'type_helpers/generic_factory_helper.dart';
import 'type_helpers/json_converter_helper.dart';
import 'type_helpers/patch_tri_state_helper.dart';
import 'unsupported_type_error.dart';
import 'utils.dart';

mixin EncodeHelper implements HelperCore {
  String _fieldAccess(FieldElement field) => '$_toJsonParamName.${field.name!}';

  Class createPerFieldToJson(Set<FieldElement> accessibleFieldSet) {
    final hasObjectField = accessibleFieldSet.any((f) => f.name == 'Object');
    final returnType = hasObjectField ? 'dynamic' : 'Object?';

    return Class(
      (c) => c
        ..name = '_\$${element.name!.nonPrivate}PerFieldToJson'
        ..abstract = true
        ..docs.add('// ignore: unused_element')
        ..methods.addAll(
          accessibleFieldSet.map((fe) {
            final paramType = hasObjectField && fe.type.isDartCoreObject
                ? 'dynamic'
                : typeToCode(fe.type);
            return Method((m) {
              m
                ..name = fe.name!
                ..static = true
                ..docs.add('// ignore: unused_element')
                ..returns = refer(returnType)
                ..types.addAll(genericClassTypeParameters)
                ..requiredParameters.add(
                  Parameter(
                    (p) => p
                      ..name = _toJsonParamName
                      ..type = refer(paramType),
                  ),
                );

              if (config.genericArgumentFactories) {
                for (var arg in element.typeParameters) {
                  final helperName = toJsonForType(
                    arg.instantiate(nullabilitySuffix: NullabilitySuffix.none),
                  );
                  m.requiredParameters.add(
                    Parameter(
                      (p) => p
                        ..name = helperName
                        ..type = refer(
                          '$returnType Function(${arg.name} value)',
                        ),
                    ),
                  );
                }
              }

              m
                ..lambda = true
                ..body = _serializeField(fe, refer(_toJsonParamName)).code;
            });
          }),
        ),
    );
  }

  /// Generates an object containing metadatas related to the encoding,
  /// destined to be used by other code-generators.
  Field createFieldMap(Set<FieldElement> accessibleFieldSet) {
    assert(config.createFieldMap);

    return Field(
      (f) => f
        ..name = '_\$${element.name!.nonPrivate}FieldMap'
        ..modifier = FieldModifier.constant
        ..assignment = literalMap(
          {
            for (final fe in accessibleFieldSet)
              escapedStringLiteral(fe.name!): CodeExpression(
                Code(safeNameAccess(fe)),
              ),
          },
          refer('String'),
          refer('String'),
        ).code,
    );
  }

  /// Generates an object containing metadatas related to the encoding,
  /// destined to be used by other code-generators.
  Class createJsonKeys(Set<FieldElement> accessibleFieldSet) {
    assert(config.createJsonKeys);

    return Class(
      (c) => c
        ..name = '_\$${element.name!.nonPrivate}JsonKeys'
        ..abstract = true
        ..modifier = ClassModifier.final$
        ..fields.addAll(
          accessibleFieldSet.map(
            (fe) => Field(
              (f) => f
                ..name = fe.name!
                ..static = true
                ..modifier = FieldModifier.constant
                ..type = refer('String')
                ..assignment = Code(safeNameAccess(fe)),
            ),
          ),
        ),
    );
  }

  Method createToJson(Set<FieldElement> accessibleFields) {
    assert(config.createToJson);

    return Method((m) {
      m
        ..name = '${prefix}ToJson'
        ..returns = refer('Map<String, dynamic>')
        ..types.addAll(genericClassTypeParameters)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = _toJsonParamName
              ..type = refer(targetClassReference),
          ),
        );

      if (config.genericArgumentFactories) {
        for (var arg in element.typeParameters) {
          final helperName = toJsonForType(
            arg.instantiate(nullabilitySuffix: NullabilitySuffix.none),
          );
          m.requiredParameters.add(
            Parameter(
              (p) => p
                ..name = helperName
                ..type = refer('Object? Function(${arg.name} value)'),
            ),
          );
        }
      }

      final mapEntries = accessibleFields
          .map((field) {
            final keyExpression = safeNameAccess(field);

            if (usesExplicitJsonNullWhenNonNullField(jsonKeyFor(field))) {
              final access = _fieldAccess(field);
              final valueExpression = toCodeString(
                _serializePatchField(field, refer(r'$value')),
              );
              return '  if ($access case final \$value?) '
                  '$keyExpression: $valueExpression';
            }

            final accessExpr = refer(_toJsonParamName).property(field.name!);
            final valueExpression = toCodeString(
              _serializeField(field, accessExpr),
            );
            final maybeQuestion = _canWriteJsonWithoutNullCheck(field)
                ? ''
                : '?';
            return '  $keyExpression: $maybeQuestion$valueExpression';
          })
          .join(',\n');

      m
        ..lambda = true
        // TODO: use code_builder once it supports null-aware map entries
        ..body = CodeExpression(
          Code('<String, dynamic>{\n$mapEntries\n}'),
        ).statement;
    });
  }

  static const _toJsonParamName = 'instance';

  Expression _serializeField(FieldElement field, Expression accessExpression) {
    try {
      return getHelperContext(field).serialize(field.type, accessExpression)!;
    } on UnsupportedTypeError catch (e) // ignore: avoid_catching_errors
    {
      throw createInvalidGenerationError('toJson', field, e);
    }
  }

  Expression _serializePatchField(
    FieldElement field,
    Expression accessExpression,
  ) {
    try {
      final type = field.type.promoteNonNullable();
      return getHelperContext(field).serialize(type, accessExpression)!;
    } on UnsupportedTypeError catch (e) // ignore: avoid_catching_errors
    {
      throw createInvalidGenerationError('toJson', field, e);
    }
  }

  /// Returns `true` if the field can be written to JSON 'naively' – meaning
  /// we can avoid checking for `null`.
  bool _canWriteJsonWithoutNullCheck(FieldElement field) {
    final jsonKey = jsonKeyFor(field);

    if (usesExplicitJsonNullWhenNonNullField(jsonKey)) {
      return true;
    }

    if (jsonKey.includeIfNull) {
      return true;
    }

    final helperContext = getHelperContext(field);

    final serializeConvertData = helperContext.serializeConvertData;
    if (serializeConvertData != null) {
      return !element.library.typeSystem.isPotentiallyNullable(
        serializeConvertData.returnType,
      );
    }

    final nullableEncodeConverter = hasConverterNullEncode(
      field.type,
      helperContext,
      forNullCheck: true,
    );

    if (nullableEncodeConverter != null) {
      return !nullableEncodeConverter;
    }

    // We can consider enums as kinda like having custom converters
    // same rules apply. If `null` is in the set of encoded values, we
    // should not write naive
    final enumWithNullValue = enumFieldWithNullInEncodeMap(field.type);
    if (enumWithNullValue != null) {
      return !enumWithNullValue;
    }

    return !element.library.typeSystem.isPotentiallyNullable(field.type);
  }
}
