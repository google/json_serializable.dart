// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/src/dart/element/inheritance_manager3.dart' // ignore: implementation_imports
    show InheritanceManager3;
import 'package:source_gen/source_gen.dart';

import 'utils.dart';

class _FieldSet implements Comparable<_FieldSet> {
  final FieldElement2 field;
  final FieldElement2 sortField;

  _FieldSet._(this.field, this.sortField)
    : assert(field.name3 == sortField.name3);

  factory _FieldSet(FieldElement2? classField, FieldElement2? superField) {
    // At least one of these will != null, perhaps both.
    final fields = [classField, superField].whereType<FieldElement2>().toList();

    // Prefer the class field over the inherited field when sorting.
    final sortField = fields.first;

    // Prefer the field that's annotated with `JsonKey`, if any.
    // If not, use the class field.
    final fieldHasJsonKey = fields.firstWhere(
      hasJsonKeyAnnotation,
      orElse: () => fields.first,
    );

    return _FieldSet._(fieldHasJsonKey, sortField);
  }

  @override
  int compareTo(_FieldSet other) => _sortByLocation(sortField, other.sortField);

  static int _sortByLocation(FieldElement2 a, FieldElement2 b) {
    final checkerA = TypeChecker.fromStatic(a.enclosingElement2.thisType);

    if (!checkerA.isExactly(b.enclosingElement2)) {
      // in this case, you want to prioritize the enclosingElement that is more
      // "super".

      if (checkerA.isAssignableFrom(b.enclosingElement2)) {
        return -1;
      }

      final checkerB = TypeChecker.fromStatic(b.enclosingElement2.thisType);

      if (checkerB.isAssignableFrom(a.enclosingElement2)) {
        return 1;
      }
    }

    /// Returns the offset of given field/property in its source file – with a
    /// preference for the getter if it's defined.
    int offsetFor(FieldElement2 e) {
      if (e.isSynthetic) {
        return (e.getter2 ?? e.setter2)!.firstFragment.nameOffset2!;
      }
      return e.firstFragment.nameOffset2!;
    }

    return offsetFor(a).compareTo(offsetFor(b));
  }
}

/// Returns a [List] of all instance [FieldElement2] items for [element] and
/// super classes, sorted first by their location in the inheritance hierarchy
/// (super first) and then by their location in the source file.
List<FieldElement2> createSortedFieldSet(ClassElement2 element) {
  // Get all of the fields that need to be assigned
  // TODO: support overriding the field set with an annotation option
  final elementInstanceFields = Map.fromEntries(
    element.fields2.where((e) => !e.isStatic).map((e) => MapEntry(e.name3, e)),
  );

  final inheritedFields = <String, FieldElement2>{};
  final manager = InheritanceManager3();

  for (final v in manager.getInheritedConcreteMap(element).values) {
    assert(v is! FieldElement2);
    if (_dartCoreObjectChecker.isExactly(v.enclosingElement2!)) {
      continue;
    }

    if (v is GetterElement) {
      final variable = v.variable3 as FieldElement2;
      assert(!inheritedFields.containsKey(variable.name3));
      inheritedFields[variable.name3!] = variable;
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

const _dartCoreObjectChecker = TypeChecker.fromRuntime(Object);
