// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'type_helpers/enum_helper.dart';

class JsonEnumGenerator extends GeneratorForAnnotation<JsonEnum> {
  const JsonEnumGenerator();

  @override
  List<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement || !element.isEnum) {
      throw InvalidGenerationSourceError(
        '`@JsonEnum` can only be used on enum elements.',
        element: element,
      );
    }

    final jsonEnum = _fromAnnotation(annotation);

    if (!jsonEnum.alwaysCreate) {
      return const [];
    }

    return [
      enumDecodeHelper,
      enumValueMapFromType(element.thisType)!,
    ];
  }
}

JsonEnum _fromAnnotation(ConstantReader reader) => JsonEnum(
      alwaysCreate: reader.read('alwaysCreate').literalValue as bool,
    );
