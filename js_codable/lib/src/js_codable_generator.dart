// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:json_annotation/json_annotation.dart';
// ignore: implementation_imports
import 'package:json_serializable/src/type_helpers/config_types.dart';
import 'package:source_gen/source_gen.dart';

import 'js_generator_helper.dart';

/// Generates standalone `.js_codable.dart` libraries with zero-copy
/// `dart:js_interop` extension types and converters for `@JsonSerializable`
/// classes.
class JsCodableGenerator extends GeneratorForAnnotation<JsonSerializable> {
  final ClassConfig _config;

  JsonSerializable get config => _config.toJsonSerializable();

  JsCodableGenerator({JsonSerializable? config})
    : _config = config != null
          ? ClassConfig.fromJsonSerializable(config)
          : ClassConfig.defaults,
      super(inPackage: 'json_annotation');

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async =>
      generateForLibraryReader(library);

  /// Generates the full `.js_codable.dart` library source for [library], or an
  /// empty string if no classes in [library] are annotated with
  /// `@JsonSerializable`.
  String generateForLibraryReader(LibraryReader library) {
    final annotatedElements = library.annotatedWith(typeChecker).toList();
    if (annotatedElements.isEmpty) {
      return '';
    }

    final dartImports = <String>{'dart:js_interop'};
    final packageImports = <String>{};
    final relativeImports = <String>{};
    final bodySpecs = <Spec>[];
    final addedMembers = <String>{};

    for (final annotated in annotatedElements) {
      final element = annotated.element;
      if (element is! ClassElement || element is EnumElement) {
        throw InvalidGenerationSourceError(
          '`@JsonSerializable` can only be used on classes.',
          element: element,
        );
      }

      final helper = JsGeneratorHelper(_config, element, annotated.annotation);
      final result = helper.generateClass();
      dartImports.addAll(result.dartImports);
      packageImports.addAll(result.packageImports);
      relativeImports.addAll(result.relativeImports);
      bodySpecs.addAll(result.specs);
      addedMembers.addAll(result.addedMembers);
    }

    final sortedDartImports = dartImports.toList()..sort();
    final sortedPackageImports = packageImports.toList()..sort();
    final sortedRelativeImports = relativeImports.toList()..sort();

    final lib = Library(
      (b) => b
        ..directives.addAll([
          for (final uri in sortedDartImports) Directive.import(uri),
          for (final uri in sortedPackageImports) Directive.import(uri),
          for (final uri in sortedRelativeImports) Directive.import(uri),
        ])
        ..body.addAll(bodySpecs)
        ..body.addAll(addedMembers.map(Code.new)),
    );

    final emitter = DartEmitter(useNullSafetySyntax: true);
    return lib.accept(emitter).toString();
  }

  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement || element is EnumElement) {
      throw InvalidGenerationSourceError(
        '`@JsonSerializable` can only be used on classes.',
        element: element,
      );
    }

    final helper = JsGeneratorHelper(_config, element, annotation);
    final result = helper.generateClass();
    final emitter = DartEmitter(useNullSafetySyntax: true);
    return [
      ...result.specs.map(
        (s) => Library((b) => b..body.add(s)).accept(emitter).toString(),
      ),
      ...result.addedMembers,
    ];
  }
}
