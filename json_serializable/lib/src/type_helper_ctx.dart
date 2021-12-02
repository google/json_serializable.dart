// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import 'default_container.dart';
import 'helper_core.dart';
import 'type_helper.dart';
import 'type_helpers/config_types.dart';
import 'type_helpers/convert_helper.dart';
import 'unsupported_type_error.dart';
import 'utils.dart';

TypeHelperCtx typeHelperContext(
  HelperCore helperCore,
  FieldElement fieldElement,
) =>
    TypeHelperCtx._(helperCore, fieldElement);

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

  late final _pairFromContext = _ConvertPair(fieldElement);

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
    final value = _run(
      targetType,
      expression,
      (TypeHelper th) => th.deserialize(
        targetType,
        expression,
        this,
        defaultValue != null,
      ),
    );

    return DefaultContainer.deserialize(
      value,
      nullable: targetType.isNullableType,
      defaultValue: defaultValue,
    );
  }

  Object _run(
    DartType targetType,
    String expression,
    Object? Function(TypeHelper) invoke,
  ) =>
      _helperCore.allTypeHelpers.map(invoke).firstWhere(
            (r) => r != null,
            orElse: () => throw UnsupportedTypeError(targetType, expression),
          ) as Object;
}

class _ConvertPair {
  static final _expando = Expando<_ConvertPair>();

  final ConvertData? fromJson, toJson;

  _ConvertPair._(this.fromJson, this.toJson);

  factory _ConvertPair(FieldElement element) {
    var pair = _expando[element];

    if (pair == null) {
      final obj = jsonKeyAnnotation(element);
      if (obj.isNull) {
        pair = _ConvertPair._(null, null);
      } else {
        final toJson = _convertData(obj.objectValue, element, false);
        final fromJson = _convertData(obj.objectValue, element, true);
        pair = _ConvertPair._(fromJson, toJson);
      }
      _expando[element] = pair;
    }
    return pair;
  }
}

ConvertData? _convertData(DartObject obj, FieldElement element, bool isFrom) {
  final paramName = isFrom ? 'fromJson' : 'toJson';
  final objectValue = obj.getField(paramName);

  if (objectValue == null || objectValue.isNull) {
    return null;
  }

  final executableElement = objectValue.toFunctionValue()!;

  if (executableElement.parameters.isEmpty ||
      executableElement.parameters.first.isNamed ||
      executableElement.parameters.where((pe) => !pe.isOptional).length > 1) {
    throwUnsupported(
        element,
        'The `$paramName` function `${executableElement.name}` must have one '
        'positional parameter.');
  }

  final argType = executableElement.parameters.first.type;
  if (isFrom) {
    final hasDefaultValue =
        !jsonKeyAnnotation(element).read('defaultValue').isNull;

    final returnType = executableElement.returnType;

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
            '`$elementTypeCode`.');
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
          ' `$elementTypeCode`.');
    }
  }

  return ConvertData(executableElement.qualifiedName, argType);
}
