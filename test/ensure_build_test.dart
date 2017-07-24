// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Tags(const ['presubmit-only'])

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  String pkgRoot;
  try {
    pkgRoot = _runProc('git', ['rev-parse', '--show-toplevel']);
    var currentDir = Directory.current.resolveSymbolicLinksSync();
    if (pkgRoot != currentDir) {
      throw new StateError("Expected the git root ($pkgRoot) "
          "to match the current directory ($currentDir).");
    }
  } catch (e) {
    print("Skipping this test – git didn't run correctly");
    print(e);
    return;
  }

  test("ensure local build succeeds with no changes", () {
    // 1 - get a list of modified `.g.dart` files - should be empty
    //expect(_changedGeneratedFiles(), isEmpty);

    // 2 - run build - should be no output, since nothing should change
    var result = _runProc('dart', ['--checked', 'tool/build.dart']);
    expect(result,
        contains(new RegExp(r"Build: Succeeded after \S+ with \d+ outputs")));

    // 3 - get a list of modified `.g.dart` files - should still be empty
    expect(_changedGeneratedFiles(), isEmpty);
  });
}

final _whitespace = new RegExp(r'\s');

Set<String> _changedGeneratedFiles() {
  var output = _runProc('git', ['status', '--porcelain']);

  return LineSplitter
      .split(output)
      .map((line) => line.split(_whitespace).last)
      .where((path) => path.endsWith('.g.dart'))
      .toSet();
}

String _runProc(String proc, List<String> args) {
  var result = Process.runSync(proc, args);

  if (result.exitCode != 0) {
    throw new ProcessException(
        proc, args, result.stderr as String, result.exitCode);
  }

  return (result.stdout as String).trim();
}
