// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'enum_utils.dart';
import 'settings.dart';

class JsonEnumGenerator extends GeneratorForAnnotation<JsonEnum> {
  JsonEnumGenerator(this._settings) : super(inPackage: 'json_annotation');

  final Settings _settings;

  @override
  List<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! EnumElement) {
      throw InvalidGenerationSourceError(
        '`@JsonEnum` can only be used on enum elements.',
        element: element,
      );
    }

    final value = enumValueMapFromType(
      element.thisType,
      nullWithNoAnnotation: true,
      defaultEnumFieldRename: _settings.config.enumFieldRename,
    );

    return [?value];
  }
}
