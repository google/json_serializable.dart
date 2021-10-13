// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:build/build.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

const _productionDirectories = {'lib', 'bin'};

Future<void> pubspecHasRightVersion(BuildStep buildStep) async {
  final segments = buildStep.inputId.pathSegments;
  final productionDependency =
      segments.length > 1 && _productionDirectories.contains(segments.first);
  final resource = await buildStep.fetchResource(
    productionDependency
        ? _productionDependencyCheckResource
        : _developmentDependencyCheckResource,
  );

  final errorMessage = await resource.run(buildStep);

  if (errorMessage == null) return;

  throw BadPackageDependencyError(errorMessage);
}

const _pkgName = 'json_serializable';
const _annotationPkgName = 'json_annotation';

final _productionDependencyCheckResource =
    _OncePerBuild.resource<bool, String?>(true, _validatePubspec);

final _developmentDependencyCheckResource =
    _OncePerBuild.resource<bool, String?>(false, _validatePubspec);

Future<String?> _validatePubspec(bool production, BuildStep buildStep) async {
  final jsonSerialPubspecAssetId = AssetId(_pkgName, 'pubspec.yaml');

  final pubspecAssetId = AssetId(buildStep.inputId.package, 'pubspec.yaml');

  if (!await buildStep.canRead(pubspecAssetId) ||
      !await buildStep.canRead(jsonSerialPubspecAssetId)) {
    log.warning(
      'Could not read the "pubspec.yaml` files associated with this package or '
      'the $_pkgName package. '
      'Usage of package:$_annotationPkgName could not be verified.',
    );
    return null;
  }

  Future<Pubspec> readPubspec(AssetId asset) async {
    final string = await buildStep.readAsString(asset);
    return Pubspec.parse(string, sourceUrl: asset.uri);
  }

  final jsonSerialPubspec = await readPubspec(jsonSerialPubspecAssetId);

  final annotationLowerConstraint = _annotationVersion(jsonSerialPubspec);

  if (annotationLowerConstraint == null) {
    return null;
  }

  final pubspec = await readPubspec(pubspecAssetId);

  return _checkAnnotationConstraint(
    pubspec,
    annotationLowerConstraint,
    !production,
  );
}

String? _checkAnnotationConstraint(
  Pubspec pubspec,
  Version requiredJsonAnnotationMinVersion,
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

Version? _annotationVersion(Pubspec jsonSerialPubspec) {
  final jsonSerialAnnotationDep =
      jsonSerialPubspec.dependencies[_annotationPkgName];

  if (jsonSerialAnnotationDep is! HostedDependency) {
    log.warning(
      'The local `$_pkgName` dependency on `$_annotationPkgName` is not a '
      '`$HostedDependency`, as expected. Version checking is being skipped.',
    );
    return null;
  }

  final constraint = jsonSerialAnnotationDep.version as VersionRange;

  assert(constraint.includeMin);

  return constraint.min!;
}

class _OncePerBuild<S, T> {
  final S state;
  final FutureOr<T> Function(S, BuildStep) _callback;
  AsyncMemoizer<T>? _memo;

  static Resource<_OncePerBuild<State, T>> resource<State, T>(
    State state,
    FutureOr<T> Function(State, BuildStep) callback,
  ) =>
      Resource<_OncePerBuild<State, T>>(
        () => _OncePerBuild._(state, callback),
        dispose: (c) => c._dispose(),
      );

  _OncePerBuild._(this.state, this._callback);

  Future<T> run(BuildStep buildStep) =>
      (_memo ??= AsyncMemoizer()).runOnce(() => _callback(state, buildStep));

  void _dispose() {
    _memo = null;
  }
}

/// Thrown when a pubspec dependency is missing or incorrectly specified.
class BadPackageDependencyError extends Error {
  final String message;

  BadPackageDependencyError(this.message);

  @override
  String toString() => message;
}
