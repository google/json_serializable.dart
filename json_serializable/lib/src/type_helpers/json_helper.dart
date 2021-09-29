// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../default_container.dart';
import '../type_helper.dart';
import '../unsupported_type_error.dart';
import '../utils.dart';
import 'config_types.dart';
import 'generic_factory_helper.dart';
import 'map_helper.dart';

const _helperLambdaParam = 'value';

/// Supports types that have `fromJson` constructors and/or `toJson` functions.
class JsonHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const JsonHelper();

  /// Simply returns the [expression] provided.
  ///
  /// By default, JSON encoding in from `dart:convert` calls `toJson()` on
  /// provided objects.
  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) {
    if (!_canSerialize(context.config, targetType)) {
      return null;
    }

    final interfaceType = targetType as InterfaceType;

    final toJsonArgs = <String>[];

    var toJson = _toJsonMethod(interfaceType);

    if (toJson != null) {
      // Using the `declaration` here so we get the original definition –
      // and not one with the generics already populated.
      toJson = toJson.declaration;

      toJsonArgs.addAll(
        _helperParams(
          context,
          _encodeHelper,
          interfaceType,
          toJson.parameters.where((element) => element.isRequiredPositional),
          toJson,
          isSerializing: true,
        ),
      );
    }

    if (context.config.explicitToJson || toJsonArgs.isNotEmpty) {
      return '$expression${interfaceType.isNullableType ? '?' : ''}'
          '.toJson(${toJsonArgs.map((a) => '$a, ').join()} )';
    }
    return expression;
  }

  @override
  Object? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    if (targetType is! InterfaceType) {
      return null;
    }

    final classElement = targetType.element2;

    final fromJsonCtor = classElement.constructors
        .singleWhereOrNull((ce) => ce.name == 'fromJson');

    var output = expression;
    if (fromJsonCtor != null) {
      final positionalParams = fromJsonCtor.parameters
          .where((element) => element.isPositional)
          .toList();

      if (positionalParams.isEmpty) {
        throw InvalidGenerationSourceError(
          'Expecting a `fromJson` constructor with exactly one positional '
          'parameter. Found a constructor with 0 parameters.',
          element: fromJsonCtor,
        );
      }

      var asCastType = positionalParams.first.type;

      if (asCastType is InterfaceType) {
        final instantiated = _instantiate(asCastType, targetType);
        if (instantiated != null) {
          asCastType = instantiated;
        }
      }

      output = context.deserialize(asCastType, output).toString();

      final args = [
        output,
        ..._helperParams(
          context,
          _decodeHelper,
          targetType,
          positionalParams.skip(1),
          fromJsonCtor,
          isSerializing: false,
        ),
      ];

      output = args.join(', ');
    } else if (_annotation(context.config, targetType)?.createFactory == true) {
      if (context.config.anyMap) {
        output += ' as Map';
      } else {
        output += ' as Map<String, dynamic>';
      }
    } else {
      return null;
    }

    // TODO: the type could be imported from a library with a prefix!
    // https://github.com/google/json_serializable.dart/issues/19
    output = '${typeToCode(targetType.promoteNonNullable())}.fromJson($output)';

    return DefaultContainer(expression, output);
  }
}

List<String> _helperParams(
  TypeHelperContextWithConfig context,
  TypeParameterTypeWithKeyHelper Function(ParameterElement, Element)
      paramMapper,
  InterfaceType type,
  Iterable<ParameterElement> positionalParams,
  Element targetElement, {
  required bool isSerializing,
}) {
  final rest = <TypeParameterTypeWithKeyHelper>[];
  for (var param in positionalParams) {
    rest.add(paramMapper(param, targetElement));
  }

  final args = <String>[];

  for (var helperArg in rest) {
    final typeParamIndex =
        type.element2.typeParameters.indexOf(helperArg.type.element2);

    // TODO: throw here if `typeParamIndex` is -1 ?
    final typeArg = type.typeArguments[typeParamIndex];
    final body = isSerializing
        ? context.serialize(typeArg, _helperLambdaParam)
        : context.deserialize(typeArg, _helperLambdaParam);
    if (helperArg.isJsonKey) {
      const keyHelper = MapKeyHelper();
      final newBody = isSerializing
          ? keyHelper.serialize(typeArg, '', context)
          : keyHelper.deserialize(typeArg, '', context, false);
      args.add('($_helperLambdaParam) => $newBody');
    } else {
      args.add('($_helperLambdaParam) => $body');
    }
  }

  return args;
}

TypeParameterTypeWithKeyHelper _decodeHelper(
  ParameterElement param,
  Element targetElement,
) {
  final type = param.type;

  if (type is FunctionType &&
      type.returnType is TypeParameterType &&
      type.normalParameterTypes.length == 1) {
    final funcReturnType = type.returnType;

    if (param.name == fromJsonForName(funcReturnType.element2!.name!)) {
      final funcParamType = type.normalParameterTypes.single;

      if ((funcParamType.isDartCoreObject && funcParamType.isNullableType) ||
          funcParamType.isDynamic ||
          funcParamType.isDartCoreString) {
        return TypeParameterTypeWithKeyHelper(
            funcReturnType as TypeParameterType,
            funcParamType.isDartCoreString);
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

class TypeParameterTypeWithKeyHelper {
  final TypeParameterType type;
  final bool isJsonKey;

  TypeParameterTypeWithKeyHelper(this.type, this.isJsonKey);
}

TypeParameterTypeWithKeyHelper _encodeHelper(
  ParameterElement param,
  Element targetElement,
) {
  final type = param.type;

  if (type is FunctionType &&
      (type.returnType.isDartCoreObject ||
          type.returnType.isDynamic ||
          type.returnType.isDartCoreString) &&
      type.normalParameterTypes.length == 1) {
    final funcParamType = type.normalParameterTypes.single;

    if (param.name == toJsonForName(funcParamType.element2!.name!)) {
      if (funcParamType is TypeParameterType) {
        return TypeParameterTypeWithKeyHelper(
            funcParamType, type.returnType.isDartCoreString);
      }
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

/// Returns an instantiation of [ctorParamType] by providing argument types
/// derived by matching corresponding type parameters from [classType].
InterfaceType? _instantiate(
  InterfaceType ctorParamType,
  InterfaceType classType,
) {
  final argTypes = ctorParamType.typeArguments.map((arg) {
    final typeParamIndex = classType.element2.typeParameters.indexWhere(
        // TODO: not 100% sure `nullabilitySuffix` is right
        (e) => e.instantiate(nullabilitySuffix: arg.nullabilitySuffix) == arg);
    if (typeParamIndex >= 0) {
      return classType.typeArguments[typeParamIndex];
    } else {
      // TODO: perhaps throw UnsupportedTypeError?
      return null;
    }
  }).toList();

  if (argTypes.any((e) => e == null)) {
    // TODO: perhaps throw UnsupportedTypeError?
    return null;
  }

  return ctorParamType.element2.instantiate(
    typeArguments: argTypes.cast<DartType>(),
    // TODO: not 100% sure nullabilitySuffix is right... Works for now
    nullabilitySuffix: NullabilitySuffix.none,
  );
}

ClassConfig? _annotation(ClassConfig config, InterfaceType source) {
  if (source.isEnum) {
    return null;
  }
  final annotations = const TypeChecker.fromRuntime(JsonSerializable)
      .annotationsOfExact(source.element2, throwOnUnresolved: false)
      .toList();

  if (annotations.isEmpty) {
    return null;
  }

  return mergeConfig(
    config,
    ConstantReader(annotations.single),
    classElement: source.element2 as ClassElement,
  );
}

MethodElement? _toJsonMethod(DartType type) => type.typeImplementations
    .map((dt) => dt is InterfaceType ? dt.getMethod('toJson') : null)
    .firstWhereOrNull((me) => me != null);

class MapKeyHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const MapKeyHelper();

  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) {
    final keyType = targetType;

    checkSafeMapKeyType(expression, keyType);

    final subKeyValue = mapKeyHelperForType(keyType)
            ?.serialize(keyType, _helperLambdaParam, false) ??
        context.serialize(keyType, _helperLambdaParam);

    if (_helperLambdaParam == subKeyValue) {
      return expression;
    }

    return '$subKeyValue';
  }

  @override
  String? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    final keyArg = targetType;

    checkSafeMapKeyType(expression, keyArg);

    final isKeyStringable = isMapKeyStringable(keyArg);
    if (!isKeyStringable) {
      throw UnsupportedTypeError(
        keyArg,
        expression,
        'Map keys must be one of: ${allowedMapKeyTypes.join(', ')}.',
      );
    }

    String keyUsage;
    if (keyArg.isEnum) {
      keyUsage = context.deserialize(keyArg, _helperLambdaParam).toString();
    } else if (context.config.anyMap &&
        !(keyArg.isDartCoreObject || keyArg.isDynamic)) {
      keyUsage = '$_helperLambdaParam as String';
    } else if (context.config.anyMap &&
        keyArg.isDartCoreObject &&
        !keyArg.isNullableType) {
      keyUsage = '$_helperLambdaParam as Object';
    } else {
      keyUsage = '$_helperLambdaParam as String';
    }

    final toFromString = mapKeyHelperForType(keyArg);
    if (toFromString != null) {
      keyUsage = toFromString.deserialize(keyArg, keyUsage, false, true)!;
    }

    return keyUsage;
  }
}
