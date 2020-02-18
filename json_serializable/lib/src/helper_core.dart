// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'json_key_utils.dart';
import 'type_helper.dart';
import 'type_helper_ctx.dart';
import 'unsupported_type_error.dart';
import 'utils.dart';

abstract class HelperCore {
  final ClassElement element;
  final JsonSerializable config;

  HelperCore(this.element, this.config);

  Iterable<TypeHelper> get allTypeHelpers;

  void addMember(String memberContent);

  @protected
  String get targetClassReference =>
      '${element.name}${genericClassArgumentsImpl(false)}';

  @protected
  String nameAccess(FieldElement field) => jsonKeyFor(field).name;

  @protected
  String safeNameAccess(FieldElement field) =>
      escapeDartString(nameAccess(field));

  @protected
  String get prefix => '_\$${element.name}';

  /// Returns a [String] representing the type arguments that exist on
  /// [element].
  ///
  /// Returns the output of calling [genericClassArguments] with [element].
  @protected
  String genericClassArgumentsImpl(bool withConstraints) =>
      genericClassArguments(element, withConstraints);

  @protected
  JsonKey jsonKeyFor(FieldElement field) => jsonKeyForField(field, config);

  @protected
  TypeHelperCtx getHelperContext(FieldElement field) =>
      typeHelperContext(this, field, jsonKeyFor(field));
}

InvalidGenerationSourceError createInvalidGenerationError(
    String targetMember, FieldElement field, UnsupportedTypeError e) {
  var message = 'Could not generate `$targetMember` code for `${field.name}`';
  if (field.type != e.type) {
    message = '$message because of type `${typeToCode(e.type)}`';
  }
  message = '$message.\n${e.reason}';

  return InvalidGenerationSourceError(
    message,
    todo: 'Make sure all of the types are serializable.',
    element: field,
  );
}

/// Returns a [String] representing the type arguments that exist on
/// [element].
///
/// If [withConstraints] is `null` or if [element] has no type arguments, an
/// empty [String] is returned.
///
/// If [withConstraints] is true, any type constraints that exist on [element]
/// are included.
///
/// For example, for class `class Sample<T as num, S>{...}`
///
/// For [withConstraints] = `false`:
///
/// ```
/// "<T, S>"
/// ```
///
/// For [withConstraints] = `true`:
///
/// ```
/// "<T as num, S>"
/// ```
String genericClassArguments(ClassElement element, bool withConstraints) {
  if (withConstraints == null || element.typeParameters.isEmpty) {
    return '';
  }
  final values = element.typeParameters.map((t) {
    if (withConstraints && t.bound != null) {
      final boundCode = typeToCode(t.bound);
      return '${t.name} extends $boundCode';
    } else {
      return t.name;
    }
  }).join(', ');
  return '<$values>';
}

/// Return the Dart code presentation for the given [type].
///
/// This function is intentionally limited, and does not support all possible
/// types and locations of these files in code. Specifically, it supports
/// only [InterfaceType]s, with optional type arguments that are also should
/// be [InterfaceType]s.
String typeToCode(DartType type) {
  if (type.isDynamic) {
    return 'dynamic';
  } else if (type is InterfaceType) {
    final typeArguments = type.typeArguments;
    if (typeArguments.isEmpty) {
      return type.element.name;
    } else {
      final typeArgumentsCode = typeArguments.map(typeToCode).join(', ');
      return '${type.element.name}<$typeArgumentsCode>';
    }
  }
  throw UnimplementedError('(${type.runtimeType}) $type');
}
