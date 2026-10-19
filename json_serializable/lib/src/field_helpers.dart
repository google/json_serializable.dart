// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

const _objectGetterNames = {'hashCode', 'runtimeType'};

class _FieldSet implements Comparable<_FieldSet> {
  final FieldElement field;
  final FieldElement sortField;

  _FieldSet._(this.field, this.sortField)
    : assert(field.name == sortField.name);

  /// [chain] is a non-empty override chain as produced by [_overrideChains].
  factory _FieldSet(List<FieldElement> chain) {
    // Prefer the class field over the inherited field when sorting.
    final sortField = chain.first;

    // Use the concrete field that provides the getter (so narrowed subclass
    // types win while setter-only subclass overrides keep the inherited
    // getter's FieldElement).
    final primaryField = chain.firstWhere(
      (f) => f.getter != null,
      orElse: () => chain.first,
    );

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
///
/// Overrides of `hashCode` and `runtimeType` are dropped unless
/// [keepObjectMemberOverride] returns `true` for them.
List<FieldElement> createSortedFieldSet(
  ClassElement element, {
  required bool Function(FieldElement objectMemberOverride)
  keepObjectMemberOverride,
}) {
  final fields = _overrideChains(
    element,
    keepObjectMemberOverride: keepObjectMemberOverride,
  ).values.map(_FieldSet.new).toList()..sort();

  return fields.map((fs) => fs.field).toList(growable: false);
}

/// Returns `[field, ...overridden super fields]` for the member named
/// [field].name in [element], in inheritance order: the declaration in
/// [element] (if any) first, then overridden superclass/superinterface
/// declarations.
///
/// A pure function of the element model. Returns `[field]` when [field] is
/// not a member of [element]'s hierarchy.
List<FieldElement> fieldOverrideChain(
  ClassElement element,
  FieldElement field,
) {
  final chain = _overrideChains(
    element,
    keepObjectMemberOverride: (_) => true,
  )[field.name];
  if (chain == null || !chain.contains(field)) {
    return [field];
  }
  return chain;
}

/// Maps each instance member name of [element] to its override chain:
/// the field declared on [element] (if any) followed by the overridden
/// superclass/superinterface fields in inheritance order.
Map<String?, List<FieldElement>> _overrideChains(
  ClassElement element, {
  required bool Function(FieldElement) keepObjectMemberOverride,
}) {
  bool isUnannotatedObjectGetter(FieldElement e) =>
      _objectGetterNames.contains(e.name) && !keepObjectMemberOverride(e);

  // Get all of the fields that need to be assigned
  // TODO: support overriding the field set with an annotation option
  final elementInstanceFields = Map.fromEntries(
    element.fields
        .where((e) => !e.isStatic && !isUnannotatedObjectGetter(e))
        .map((e) => MapEntry(e.name, e)),
  );

  final inheritedFields = <String, List<FieldElement>>{};

  for (final v in element.inheritedConcreteMembers.values) {
    assert(v is! FieldElement);
    if (_dartCoreObjectChecker.isExactly(v.enclosingElement!)) {
      continue;
    }

    if (v case GetterElement(variable: final FieldElement variable)) {
      if (isUnannotatedObjectGetter(variable)) {
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
      if (field.isStatic || isUnannotatedObjectGetter(field)) {
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

  return {
    for (final name in allFields)
      // At least one of these will be non-null, perhaps both.
      name: <FieldElement>[
        ?elementInstanceFields[name],
        ...?inheritedFields[name],
      ],
  };
}

const _dartCoreObjectChecker = TypeChecker.typeNamed(
  Object,
  inPackage: 'core',
  inSdk: true,
);

// -----------------------------------------------------------------------------
// json_serializable-internal shim.
//
// `_jsonKeyAnnotation` (utils.dart) and the converter lookup
// (type_helpers/json_converter_helper.dart) receive only a [FieldElement] and
// have no class in scope, so the override chain is recorded here by the
// callers of [createSortedFieldSet] and looked up by field.
// -----------------------------------------------------------------------------

final _fieldHierarchyExpando = Expando<List<FieldElement>>();

/// Returns [field] followed by any overridden superclass/superinterface
/// [FieldElement]s in inheritance order, as recorded by
/// [recordFieldOverrideChains]; `[field]` if nothing was recorded.
List<FieldElement> fieldHierarchyFor(FieldElement field) =>
    _fieldHierarchyExpando[field] ?? [field];

/// Records the [fieldOverrideChain] of each of [fields] (the result of
/// [createSortedFieldSet] for [element]) so [fieldHierarchyFor] can serve it.
void recordFieldOverrideChains(
  ClassElement element,
  Iterable<FieldElement> fields,
) {
  final chains = _overrideChains(
    element,
    keepObjectMemberOverride: (_) => true,
  );
  for (final field in fields) {
    final chain = chains[field.name];
    if (chain != null && chain.length > 1 && chain.contains(field)) {
      _fieldHierarchyExpando[field] = chain;
    }
  }
}
