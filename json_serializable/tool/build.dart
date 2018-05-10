#!/usr/bin/env dart --checked
// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' show exitCode;

import 'package:build_config/build_config.dart';
import 'package:build_runner/build_runner.dart';
import 'package:json_serializable/src/json_part_builder.dart';

import 'builder.dart';

final List<BuilderApplication> builders = [
  applyToRoot(nonNull(null),
      generateFor: const InputSet(include: const [
        'test/test_files/kitchen_sink.dart',
        'test/test_files/json_test_example.dart'
      ])),
  applyToRoot(wrapped(null),
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
          'test/test_files/json_test_example.non_nullable.dart',
          'test/test_files/kitchen_sink.dart',
          'test/test_files/kitchen_sink.non_nullable.dart'
        ],
      )),
  applyToRoot(jsonPartBuilder(useWrappers: true, header: copyrightHeader),
      generateFor: const InputSet(
        include: const [
          'test/test_files/kitchen_sink*wrapped.dart',
          'test/test_files/json_test_example*wrapped.dart',
        ],
      ))
];

main(List<String> args) async {
  exitCode = await run(args, builders);
}
