// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:analyzer/file_system/file_system.dart' hide File;
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/source/package_map_resolver.dart';
import 'package:analyzer/source/pub_package_map_provider.dart';
import 'package:analyzer/src/dart/sdk/sdk.dart' show FolderBasedDartSdk;
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/generated/source_io.dart';
import 'package:path/path.dart' as p;

Future<AnalysisContext> getAnalysisContextForProjectPath(
    String projectPath) async {
  // TODO: fail more clearly if this...fails
  var sdkPath = _getSdkPath();

  var resourceProvider = PhysicalResourceProvider.INSTANCE;
  var sdk = new FolderBasedDartSdk(
      resourceProvider, resourceProvider.getFolder(sdkPath));

  var packageResolver = _getPackageResolver(projectPath, sdk);

  var resolvers = [
    new DartUriResolver(sdk),
    new ResourceUriResolver(PhysicalResourceProvider.INSTANCE),
    packageResolver
  ];

  AnalysisEngine.instance.processRequiredPlugins();

  var options = new AnalysisOptionsImpl()..analyzeFunctionBodies = false;

  var context = AnalysisEngine.instance.createAnalysisContext()
    ..analysisOptions = options
    ..sourceFactory = new SourceFactory(resolvers);

  return context;
}

UriResolver _getPackageResolver(String projectPath, FolderBasedDartSdk sdk) {
  var dotPackagesPath = p.join(projectPath, '.packages');

  if (!FileSystemEntity.isFileSync(dotPackagesPath)) {
    throw new StateError('A package configuration file was not found at the '
        'expectetd location. $dotPackagesPath');
  }

  var pubPackageMapProvider =
      new PubPackageMapProvider(PhysicalResourceProvider.INSTANCE, sdk);
  var packageMapInfo = pubPackageMapProvider.computePackageMap(
      PhysicalResourceProvider.INSTANCE.getResource(projectPath) as Folder);
  var packageMap = packageMapInfo.packageMap;
  if (packageMap == null) {
    throw new StateError('An error occurred getting the package map.');
  }

  return new PackageMapUriResolver(
      PhysicalResourceProvider.INSTANCE, packageMap);
}

/// Return the path to the current Dart SDK.
String _getSdkPath() => p.dirname(p.dirname(Platform.resolvedExecutable));
