// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import '../json_key_utils.dart';
import '../json_literal_generator.dart';
import '../type_helper.dart';
import '../utils.dart';

final simpleExpression = RegExp('^[a-zA-Z_]+\$');

class EnumHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const EnumHelper();

  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) {
    final memberContent = enumValueMapFromType(targetType);

    if (memberContent == null) {
      return null;
    }

    context.addMember(memberContent);

    return '${_constMapName(targetType)}[$expression]';
  }

  @override
  String? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    final memberContent = enumValueMapFromType(targetType);

    if (memberContent == null) {
      return null;
    }

    String functionName;
    if (targetType.isNullableType || defaultProvided) {
      functionName = r'$enumDecodeNullable';
    } else {
      functionName = r'$enumDecode';
    }

    context.addMember(memberContent);

    final jsonKey = jsonKeyForField(context.fieldElement, context.config);
    final args = [
      _constMapName(targetType),
      expression,
      if (jsonKey.unknownEnumValue != null)
        'unknownValue: ${jsonKey.unknownEnumValue}',
    ];

    return '$functionName(${args.join(', ')})';
  }
}

String _constMapName(DartType targetType) =>
    '_\$${targetType.element!.name}EnumMap';

String? enumValueMapFromType(DartType targetType) {
  final enumMap = enumFieldsMap(targetType);

  if (enumMap == null) {
    return null;
  }

  final items = enumMap.entries
      .map((e) => '  ${targetType.element!.name}.${e.key.name}: '
          '${jsonLiteralAsDart(e.value)},')
      .join();

  return 'const ${_constMapName(targetType)} = {\n$items\n};';
}
