// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'json_literal_generator.dart';
import 'json_serializable_generator.dart';

/// Returns a [Builder] for use within a `package:build_runner`
/// `BuildAction`.
///
/// [header] is used to specify the content at the top of each generated file.
/// If `null`, the content of [defaultFileHeader] is used.
/// If [header] is an empty `String` no header is added.
///
/// If [useWrappers] is `true`, wrappers are used to minimize the number of
/// [Map] and [List] instances created during serialization. This will
/// increase the code size, but it may improve runtime performance, especially
/// for large object graphs.
Builder jsonPartBuilder({String header, bool useWrappers: false}) {
  useWrappers ??= false;
  return new PartBuilder([
    new JsonSerializableGenerator(useWrappers: useWrappers),
    const JsonLiteralGenerator()
  ], header: header);
}
