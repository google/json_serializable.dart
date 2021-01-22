// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';

import 'helper_core.dart';

abstract class EqualHelper implements HelperCore {
  String _fieldInstanceAccess(FieldElement field) => '$_instance.${field.name}';
  String _fieldOtherAccess(FieldElement field) => '$_other.${field.name}';

  Iterable<String> createEqual(Set<FieldElement> accessibleFields) sync* {
    assert(config.createEqual);

    final buffer = StringBuffer();

    final functionName = '${prefix}IsEqual${genericClassArgumentsImpl(true)}';
    buffer.write('bool '
        '$functionName($targetClassReference $_instance, dynamic $_other');

    buffer.write(') {\n');

    _writeOperatorToJsonSimple(buffer, accessibleFields);

    _writeHashCodeToJson(buffer, accessibleFields);

    yield buffer.toString();
  }

  void _writeOperatorToJsonSimple(
      StringBuffer buffer, Iterable<FieldElement> fields) {
    buffer
      ..write('return other is $targetClassReference')
      ..writeAll(fields.map((field) {
        final value = '${ _fieldInstanceAccess(field)} == ${_fieldOtherAccess(field)}';
        return '        && $value\n';
      }))
      ..write(';')
      ..writeln('}');
  }

  void _writeHashCodeToJson(StringBuffer buffer, Iterable<FieldElement> fields) {
    buffer
      ..write('int ${prefix}HashCode($targetClassReference $_instance) => hashList(<Object?>[')
      ..writeAll(fields.map((field) {
        return '        ${_fieldInstanceAccess(field)},\n';
      }))
      ..writeln(']);');
  }

  static const _instance = 'instance';
  static const _other = 'other';
}
