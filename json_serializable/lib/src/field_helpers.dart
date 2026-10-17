// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/element/inheritance_manager3.dart' // ignore: implementation_imports
    show InheritanceManager3;
import 'package:source_gen/source_gen.dart';

import 'utils.dart';

const _objectGetterNames = {'hashCode', 'runtimeType'};

bool _isUnannotatedObjectGetter(FieldElement element) =>
    _objectGetterNames.contains(element.name) && !hasJsonKeyAnnotation(element);

class _MergedFieldElement implements FieldElement {
  final FieldElement _classField;
  final FieldElement _superField;
  final FieldElement _annotationField;

  _MergedFieldElement(
    this._classField,
    this._superField,
    this._annotationField,
  );

  FieldElement get _primary =>
      _classField.getter != null ? _classField : _superField;

  @override
  DartType get type => _primary.type;

  @override
  GetterElement? get getter =>
      _annotationField.getter ?? _classField.getter ?? _superField.getter;

  @override
  SetterElement? get setter => _classField.setter ?? _superField.setter;

  @override
  Metadata get metadata => _annotationField.metadata;

  @override
  String? get documentationComment =>
      _classField.documentationComment ?? _superField.documentationComment;

  @override
  bool get hasInitializer =>
      _classField.hasInitializer || _superField.hasInitializer;

  @override
  String? get name => _classField.name;

  @override
  String get displayName => _classField.displayName;

  @override
  bool get isPublic => _classField.isPublic;

  @override
  bool get isPrivate => _classField.isPrivate;

  @override
  bool get isStatic => _classField.isStatic;

  @override
  bool get isFinal => _primary.isFinal;

  @override
  bool get isConst => _primary.isConst;

  @override
  bool get isLate => _primary.isLate;

  @override
  InstanceElement get enclosingElement => _classField.enclosingElement;

  @override
  LibraryElement get library => _classField.library;

  @override
  FieldFragment get firstFragment => _classField.firstFragment;

  @override
  List<FieldFragment> get fragments => _classField.fragments;

  @override
  bool get isOriginGetterSetter => _primary.isOriginGetterSetter;

  @override
  bool get isOriginDeclaringFormalParameter =>
      _primary.isOriginDeclaringFormalParameter;

  @override
  FieldFormalParameterElement? get declaringFormalParameter =>
      _classField.declaringFormalParameter ??
      _superField.declaringFormalParameter;

  @override
  FieldElement get baseElement => _primary.baseElement;

  @override
  ElementKind get kind => _classField.kind;

  @override
  int get id => _classField.id;

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

class _FieldSet implements Comparable<_FieldSet> {
  final FieldElement field;
  final FieldElement sortField;

  _FieldSet._(this.field, this.sortField)
    : assert(field.name == sortField.name);

  factory _FieldSet(FieldElement? classField, FieldElement? superField) {
    // At least one of these will != null, perhaps both.
    final fields = [classField, superField].whereType<FieldElement>().toList();

    // Prefer the class field over the inherited field when sorting.
    final sortField = fields.first;

    // Prefer the field that's annotated with `JsonKey`, if any.
    // If not, use the class field.
    final fieldHasJsonKey = fields.firstWhere(
      hasJsonKeyAnnotation,
      orElse: () => fields.first,
    );

    if (classField != null && superField != null) {
      return _FieldSet._(
        _MergedFieldElement(classField, superField, fieldHasJsonKey),
        sortField,
      );
    }

    return _FieldSet._(fieldHasJsonKey, sortField);
  }

  @override
  int compareTo(_FieldSet other) => _sortByLocation(sortField, other.sortField);

  static int _sortByLocation(FieldElement a, FieldElement b) {
    final checkerA = TypeChecker.fromStatic(a.enclosingElement.thisType);

    if (!checkerA.isExactly(b.enclosingElement)) {
      // in this case, you want to prioritize the enclosingElement that is more
      // "super".

      if (checkerA.isAssignableFrom(b.enclosingElement)) {
        return -1;
      }

      final checkerB = TypeChecker.fromStatic(b.enclosingElement.thisType);

      if (checkerB.isAssignableFrom(a.enclosingElement)) {
        return 1;
      }
    }

    /// Returns the offset of given field/property in its source file – with a
    /// preference for the getter if it's defined.
    int offsetFor(FieldElement e) {
      if (e.isOriginGetterSetter) {
        return (e.getter ?? e.setter)!.firstFragment.nameOffset ?? 0;
      }
      if (e.isOriginDeclaringFormalParameter) {
        final offset = e.declaringFormalParameter?.firstFragment.nameOffset;
        if (offset != null) {
          return offset;
        }
      }
      return e.firstFragment.nameOffset ?? 0;
    }

    return offsetFor(a).compareTo(offsetFor(b));
  }
}

/// Returns a [List] of all instance [FieldElement] items for [element] and
/// super classes, sorted first by their location in the inheritance hierarchy
/// (super first) and then by their location in the source file.
List<FieldElement> createSortedFieldSet(ClassElement element) {
  // Get all of the fields that need to be assigned
  // TODO: support overriding the field set with an annotation option
  final elementInstanceFields = Map.fromEntries(
    element.fields
        .where((e) => !e.isStatic && !_isUnannotatedObjectGetter(e))
        .map((e) => MapEntry(e.name, e)),
  );

  final inheritedFields = <String, FieldElement>{};
  final manager = InheritanceManager3();

  for (final v in manager.getInheritedConcreteMap(element).values) {
    assert(v is! FieldElement);
    if (_dartCoreObjectChecker.isExactly(v.enclosingElement!)) {
      continue;
    }

    if (v case GetterElement(variable: final FieldElement variable)) {
      if (_isUnannotatedObjectGetter(variable)) {
        continue;
      }
      assert(!inheritedFields.containsKey(variable.name));
      inheritedFields[variable.name!] = variable;
    }
  }

  // Get the list of all fields for `element`
  final allFields = elementInstanceFields.keys.toSet().union(
    inheritedFields.keys.toSet(),
  );

  final fields =
      allFields
          .map((e) => _FieldSet(elementInstanceFields[e], inheritedFields[e]))
          .toList()
        ..sort();

  return fields.map((fs) => fs.field).toList(growable: false);
}

const _dartCoreObjectChecker = TypeChecker.fromUrl('dart:core#Object');
