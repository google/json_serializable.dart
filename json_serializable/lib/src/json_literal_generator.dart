// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

import 'package:json_annotation/json_annotation.dart';

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

    var asConst = annotation.read('asConst').boolValue;

    var thing = _jsonLiteralAsDart(content, asConst).toString();
    var marked = asConst ? 'const' : 'final';

    return '$marked _\$${element.displayName}JsonLiteral = $thing;';
  }
}

/// Returns a [String] representing a valid Dart literal for [value].
///
/// If [asConst] is `true`, the returned [String] is encoded as a `const`
/// literal.
String _jsonLiteralAsDart(dynamic value, bool asConst) {
  if (value == null) return 'null';

  if (value is String) return _jsonStringAsDart(value);

  if (value is bool || value is num) return value.toString();

  if (value is List) {
    var listItems =
        value.map((v) => _jsonLiteralAsDart(v, asConst)).join(',\n');
    return '${asConst ? 'const' : ''}[$listItems]';
  }

  if (value is Map<String, dynamic>) return _jsonMapAsDart(value, asConst);

  throw new StateError(
      'Should never get here – with ${value.runtimeType} - `$value`.');
}

String _jsonMapAsDart(Map<String, dynamic> value, bool asConst) {
  var buffer = new StringBuffer();
  if (asConst) {
    buffer.write('const ');
  }
  buffer.write('{');

  var first = true;
  value.forEach((k, v) {
    if (first) {
      first = false;
    } else {
      buffer.writeln(',');
    }
    buffer.write(_jsonStringAsDart(k));
    buffer.write(':');
    buffer.write(_jsonLiteralAsDart(v, asConst));
  });

  buffer.write('}');

  return buffer.toString();
}

String _jsonStringAsDart(String value) {
  var containsSingleQuote = value.contains("'");
  var contains$ = value.contains(r'$');

  if (containsSingleQuote) {
    if (value.contains('"')) {
      // `value` contains both single and double quotes as well as `$`.
      // The only safe way to wrap the content is to escape all of the
      // problematic characters.
      var string = value
          .replaceAll('\$', '\\\$')
          .replaceAll('"', '\\"')
          .replaceAll("'", "\\'");
      return "'$string'";
    } else if (contains$) {
      // `value` contains "'" and "$", but not '"'.
      // Safely wrap it in a raw string within double-quotes.
      return 'r"$value"';
    }
    return '"$value"';
  } else if (contains$) {
    // `value` contains "$", but no "'"
    // wrap it in a raw string using single quotes
    return "r'$value'";
  }

  // `value` contains no problematic characters - except for '"' maybe.
  // Wrap it in standard single-quotes.
  return "'$value'";
}
