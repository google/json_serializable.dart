// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'helper_core.dart';
import 'type_helpers/generic_factory_helper.dart';
import 'type_helpers/patch_tri_state_helper.dart';
import 'unsupported_type_error.dart';
import 'utils.dart';

class CreateFactoryResult {
  final Method method;
  final Set<String> usedFields;

  CreateFactoryResult(this.method, this.usedFields);
}

mixin DecodeHelper implements HelperCore {
  CreateFactoryResult createFactory(
    Map<String, FieldElement> accessibleFields,
    Map<String, String> unavailableReasons, {
    Iterable<FieldElement> explicitToJsonFields = const [],
  }) {
    assert(config.createFactory);

    Expression? lambdaExpr;
    final fromJsonLines = <Code>[];

    Expression deserializeFun(
      String paramOrFieldName, {
      FormalParameterElement? ctorParam,
    }) => _deserializeForField(
      accessibleFields[paramOrFieldName]!,
      ctorParam: ctorParam,
    );

    final data = _writeConstructorInvocation(
      element,
      config.constructor,
      accessibleFields.keys,
      accessibleFields.values
          .where(
            (fe) =>
                element.lookUpSetter(
                  name: fe.name!,
                  library: element.library,
                ) !=
                null,
          )
          .map((fe) => fe.name!)
          .toList(),
      unavailableReasons,
      deserializeFun,
    );

    final checks = _checkKeys(
      accessibleFields.values.where(
        (fe) => data.usedCtorParamsAndFields.contains(fe.name),
      ),
      explicitToJsonFields: explicitToJsonFields,
    ).toList();

    if (config.checked) {
      final fieldKeyMap = Map.fromEntries(
        data.usedCtorParamsAndFields
            .map((k) => MapEntry(k, nameAccess(accessibleFields[k]!)))
            .where((me) => me.key != me.value),
      );

      final closureBody = Block(
        (b) => b
          ..statements.addAll(checks)
          ..statements.add(declareFinal('val').assign(data.content).statement)
          ..statements.addAll(
            data.fieldsToSet.map((fieldName) {
              final fieldValue = accessibleFields[fieldName]!;
              final safeName = safeNameAccess(fieldValue);
              final readValueFunc = jsonKeyFor(
                fieldValue,
              ).readValueFunctionName;
              final deserializeCall = _deserializeForField(
                fieldValue,
                checkedProperty: true,
              );

              return refer(r'$checkedConvert')
                  .call(
                    [
                      CodeExpression(Code(safeName)),
                      Method(
                        (m) => m
                          ..requiredParameters.add(
                            Parameter((p) => p..name = 'v'),
                          )
                          ..lambda = true
                          ..body = refer(
                            'val',
                          ).property(fieldName).assign(deserializeCall).code,
                      ).closure,
                    ],
                    {
                      if (readValueFunc != null)
                        'readValue': refer(readValueFunc),
                    },
                  )
                  .statement;
            }),
          )
          ..statements.add(refer('val').returned.statement),
      );

      final checkedCreateCall = refer(r'$checkedCreate').call(
        [
          literal(element.name!),
          refer('json'),
          Method(
            (m) => m
              ..requiredParameters.add(
                Parameter((p) => p..name = r'$checkedConvert'),
              )
              ..body = closureBody,
          ).closure,
        ],
        {
          if (fieldKeyMap.isNotEmpty)
            'fieldKeyMap': literalConstMap({
              for (final MapEntry(:key, :value) in fieldKeyMap.entries)
                CodeExpression(Code(escapeDartString(key))): CodeExpression(
                  Code(escapeDartString(value)),
                ),
            }),
        },
      );

      lambdaExpr = checkedCreateCall;
    } else {
      if (data.fieldsToSet.isEmpty) {
        if (checks.isEmpty) {
          lambdaExpr = data.content;
        } else {
          fromJsonLines
            ..addAll(checks)
            ..add(data.content.returned.statement);
        }
      } else {
        // TODO: https://github.com/dart-lang/tools/issues/2524 - trailing
        // space prevents `?..` collision in code_builder cascade emission.
        final expr = data.fieldsToSet.fold<Expression>(
          data.content,
          (current, field) => current
              .cascade(field)
              .assign(
                CodeExpression(Code('${toCodeString(deserializeFun(field))} ')),
              ),
        );

        if (checks.isEmpty) {
          lambdaExpr = expr;
        } else {
          fromJsonLines
            ..addAll(checks)
            ..add(expr.returned.statement);
        }
      }
    }

    final method = Method((m) {
      m
        ..name = '${prefix}FromJson'
        ..returns = refer(targetClassReference)
        ..types.addAll(
          element.typeParameters.map((t) {
            final bound = t.bound;
            return refer(
              bound != null
                  ? '${t.name} extends ${bound.getDisplayString()}'
                  : t.name!,
            );
          }),
        )
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer(config.anyMap ? 'Map' : 'Map<String, dynamic>'),
          ),
        );

      if (config.genericArgumentFactories) {
        for (var arg in element.typeParameters) {
          final helperName = fromJsonForType(
            arg.instantiate(nullabilitySuffix: NullabilitySuffix.none),
          );
          m.requiredParameters.add(
            Parameter(
              (p) => p
                ..name = helperName
                ..type = refer('${arg.name} Function(Object? json)'),
            ),
          );
        }
      }

      if (lambdaExpr != null) {
        m
          ..lambda = true
          ..body = lambdaExpr.statement;
      } else {
        m.body = Block((b) => b.statements.addAll(fromJsonLines));
      }
    });

    return CreateFactoryResult(method, data.usedCtorParamsAndFields);
  }

  Iterable<Code> _checkKeys(
    Iterable<FieldElement> accessibleFields, {
    Iterable<FieldElement> explicitToJsonFields = const [],
  }) sync* {
    final args = <String, Expression>{};

    Expression constantList(Iterable<FieldElement> things) =>
        literalConstList(things.map<String>(nameAccess).toList());

    if (config.disallowUnrecognizedKeys) {
      final allowedFields = [
        ...accessibleFields,
        ...explicitToJsonFields.where((fe) => !accessibleFields.contains(fe)),
      ];
      args['allowedKeys'] = constantList(allowedFields);
    }

    final requiredKeys = accessibleFields
        .where((fe) => jsonKeyFor(fe).required)
        .toList();
    if (requiredKeys.isNotEmpty) {
      args['requiredKeys'] = constantList(requiredKeys);
    }

    final disallowNullKeys = accessibleFields
        .where((fe) => jsonKeyFor(fe).disallowNullValue)
        .toList();
    if (disallowNullKeys.isNotEmpty) {
      args['disallowNullValues'] = constantList(disallowNullKeys);
    }

    if (args.isNotEmpty) {
      yield refer(r'$checkKeys').call([refer('json')], args).statement;
    }
  }

  /// If [checkedProperty] is `true`, we're using this function to write to a
  /// setter.
  Expression _deserializeForField(
    FieldElement field, {
    FormalParameterElement? ctorParam,
    bool checkedProperty = false,
  }) {
    final jsonKeyName = CodeExpression(Code(safeNameAccess(field)));
    final targetType = ctorParam?.type ?? field.type;
    final contextHelper = getHelperContext(field);
    final jsonKey = jsonKeyFor(field);
    final defaultValue = jsonKey.defaultValue;
    final readValueFunc = jsonKey.readValueFunctionName;
    final patchTriState = usesExplicitJsonNullWhenNonNullField(jsonKey);

    Expression deserialize(
      Expression expression, {
      bool patchPresentValue = false,
    }) => patchPresentValue
        ? contextHelper.deserializePresentJsonValue(
            targetType,
            expression,
            defaultValue: defaultValue,
          )
        : contextHelper.deserialize(
            targetType,
            expression,
            defaultValue: defaultValue,
          );

    Expression value;
    try {
      if (config.checked) {
        final deserializeV = deserialize(refer('v'));
        if (patchTriState) {
          validateExplicitJsonNullDeserialize(field, contextHelper, targetType);
          value = wrapPatchTriStateCheckedConvert(
            mapExpression: refer('json'),
            jsonKeyName: jsonKeyName,
            absentExpression: literalNull,
            presentExpression: deserialize(refer('v'), patchPresentValue: true),
          );
        } else {
          value = deserializeV;
        }
        if (!checkedProperty) {
          value = refer(r'$checkedConvert').call(
            [
              jsonKeyName,
              Method(
                (m) => m
                  ..requiredParameters.add(Parameter((p) => p..name = 'v'))
                  ..lambda = true
                  ..body = value.code,
              ).closure,
            ],
            {if (readValueFunc != null) 'readValue': refer(readValueFunc)},
          );
        }
      } else {
        assert(
          !checkedProperty,
          'should only be true if `_generator.checked` is true.',
        );

        final jsonValueExpression = readValueFunc == null
            ? refer('json').index(jsonKeyName)
            : refer(readValueFunc).call([refer('json'), jsonKeyName]);

        final deserializeValue = deserialize(
          jsonValueExpression,
          patchPresentValue: patchTriState,
        );

        if (patchTriState) {
          validateExplicitJsonNullDeserialize(field, contextHelper, targetType);
          value = wrapPatchTriStateFromJson(
            mapExpression: refer('json'),
            jsonKeyName: jsonKeyName,
            absentExpression: literalNull,
            presentExpression: deserializeValue,
          );
        } else {
          value = deserializeValue;
        }
      }
    } on UnsupportedTypeError catch (e) // ignore: avoid_catching_errors
    {
      throw createInvalidGenerationError('fromJson', field, e);
    }

    if (defaultValue != null) {
      if (jsonKey.disallowNullValue && jsonKey.required) {
        log.warning(
          'The `defaultValue` on field `${field.name}` will have no '
          'effect because both `disallowNullValue` and `required` are set to '
          '`true`.',
        );
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
/// included in the [UnsupportedError] message; otherwise a default explanation
/// is provided.
///
/// [writableFields] are also populated, but only if they have not already
/// been defined by a constructor parameter with the same name.
_ConstructorData _writeConstructorInvocation(
  ClassElement classElement,
  String constructorName,
  Iterable<String> availableConstructorParameters,
  Iterable<String> writableFields,
  Map<String, String> unavailableReasons,
  Expression Function(
    String paramOrFieldName, {
    FormalParameterElement ctorParam,
  })
  deserializeForField,
) {
  final className = classElement.name;

  final ctor = constructorByName(classElement, constructorName);

  final usedCtorParamsAndFields = <String>{};
  final positionalArgs = <Expression>[];
  final namedArgs = <String, Expression>{};

  for (final arg in ctor.formalParameters) {
    if (!availableConstructorParameters.contains(arg.name)) {
      if (arg.isRequired) {
        var msg =
            'Cannot populate the required constructor '
            'argument: ${arg.name}.';

        final additionalInfo =
            unavailableReasons[arg.name] ??
            'It does not correspond to any field or getter on the class.';
        msg = '$msg $additionalInfo';

        throw InvalidGenerationSourceError(msg, element: ctor);
      }

      continue;
    }

    final expr = deserializeForField(arg.name!, ctorParam: arg);
    if (arg.isNamed) {
      namedArgs[arg.name!] = expr;
    } else {
      positionalArgs.add(expr);
    }
    usedCtorParamsAndFields.add(arg.name!);
  }

  final remainingFieldsForInvocationBody = writableFields.toSet().difference(
    usedCtorParamsAndFields,
  );

  final typeArguments = classElement.typeParameters
      .map((t) => refer(t.name!))
      .toList();

  Expression constructorInvocation;
  if (constructorName.isEmpty) {
    constructorInvocation = refer(
      className!,
    ).newInstance(positionalArgs, namedArgs, typeArguments);
  } else {
    constructorInvocation = refer(className!).newInstanceNamed(
      constructorName,
      positionalArgs,
      namedArgs,
      typeArguments,
    );
  }

  usedCtorParamsAndFields.addAll(remainingFieldsForInvocationBody);

  return _ConstructorData(
    constructorInvocation,
    remainingFieldsForInvocationBody,
    usedCtorParamsAndFields,
  );
}

class _ConstructorData {
  final Expression content;
  final Set<String> fieldsToSet;
  final Set<String> usedCtorParamsAndFields;

  _ConstructorData(
    this.content,
    this.fieldsToSet,
    this.usedCtorParamsAndFields,
  );
}
