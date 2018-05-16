// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

import '../shared_checkers.dart';
import '../type_helper.dart';
import '../type_helper_context.dart';
import '../utils.dart';

/// Name used for closure argument when generating calls to `map`.
final _closureArg = 'e';

class MapHelper extends TypeHelper {
  const MapHelper();

  @override
  String serialize(
      DartType targetType, String expression, SerializeContext context) {
    if (!coreMapTypeChecker.isAssignableFromType(targetType)) {
      return null;
    }
    var args = typeArgumentsOf(targetType, coreMapTypeChecker);
    assert(args.length == 2);

    var keyType = args[0];
    var valueType = args[1];

    _checkSafeKeyType(expression, keyType);

    var subFieldValue = context.serialize(valueType, _closureArg);

    if (_closureArg == subFieldValue) {
      return expression;
    }

    if (context.useWrappers) {
      var method = '\$wrapMap';
      if (context.nullable) {
        method = '${method}HandleNull';
      }

      return '$method<$keyType, $valueType>($expression, ($_closureArg) => $subFieldValue)';
    }

    var result = 'new Map<String, dynamic>.fromIterables('
        '$expression.keys,'
        '$expression.values.map(($_closureArg) => $subFieldValue))';

    return commonNullPrefix(context.nullable, expression, result);
  }

  @override
  String deserialize(
      DartType targetType, String expression, DeserializeContext context) {
    if (!coreMapTypeChecker.isAssignableFromType(targetType)) {
      return null;
    }

    // Just pass through if
    //    key:   dynamic, Object, String
    //    value: dynamic, Object
    var typeArgs = typeArgumentsOf(targetType, coreMapTypeChecker);
    assert(typeArgs.length == 2);
    var keyArg = typeArgs.first;
    var valueArg = typeArgs.last;

    _checkSafeKeyType(expression, keyArg);

    var valueArgIsAny = valueArg.isDynamic || valueArg.isObject;
    var isAnyMap = context is TypeHelperContext && context.anyMap;

    if (valueArgIsAny) {
      if (isAnyMap) {
        if (keyArg.isObject || keyArg.isDynamic) {
          return '$expression as Map';
        }
      } else {
        // this is the trivial case. Do a runtime cast to the known type of JSON
        // map values - `Map<String, dynamic>`
        return '$expression as Map<String, dynamic>';
      }
    }

    if (valueArgIsAny || simpleJsonTypeChecker.isAssignableFromType(valueArg)) {
      // No mapping of the values is required!

      var result = 'new Map<String, $valueArg>.from($expression as Map)';
      return commonNullPrefix(context.nullable, expression, result);
    }

    // In this case, we're going to create a new Map with matching reified
    // types.

    var itemSubVal = context.deserialize(valueArg, _closureArg);

    var keyIterable = isAnyMap
        ? '($expression as Map).keys.cast<String>()'
        : '($expression as Map<String, dynamic>).keys';

    var result = 'new Map<String, $valueArg>.fromIterables($keyIterable,'
        '($expression as Map).values.map(($_closureArg) => $itemSubVal))';

    return commonNullPrefix(context.nullable, expression, result);
  }

  void _checkSafeKeyType(String expression, DartType keyArg) {
    // We're not going to handle converting key types at the moment
    // So the only safe types for key are dynamic/Object/String
    var safeKey = keyArg.isDynamic ||
        keyArg.isObject ||
        coreStringTypeChecker.isExactlyType(keyArg);

    if (!safeKey) {
      throw new UnsupportedTypeError(keyArg, expression,
          'The type of the Map key must be `String`, `Object` or `dynamic`.');
    }
  }
}
