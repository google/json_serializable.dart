// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class ShouldThrow {
  final String testDescription;
  final String errorMessage;
  final String todo;
  const ShouldThrow(this.testDescription, this.errorMessage, [this.todo]);
}

class ShouldGenerate {
  final String expectedOutput;
  final bool contains;
  final List<String> expectedLogItems;
  final bool checked;
  const ShouldGenerate(this.expectedOutput,
      {this.contains = false,
      this.expectedLogItems = const [],
      this.checked = false});
}
