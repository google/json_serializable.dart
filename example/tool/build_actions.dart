// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Defines [BuildAction]
import 'package:build_runner/build_runner.dart';

/// Defines [jsonPartBuilder]
import 'package:json_serializable/json_serializable.dart';

/// The list of [BuildAction]s  used by `build.dart` and `watch.dart` to
/// generate source code for this package.
List<BuildAction> get buildActions => [
      new BuildAction(
        jsonPartBuilder(header: _copyrightContent),

        // The name of the current package
        'example',

        // All of the files this `BuildAction` should target when run.
        inputs: const [
          'lib/*.dart',
        ],
      ),
    ];

/// Used in the `header` argument to the [jsonPartBuilder] constructor to add
/// the standard copyright notice to all generated files.
final _copyrightContent =
    '''// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

''';
