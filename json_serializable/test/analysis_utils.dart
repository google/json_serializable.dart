// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/analysis/context_builder.dart';
import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:source_gen/source_gen.dart';

Future<LibraryReader> resolveCompilationUnit(String path) async {
  var contextLocator = new ContextLocator();
  var roots = contextLocator.locateRoots(includedPaths: [path]);
  if (roots.length != 1) {
    throw new StateError('Expected exactly one context root, got $roots');
  }

  var analysisContext =
      new ContextBuilder().createContext(contextRoot: roots.single);
  var resolveResult = await analysisContext.currentSession.getResolvedAst(path);
  return new LibraryReader(resolveResult.unit.element.library);
}
