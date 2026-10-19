// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:source_helper/source_helper.dart';

export 'package:source_helper/source_helper.dart'
    show createSortedFieldSet, fieldOverrideChain;

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
  for (final field in fields) {
    final chain = fieldOverrideChain(element, field);
    if (chain.length > 1) {
      _fieldHierarchyExpando[field] = chain;
    }
  }
}
