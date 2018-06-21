#!/usr/bin/env dart --enable-asserts
// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' show exitCode;

import 'package:build/build.dart';
import 'package:build_config/build_config.dart';
import 'package:build_runner/build_runner.dart';
import 'package:build_test/builder.dart';
import 'package:json_serializable/src/json_part_builder.dart' as jpb;

import 'builder.dart';

Builder _jsonPartBuilder({
  bool useWrappers,
  bool anyMap,
  bool checked,
  bool format,
  bool generateToJsonFunction,
}) {
  format ??= true;
  String Function(String code) formatOutput;

  if (!format) {
    formatOutput = (s) => s;
  }

  return jpb.jsonPartBuilder(
      header: copyrightHeader,
      formatOutput: formatOutput,
      useWrappers: useWrappers,
      anyMap: anyMap,
      checked: checked,
      generateToJsonFunction: generateToJsonFunction);
}

final List<BuilderApplication> builders = [
  applyToRoot(nonNull(),
      generateFor: const InputSet(include: const [
        'test/kitchen_sink/kitchen_sink.dart',
        'test/integration/json_test_example.dart'
      ])),
  applyToRoot(checked(),
      generateFor: const InputSet(include: const [
        'test/default_value/default_value.dart',
        'test/kitchen_sink/kitchen_sink.non_nullable.dart',
      ])),
  applyToRoot(wrapped(),
      generateFor: const InputSet(include: const [
        'test/generic_files/generic_class.dart',
        'test/kitchen_sink/kitchen_sink.dart',
        'test/kitchen_sink/kitchen_sink.non_nullable.dart',
        'test/integration/json_test_example.dart',
        'test/integration/json_test_example.non_nullable.dart',
      ])),
  applyToRoot(_jsonPartBuilder(),
      generateFor: const InputSet(
        include: const [
          'example/example.dart',
          'test/literal/json_literal.dart',
          'test/integration/json_test_example.dart',
          'test/integration/json_test_example.non_nullable.dart'
        ],
      )),
  applyToRoot(_jsonPartBuilder(generateToJsonFunction: true),
      generateFor: const InputSet(
        include: const [
          'test/generic_files/generic_class.dart',
          'test/default_value/default_value.dart',
        ],
      )),
  applyToRoot(_jsonPartBuilder(anyMap: true),
      generateFor: const InputSet(
        include: const [
          'test/kitchen_sink/kitchen_sink.dart',
          'test/kitchen_sink/kitchen_sink.non_nullable.dart',
          'test/kitchen_sink/simple_object.dart',
          'test/kitchen_sink/strict_keys_object.dart'
        ],
      )),
  applyToRoot(_jsonPartBuilder(checked: true, anyMap: true),
      generateFor: const InputSet(
        include: const [
          'test/kitchen_sink/kitchen_sink.non_nullable.checked.dart',
          'test/yaml/build_config.dart',
        ],
      )),
  applyToRoot(
      _jsonPartBuilder(
          checked: true, anyMap: true, generateToJsonFunction: true),
      generateFor: const InputSet(
        include: const [
          'test/default_value/default_value.checked.dart',
        ],
      )),
  applyToRoot(_jsonPartBuilder(useWrappers: true),
      generateFor: const InputSet(
        include: const [
          'test/integration/json_test_example*wrapped.dart',
        ],
      )),
  applyToRoot(_jsonPartBuilder(useWrappers: true, generateToJsonFunction: true),
      generateFor: const InputSet(
        include: const [
          'test/generic_files/generic_class*wrapped.dart',
        ],
      )),
  applyToRoot(_jsonPartBuilder(useWrappers: true, anyMap: true),
      generateFor: const InputSet(
        include: const [
          'test/kitchen_sink/kitchen_sink*wrapped.dart',
        ],
      )),
  applyToRoot(testBootstrapBuilder(null),
      generateFor: const InputSet(include: const ['test/**']),
      hideOutput: true),
];

void main(List<String> args) async {
  exitCode = await run(args, builders);
}
