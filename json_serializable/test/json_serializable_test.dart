// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'dart:async';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart' as dart_style;
import 'package:json_serializable/json_serializable.dart';
import 'package:json_serializable/src/constants.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'analysis_utils.dart';
import 'test_file_utils.dart';

Matcher _matcherFromShouldGenerateAnnotation(ConstantReader reader,
    {bool wrapped = false}) {
  String expectedOutput;
  if (wrapped) {
    final expectedWrappedOutput = reader.read('expectedWrappedOutput');
    if (expectedWrappedOutput.isNull) {
      return null;
    }
    expectedOutput = expectedWrappedOutput.stringValue;
  } else {
    expectedOutput = reader.read('expectedOutput').stringValue;
  }

  final isContains = reader.read('contains').boolValue;

  if (isContains) {
    return contains(expectedOutput);
  }
  return equals(expectedOutput);
}

Matcher _throwsInvalidGenerationSourceError(messageMatcher, todoMatcher) =>
    throwsA(const TypeMatcher<InvalidGenerationSourceError>()
        .having((e) => e.message, 'message', messageMatcher)
        .having((e) => e.todo, 'todo', todoMatcher)
        .having((e) => e.element, 'element', isNotNull));

Matcher _throwsUnsupportedError(matcher) =>
    throwsA(const TypeMatcher<UnsupportedError>()
        .having((e) => e.message, 'message', matcher));

final _formatter = dart_style.DartFormatter();

LibraryReader _library;

final _buildLogItems = <String>[];

const _expectedAnnotatedTests = {
  '_json_serializable_test_input.dart': [
    'theAnswer',
    'annotatedMethod',
    'Person',
    'Order',
    'FinalFields',
    'FinalFieldsNotSetInCtor',
    'SetSupport',
    'IncludeIfNullOverride',
    'KeyDupesField',
    'DupeKeys',
    'IgnoredFieldClass',
    'IgnoredFieldCtorClass',
    'PrivateFieldCtorClass',
    'IncludeIfNullDisallowNullClass',
    'JsonValueWithBool',
    'JsonValueValid'
  ],
  'checked_test_input.dart': [
    'WithANonCtorGetterChecked',
    'WithANonCtorGetter'
  ],
  'default_value_input.dart': [
    'DefaultWithSymbol',
    'DefaultWithFunction',
    'DefaultWithType',
    'DefaultWithConstObject',
    'DefaultWithNestedEnum',
    'DefaultWithNonNullableField',
    'DefaultWithNonNullableClass'
  ],
  'field_namer_input.dart': [
    'FieldNamerNone',
    'FieldNamerKebab',
    'FieldNamerSnake'
  ],
  'generic_test_input.dart': ['GenericClass'],
  'inheritance_test_input.dart': [
    'SubType',
    'SubTypeWithAnnotatedFieldOverrideExtends',
    'SubTypeWithAnnotatedFieldOverrideExtendsWithOverrides',
    'SubTypeWithAnnotatedFieldOverrideImplements'
  ],
  'json_converter_test_input.dart': [
    'JsonConverterNamedCtor',
    'JsonConverterWithBadTypeArg',
    'JsonConverterDuplicateAnnotations',
    'JsonConverterCtorParams',
  ],
  'setter_test_input.dart': [
    'JustSetter',
    'JustSetterNoToJson',
    'JustSetterNoFromJson'
  ],
  'to_from_json_test_input.dart': [
    'BadFromFuncReturnType',
    'InvalidFromFunc2Args',
    'ValidToFromFuncClassStatic',
    'BadToFuncReturnType',
    'InvalidToFunc2Args',
    'ObjectConvertMethods',
    'DynamicConvertMethods',
    'TypedConvertMethods',
    'FromDynamicCollection',
    'BadNoArgs',
    'BadTwoRequiredPositional',
    'BadOneNamed',
    'OkayOneNormalOptionalPositional',
    'OkayOneNormalOptionalNamed',
    'OkayOnlyOptionalPositional'
  ],
};

void main() async {
  final path = testFilePath('test', 'src');
  _library = await resolveCompilationUnit(path);

  StreamSubscription logSubscription;

  setUp(() {
    assert(_buildLogItems.isEmpty);
    assert(logSubscription == null);
    logSubscription = log.onRecord.listen((r) => _buildLogItems.add(r.message));
  });

  tearDown(() async {
    if (logSubscription != null) {
      await logSubscription.cancel();
      logSubscription = null;
    }

    final remainingItems = _buildLogItems.toList();
    _buildLogItems.clear();
    expect(remainingItems, isEmpty,
        reason:
            'Tests should validate entries and clear this before `tearDown`.');
    _buildLogItems.clear();
  });

  // Only need to run this check once!
  test('[all expected files]', () {
    expect(_annotatedElements.keys, _expectedAnnotatedTests.keys);
  });

  for (final entry in _annotatedElements.entries) {
    group(entry.key, () {
      test('[all expected classes]', () {
        expect(_expectedAnnotatedTests,
            containsPair(entry.key, entry.value.map((ae) => ae.element.name)));
      });

      for (final annotatedElement in entry.value) {
        _testAnnotatedClass(annotatedElement);
      }
    });
  }

  group('without wrappers', () {
    _registerTests(const JsonSerializableGenerator());
  });
  group('with wrapper',
      () => _registerTests(const JsonSerializableGenerator(useWrappers: true)));
}

void _testAnnotatedClass(AnnotatedElement annotatedElement) {
  final annotationName = annotatedElement.annotation.objectValue.type.name;
  switch (annotationName) {
    case 'ShouldThrow':
      _testShouldThrow(annotatedElement);
      break;
    case 'ShouldGenerate':
      _testShouldGenerate(annotatedElement);
      break;
    default:
      throw UnsupportedError("We don't support $annotationName");
  }
}

void _testShouldThrow(AnnotatedElement annotatedElement) {
  final element = annotatedElement.element;
  final constReader = annotatedElement.annotation;
  final messageMatcher = constReader.read('errorMessage').stringValue;
  var todoMatcher = constReader.read('todo').literalValue;

  test(element.name, () {
    todoMatcher ??= isEmpty;

    expect(
        () => _runForElementNamed(
            const JsonSerializableGenerator(useWrappers: false), element.name),
        _throwsInvalidGenerationSourceError(messageMatcher, todoMatcher),
        reason: 'Should fail without wrappers.');

    expect(
        () => _runForElementNamed(
            const JsonSerializableGenerator(useWrappers: true), element.name),
        _throwsInvalidGenerationSourceError(messageMatcher, todoMatcher),
        reason: 'Should fail with wrappers.');
  });
}

void _testShouldGenerate(AnnotatedElement annotatedElement) {
  final element = annotatedElement.element;

  final matcher =
      _matcherFromShouldGenerateAnnotation(annotatedElement.annotation);

  final expectedLogItems = annotatedElement.annotation
      .read('expectedLogItems')
      .listValue
      .map((obj) => obj.toStringValue())
      .toList();

  final checked = annotatedElement.annotation.read('checked').boolValue;

  test(element.name, () {
    final output = _runForElementNamed(
        JsonSerializableGenerator(checked: checked), element.name);
    expect(output, matcher);

    expect(_buildLogItems, expectedLogItems);
    _buildLogItems.clear();
  });

  final wrappedMatcher = _matcherFromShouldGenerateAnnotation(
      annotatedElement.annotation,
      wrapped: true);
  if (wrappedMatcher != null) {
    test('${element.name} - (wrapped)', () {
      final output = _runForElementNamed(
          JsonSerializableGenerator(checked: checked, useWrappers: true),
          element.name);
      expect(output, wrappedMatcher);

      expect(_buildLogItems, expectedLogItems);
      _buildLogItems.clear();
    });
  }
}

String _runForElementNamed(JsonSerializableGenerator generator, String name) {
  final element = _library.allElements.singleWhere((e) => e.name == name);
  final annotation = generator.typeChecker.firstAnnotationOf(element);
  final generated = generator
      .generateForAnnotatedElement(element, ConstantReader(annotation), null)
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .map((e) => '$e\n\n')
      .join();

  final output = _formatter.format(generated);
  printOnFailure("r'''\n$output'''");
  return output;
}

final _annotatedElements = _library.allElements
    .map<AnnotatedElement>((e) {
      for (final md in e.metadata) {
        final reader = ConstantReader(md.constantValue);
        if (const ['ShouldGenerate', 'ShouldThrow']
            .contains(reader.objectValue.type.name)) {
          return AnnotatedElement(reader, e);
        }
      }
      return null;
    })
    .where((ae) => ae != null)
    .fold<Map<String, List<AnnotatedElement>>>(
        <String, List<AnnotatedElement>>{}, (map, annotatedElement) {
      final list = map.putIfAbsent(
          annotatedElement.element.source.uri.pathSegments.last,
          () => <AnnotatedElement>[]);
      list.add(annotatedElement);
      return map;
    });

void _registerTests(JsonSerializableGenerator generator) {
  String runForElementNamed(String name) =>
      _runForElementNamed(generator, name);

  void expectThrows(String elementName, messageMatcher, [todoMatcher]) {
    todoMatcher ??= isEmpty;
    expect(() => runForElementNamed(elementName),
        _throwsInvalidGenerationSourceError(messageMatcher, todoMatcher));
  }

  group('explicit toJson', () {
    test('nullable', () {
      final output = _runForElementNamed(
          JsonSerializableGenerator(
              explicitToJson: true, useWrappers: generator.useWrappers),
          'TrivialNestedNullable');

      final expected = generator.useWrappers
          ? r'''
Map<String, dynamic> _$TrivialNestedNullableToJson(
        TrivialNestedNullable instance) =>
    _$TrivialNestedNullableJsonMapWrapper(instance);

class _$TrivialNestedNullableJsonMapWrapper extends $JsonMapWrapper {
  final TrivialNestedNullable _v;
  _$TrivialNestedNullableJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const ['child', 'otherField'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'child':
          return _v.child?.toJson();
        case 'otherField':
          return _v.otherField;
      }
    }
    return null;
  }
}
'''
          : r'''
Map<String, dynamic> _$TrivialNestedNullableToJson(
        TrivialNestedNullable instance) =>
    <String, dynamic>{
      'child': instance.child?.toJson(),
      'otherField': instance.otherField
    };
''';

      expect(output, expected);
    });
    test('non-nullable', () {
      final output = _runForElementNamed(
          JsonSerializableGenerator(
              explicitToJson: true, useWrappers: generator.useWrappers),
          'TrivialNestedNonNullable');

      final expected = generator.useWrappers
          ? r'''
Map<String, dynamic> _$TrivialNestedNonNullableToJson(
        TrivialNestedNonNullable instance) =>
    _$TrivialNestedNonNullableJsonMapWrapper(instance);

class _$TrivialNestedNonNullableJsonMapWrapper extends $JsonMapWrapper {
  final TrivialNestedNonNullable _v;
  _$TrivialNestedNonNullableJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const ['child', 'otherField'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'child':
          return _v.child.toJson();
        case 'otherField':
          return _v.otherField;
      }
    }
    return null;
  }
}
'''
          : r'''
Map<String, dynamic> _$TrivialNestedNonNullableToJson(
        TrivialNestedNonNullable instance) =>
    <String, dynamic>{
      'child': instance.child.toJson(),
      'otherField': instance.otherField
    };
''';

      expect(output, expected);
    });
  });

  group('unknown types', () {
    tearDown(() {
      expect(_buildLogItems, hasLength(1));
      expect(_buildLogItems.first,
          startsWith('This element has an undefined type.'));
      _buildLogItems.clear();
    });
    String flavorMessage(String flavor) =>
        'Could not generate `$flavor` code for `number` '
        'because the type is undefined.';

    String flavorTodo(String flavor) =>
        'Check your imports. If you\'re trying to generate code for a '
        'Platform-provided type, you may have to specify a custom `$flavor` '
        'in the associated `@JsonKey` annotation.';

    group('fromJson', () {
      final msg = flavorMessage('fromJson');
      final todo = flavorTodo('fromJson');
      test('in constructor arguments', () {
        expectThrows('UnknownCtorParamType', msg, todo);
      });

      test('in fields', () {
        expectThrows('UnknownFieldType', msg, todo);
      });
    });

    group('toJson', () {
      test('in fields', () {
        expectThrows('UnknownFieldTypeToJsonOnly', flavorMessage('toJson'),
            flavorTodo('toJson'));
      });
    });

    test('with proper convert methods', () {
      final output = runForElementNamed('UnknownFieldTypeWithConvert');
      expect(output, contains("_everythingIs42(json['number'])"));
      if (generator.useWrappers) {
        expect(output, contains('_everythingIs42(_v.number)'));
      } else {
        expect(output, contains('_everythingIs42(instance.number)'));
      }
    });
  });

  group('unserializable types', () {
    final noSupportHelperFyi = 'Could not generate `toJson` code for `watch`.\n'
        'None of the provided `TypeHelper` instances support the defined type.';

    test('for toJson', () {
      expectThrows('NoSerializeFieldType', noSupportHelperFyi,
          'Make sure all of the types are serializable.');
    });

    test('for fromJson', () {
      expectThrows(
          'NoDeserializeFieldType',
          noSupportHelperFyi.replaceFirst('toJson', 'fromJson'),
          'Make sure all of the types are serializable.');
    });

    final mapKeyFyi = 'Could not generate `toJson` code for `intDateTimeMap` '
        'because of type `int`.\nMap keys must be of type '
        '`String`, enum, `Object` or `dynamic`.';

    test('for toJson in Map key', () {
      expectThrows('NoSerializeBadKey', mapKeyFyi,
          'Make sure all of the types are serializable.');
    });

    test('for fromJson', () {
      expectThrows(
          'NoDeserializeBadKey',
          mapKeyFyi.replaceFirst('toJson', 'fromJson'),
          'Make sure all of the types are serializable.');
    });
  });

  test('class with final fields', () {
    final generateResult = runForElementNamed('FinalFields');
    expect(
        generateResult,
        contains(
            r'Map<String, dynamic> _$FinalFieldsToJson(FinalFields instance)'));
  });

  group('valid inputs', () {
    test('class with fromJson() constructor with optional parameters', () {
      final output = runForElementNamed('FromJsonOptionalParameters');

      expect(output, contains('ChildWithFromJson.fromJson'));
    });

    test('class with child json-able object', () {
      final output = runForElementNamed('ParentObject');

      expect(
          output,
          contains("ChildObject.fromJson(json['child'] "
              'as Map<String, dynamic>)'));
    });

    test('class with child json-able object - anyMap', () {
      final output = _runForElementNamed(
          JsonSerializableGenerator(
              anyMap: true, useWrappers: generator.useWrappers),
          'ParentObject');

      expect(output, contains("ChildObject.fromJson(json['child'] as Map)"));
    });

    test('class with child list of json-able objects', () {
      final output = runForElementNamed('ParentObjectWithChildren');

      expect(output, contains('.toList()'));
      expect(output, contains('ChildObject.fromJson'));
    });

    test('class with child list of dynamic objects is left alone', () {
      final output = runForElementNamed('ParentObjectWithDynamicChildren');

      expect(output, contains('children = json[\'children\'] as List;'));
    });

    test('class with list of int is cast for strong mode', () {
      final output = runForElementNamed('Person');

      expect(output,
          contains("json['listOfInts'] as List)?.map((e) => e as int)"));
    });
  });

  group('includeIfNull', () {
    test('some', () {
      final output = runForElementNamed('IncludeIfNullAll');
      expect(output, isNot(contains(generatedLocalVarName)));
      expect(output, isNot(contains(toJsonMapHelperName)));
    });
  });

  test('missing default ctor with a factory', () {
    expect(
        () => runForElementNamed('NoCtorClass'),
        _throwsUnsupportedError(
            'The class `NoCtorClass` has no default constructor.'));
  });
}
