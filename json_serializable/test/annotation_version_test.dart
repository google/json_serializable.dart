// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
@Tags(['presubmit-only'])
import 'dart:io';

import 'package:json_serializable/src/check_dependencies.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;
import 'package:test_process/test_process.dart';

import 'test_utils.dart';

void main() {
  test('validate pubspec constraint', () {
    final annotationConstraint =
        _jsonSerialPubspec.dependencies['json_annotation'] as HostedDependency;
    final versionRange = annotationConstraint.version as VersionRange;

    expect(versionRange.includeMin, isTrue);
    expect(versionRange.min, requiredJsonAnnotationMinVersion);
  });

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

Future<void> _structurePackage({
  required String sourceDirectory,
  required String message,
  Map<String, dynamic> dependencies = const {},
  Map<String, dynamic> devDependencies = const {},
}) async {
  final pubspec = loudEncode(
    {
      'name': '_test_pkg',
      'environment': {'sdk': '>=2.14.0 <3.0.0'},
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
    'dart',
    ['run', 'build_runner', 'build'],
    workingDirectory: d.sandbox,
  );

  final lines = StringBuffer();
  await for (var line in proc.stdoutStream()) {
    lines.writeln(line);
    print(line);
  }

  expect(lines.toString(), contains('''
[WARNING] json_serializable on $sourceDirectory/sample.dart:
$message'''));

  await proc.shouldExit(0);
}
