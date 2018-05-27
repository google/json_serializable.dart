// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../shared_checkers.dart';
import '../type_helper.dart';
import '../type_helper_context.dart';
import '../utils.dart';

class JsonHelper extends TypeHelper {
  const JsonHelper();

  /// Simply returns the [expression] provided.
  ///
  /// By default, JSON encoding in from `dart:convert` calls `toJson()` on
  /// provided objects.
  @override
  String serialize(
      DartType targetType, String expression, SerializeContext context) {
    if (!_canSerialize(targetType)) {
      return null;
    }

    if (context is TypeHelperContext && context.explicitToJson) {
      return '$expression${context.nullable ? '?' : ''}.toJson()';
    }
    return expression;
  }

  @override
  String deserialize(
      DartType targetType, String expression, DeserializeContext context) {
    if (targetType is! InterfaceType) {
      return null;
    }

    var type = targetType as InterfaceType;
    var classElement = type.element;

    var fromJsonCtor = classElement.constructors
        .singleWhere((ce) => ce.name == 'fromJson', orElse: () => null);

    String asCast;
    if (fromJsonCtor != null) {
      // TODO: should verify that this type is a valid JSON type
      var asCastType = fromJsonCtor.parameters.first.type;
      asCast = asStatement(asCastType);
    } else if (_annotation(type)?.createFactory == true) {
      if ((context as TypeHelperContext).anyMap) {
        asCast = ' as Map';
      } else {
        asCast = ' as Map<String, dynamic>';
      }
    } else {
      return null;
    }

    // TODO: the type could be imported from a library with a prefix!
    // github.com/dart-lang/json_serializable/issues/19
    var result = 'new ${targetType.name}.fromJson($expression$asCast)';

    return commonNullPrefix(context.nullable, expression, result);
  }
}

bool _canSerialize(DartType type) {
  if (type is InterfaceType) {
    var toJsonMethod = _toJsonMethod(type);

    if (toJsonMethod != null) {
      // TODO: validate there are no required parameters
      return true;
    }

    if (_annotation(type)?.createToJson == true) {
      // TODO: consider logging that we're assuming a user will wire up the
      // generated mixin at some point...
      return true;
    }
  }
  return false;
}

JsonSerializable _annotation(InterfaceType source) {
  var annotations = const TypeChecker.fromRuntime(JsonSerializable)
      .annotationsOfExact(source.element, throwOnUnresolved: false)
      .toList();

  if (annotations.isEmpty) {
    return null;
  }

  return valueForAnnotation(new ConstantReader(annotations.single));
}

MethodElement _toJsonMethod(DartType type) => typeImplementations(type)
    .map((dt) => dt is InterfaceType ? dt.getMethod('toJson') : null)
    .firstWhere((me) => me != null, orElse: () => null);
