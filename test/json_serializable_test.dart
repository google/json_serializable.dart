// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('!browser')
library source_gen.test.json_generator_test;

import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/generated/source_io.dart';
import 'package:analyzer/src/string_source.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/generators/json_serializable_generator.dart';
import 'package:source_gen/src/utils.dart';
import 'package:test/test.dart';

import 'analysis_utils.dart';
import 'src/io.dart';
import 'test_utils.dart';

void main() {
  group('non-classes', () {
    test('const field', () async {
      var element = await _getClassForCodeString('theAnswer');

      expect(_generator.generate(element, null),
          throwsInvalidGenerationSourceError);
      // TODO: validate the properties on the thrown error
    });

    test('method', () async {
      var element = await _getClassForCodeString('annotatedMethod');

      expect(_generator.generate(element, null),
          throwsInvalidGenerationSourceError);
      // TODO: validate the properties on the thrown error
    });
  });

  test('class with final fields', () async {
    var element = await _getClassForCodeString('FinalFields');
    var generateResult = await _generator.generate(element, null);
    expect(generateResult, contains("Map<String, dynamic> toJson()"));
  });

  test('unannotated classes no-op', () async {
    var element = await _getClassForCodeString('NoAnnotation');
    var output = _generator.generate(element, null);

    expect(output, isNull);
  });

  group('valid inputs', () {
    test('class with no fields', () async {
      var element = await _getClassForCodeString('Person');
      var output = await _generator.generate(element, null);

      expect(output, isNotNull);

      // TODO: test the actual output
      // print(output);
    });

    test('class with ctor params', () async {
      var element = await _getClassForCodeString('Order');
      var output = await _generator.generate(element, null);

      expect(output, isNotNull);

      // TODO: test the actual output
      // print(output);
    });

    test('class with child json-able object', () async {
      var element = await _getClassForCodeString('ParentObject');
      var output = await _generator.generate(element, null);

      expect(output, contains('new ChildObject.fromJson'));
    });

    test('class with child list of json-able objects', () async {
      var element = await _getClassForCodeString('ParentObjectWithChildren');
      var output = await _generator.generate(element, null);

      expect(output, contains('.toList()'));
      expect(output, contains('new ChildObject.fromJson'));
    });

    test('class with child list of dynamic objects is left alone', () async {
      var element =
          await _getClassForCodeString('ParentObjectWithDynamicChildren');
      var output = await _generator.generate(element, null);

      expect(output, contains('children = json[\'children\'];'));
    });

    test('class with list of int is cast for strong mode', () async {
      var element = await _getClassForCodeString('Person');
      var output = await _generator.generate(element, null);

      expect(output,
          contains("json['listOfInts'] as List)?.map((v0) => v0 as int)"));
    });
  });

  test('reads JsonKey annotations', () async {
    var element = await _getClassForCodeString('Person');
    var output = await _generator.generate(element, null);

    expect(output, contains("'h': height,"));
    expect(output, contains("..height = json['h']"));
  });
}

const _generator = const JsonSerializableGenerator();

Future<Element> _getClassForCodeString(String name) async {
  if (_compUnit == null) {
    _compUnit = await _getCompilationUnitForString(getPackagePath());
  }

  return getElementsFromLibraryElement(_compUnit.element.library)
      .singleWhere((e) => e.name == name);
}

Future<CompilationUnit> _getCompilationUnitForString(String projectPath) async {
  Source source = new StringSource(_testSource, 'test content');

  var foundFiles = await getDartFiles(projectPath,
      searchList: [p.join(getPackagePath(), 'test', 'test_files')]);

  var context = await getAnalysisContextForProjectPath(projectPath, foundFiles);

  LibraryElement libElement = context.computeLibraryElement(source);
  return context.resolveCompilationUnit(source, libElement);
}

CompilationUnit _compUnit;

const _testSource = r'''
import 'package:source_gen/generators/json_serializable.dart';

@JsonSerializable()
const theAnswer = 42;

@JsonSerializable()
void annotatedMethod() => null;

@JsonSerializable()
class Person {
  String firstName, lastName;
  @JsonKey("h")
  int height;
  DateTime dateOfBirth;
  dynamic dynamicType;
  var varType;
  List<int> listOfInts;
}

@JsonSerializable()
class Order {
  final String firstName, lastName;
  int height;
  DateTime dateOfBirth;

  Order(this.height, String firstName, [this.lastName]);
}

class NoAnnotation {
}

@JsonSerializable()
class FinalFields {
  final int a;
  int get b => 4;

  FinalFields(this.a);
}

@JsonSerializable()
class ParentObject {
  int number;
  String str;
  ChildObject child;
}

@JsonSerializable()
class ChildObject {
  int number;
  String str;

  factory ChildObject.fromJson(json) => null;
}

@JsonSerializable()
class ParentObjectWithChildren {
  int number;
  String str;
  List<ChildObject> children;
}

@JsonSerializable()
class ParentObjectWithDynamicChildren {
  int number;
  String str;
  List<dynamic> children;
}
''';
