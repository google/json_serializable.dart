// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Defines the `BuildAction` class.
import 'package:build_runner/build_runner.dart';

// Defines `JsonSerializableGenerator` and `JsonLiteralGenerator`
import 'package:json_serializable/generators.dart';

// Defines `PartBuilder`
import 'package:source_gen/source_gen.dart';

// The list of `BuildAction`s  used by `build.dart` and `watch.dart` to
// generate source code for this package.
List<BuildAction> get buildActions => [
      new BuildAction(
        // `PartBuilder` is a `Builder` defined by `package:source_gen` for
        // generating Dart "part" files (.g.dart) given a set of generators.
        new PartBuilder(const [
          // Uses `@JsonSerializable()` annotations in source files to create
          // helpers to support to/from JSON.

          const JsonSerializableGenerator(),

          // Uses @JsonLiteral('...') annotations in source files to create
          // Dart literals for the provided JSON file.
          const JsonLiteralGenerator()
        ], header: _copyrightContent),

        // The name of the current package
        'example',

        // All of the files this `BuildAction` should target when run.
        inputs: const [
          'lib/*.dart',
        ],
      ),
    ];

final _copyrightContent =
    '''// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

$defaultFileHeader''';
