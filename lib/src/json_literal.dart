// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class JsonLiteral {
  /// The relative path from the Dart file with the annotation to the file
  /// containing the source JSON.
  final String path;

  /// `true` if the JSON literal should be written as a constant.
  final bool asConst;

  const JsonLiteral(this.path, {bool asConst: false})
      : this.asConst = asConst ?? false;
}
