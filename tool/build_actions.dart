// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build_runner/build_runner.dart';
import 'package:json_serializable/generators.dart';
import 'package:source_gen/source_gen.dart';

final List<BuildAction> buildActions = [
  new BuildAction(
      new PartBuilder(const [
        const JsonSerializableGenerator(),
        const JsonLiteralGenerator()
      ]),
      'json_serializable',
      inputs: const ['example/*.dart', 'test/test_files/*.dart'])
];
