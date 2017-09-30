// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('!browser')
library json_serializable.test.json_generator_test;

import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/src/string_source.dart';
import 'package:dart_style/dart_style.dart' as dart_style;
import 'package:json_serializable/generators.dart';
import 'package:json_serializable/src/utils.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'analysis_utils.dart';
import 'src/io.dart';
import 'test_utils.dart';

void main() {
  setUpAll(() async {
    _compUnit = await _getCompilationUnitForString(getPackagePath());
  });

  group('non-classes', () {
    test('const field', () async {
      expect(
          _runForElementNamed('theAnswer'),
          throwsInvalidGenerationSourceError(
              'Generator cannot target `const dynamic theAnswer`.',
              'Remove the JsonSerializable annotation from `const dynamic theAnswer`.'));
    });

    test('method', () async {
      expect(
          _runForElementNamed('annotatedMethod'),
          throwsInvalidGenerationSourceError(
              'Generator cannot target `annotatedMethod`.',
              'Remove the JsonSerializable annotation from `annotatedMethod`.'));
    });
  });
  group('unknown types', () {
    test('in constructor arguments', () async {
      expect(
          _runForElementNamed('UnknownCtorParamType'),
          throwsInvalidGenerationSourceError(
              'At least one constructor argument has an invalid type: `number`.',
              'Check names and imports.'));
    });

    test('in fields', () async {
      expect(
          _runForElementNamed('UnknownFieldType'),
          throwsInvalidGenerationSourceError(
              'At least one field has an invalid type: `number`.',
              'Check names and imports.'));
    });
  });

  group('unserializable types', () {
    test('for toJson', () async {
      expect(
          _runForElementNamed('NoSerializeFieldType'),
          throwsInvalidGenerationSourceError(
              'Could not generate `toJson` code for `Stopwatch watch`.',
              'Make sure all of the types are serializable.'));
    });

    test('for fromJson', () async {
      expect(
          _runForElementNamed('NoDeserializeFieldType'),
          throwsInvalidGenerationSourceError(
              'Could not generate fromJson code for `Stopwatch watch`.',
              'Make sure all of the types are serializable.'));
    });

    test('for toJson in Map key', () async {
      expect(
          _runForElementNamed('NoSerializeBadKey'),
          throwsInvalidGenerationSourceError(
              'Could not generate `toJson` code for `Map<int, DateTime> intDateTimeMap`.',
              'Make sure all of the types are serializable.'));
    });

    test('for fromJson', () async {
      expect(
          _runForElementNamed('NoDeserializeBadKey'),
          throwsInvalidGenerationSourceError(
              'Could not generate fromJson code for `Map<int, DateTime> intDateTimeMap`.',
              'Make sure all of the types are serializable.'));
    });
  });

  test('class with final fields', () async {
    var generateResult = await _runForElementNamed('FinalFields');
    expect(generateResult, contains('Map<String, dynamic> toJson()'));
  });

  group('valid inputs', () {
    test('class with no ctor params', () async {
      var output = await _runForElementNamed('Person');
      expect(output,
          r'''Person _$PersonFromJson(Map<String, dynamic> json) => new Person()
  ..firstName = json['firstName'] as String
  ..lastName = json['lastName'] as String
  ..height = json['h'] as int
  ..dateOfBirth = json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String)
  ..dynamicType = json['dynamicType']
  ..varType = json['varType']
  ..listOfInts = (json['listOfInts'] as List)?.map((e) => e as int)?.toList();

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get lastName;
  int get height;
  DateTime get dateOfBirth;
  dynamic get dynamicType;
  dynamic get varType;
  List<int> get listOfInts;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'h': height,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'dynamicType': dynamicType,
        'varType': varType,
        'listOfInts': listOfInts
      };
}
''');
    });

    test('class with ctor params', () async {
      var output = await _runForElementNamed('Order');
      expect(output,
          r'''Order _$OrderFromJson(Map<String, dynamic> json) => new Order(
    json['height'] as int,
    json['firstName'] as String,
    json['lastName'] as String)
  ..dateOfBirth = json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String);

abstract class _$OrderSerializerMixin {
  String get firstName;
  String get lastName;
  int get height;
  DateTime get dateOfBirth;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'height': height,
        'dateOfBirth': dateOfBirth?.toIso8601String()
      };
}
''');
    });

    test('class with child json-able object', () async {
      var output = await _runForElementNamed('ParentObject');

      expect(output, contains('new ChildObject.fromJson'));
    });

    test('class with child list of json-able objects', () async {
      var output = await _runForElementNamed('ParentObjectWithChildren');

      expect(output, contains('.toList()'));
      expect(output, contains('new ChildObject.fromJson'));
    });

    test('class with child list of dynamic objects is left alone', () async {
      var output = await _runForElementNamed('ParentObjectWithDynamicChildren');

      expect(output, contains('children = json[\'children\'] as List;'));
    });

    test('class with list of int is cast for strong mode', () async {
      var output = await _runForElementNamed('Person');

      expect(output,
          contains("json['listOfInts'] as List)?.map((e) => e as int)"));
    });
  });

  test('reads JsonKey annotations', () async {
    var output = await _runForElementNamed('Person');

    expect(output, contains("'h': height,"));
    expect(output, contains("..height = json['h']"));
  });

  group('includeIfNull', () {
    test('some', () async {
      var output = await _runForElementNamed('IncludeIfNullAll');
      expect(output, isNot(contains(toJsonMapVarName)));
      expect(output, isNot(contains(toJsonMapHelperName)));
    });

    test('all', () async {
      var output = await _runForElementNamed('IncludeIfNullOverride');
      expect(output, contains("'number': number,"));
      expect(output, contains("$toJsonMapHelperName('str', str);"));
    });
  });

  test('missing default ctor with a factory', () async {
    expect(
        () => _runForElementNamed('NoCtorClass'),
        throwsA(new FeatureMatcher<UnsupportedError>(
            'message',
            (e) => e.message,
            'The class `NoCtorClass` has no default constructor.')));
  });
}

const _generator = const JsonSerializableGenerator();

final _formatter = new dart_style.DartFormatter();

Future<String> _runForElementNamed(String name) async {
  var library = new LibraryReader(_compUnit.element.library);
  var element = library.allElements.singleWhere((e) => e.name == name);
  var annotation = _generator.typeChecker.firstAnnotationOf(element);
  var generated = await _generator.generateForAnnotatedElement(
      element, new ConstantReader(annotation), null);

  return _formatter.format(generated);
}

Future<CompilationUnit> _getCompilationUnitForString(String projectPath) async {
  var source = new StringSource(_testSource, 'test content');

  var foundFiles = await getDartFiles(projectPath,
      searchList: [p.join(getPackagePath(), 'test', 'test_files')]);

  var context = await getAnalysisContextForProjectPath(projectPath, foundFiles);

  var libElement = context.computeLibraryElement(source);
  return context.resolveCompilationUnit(source, libElement);
}

CompilationUnit _compUnit;

const _testSource = r'''
import 'package:json_serializable/annotations.dart';

@JsonSerializable()
const theAnswer = 42;

@JsonSerializable()
void annotatedMethod() => null;

@JsonSerializable()
class Person {
  String firstName, lastName;
  @JsonKey(name: 'h')
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

@JsonSerializable()
class UnknownCtorParamType {
  int number;
  
  UnknownCtorParamType(Bob number) : this.number = number;
}

@JsonSerializable()
class UnknownFieldType {
  Bob number;
}

@JsonSerializable(createFactory: false)
class NoSerializeFieldType {
  Stopwatch watch;
}

@JsonSerializable(createToJson: false)
class NoDeserializeFieldType {
  Stopwatch watch;
}

@JsonSerializable(createFactory: false)
class NoSerializeBadKey {
  Map<int, DateTime> intDateTimeMap;
}

@JsonSerializable(createToJson: false)
class NoDeserializeBadKey {
  Map<int, DateTime> intDateTimeMap;
}

@JsonSerializable(createFactory: false)
class IncludeIfNullAll {
  @JsonKey(includeIfNull: true)
  int number;
  String str;
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class IncludeIfNullOverride {
  @JsonKey(includeIfNull: true)
  int number;
  String str;
}

// https://github.com/dart-lang/json_serializable/issues/7 regression
@JsonSerializable()
class NoCtorClass {
  final int member;
  
  factory TestDoneEvent.fromJson(Map<String, dynamic> json) => null;
}
''';
