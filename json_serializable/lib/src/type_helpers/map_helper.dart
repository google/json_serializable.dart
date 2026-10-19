// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
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
  Expression? serialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
  ) {
    if (!coreMapTypeChecker.isAssignableFromType(targetType)) {
      return null;
    }
    final args = targetType.typeArgumentsOf(coreMapTypeChecker)!;
    assert(args.length == 2);

    final keyType = args[0];
    final valueType = args[1];

    final exprStr = toCodeString(expression);
    _checkSafeKeyType(exprStr, keyType);

    final subFieldValue = context.serialize(valueType, refer(closureArg));
    final subFieldValueStr = toCodeString(subFieldValue);
    final customKeyConverter = const JsonConverterHelper(
      forMapKey: true,
    ).serialize(keyType, refer(keyParam), context);
    var subKeyValue =
        customKeyConverter ??
        _forType(
          keyType,
          dateTimeUtc: context.config.dateTimeUtc,
        )?.serialize(keyType, refer(keyParam), false) ??
        context.serialize(keyType, refer(keyParam));
    if (customKeyConverter == null &&
        keyType.isEnum &&
        (enumEncodedValues(keyType)?.any((v) => v is int) ?? false)) {
      subKeyValue = subKeyValue!.property('toString').call([]);
    }
    final subKeyValueStr = toCodeString(subKeyValue);

    if (closureArg == subFieldValueStr && keyParam == subKeyValueStr) {
      return expression;
    }

    final mapProperty = targetType.isNullableType
        ? expression.nullSafeProperty('map')
        : expression.property('map');

    final mapEntry = refer(
      'MapEntry',
    ).newInstance([subKeyValue!, subFieldValue!]);

    final closure = Method(
      (m) => m
        ..requiredParameters.addAll([
          Parameter((p) => p..name = keyParam),
          Parameter((p) => p..name = closureArg),
        ])
        ..lambda = true
        ..body = mapEntry.code,
    ).closure;

    return mapProperty.call([closure]);
  }

  @override
  Expression? deserialize(
    DartType targetType,
    Expression expression,
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

    final exprStr = toCodeString(expression);
    _checkSafeKeyType(exprStr, keyArg);

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
            // TODO: https://github.com/dart-lang/tools/issues/1140 - using castExpression
            // for unparenthesized argument cast.
            return castExpression(expression, 'Map$optionalQuestion');
          }
        } else {
          // this is the trivial case. Do a runtime cast to the known type of
          // JSON map values - `Map<String, dynamic>`
          // TODO: https://github.com/dart-lang/tools/issues/1140 - using castExpression
          // for unparenthesized argument cast.
          return castExpression(
            expression,
            'Map<String, dynamic>$optionalQuestion',
          );
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
        // TODO: https://github.com/dart-lang/tools/issues/1140 - using castExpression
        // for unparenthesized argument cast.
        return refer(
          'Map<$keyString, $valueString>',
        ).property('from').call([castExpression(expression, 'Map')]);
      }
    }

    // In this case, we're going to create a new Map with matching reified
    // types.

    final itemSubVal = context.deserialize(valueArg, refer(closureArg));

    final isAnyMapKey =
        context.config.anyMap ||
        keyArg.isDartCoreObject ||
        keyArg is DynamicType;

    Expression keyUsage;
    final customKeyConverter = const JsonConverterHelper(
      forMapKey: true,
    ).deserialize(keyArg, refer(keyParam), context, false);
    if (customKeyConverter != null) {
      if (!isAnyMapKey &&
          customKeyConverter is LambdaResult &&
          customKeyConverter.asContent != null &&
          coreStringTypeChecker.isExactlyType(customKeyConverter.asContent!)) {
        keyUsage = refer(customKeyConverter.lambda).call([refer(keyParam)]);
      } else {
        keyUsage = customKeyConverter;
      }
    } else if (keyArg.isEnum) {
      keyUsage = context.deserialize(keyArg, refer(keyParam))!;
    } else {
      if (context.config.anyMap &&
          !(keyArg.isDartCoreObject || keyArg is DynamicType)) {
        // TODO: https://github.com/dart-lang/tools/issues/1140 - using castExpression
        // for unparenthesized argument cast.
        keyUsage = castExpression(refer(keyParam), 'String');
      } else if (isAnyMapKey &&
          keyArg.isDartCoreObject &&
          !keyArg.isNullableType) {
        // TODO: https://github.com/dart-lang/tools/issues/1140 - using castExpression
        // for unparenthesized argument cast.
        keyUsage = castExpression(refer(keyParam), 'Object');
      } else {
        keyUsage = refer(keyParam);
      }

      final toFromString = _forType(
        keyArg,
        dateTimeUtc: context.config.dateTimeUtc,
      );
      if (toFromString != null) {
        keyUsage = toFromString.deserialize(keyArg, keyUsage, false, true)!;
      }
    }

    final mapTypeStr = isAnyMapKey ? 'Map' : 'Map<String, dynamic>';
    final castType = refer('$mapTypeStr${targetTypeIsNullable ? '?' : ''}');
    final target = expression.asA(castType);
    final mapProperty = targetTypeIsNullable
        ? target.nullSafeProperty('map')
        : target.property('map');

    final mapEntry = refer('MapEntry').newInstance([keyUsage, itemSubVal!]);

    final closure = Method(
      (m) => m
        ..requiredParameters.addAll([
          Parameter((p) => p..name = keyParam),
          Parameter((p) => p..name = closureArg),
        ])
        ..lambda = true
        ..body = mapEntry.code,
    ).closure;

    return mapProperty.call([closure]);
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
