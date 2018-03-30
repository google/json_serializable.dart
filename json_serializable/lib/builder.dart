// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build/build.dart';
import 'package:logging/logging.dart';

import 'src/json_part_builder.dart';

// TODO: until we can use `log` here - github.com/dart-lang/build/issues/1223
final _logger = new Logger('json_serializable');

/// Supports `package:build_runner` creation and configuration of `build_cli`.
///
/// Not meant to be invoked by hand-authored code.
Builder jsonSerializable(BuilderOptions options) {
  // Paranoid copy of options.config - don't assume it's mutable or needed
  // elsewhere.
  var optionsMap = new Map<String, dynamic>.from(options.config);

  try {
    return jsonPartBuilder(
        header: optionsMap.remove('header') as String,
        useWrappers: optionsMap.remove('use_wrappers') as bool);
  } finally {
    if (optionsMap.isNotEmpty) {
      _logger.warning('These options were ignored: `$optionsMap`.');
    }
  }
}
