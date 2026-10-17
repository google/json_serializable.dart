// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import '../constants.dart';
import '../enum_utils.dart';
import '../lambda_result.dart';
import '../shared_checkers.dart';
import '../type_helper.dart';
import '../unsupported_type_error.dart';
import '../utils.dart';
import 'json_converter_helper.dart';
import 'to_from_string.dart';

class MapHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const MapHelper();

  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) {
    if (!coreMapTypeChecker.isAssignableFromType(targetType)) {
      return null;
    }
    final args = targetType.typeArgumentsOf(coreMapTypeChecker)!;
    assert(args.length == 2);

    final keyType = args[0];
    final valueType = args[1];

    _checkSafeKeyType(expression, keyType);

    final subFieldValue = context.serialize(valueType, closureArg);
    final customKeyConverter = const JsonConverterHelper().serialize(
      keyType,
      keyParam,
      context,
    );
    var subKeyValue =
        customKeyConverter ??
        _forType(
          keyType,
          dateTimeUtc: context.config.dateTimeUtc,
        )?.serialize(keyType, keyParam, false) ??
        context.serialize(keyType, keyParam);
    if (customKeyConverter == null &&
        keyType.isEnum &&
        (enumEncodedValues(keyType)?.any((v) => v is int) ?? false)) {
      subKeyValue = '$subKeyValue.toString()';
    }

    if (closureArg == subFieldValue && keyParam == subKeyValue) {
      return expression;
    }

    final optionalQuestion = targetType.isNullableType ? '?' : '';

    return '$expression$optionalQuestion'
        '.map(($keyParam, $closureArg) => '
        'MapEntry($subKeyValue, $subFieldValue))';
  }

  @override
  String? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    if (!coreMapTypeChecker.isExactlyType(targetType)) {
      return null;
    }

    final typeArgs = targetType.typeArgumentsOf(coreMapTypeChecker)!;
    assert(typeArgs.length == 2);
    final keyArg = typeArgs.first;
    final valueArg = typeArgs.last;

    _checkSafeKeyType(expression, keyArg);

    final valueArgIsAny =
        valueArg is DynamicType ||
        (valueArg.isDartCoreObject && valueArg.isNullableType);
    final isKeyStringable = _isKeyStringable(keyArg);

    final targetTypeIsNullable = defaultProvided || targetType.isNullableType;
    final optionalQuestion = targetTypeIsNullable ? '?' : '';

    if (!isKeyStringable) {
      if (valueArgIsAny) {
        if (context.config.anyMap) {
          if (keyArg.isLikeDynamic) {
            return '$expression as Map$optionalQuestion';
          }
        } else {
          // this is the trivial case. Do a runtime cast to the known type of
          // JSON map values - `Map<String, dynamic>`
          return '$expression as Map<String, dynamic>$optionalQuestion';
        }
      }

      if (!targetTypeIsNullable &&
          (valueArgIsAny ||
              // explicitly exclude double since we need to do an explicit
              // `toDouble` on input values
              valueArg.isSimpleJsonTypeNotDouble)) {
        // No mapping of the values or null check required!
        final keyString =
            context.config.anyMap &&
                (keyArg.isDartCoreObject || keyArg is DynamicType)
            ? typeToCode(keyArg)
            : 'String';
        final valueString = typeToCode(valueArg);
        return 'Map<$keyString, $valueString>.from($expression as Map)';
      }
    }

    // In this case, we're going to create a new Map with matching reified
    // types.

    final itemSubVal = context.deserialize(valueArg, closureArg);

    final isAnyMapKey =
        context.config.anyMap ||
        keyArg.isDartCoreObject ||
        keyArg is DynamicType;
    var mapCast = isAnyMapKey ? 'as Map' : 'as Map<String, dynamic>';

    if (targetTypeIsNullable) {
      mapCast += '?';
    }

    String keyUsage;
    final customKeyConverter = const JsonConverterHelper().deserialize(
      keyArg,
      keyParam,
      context,
      false,
    );
    if (customKeyConverter != null) {
      if (!isAnyMapKey &&
          customKeyConverter is LambdaResult &&
          customKeyConverter.asContent != null &&
          coreStringTypeChecker.isExactlyType(customKeyConverter.asContent!)) {
        keyUsage = '${customKeyConverter.lambda}($keyParam)';
      } else {
        keyUsage = customKeyConverter.toString();
      }
    } else if (keyArg.isEnum) {
      keyUsage = context.deserialize(keyArg, keyParam).toString();
    } else {
      if (context.config.anyMap &&
          !(keyArg.isDartCoreObject || keyArg is DynamicType)) {
        keyUsage = '$keyParam as String';
      } else if (isAnyMapKey &&
          keyArg.isDartCoreObject &&
          !keyArg.isNullableType) {
        keyUsage = '$keyParam as Object';
      } else {
        keyUsage = keyParam;
      }

      final toFromString = _forType(
        keyArg,
        dateTimeUtc: context.config.dateTimeUtc,
      );
      if (toFromString != null) {
        keyUsage = toFromString
            .deserialize(keyArg, keyUsage, false, true)
            .toString();
      }
    }

    return '($expression $mapCast)$optionalQuestion.map( '
        '($keyParam, $closureArg) => MapEntry($keyUsage, $itemSubVal),)';
  }
}

final _intString = ToFromStringHelper('int.parse', 'toString()', 'int');

/// [ToFromStringHelper] instances representing non-String types that can
/// be used as [Map] keys.
final _instances = [bigIntString, dateTimeString, _intString, uriString];

ToFromStringHelper? _forType(DartType type, {bool dateTimeUtc = false}) {
  if (dateTimeUtc && dateTimeUtcString.matches(type)) {
    return dateTimeUtcString;
  }
  return _instances.where((i) => i.matches(type)).singleOrNull;
}

/// Returns `true` if [keyType] can be automatically converted to/from String –
/// and is therefor usable as a key in a [Map].
bool _isKeyStringable(DartType keyType) =>
    keyType.isEnum || _instances.any((inst) => inst.matches(keyType));

void _checkSafeKeyType(String expression, DartType keyArg) {
  // We're not going to handle converting key types at the moment
  // So the only safe types for key are dynamic/Object/String/enum
  if (keyArg is DynamicType ||
      (!keyArg.isNullableType &&
          (keyArg.isDartCoreObject ||
              coreStringTypeChecker.isExactlyType(keyArg) ||
              _isKeyStringable(keyArg)))) {
    return;
  }

  throw UnsupportedTypeError(
    keyArg,
    expression,
    'Map keys must be one of: ${allowedMapKeyTypes.join(', ')}.',
  );
}

/// The names of types that can be used as [Map] keys.
///
/// Used in [_checkSafeKeyType] to provide a helpful error with unsupported
/// types.
List<String> get allowedMapKeyTypes => [
  'Object',
  'dynamic',
  'enum',
  'String',
  ..._instances.map((i) => i.coreTypeName),
];

extension on DartType {
  bool get isSimpleJsonTypeNotDouble =>
      !isDartCoreDouble && simpleJsonTypeChecker.isAssignableFromType(this);
}
