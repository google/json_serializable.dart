// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
@Tags(['presubmit-only'])
import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;
import 'package:test_process/test_process.dart';

const _annotationLowerBound = '4.2.0';

const _missingProductionDep =
    'You are missing a required dependency on json_annotation in the '
    '"dependencies" section of your pubspec with a lower bound of at least '
    '"$_annotationLowerBound".';

void main() {
  test(
    'missing dependency in production code',
    () => _structurePackage(
      sourceDirectory: 'lib',
      message: _missingProductionDep,
    ),
  );

  test(
    'missing dependency in example code',
    () => _structurePackage(
      sourceDirectory: 'example',
      message:
          'You are missing a required dependency on json_annotation with a '
          'lower bound of at least "$_annotationLowerBound".',
    ),
  );

  test(
    'dev dependency with a production usage',
    () => _structurePackage(
      sourceDirectory: 'lib',
      devDependencies: {'json_annotation': _annotationLowerBound},
      message: _missingProductionDep,
    ),
  );

  test(
    'dependency with `null` constraint',
    () => _structurePackage(
      sourceDirectory: 'lib',
      dependencies: {'json_annotation': null},
      message:
          'The version constraint "any" on json_annotation allows versions '
          'before $_annotationLowerBound which is not allowed.',
    ),
  );

  test(
    'dependency with "any" constraint',
    () => _structurePackage(
      sourceDirectory: 'lib',
      dependencies: {'json_annotation': 'any'},
      message:
          'The version constraint "any" on json_annotation allows versions '
          'before $_annotationLowerBound which is not allowed.',
    ),
  );

  test(
    'dependency with too low version range',
    () => _structurePackage(
      sourceDirectory: 'lib',
      dependencies: {'json_annotation': '^4.0.0'},
      message:
          'The version constraint "^4.0.0" on json_annotation allows versions '
          'before $_annotationLowerBound which is not allowed.',
    ),
  );
}

Future<void> _structurePackage({
  required String sourceDirectory,
  required String message,
  Map<String, dynamic> dependencies = const {},
  Map<String, dynamic> devDependencies = const {},
}) async {
  final pubspec = const JsonEncoder.withIndent(' ').convert(
    {
      'name': '_test_pkg',
      'environment': {'sdk': '>=2.14.0 <3.0.0'},
      'dependencies': dependencies,
      'dev_dependencies': {
        ...devDependencies,
        'build_runner': 'any',
        'json_serializable': {'path': p.current},
      }
    },
  );

  await d.file('pubspec.yaml', pubspec).create();

  await d.dir(
    sourceDirectory,
    [
      d.file(
        'sample.dart',
        '''
import 'package:json_annotation/json_annotation.dart';

part 'sample.g.dart';

@JsonSerializable()
class SomeClass{}
''',
      )
    ],
  ).create();

  final proc = await TestProcess.start(
    'dart',
    ['run', 'build_runner', 'build'],
    workingDirectory: d.sandbox,
  );

  await proc.stdoutStream().forEach(print);

  await expectLater(
    proc.stdout,
    emitsThrough(
      emitsInOrder([
        '[SEVERE] json_serializable:json_serializable on $sourceDirectory/sample.dart:',
        '',
        message,
      ]),
    ),
  );

  await expectLater(proc.stderr, emitsDone);

  await proc.shouldExit(1);
}
