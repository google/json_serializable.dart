// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;

import 'type_helpers/config_types.dart';

/// Context information provided in calls to [TypeHelper.serialize] and
/// [TypeHelper.deserialize].
abstract class TypeHelperContext {
  /// The annotated class that code is being generated for.
  ClassElement get classElement;

  /// The field that code is being generated for.
  FieldElement get fieldElement;

  /// [expression] may be just the name of the field or it may an expression
  /// representing the serialization of a value.
  Expression? serialize(DartType fieldType, Expression expression);

  /// [expression] may be just the name of the field or it may an expression
  /// representing the serialization of a value.
  Expression? deserialize(DartType fieldType, Expression expression);

  /// Adds [memberContent] to the set of generated, top-level members.
  void addMember(String memberContent);
}

/// Extended context information with includes configuration values
/// corresponding to `JsonSerializableGenerator` settings.
abstract class TypeHelperContextWithConfig extends TypeHelperContext {
  ClassConfig get config;
}

abstract class TypeHelper<T extends TypeHelperContext> {
  const TypeHelper();

  /// Returns Dart code that serializes an [expression] representing a Dart
  /// object of type [targetType].
  ///
  /// If [targetType] is not supported, returns `null`.
  ///
  /// Let's say you want to serialize a class `Foo` as just its `id` property
  /// of type `int`.
  ///
  /// Treating [expression] as an opaque Dart expression, the [serialize]
  /// implementation could be as simple as:
  ///
  /// ```dart
  /// Expression? serialize(
  ///   DartType targetType,
  ///   Expression expression,
  ///   T context,
  /// ) => expression.property('id');
  /// ```
  Expression? serialize(DartType targetType, Expression expression, T context);

  /// Returns Dart code that deserializes an [expression] representing a JSON
  /// literal into [targetType].
  ///
  /// If [targetType] is not supported, returns `null`.
  ///
  /// Let's say you want to deserialize a class `Foo` by taking an `int` stored
  /// in a JSON literal and calling the `Foo.fromInt` constructor.
  ///
  /// Treating [expression] as an opaque Dart expression representing a JSON
  /// literal, the [deserialize] implementation could be as simple as:
  ///
  /// ```dart
  /// Expression? deserialize(
  ///   DartType targetType,
  ///   Expression expression,
  ///   T context,
  ///   bool defaultProvided,
  /// ) => refer('Foo').newInstanceNamed('fromInt', [expression]);
  /// ```
  ///
  /// Note that [targetType] is not used here. If you wanted to support many
  /// types of [targetType] you could write:
  ///
  /// ```dart
  /// Expression? deserialize(
  ///   DartType targetType,
  ///   Expression expression,
  ///   T context,
  ///   bool defaultProvided,
  /// ) => refer(targetType.element!.name!)
  ///     .newInstanceNamed('fromInt', [expression]);
  /// ```
  Expression? deserialize(
    DartType targetType,
    Expression expression,
    T context,
    bool defaultProvided,
  );
}
