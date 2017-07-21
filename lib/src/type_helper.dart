// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:source_gen/source_gen.dart' show TypeChecker;

abstract class TypeHelper {
  const TypeHelper();

  /// Returns `true` if this can serialize a value of type [targetType] into a
  /// JSON literal.
  bool canSerialize(DartType targetType);

  /// Returns `true` if this can deserialize a JSON literal into a value of
  /// type [targetType].
  bool canDeserialize(DartType targetType);

  /// Returns Dart code that serializes an [expression] representing a Dart
  /// object of type [targetType].
  ///
  /// Let's say you want to serialize a class `Foo` as just its `id` property
  /// of type `int`.
  ///
  /// Treating [expression] as a opaque Dart expression, the [serialize]
  /// implementation could be a simple as:
  ///
  /// ```dart
  /// String serialize(DartType targetType, String expression) =>
  ///   "$expression.id";
  /// ```.
  String serialize(DartType targetType, String expression);

  /// Returns Dart code that deserializes an [expression] representing a JSON
  /// literal to into [targetType].
  ///
  /// Let's say you want to deserialize a class `Foo` by taking an `int` stored
  /// in a JSON literal and calling the `Foo.fromInt` constructor.
  ///
  /// Treating [expression] as a opaque Dart expression representing a JSON
  /// literal, the [deserialize] implementation could be a simple as:
  ///
  /// ```dart
  /// String deserialize(DartType targetType, String expression) =>
  ///   "new Foo.fromInt($expression)";
  /// ```.
  ///
  /// Note that [targetType] is not used here. If you wanted to support many
  /// types of [targetType] you could write:
  ///
  /// ```dart
  /// String deserialize(DartType targetType, String expression) =>
  ///   "new ${targetType.name}.fromInt($expression)";
  /// ```.
  String deserialize(DartType targetType, String expression);
}

class JsonHelper extends TypeHelper {
  const JsonHelper();

  //TODO(kevmoo): This should be checking for toJson method, but toJson might be
  //   gone during generation, so we'll have to check for the annotation, too!
  // In the mean time, just assume the `canSerialize` logic will work most of
  //   the time.
  @override
  bool canSerialize(DartType type) => canDeserialize(type);

  @override
  bool canDeserialize(DartType type) {
    if (type is! InterfaceType) return false;

    var classElement = type.element as ClassElement;

    for (var ctor in classElement.constructors) {
      if (ctor.name == 'fromJson') {
        // TODO: validate that there are the right number and type of arguments
        return true;
      }
    }

    return false;
  }

  /// Simply returns the [name] provided.
  ///
  /// By default, JSON encoding in from `dart:convert` calls `toJson` on
  /// provided objects.
  @override
  String serialize(DartType targetType, String name) => name;

  @override
  String deserialize(DartType targetType, String expression) {
    // TODO: the type could be imported from a library with a prefix!
    // github.com/dart-lang/json_serializable/issues/19
    return "new ${targetType.name}.fromJson($expression as Map<String, dynamic>)";
  }
}

class DateTimeHelper extends TypeHelper {
  const DateTimeHelper();

  @override
  bool canSerialize(DartType type) => _matchesType(type);

  @override
  bool canDeserialize(DartType type) => _matchesType(type);

  bool _matchesType(DartType type) =>
      const TypeChecker.fromUrl('dart:core#DateTime').isExactlyType(type);

  @override
  String serialize(DartType targetType, String name) =>
      "$name?.toIso8601String()";

  @override
  String deserialize(DartType targetType, String expression) =>
      // TODO(kevmoo) `String` here is ignoring
      // github.com/dart-lang/json_serializable/issues/19
      "DateTime.parse($expression as String)";
}
