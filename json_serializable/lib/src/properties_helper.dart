// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';

import 'helper_core.dart';

abstract class PropertiesHelper implements HelperCore {
  Iterable<String> createFields(Set<FieldElement> accessibleFields) sync* {
    final buffer = StringBuffer();

    final functionName = '${prefix}Fields';
    buffer
      ..writeln('class $functionName {')
      ..writeln('  const $functionName();');

    _writeFields(buffer, accessibleFields);

    yield buffer.toString();
  }

  void _writeFields(StringBuffer buffer, Iterable<FieldElement> fields) {
    buffer
      ..writeAll(fields.map((field) {
        final value = 'final String ${field.name} = ${safeNameAccess(field)};';
        return '  $value\n';
      }))
      ..writeln('}');
  }
}
