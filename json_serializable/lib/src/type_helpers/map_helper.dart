// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

import '../constants.dart';
import '../shared_checkers.dart';
import '../type_helper.dart';
import '../utils.dart';

const _keyParam = 'k';

const _helperFunctionDefinition = '''T $_helperName<T extends Map>(T source) =>
    (source == null || source.isEmpty) ? null : source;''';

const _helperName = r'_$nullIfEmptyMap';

class MapHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const MapHelper();

  @override
  String serialize(DartType targetType, String expression,
      TypeHelperContextWithConfig context) {
    if (!coreMapTypeChecker.isAssignableFromType(targetType)) {
      return null;
    }
    final args = typeArgumentsOf(targetType, coreMapTypeChecker);
    assert(args.length == 2);

    final keyType = args[0];
    final valueType = args[1];

    _checkSafeKeyType(expression, keyType);

    final subFieldValue = context.serialize(valueType, closureArg);
    final subKeyValue = context.serialize(keyType, _keyParam);

    final contextNullable = context.nullable || encodeEmptyAsNullRoot(context);

    if (encodeEmptyAsNullRoot(context)) {
      context.addMember(_helperFunctionDefinition);
      expression = '$_helperName($expression)';
    }

    if (closureArg == subFieldValue && _keyParam == subKeyValue) {
      return expression;
    }

    final optionalQuestion = contextNullable ? '?' : '';

    return '$expression$optionalQuestion'
        '.map(($_keyParam, $closureArg) => MapEntry($subKeyValue, $subFieldValue))';
  }

  @override
  String deserialize(DartType targetType, String expression,
      TypeHelperContextWithConfig context) {
    if (!coreMapTypeChecker.isExactlyType(targetType)) {
      return null;
    }

    final typeArgs = typeArgumentsOf(targetType, coreMapTypeChecker);
    assert(typeArgs.length == 2);
    final keyArg = typeArgs.first;
    final valueArg = typeArgs.last;

    _checkSafeKeyType(expression, keyArg);

    final valueArgIsAny = _isObjectOrDynamic(valueArg);
    final isEnumKey = isEnum(keyArg);

    if (!isEnumKey) {
      if (valueArgIsAny) {
        if (context.config.anyMap) {
          if (_isObjectOrDynamic(keyArg)) {
            return '$expression as Map';
          }
        } else {
          // this is the trivial case. Do a runtime cast to the known type of JSON
          // map values - `Map<String, dynamic>`
          return '$expression as Map<String, dynamic>';
        }
      }

      if (!context.nullable &&
          (valueArgIsAny ||
              simpleJsonTypeChecker.isAssignableFromType(valueArg))) {
        // No mapping of the values or null check required!
        return 'Map<String, $valueArg>.from($expression as Map)';
      }
    }

    // In this case, we're going to create a new Map with matching reified
    // types.

    final itemSubVal = context.deserialize(valueArg, closureArg);

    final optionalQuestion = context.nullable ? '?' : '';

    final mapCast =
        context.config.anyMap ? 'as Map' : 'as Map<String, dynamic>';

    String keyUsage;
    if (isEnumKey) {
      keyUsage = context.deserialize(keyArg, _keyParam).toString();
    } else if (context.config.anyMap && !_isObjectOrDynamic(keyArg)) {
      keyUsage = '$_keyParam as String';
    } else {
      keyUsage = _keyParam;
    }

    return '($expression $mapCast)$optionalQuestion.map('
        '($_keyParam, $closureArg) => MapEntry($keyUsage, $itemSubVal),)';
  }
}

bool _isObjectOrDynamic(DartType type) => type.isObject || type.isDynamic;

void _checkSafeKeyType(String expression, DartType keyArg) {
  // We're not going to handle converting key types at the moment
  // So the only safe types for key are dynamic/Object/String/enum
  final safeKey = _isObjectOrDynamic(keyArg) ||
      coreStringTypeChecker.isExactlyType(keyArg) ||
      isEnum(keyArg);

  if (!safeKey) {
    throw UnsupportedTypeError(keyArg, expression,
        'Map keys must be of type `String`, enum, `Object` or `dynamic`.');
  }
}
