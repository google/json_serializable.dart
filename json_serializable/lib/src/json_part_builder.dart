// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// https://github.com/dart-lang/sdk/issues/31761
// ignore_for_file: comment_references

// Until `requireLibraryDirective` is removed
// ignore_for_file: deprecated_member_use

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
///
/// May set [requireLibraryDirective] to `true` in order to opt-out of the
/// Dart `2.0.0-dev` feature of `part of` being usable without an explicit
/// `library` directive. Developers should restrict the SDK constraint in
/// `pubspec.yaml` accordingly:
///
/// ```yaml
/// sdk: '>=2.0.0-dev <2.0.0'
/// ```
///
/// Usage:
///
/// ```dart
/// new BuildAction(
///   jsonPartBuilder(),
///   'my_package',
///   inputs: const ['lib/*.dart']
/// )
/// ```
///
/// See the [example] to understand how to configure your project for
/// `json_serializable`.
///
/// [example]: https://github.com/dart-lang/json_serializable/tree/master/example
Builder jsonPartBuilder(
    {String header,
    bool useWrappers: false,
    @Deprecated(
        'Library directives are no longer required for part generation. '
        'This option will be removed in v0.4.0.')
        bool requireLibraryDirective: false}) {
  useWrappers ??= false;
  requireLibraryDirective ??= false;
  return new PartBuilder([
    new JsonSerializableGenerator(useWrappers: useWrappers),
    const JsonLiteralGenerator()
  ],
      header: header,
      // ignore: deprecated_member_use
      requireLibraryDirective: requireLibraryDirective);
}
