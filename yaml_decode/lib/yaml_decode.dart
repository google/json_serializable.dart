// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

/// Returns a [ParsedYamlException] for the provided [exception].
///
/// This function assumes `exception.map` is of type `YamlMap` from
/// `package:yaml`. If not, you may provide an alternative via [exceptionMap].
ParsedYamlException toParsedYamlException(
  CheckedFromJsonException exception, {
  YamlMap exceptionMap,
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
    return ParsedYamlException(
      exception.message,
      node,
      innerError: exception,
    );
  } else {
    final yamlValue = yamlMap.nodes[exception.key];

    if (yamlValue == null) {
      // TODO(kevmoo): test this case!
      return ParsedYamlException(
        exception.message,
        yamlMap,
        innerError: exception,
      );
    } else {
      var message = 'Unsupported value for "${exception.key}".';
      if (exception.message != null) {
        message = '$message ${exception.message}';
      }
      return ParsedYamlException(
        message,
        yamlValue,
        innerError: exception,
      );
    }
  }
}

/// An exception thrown when parsing YAML that contains information about the
/// location in the source where the exception occurred.
class ParsedYamlException implements Exception {
  /// Describes the nature of the parse failure.
  final String message;

  /// The node associated with this exception.
  final YamlNode yamlNode;

  /// If this exception was thrown as a result of another error,
  /// contains the source error object.
  final Object innerError;

  ParsedYamlException(
    this.message,
    this.yamlNode, {
    this.innerError,
  })  : assert(message != null),
        assert(yamlNode != null);

  /// Returns [message] formatted with source information provided by
  /// [yamlNode].
  String get formattedMessage => yamlNode.span.message(message);

  @override
  String toString() => 'ParsedYamlException: $formattedMessage';
}
