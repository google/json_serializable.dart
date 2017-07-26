// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

import 'json_literal.dart';

class JsonLiteralGenerator extends GeneratorForAnnotation<JsonLiteral> {
  const JsonLiteralGenerator();

  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (p.isAbsolute(annotation.read('path').stringValue)) {
      throw new ArgumentError(
          '`annotation.path` must be relative path to the source file.');
    }

    var sourcePathDir = p.dirname(buildStep.inputId.path);
    var fileId = new AssetId(buildStep.inputId.package,
        p.join(sourcePathDir, annotation.read('path').stringValue));
    var content = JSON.decode(await buildStep.readAsString(fileId));

    var thing = JSON.encode(content);

    var marked = _isConstType(content) ? 'const' : 'final';

    return '$marked _\$${element.displayName}JsonLiteral = $thing;';
  }
}

bool _isConstType(value) {
  return value == null || value is String || value is num || value is bool;
}
