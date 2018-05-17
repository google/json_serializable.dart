#!/usr/bin/env dart --checked
// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' show exitCode;

import 'package:build_config/build_config.dart';
import 'package:build_runner/build_runner.dart';
import 'package:build_test/builder.dart';
import 'package:json_serializable/src/json_part_builder.dart';

import 'builder.dart';

final List<BuilderApplication> builders = [
  applyToRoot(nonNull(),
      generateFor: const InputSet(include: const [
        'test/test_files/kitchen_sink.dart',
        'test/test_files/json_test_example.dart'
      ])),
  applyToRoot(checked(),
      generateFor: const InputSet(include: const [
        'test/test_files/kitchen_sink.non_nullable.dart',
      ])),
  applyToRoot(wrapped(),
      generateFor: const InputSet(include: const [
        'test/test_files/kitchen_sink.dart',
        'test/test_files/kitchen_sink.non_nullable.dart',
        'test/test_files/json_test_example.dart',
        'test/test_files/json_test_example.non_nullable.dart',
      ])),
  applyToRoot(jsonPartBuilder(header: copyrightHeader),
      generateFor: const InputSet(
        include: const [
          'example/example.dart',
          'test/test_files/json_literal.dart',
          'test/test_files/json_test_example.dart',
          'test/test_files/json_test_example.non_nullable.dart'
        ],
      )),
  applyToRoot(jsonPartBuilder(header: copyrightHeader, anyMap: true),
      generateFor: const InputSet(
        include: const [
          'test/test_files/kitchen_sink.dart',
          'test/test_files/kitchen_sink.non_nullable.dart',
          'test/test_files/simple_object.dart'
        ],
      )),
  applyToRoot(
      jsonPartBuilder(header: copyrightHeader, checked: true, anyMap: true),
      generateFor: const InputSet(
        include: const [
          'test/config/build_config.dart',
          'test/test_files/kitchen_sink.non_nullable.checked.dart'
        ],
      )),
  applyToRoot(jsonPartBuilder(useWrappers: true, header: copyrightHeader),
      generateFor: const InputSet(
        include: const [
          'test/test_files/json_test_example*wrapped.dart',
        ],
      )),
  applyToRoot(
      jsonPartBuilder(useWrappers: true, anyMap: true, header: copyrightHeader),
      generateFor: const InputSet(
        include: const [
          'test/test_files/kitchen_sink*wrapped.dart',
        ],
      )),
  applyToRoot(testBootstrapBuilder(null),
      generateFor: const InputSet(include: const ['test/**']),
      hideOutput: true),
];

main(List<String> args) async {
  exitCode = await run(args, builders);
}
