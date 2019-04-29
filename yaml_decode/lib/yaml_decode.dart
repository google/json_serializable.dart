// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

/// Returns a [ParsedYamlException] for the provided [exception].
ParsedYamlException parsedYamlExceptionFromCheckedFromJsonException(
  CheckedFromJsonException exception, {
  YamlMap exceptionMap,
  StackTrace stack,
}) {
  final yamlMap = exceptionMap ?? exception.map as YamlMap;

  YamlNode _getYamlKey(String key) =>
      yamlMap.nodes.keys.singleWhere((k) => (k as YamlScalar).value == key,
          orElse: () => null) as YamlScalar;

  final innerError = exception.innerError;

  if (exception.badKey) {
    final key = (innerError is UnrecognizedKeysException)
        ? innerError.unrecognizedKeys.first
        : exception.key;

    final node = _getYamlKey(key) ?? yamlMap;
    return ParsedYamlException._(
      exception.message,
      node,
      innerError: exception,
      innerStack: stack,
    );
  } else {
    final yamlValue = yamlMap.nodes[exception.key];

    if (yamlValue == null) {
      return ParsedYamlException._(
        exception.message,
        yamlMap,
        innerError: exception,
        innerStack: stack,
      );
    } else {
      var message = 'Unsupported value for "${exception.key}".';
      if (exception.message != null) {
        message = '$message ${exception.message}';
      }
      return ParsedYamlException._(
        message,
        yamlValue,
        innerError: exception,
        innerStack: stack,
      );
    }
  }
}

/// Thrown when parsing a YAML document fails.
class ParsedYamlException implements Exception {
  /// Describes the nature of the parse failure.
  final String message;

  final YamlNode yamlNode;

  /// If this exception was thrown as a result of another error,
  /// contains the source error object.
  final Object innerError;

  /// If this exception was thrown as a result of another error,
  /// contains the corresponding [StackTrace].
  final StackTrace innerStack;

  ParsedYamlException(String message, YamlNode yamlNode)
      : this._(message, yamlNode);

  ParsedYamlException._(
    this.message,
    this.yamlNode, {
    this.innerError,
    this.innerStack,
  })  : assert(message != null),
        assert(yamlNode != null);

  /// Returns [message] formatted with source information provided by
  /// [yamlNode].
  String get formattedMessage => yamlNode.span.message(message);

  @override
  String toString() => message;
}
