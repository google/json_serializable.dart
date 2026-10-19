// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart'
    hide Enum, FunctionType, RecordType;
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../default_container.dart';
import '../lambda_result.dart';
import '../type_helper.dart';
import '../utils.dart';
import 'config_types.dart';
import 'generic_factory_helper.dart';

const _helperLambdaParam = 'value';

/// Supports types that have `fromJson` constructors and/or `toJson` functions.
class JsonHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const JsonHelper();

  /// Simply returns the [expression] provided.
  ///
  /// By default, JSON encoding in from `dart:convert` calls `toJson()` on
  /// provided objects.
  @override
  Expression? serialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
  ) {
    if (!_canSerialize(context.config, targetType)) {
      return null;
    }

    final interfaceType = targetType as InterfaceType;

    final toJsonArgs = <Expression>[];

    var toJson = _toJsonMethod(interfaceType);

    if (toJson != null) {
      // Using the `baseElement` here so we get the original definition –
      // and not one with the generics already populated.
      toJson = toJson.baseElement;

      toJsonArgs.addAll(
        _helperParams(
          context.serialize,
          _encodeHelper,
          interfaceType,
          toJson.formalParameters.where(
            (element) => element.isRequiredPositional,
          ),
          toJson,
        ),
      );
    }

    if (context.config.explicitToJson ||
        toJsonArgs.isNotEmpty ||
        interfaceType.element is ExtensionTypeElement) {
      final prop = interfaceType.isNullableType
          ? expression.nullSafeProperty('toJson')
          : expression.property('toJson');
      return prop.call(toJsonArgs);
    }
    return expression;
  }

  @override
  DefaultContainer? deserialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    if (targetType is! InterfaceType) {
      return null;
    }

    final classElement = targetType.element;

    var fromJsonCtor = classElement.constructors
        .where((ce) => ce.name == 'fromJson')
        .singleOrNull;

    var output = expression;
    var additionalArgs = const <Expression>[];

    if (fromJsonCtor != null) {
      while (fromJsonCtor!.enclosingElement is ClassElement &&
          (fromJsonCtor.enclosingElement as ClassElement).isMixinApplication &&
          fromJsonCtor.superConstructor != null) {
        fromJsonCtor = fromJsonCtor.superConstructor!.baseElement;
      }

      final positionalParams = fromJsonCtor.formalParameters
          .where((element) => element.isPositional)
          .toList();

      if (positionalParams.isEmpty) {
        throw InvalidGenerationSourceError(
          'Expecting a `fromJson` constructor with exactly one positional '
          'parameter. Found a constructor with 0 parameters.',
          element: fromJsonCtor,
        );
      }

      final instantiatedTarget =
          targetType.asInstanceOf(fromJsonCtor.enclosingElement) ?? targetType;
      final instantiatedCtor = instantiatedTarget.constructors
          .where((ce) => ce.baseElement == fromJsonCtor!.baseElement)
          .singleOrNull;
      final instantiatedPositionalParams = instantiatedCtor?.formalParameters
          .where((element) => element.isPositional)
          .toList();

      final asCastType =
          instantiatedPositionalParams != null &&
              instantiatedPositionalParams.isNotEmpty
          ? instantiatedPositionalParams.first.type
          : positionalParams.first.type;

      output = context.deserialize(asCastType, output)!;

      additionalArgs = _helperParams(
        context.deserialize,
        _decodeHelper,
        targetType,
        positionalParams.skip(1).where((e) => e.isRequiredPositional),
        fromJsonCtor,
      );
    } else if (_annotation(context.config, targetType)?.createFactory == true) {
      output = castExpression(
        output,
        context.config.anyMap ? 'Map' : 'Map<String, dynamic>',
      );
    } else {
      return null;
    }

    // TODO: the type could be imported from a library with a prefix!
    // https://github.com/google/json_serializable.dart/issues/19
    final lambda = LambdaResult(
      output,
      '${typeToCode(targetType.promoteNonNullable())}.fromJson',
      additionalPositionalArguments: additionalArgs,
    );

    return DefaultContainer(expression, lambda);
  }
}

List<Expression> _helperParams(
  Expression? Function(DartType, Expression) execute,
  TypeParameterType Function(FormalParameterElement, Element) paramMapper,
  InterfaceType type,
  Iterable<FormalParameterElement> positionalParams,
  Element targetElement,
) {
  final rest = <TypeParameterType>[];
  for (var param in positionalParams) {
    rest.add(paramMapper(param, targetElement));
  }

  if (targetElement.enclosingElement case final InterfaceElement enclosing) {
    type = type.asInstanceOf(enclosing) ?? type;
  }

  final args = <Expression>[];

  for (var helperArg in rest) {
    final typeParamIndex = type.element.typeParameters.indexOf(
      helperArg.element,
    );

    // TODO: throw here if `typeParamIndex` is -1 ?
    final typeArg = type.typeArguments[typeParamIndex];
    final body = execute(typeArg, refer(_helperLambdaParam))!;
    args.add(
      Method(
        (m) => m
          ..requiredParameters.add(
            Parameter((p) => p..name = _helperLambdaParam),
          )
          ..lambda = true
          ..body = body.code,
      ).closure,
    );
  }

  return args;
}

TypeParameterType _decodeHelper(
  FormalParameterElement param,
  Element targetElement,
) {
  final type = param.type;

  if (type is FunctionType &&
      type.returnType is TypeParameterType &&
      type.normalParameterTypes.length == 1) {
    final funcReturnType = type.returnType;

    if (param.name == fromJsonForName(funcReturnType.element!.name!)) {
      final funcParamType = type.normalParameterTypes.single;

      if (((funcParamType.isDartCoreObject && funcParamType.isNullableType) ||
              funcParamType is DynamicType) &&
          (targetElement.enclosingElement is! InterfaceElement ||
              (targetElement.enclosingElement as InterfaceElement)
                  .typeParameters
                  .contains(funcReturnType.element))) {
        return funcReturnType as TypeParameterType;
      }
    }
  }

  throw InvalidGenerationSourceError(
    'Expecting a `fromJson` constructor with exactly one positional '
    'parameter. '
    'The only extra parameters allowed are functions of the form '
    '`T Function(Object?) ${fromJsonForName('T')}` where `T` is a type '
    'parameter of the target type.',
    element: targetElement,
  );
}

TypeParameterType _encodeHelper(
  FormalParameterElement param,
  Element targetElement,
) {
  final type = param.type;

  if (type is FunctionType &&
      (type.returnType.isDartCoreObject || type.returnType is DynamicType) &&
      type.normalParameterTypes.length == 1) {
    final funcParamType = type.normalParameterTypes.single;

    if (funcParamType is TypeParameterType &&
        param.name == toJsonForName(funcParamType.element.name!) &&
        (targetElement.enclosingElement is! InterfaceElement ||
            (targetElement.enclosingElement as InterfaceElement).typeParameters
                .contains(funcParamType.element))) {
      return funcParamType;
    }
  }

  throw InvalidGenerationSourceError(
    'Expecting a `toJson` function with no required parameters. '
    'The only extra parameters allowed are functions of the form '
    '`Object Function(T) toJsonT` where `T` is a type parameter of the target '
    ' type.',
    element: targetElement,
  );
}

bool _canSerialize(ClassConfig config, DartType type) {
  if (type is InterfaceType) {
    final toJsonMethod = _toJsonMethod(type);

    if (toJsonMethod != null) {
      return true;
    }

    if (_annotation(config, type)?.createToJson == true) {
      // TODO: consider logging that we're assuming a user will wire up the
      // generated mixin at some point...
      return true;
    }
  }
  return false;
}

ClassConfig? _annotation(ClassConfig config, InterfaceType source) {
  if (source.isEnum) {
    return null;
  }
  final annotation = jsonSerializableChecker.firstAnnotationOfExact(
    source.element,
    throwOnUnresolved: false,
  );

  if (annotation == null) {
    return null;
  }

  return mergeConfig(
    config,
    ConstantReader(annotation),
    classElement: source.element as ClassElement,
  );
}

MethodElement? _toJsonMethod(DartType type) => type is InterfaceType
    ? type.lookUpMethod('toJson', type.element.library, concrete: true) ??
          type.lookUpMethod('toJson', type.element.library)
    : null;
