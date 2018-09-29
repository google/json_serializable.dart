// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

Future<LibraryReader> resolveCompilationUnit(String sourceDirectory) async {
  final files =
      Directory(sourceDirectory).listSync().whereType<File>().toList();

  // Sort files to ensure the "first" one is first
  files.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

  final fileMap = Map<String, String>.fromEntries(files.map(
      (f) => MapEntry('a|lib/${p.basename(f.path)}', f.readAsStringSync())));

  final library = await resolveSources(fileMap, (item) async {
    final assetId = AssetId.parse(fileMap.keys.first);
    return await item.libraryFor(assetId);
  });

  return LibraryReader(library);
}
