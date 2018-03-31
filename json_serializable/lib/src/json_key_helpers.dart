// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

final _jsonKeyExpando = new Expando<JsonKey>();

final _jsonKeyChecker = const TypeChecker.fromRuntime(JsonKey);

JsonKey jsonKeyFor(FieldElement element) {
  var key = _jsonKeyExpando[element];

  if (key == null) {
    // If an annotation exists on `element` the source is a 'real' field.
    // If the result is `null`, check the getter – it is a property.
    // TODO(kevmoo) setters: github.com/dart-lang/json_serializable/issues/24
    var obj = _jsonKeyChecker.firstAnnotationOfExact(element) ??
        _jsonKeyChecker.firstAnnotationOfExact(element.getter);

    _jsonKeyExpando[element] = key = obj == null
        ? const JsonKey()
        : new JsonKey(
            name: obj.getField('name').toStringValue(),
            nullable: obj.getField('nullable').toBoolValue(),
            includeIfNull: obj.getField('includeIfNull').toBoolValue(),
            ignore: obj.getField('ignore').toBoolValue());
  }

  return key;
}
