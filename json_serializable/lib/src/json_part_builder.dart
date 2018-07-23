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
/// [formatOutput] is called to format the generated code. If not provided,
/// the default Dart code formatter is used.
///
/// For details on [useWrappers], [anyMap], and [checked] see
/// [JsonSerializableGenerator].
Builder jsonPartBuilder({
  String formatOutput(String code),
  bool useWrappers = false,
  bool anyMap = false,
  bool checked = false,
  bool explicitToJson = false,
  bool generateToJsonFunction = true,
}) {
  return new SharedPartBuilder([
    new JsonSerializableGenerator(
      useWrappers: useWrappers,
      anyMap: anyMap,
      checked: checked,
      explicitToJson: explicitToJson,
      generateToJsonFunction: generateToJsonFunction,
    ),
    const JsonLiteralGenerator()
  ], 'json_serializable', formatOutput: formatOutput);
}
