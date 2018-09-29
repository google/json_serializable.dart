// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';

import '../json_literal_generator.dart';
import '../type_helper.dart';
import '../utils.dart';

final simpleExpression = RegExp('^[a-zA-Z_]+\$');

class EnumHelper extends TypeHelper {
  const EnumHelper();

  @override
  String serialize(
      DartType targetType, String expression, TypeHelperContext context) {
    final memberContent = _enumValueMapFromType(targetType);

    if (memberContent == null) {
      return null;
    }

    context.addMember(memberContent);

    return '${_constMapName(targetType)}[$expression]';
  }

  @override
  String deserialize(
      DartType targetType, String expression, TypeHelperContext context) {
    final memberContent = _enumValueMapFromType(targetType);

    if (memberContent == null) {
      return null;
    }

    context.addMember(_enumDecodeHelper);

    if (context.nullable) {
      context.addMember(_enumDecodeHelperNullable);
    }

    context.addMember(memberContent);

    final functionName =
        context.nullable ? r'_$enumDecodeNullable' : r'_$enumDecode';
    return '$functionName(${_constMapName(targetType)}, '
        '$expression)';
  }
}

String _constMapName(DartType targetType) => '_\$${targetType.name}EnumMap';

String _enumValueMapFromType(DartType targetType) {
  final enumMap = enumFieldsMap(targetType);

  if (enumMap == null) {
    return null;
  }

  final items =
      enumMap.entries.map((e) => '  ${targetType.name}.${e.key.name}: '
          '${jsonLiteralAsDart(e.value)}');

  return 'const ${_constMapName(targetType)} = '
      '<${targetType.name}, dynamic>{\n${items.join(',\n')}\n};';
}

const _enumDecodeHelper = r'''
T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}''';

const _enumDecodeHelperNullable = r'''
T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}''';
