import 'package:analyzer/dart/element/element.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'json_key_with_conversion.dart';
import 'json_serializable_generator.dart';
import 'type_helper.dart';
import 'type_helper_context.dart';
import 'utils.dart';

abstract class HelperCore {
  final ClassElement element;
  final JsonSerializable annotation;
  final JsonSerializableGenerator generator;

  HelperCore(this.generator, this.element, this.annotation);

  String get targetClassReference =>
      '${element.name}${genericClassArgumentsImpl(false)}';

  String nameAccess(FieldElement field) => jsonKeyFor(field).name ?? field.name;

  String safeNameAccess(FieldElement field) =>
      escapeDartString(nameAccess(field));

  String get prefix => '_\$${element.name}';

  /// Returns a [String] representing the type arguments that exist on
  /// [element].
  ///
  /// Returns the output of calling [genericClassArguments] with [element].
  String genericClassArgumentsImpl(bool withConstraints) =>
      genericClassArguments(element, withConstraints);

  JsonKeyWithConversion jsonKeyFor(FieldElement field) =>
      new JsonKeyWithConversion(field, annotation);

  TypeHelperContext getHelperContext(FieldElement field) =>
      new TypeHelperContext(generator, field.metadata, jsonKeyFor(field));
}

InvalidGenerationSourceError createInvalidGenerationError(
    String targetMember, FieldElement field, UnsupportedTypeError e) {
  var extra = (field.type != e.type) ? ' because of type `${e.type}`' : '';

  var message = 'Could not generate `$targetMember` code for '
      '`${field.name}`$extra.\n${e.reason}';

  return new InvalidGenerationSourceError(message,
      todo: 'Make sure all of the types are serializable.', element: field);
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
  var values = element.typeParameters
      .map((t) => withConstraints ? t.toString() : t.name)
      .join(', ');
  return '<$values>';
}
