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
/// [formatOutput] is called to format the generated code. If not provided,
/// the default Dart code formatter is used.
///
/// For details on [useWrappers], [anyMap], and [checked] see
/// [JsonSerializableGenerator].
Builder jsonPartBuilder({
  String header,
  String formatOutput(String code),
  bool useWrappers: false,
  bool anyMap: false,
  bool checked: false,
  bool explicitToJson: false,
}) {
  return new PartBuilder([
    new JsonSerializableGenerator(
      useWrappers: useWrappers,
      anyMap: anyMap,
      checked: checked,
      explicitToJson: explicitToJson,
    ),
    const JsonLiteralGenerator()
  ], header: header, formatOutput: formatOutput);
}
