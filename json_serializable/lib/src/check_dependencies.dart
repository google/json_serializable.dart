// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

const _productionDirectories = {'lib', 'bin'};
const _annotationPkgName = 'json_annotation';
final requiredJsonAnnotationMinVersion = Version.parse('4.8.0');

Future<void> pubspecHasRightVersion(BuildStep buildStep) async {
  final segments = buildStep.inputId.pathSegments;
  final productionDependency =
      segments.length > 1 && _productionDirectories.contains(segments.first);
  final resource =
      productionDependency ? _productionDependency : _developmentDependency;

  await resource.run(buildStep);
}

final _productionDependency = _OncePerBuild(true, _validatePubspec);

final _developmentDependency = _OncePerBuild(false, _validatePubspec);

Future<void> _validatePubspec(bool production, BuildStep buildStep) async {
  final pubspecAssetId = AssetId(buildStep.inputId.package, 'pubspec.yaml');

  if (!await buildStep.canRead(pubspecAssetId)) {
    log.warning(
      'Could not read the "pubspec.yaml` file associated with this package. '
      'Usage of package:$_annotationPkgName could not be verified.',
    );
    return;
  }

  Future<Pubspec> readPubspec(AssetId asset) async {
    final string = await buildStep.readAsString(asset);
    return Pubspec.parse(string, sourceUrl: asset.uri);
  }

  final pubspec = await readPubspec(pubspecAssetId);

  final errorMessage = _checkAnnotationConstraint(
    pubspec,
    !production,
  );

  if (errorMessage == null) return;

  log.warning(errorMessage);
}

String? _checkAnnotationConstraint(
  Pubspec pubspec,
  bool includeDevDependencies,
) {
  var dependency = pubspec.dependencies[_annotationPkgName];

  if (dependency == null && includeDevDependencies) {
    dependency = pubspec.devDependencies[_annotationPkgName];
  }

  if (dependency == null) {
    if (includeDevDependencies) {
      dependency = pubspec.devDependencies[_annotationPkgName];

      if (dependency == null) {
        return 'You are missing a required dependency on $_annotationPkgName '
            'with a lower bound of at least '
            '"$requiredJsonAnnotationMinVersion".';
      }
    } else {
      return 'You are missing a required dependency on $_annotationPkgName in '
          'the "dependencies" section of your pubspec with a lower bound of at '
          'least "$requiredJsonAnnotationMinVersion".';
    }
  }

  if (dependency is! HostedDependency) {
    log.warning(
      'Your dependency on `$_annotationPkgName` is not a '
      '`$HostedDependency`, as expected. Version checking is being skipped.',
    );
    return null;
  }

  // We know it's a HostedDependency at this point!
  final constraint = dependency.version;

  final constraintTooLowMessage =
      'The version constraint "$constraint" on $_annotationPkgName allows '
      'versions before $requiredJsonAnnotationMinVersion which is not '
      'allowed.';

  if (constraint is Version && constraint < requiredJsonAnnotationMinVersion) {
    return constraintTooLowMessage;
  }

  final range = constraint as VersionRange;
  final rangeMin = range.min;

  if (rangeMin == null || rangeMin < requiredJsonAnnotationMinVersion) {
    return constraintTooLowMessage;
  }

  return null;
}

class _OncePerBuild {
  final bool state;
  final FutureOr<void> Function(bool, BuildStep) _callback;
  bool _ran = false;

  _OncePerBuild(this.state, this._callback);

  Future<void> run(BuildStep buildStep) async {
    if (!_ran) {
      _ran = true;
      await _callback(state, buildStep);
    }
  }
}
