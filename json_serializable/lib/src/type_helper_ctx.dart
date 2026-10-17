// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'default_container.dart';
import 'helper_core.dart';
import 'json_key_utils.dart';
import 'type_helper.dart';
import 'type_helpers/config_types.dart';
import 'type_helpers/convert_helper.dart';
import 'type_helpers/patch_tri_state_helper.dart';
import 'unsupported_type_error.dart';
import 'utils.dart';

TypeHelperCtx typeHelperContext(
  HelperCore helperCore,
  FieldElement fieldElement,
) => TypeHelperCtx._(helperCore, fieldElement);

class TypeHelperCtx
    implements TypeHelperContextWithConfig, TypeHelperContextWithConvert {
  final HelperCore _helperCore;

  @override
  final FieldElement fieldElement;

  @override
  ClassElement get classElement => _helperCore.element;

  @override
  ClassConfig get config => _helperCore.config;

  @override
  ConvertData? get serializeConvertData => _pairFromContext.toJson;

  @override
  ConvertData? get deserializeConvertData => _pairFromContext.fromJson;

  late final _pairFromContext = _ConvertPair(fieldElement, config);
  int _runDepth = 0;

  TypeHelperCtx._(this._helperCore, this.fieldElement);

  @override
  void addMember(String memberContent) {
    _helperCore.addMember(memberContent);
  }

  @override
  Object? serialize(DartType targetType, String expression) => _run(
    targetType,
    expression,
    (TypeHelper th) => th.serialize(targetType, expression, this),
  );

  @override
  Object deserialize(
    DartType targetType,
    String expression, {
    String? defaultValue,
  }) {
    if (_runDepth == 0 &&
        usesExplicitJsonNullWhenNonNullField(
          jsonKeyForField(fieldElement, config),
        )) {
      return deserializePresentJsonValue(
        targetType,
        expression,
        defaultValue: defaultValue,
      );
    }

    var value = _run(
      targetType,
      expression,
      (TypeHelper th) =>
          th.deserialize(targetType, expression, this, defaultValue != null),
    );

    final fromJsonData = deserializeConvertData;
    if (fromJsonData != null) {
      if (defaultValue != null &&
          !targetType.isNullableType &&
          fromJsonData.returnType.isNullableType) {
        return ifNullOrElse(
          expression,
          defaultValue,
          '$value ?? $defaultValue',
        );
      }
      if (defaultValue == null &&
          targetType.isNullableType &&
          !fromJsonData.paramType.isNullableType) {
        value = DefaultContainer(expression, value);
      }
    }

    return DefaultContainer.deserialize(
      value,
      nullable: targetType.isNullableType,
      defaultValue: defaultValue,
    );
  }

  /// Like [deserialize], but does not apply nullable short-circuiting for
  /// [targetType] when [targetType] deserializes explicit `null` through a
  /// `fromJson` constructor, converter, or generic argument factory.
  ///
  /// Used when a JSON key is present (including when its value is JSON `null`)
  /// for PATCH tri-state fields, so explicit `null` is passed to `fromJson`.
  Object deserializePresentJsonValue(
    DartType targetType,
    String expression, {
    String? defaultValue,
  }) {
    final effectiveTargetType =
        config.genericArgumentFactories && targetType is TypeParameterType
        ? targetType.promoteNonNullable()
        : targetType;
    final value = _run(
      effectiveTargetType,
      expression,
      (TypeHelper th) => th.deserialize(
        effectiveTargetType,
        expression,
        this,
        defaultValue != null,
      ),
    );

    return DefaultContainer.deserialize(
      value,
      nullable:
          targetType.isNullableType &&
          !passesExplicitNullToFromJson(this, targetType),
      defaultValue: defaultValue,
    );
  }

  Object _run(
    DartType targetType,
    String expression,
    Object? Function(TypeHelper) invoke,
  ) {
    _runDepth++;
    try {
      return _helperCore.allTypeHelpers
              .map(invoke)
              .firstWhere(
                (r) => r != null,
                orElse: () =>
                    throw UnsupportedTypeError(targetType, expression),
              )
          as Object;
    } finally {
      _runDepth--;
    }
  }
}

class _ConvertPair {
  static final _expando = Expando<Map<ClassConfig, _ConvertPair>>();

  final ConvertData? fromJson, toJson;

  _ConvertPair._(this.fromJson, this.toJson);

  factory _ConvertPair(FieldElement element, ClassConfig config) {
    final map = _expando[element] ??= <ClassConfig, _ConvertPair>{};
    var pair = map[config];

    if (pair == null) {
      final ctorParam = config.ctorParams
          .where((e) => e.name == element.name)
          .singleOrNull;
      final obj = jsonKeyAnnotation(element);
      final ctorObj = ctorParam == null
          ? ConstantReader(null)
          : jsonKeyAnnotationForCtorParam(ctorParam);
      if (obj.isNull && ctorObj.isNull) {
        pair = _ConvertPair._(null, null);
      } else {
        final toJson = _convertData(obj, ctorObj, ctorParam, element, false);
        final fromJson = _convertData(obj, ctorObj, ctorParam, element, true);
        pair = _ConvertPair._(fromJson, toJson);
      }
      map[config] = pair;
    }
    return pair;
  }
}

ConstantReader _fallbackRead(
  ConstantReader obj,
  ConstantReader ctorObj,
  String field,
) {
  if (!ctorObj.isNull) {
    final reader = ctorObj.read(field);
    if (!reader.isNull) return reader;
  }
  if (!obj.isNull) {
    return obj.read(field);
  }
  return ConstantReader(null);
}

ConvertData? _convertData(
  ConstantReader obj,
  ConstantReader ctorObj,
  FormalParameterElement? ctorParam,
  FieldElement element,
  bool isFrom,
) {
  final paramName = isFrom ? 'fromJson' : 'toJson';
  final objectValue = _fallbackRead(obj, ctorObj, paramName);

  if (objectValue.isNull) {
    return null;
  }

  final executableElement = objectValue.objectValue.toFunctionValue()!;

  if (executableElement.formalParameters.isEmpty ||
      executableElement.formalParameters.first.isNamed ||
      executableElement.formalParameters.where((pe) => !pe.isOptional).length >
          1) {
    throwUnsupported(
      element,
      'The `$paramName` function `${executableElement.name}` must have one '
      'positional parameter.',
    );
  }

  final functionType = objectValue.objectValue.type as FunctionType;
  var returnType = functionType.returnType;
  var argType = functionType.formalParameters.first.type;

  if (functionType.typeParameters.isNotEmpty) {
    if (isFrom) {
      if (argType is TypeParameterType &&
          functionType.typeParameters.contains(argType.element)) {
        if (returnType is TypeParameterType &&
            returnType.element == argType.element) {
          argType = element.type;
          returnType = element.type;
        } else {
          argType = argType.bound;
        }
      }
    } else {
      if (argType is TypeParameterType &&
          functionType.typeParameters.contains(argType.element)) {
        if (returnType is TypeParameterType &&
            returnType.element == argType.element) {
          returnType = element.type;
        }
        argType = element.type;
      }
    }
  }

  if (isFrom) {
    final hasDefaultValue =
        !_fallbackRead(obj, ctorObj, 'defaultValue').isNull ||
        ctorParam?.defaultValueCode != null;

    if (returnType is TypeParameterType) {
      // We keep things simple in this case. We rely on inferred type arguments
      // to the `fromJson` function.
      // TODO: consider adding error checking here if there is confusion.
    } else if (!returnType.isAssignableTo(element.type)) {
      if (returnType.promoteNonNullable().isAssignableTo(element.type) &&
          hasDefaultValue) {
        // noop
      } else {
        final returnTypeCode = typeToCode(returnType);
        final elementTypeCode = typeToCode(element.type);
        throwUnsupported(
          element,
          'The `$paramName` function `${executableElement.name}` return type '
          '`$returnTypeCode` is not compatible with field type '
          '`$elementTypeCode`.',
        );
      }
    }
  } else {
    if (argType is TypeParameterType) {
      // We keep things simple in this case. We rely on inferred type arguments
      // to the `fromJson` function.
      // TODO: consider adding error checking here if there is confusion.
    } else if (!element.type.isAssignableTo(argType)) {
      final argTypeCode = typeToCode(argType);
      final elementTypeCode = typeToCode(element.type);
      throwUnsupported(
        element,
        'The `$paramName` function `${executableElement.name}` argument type '
        '`$argTypeCode` is not compatible with field type'
        ' `$elementTypeCode`.',
      );
    }
  }

  return ConvertData(executableElement.qualifiedName, argType, returnType);
}
