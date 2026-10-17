// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/element/inheritance_manager3.dart' // ignore: implementation_imports
    show InheritanceManager3;
import 'package:source_gen/source_gen.dart';

import 'utils.dart';

const _objectGetterNames = {'hashCode', 'runtimeType'};

bool _isUnannotatedObjectGetter(FieldElement element) =>
    _objectGetterNames.contains(element.name) && !hasJsonKeyAnnotation(element);

final _fieldHierarchyExpando = Expando<List<FieldElement>>();

/// Returns [field] followed by any overridden superclass/superinterface
/// [FieldElement]s in inheritance order.
List<FieldElement> fieldHierarchyFor(FieldElement field) =>
    _fieldHierarchyExpando[field] ?? [field];

class _FieldSet implements Comparable<_FieldSet> {
  final FieldElement field;
  final FieldElement sortField;

  _FieldSet._(this.field, this.sortField)
    : assert(field.name == sortField.name);

  factory _FieldSet(FieldElement? classField, List<FieldElement> superFields) {
    // At least one of these will != null, perhaps both.
    final fields = <FieldElement>[?classField, ...superFields];

    // Prefer the class field over the inherited field when sorting.
    final sortField = fields.first;

    // Use the concrete field that provides the getter (so narrowed subclass
    // types win while setter-only subclass overrides keep the inherited
    // getter's FieldElement).
    final primaryField = fields.firstWhere(
      (f) => f.getter != null,
      orElse: () => fields.first,
    );

    if (fields.length > 1) {
      _fieldHierarchyExpando[primaryField] = fields;
    }

    return _FieldSet._(primaryField, sortField);
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

  final inheritedFields = <String, List<FieldElement>>{};
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
      inheritedFields.putIfAbsent(variable.name!, () => []).add(variable);
    }
  }

  for (final supertype in element.allSupertypes) {
    if (_dartCoreObjectChecker.isExactly(supertype.element)) {
      continue;
    }
    for (final field in supertype.element.fields) {
      if (field.isStatic || _isUnannotatedObjectGetter(field)) {
        continue;
      }
      final name = field.name;
      if (name == null) continue;
      final list = inheritedFields[name];
      if (list != null && !list.contains(field)) {
        list.add(field);
      }
    }
  }

  // Get the list of all fields for `element`
  final allFields = elementInstanceFields.keys.toSet().union(
    inheritedFields.keys.toSet(),
  );

  final fields =
      allFields
          .map(
            (e) => _FieldSet(
              elementInstanceFields[e],
              inheritedFields[e] ?? const [],
            ),
          )
          .toList()
        ..sort();

  return fields.map((fs) => fs.field).toList(growable: false);
}

const _dartCoreObjectChecker = TypeChecker.fromUrl('dart:core#Object');
