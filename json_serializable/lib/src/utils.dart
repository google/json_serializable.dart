// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart' show alwaysThrows;
import 'package:source_gen/source_gen.dart';

@alwaysThrows
void throwUnsupported(FieldElement element, String message) =>
    throw new InvalidGenerationSourceError(
        'Error with `@JsonKey` on `${element.name}`. $message',
        element: element);

JsonSerializable valueForAnnotation(ConstantReader annotation) =>
    new JsonSerializable(
        disallowUnrecognizedKeys:
            annotation.read('disallowUnrecognizedKeys').boolValue,
        createToJson: annotation.read('createToJson').boolValue,
        createFactory: annotation.read('createFactory').boolValue,
        nullable: annotation.read('nullable').boolValue,
        includeIfNull: annotation.read('includeIfNull').boolValue);

bool isEnum(DartType targetType) =>
    targetType is InterfaceType && targetType.element.isEnum;

/// Returns a quoted String literal for [value] that can be used in generated
/// Dart code.
String escapeDartString(String value) {
  var hasSingleQuote = false;
  var hasDoubleQuote = false;
  var hasDollar = false;
  var canBeRaw = true;

  value = value.replaceAllMapped(_escapeRegExp, (match) {
    var value = match[0];
    if (value == "'") {
      hasSingleQuote = true;
      return value;
    } else if (value == '"') {
      hasDoubleQuote = true;
      return value;
    } else if (value == r'$') {
      hasDollar = true;
      return value;
    }

    canBeRaw = false;
    return _escapeMap[value] ?? _getHexLiteral(value);
  });

  if (!hasDollar) {
    if (hasSingleQuote) {
      if (!hasDoubleQuote) {
        return '"$value"';
      }
      // something
    } else {
      // trivial!
      return "'$value'";
    }
  }

  if (hasDollar && canBeRaw) {
    if (hasSingleQuote) {
      if (!hasDoubleQuote) {
        // quote it with single quotes!
        return 'r"$value"';
      }
    } else {
      // quote it with single quotes!
      return "r'$value'";
    }
  }

  // The only safe way to wrap the content is to escape all of the
  // problematic characters - `$`, `'`, and `"`
  var string = value.replaceAll(_dollarQuoteRegexp, r'\');
  return "'$string'";
}

final _dollarQuoteRegexp = new RegExp(r"""(?=[$'"])""");

/// A [Map] between whitespace characters & `\` and their escape sequences.
const _escapeMap = const {
  '\b': r'\b', // 08 - backspace
  '\t': r'\t', // 09 - tab
  '\n': r'\n', // 0A - new line
  '\v': r'\v', // 0B - vertical tab
  '\f': r'\f', // 0C - form feed
  '\r': r'\r', // 0D - carriage return
  '\x7F': r'\x7F', // delete
  r'\': r'\\' // backslash
};

final _escapeMapRegexp = _escapeMap.keys.map(_getHexLiteral).join();

/// A [RegExp] that matches whitespace characters that should be escaped and
/// single-quote, double-quote, and `$`
final _escapeRegExp =
    new RegExp('[\$\'"\\x00-\\x07\\x0E-\\x1F$_escapeMapRegexp]');

/// Given single-character string, return the hex-escaped equivalent.
String _getHexLiteral(String input) {
  var rune = input.runes.single;
  var value = rune.toRadixString(16).toUpperCase().padLeft(2, '0');
  return '\\x$value';
}
