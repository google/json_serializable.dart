// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
@Tags(['presubmit-only'])
@Timeout.factor(2)
library;

import 'dart:io';

import 'package:json_serializable/src/check_dependencies.dart';
import 'package:json_serializable/src/constants.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;
import 'package:test_process/test_process.dart';

import 'test_utils.dart';

void main() {
  test('validate pubspec constraint', () async {
    final annotationConstraint =
        _jsonSerialPubspec.dependencies['json_annotation'] as HostedDependency;
    final versionRange = annotationConstraint.version as VersionRange;

    expect(versionRange.includeMin, isTrue);
    expect(versionRange.min, requiredJsonAnnotationMinVersion);
  });

  group('language version', () {
    test('is less than required', () async {
      const sdkLowerBound = '2.12.0';
      await _structurePackage(
        environment: const {'sdk': '^$sdkLowerBound'},
        dependencies: {'json_annotation': _annotationLowerBound},
        message: '''
The language version ($sdkLowerBound) of this package ($_testPkgName) does not match the required range `$supportedLanguageConstraint`.

Edit pubspec.yaml to include an SDK constraint of at least $supportedLanguageConstraint.

environment:
  sdk: $supportedLanguageConstraint
''',
      );
    });

    test(
      'is at least the required `$supportedLanguageConstraint`',
      () async => await _structurePackage(
        dependencies: {'json_annotation': _annotationLowerBound},
        message: null,
      ),
    );
  });

  test(
    'missing dependency in production code',
    () => _structurePackage(
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
      devDependencies: {'json_annotation': _annotationLowerBound},
      message: _missingProductionDep,
    ),
  );

  test(
    'dependency with `null` constraint',
    () => _structurePackage(
      dependencies: {'json_annotation': null},
      message:
          'The version constraint "any" on json_annotation allows versions '
          'before $_annotationLowerBound which is not allowed.',
    ),
  );

  test(
    'dependency with "any" constraint',
    () => _structurePackage(
      dependencies: {'json_annotation': 'any'},
      message:
          'The version constraint "any" on json_annotation allows versions '
          'before $_annotationLowerBound which is not allowed.',
    ),
  );

  test(
    'dependency with too low version range',
    () => _structurePackage(
      dependencies: {'json_annotation': '^4.0.0'},
      message:
          'The version constraint "^4.0.0" on json_annotation allows versions '
          'before $_annotationLowerBound which is not allowed.',
    ),
  );
}

final _jsonSerialPubspec = Pubspec.parse(
  File('pubspec.yaml').readAsStringSync(),
  sourceUrl: Uri.file('pubspec.yaml'),
);

String _fixPath(String path) {
  if (p.isAbsolute(path)) return path;

  return p.canonicalize(p.join(p.current, path));
}

final _jsonSerialPathDependencyOverrides = {
  for (var entry in _jsonSerialPubspec.dependencyOverrides.entries)
    if (entry.value is PathDependency)
      entry.key: {'path': _fixPath((entry.value as PathDependency).path)}
};

final _annotationLowerBound = requiredJsonAnnotationMinVersion.toString();

final _missingProductionDep =
    'You are missing a required dependency on json_annotation in the '
    '"dependencies" section of your pubspec with a lower bound of at least '
    '"$_annotationLowerBound".';

const _testPkgName = '_test_pkg';

Future<void> _structurePackage({
  String sourceDirectory = 'lib',
  required String? message,
  Map<String, dynamic> environment = const {'sdk': supportedLanguageConstraint},
  Map<String, dynamic> dependencies = const {},
  Map<String, dynamic> devDependencies = const {},
}) async {
  final pubspec = loudEncode(
    {
      'name': _testPkgName,
      'environment': environment,
      'dependencies': dependencies,
      'dev_dependencies': {
        ...devDependencies,
        'build_runner': 'any',
        'json_serializable': {'path': p.current},
      },
      'dependency_overrides': _jsonSerialPathDependencyOverrides,
    },
  );

  await d.file('pubspec.yaml', pubspec).create();

  /// A file in the lib directory without JsonSerializable should do nothing!
  await d.dir(
    'lib',
    [
      d.file('no_op.dart', '''
class NoOp {}
''')
    ],
  ).create();

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
    Platform.resolvedExecutable,
    ['run', 'build_runner', 'build'],
    workingDirectory: d.sandbox,
  );

  final lines = StringBuffer();
  await for (var line in proc.stdoutStream()) {
    lines.writeln(line);
    print(line);
  }

  final output = lines.toString();
  final expectedWarningCount = message == null ? 0 : 1;
  final warningCount = '[WARNING]'.allMatches(output).length;
  expect(
    warningCount,
    expectedWarningCount,
    reason:
        'Expected the number of output warnings ($warningCount) to match the '
        'number of expected warnings ($expectedWarningCount).',
  );

  if (message != null) {
    expect(output, contains('''
[WARNING] json_serializable on $sourceDirectory/sample.dart:
$message'''));
  }

  await proc.shouldExit(0);
}
