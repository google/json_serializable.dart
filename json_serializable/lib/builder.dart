// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Configuration for using `package:build`-compatible build systems.
///
/// See:
/// * [build_runner](https://pub.dartlang.org/packages/build_runner)
///
/// This library is **not** intended to be imported by typical end-users unless
/// you are creating a custom compilation pipeline. See documentation for
/// details, and `build.yaml` for how these builders are configured by default.
library json_serializable.builder;

import 'package:build/build.dart';

import 'src/json_part_builder.dart';

/// Supports `package:build_runner` creation and configuration of
/// `json_serializable`.
///
/// Not meant to be invoked by hand-authored code.
Builder jsonSerializable(BuilderOptions options) {
  // Paranoid copy of options.config - don't assume it's mutable or needed
  // elsewhere.
  var optionsMap = new Map<String, dynamic>.from(options.config);

  var builder = jsonPartBuilder(
    header: optionsMap.remove('header') as String,
    useWrappers: optionsMap.remove('use_wrappers') as bool,
    checked: optionsMap.remove('checked') as bool,
    anyMap: optionsMap.remove('any_map') as bool,
    explicitToJson: optionsMap.remove('explicit_to_json') as bool,
  );

  if (optionsMap.isNotEmpty) {
    if (log == null) {
      throw new StateError('Upgrade `build_runner` to at least 0.8.2.');
    } else {
      log.warning('These options were ignored: `$optionsMap`.');
    }
  }
  return builder;
}
