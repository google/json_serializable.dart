// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')

import 'package:dart_style/dart_style.dart' as dart_style;
import 'package:json_serializable/json_serializable.dart';
import 'package:json_serializable/src/constants.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'analysis_utils.dart';
import 'test_file_utils.dart';

Matcher _matcherFromShouldGenerateAnnotation(ConstantReader reader) {
  var expectedOutput = reader.read('expectedOutput').stringValue;
  var isContains = reader.read('contains').boolValue;

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

void main() async {
  var path = testFilePath('test', 'src');
  _library = await resolveCompilationUnit(path);

  group('without wrappers',
      () => _registerTests(const JsonSerializableGenerator()));
  group('with wrapper',
      () => _registerTests(const JsonSerializableGenerator(useWrappers: true)));
}

String _runForElementNamed(JsonSerializableGenerator generator, String name) {
  var element = _library.allElements.singleWhere((e) => e.name == name);
  var annotation = generator.typeChecker.firstAnnotationOf(element);
  var generated = generator
      .generateForAnnotatedElement(element, ConstantReader(annotation), null)
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .map((e) => '$e\n\n')
      .join();

  var output = _formatter.format(generated);
  printOnFailure("r'''\n$output'''");
  return output;
}

List<AnnotatedElement> _annotatedWithName(String name) => _library.allElements
    .map((e) {
      for (var md in e.metadata) {
        var reader = ConstantReader(md.constantValue);
        if (reader.objectValue.type.name == name) {
          return AnnotatedElement(reader, e);
        }
      }
      return null;
    })
    .where((ae) => ae != null)
    .toList()
      ..sort((a, b) => a.element.name.compareTo(b.element.name));

void _registerTests(JsonSerializableGenerator generator) {
  String runForElementNamed(String name) =>
      _runForElementNamed(generator, name);

  void expectThrows(String elementName, messageMatcher, [todoMatcher]) {
    todoMatcher ??= isEmpty;
    expect(() => runForElementNamed(elementName),
        _throwsInvalidGenerationSourceError(messageMatcher, todoMatcher));
  }

  group('fails when generating for', () {
    var annotatedElements = _annotatedWithName('ShouldThrow');

    test('all expected members', () {
      expect(annotatedElements.map((ae) => ae.element.name), [
        'BadFromFuncReturnType',
        'BadNoArgs',
        'BadOneNamed',
        'BadToFuncReturnType',
        'BadTwoRequiredPositional',
        'DefaultWithConstObject',
        'DefaultWithFunction',
        'DefaultWithNestedEnum',
        'DefaultWithNonNullableClass',
        'DefaultWithNonNullableField',
        'DefaultWithSymbol',
        'DefaultWithType',
        'DupeKeys',
        'IgnoredFieldCtorClass',
        'IncludeIfNullDisallowNullClass',
        'InvalidFromFunc2Args',
        'InvalidFromFuncClassStatic',
        'InvalidToFunc2Args',
        'InvalidToFuncClassStatic',
        'JsonValueWithBool',
        'KeyDupesField',
        'PrivateFieldCtorClass',
        'annotatedMethod',
        'theAnswer',
      ]);
    });

    for (var annotatedElement in annotatedElements) {
      var element = annotatedElement.element;
      var constReader = annotatedElement.annotation;
      var testDescription = constReader.read('testDescription').stringValue;
      var messageMatcher = constReader.read('errorMessage').stringValue;
      var todoMatcher = constReader.read('todo').literalValue;

      test('$testDescription (${element.name})', () {
        expectThrows(
            annotatedElement.element.name, messageMatcher, todoMatcher);
      });
    }
  });

  if (!generator.useWrappers) {
    group('succeeds when generating for', () {
      var annotatedElements = _annotatedWithName('ShouldGenerate');

      test('all expected members', () {
        expect(annotatedElements.map((ae) => ae.element.name), [
          'DynamicConvertMethods',
          'FieldNamerKebab',
          'FieldNamerNone',
          'FieldNamerSnake',
          'FromDynamicCollection',
          'IgnoredFieldClass',
          'IncludeIfNullOverride',
          'JsonValueValid',
          'ObjectConvertMethods',
          'OkayOneNormalOptionalNamed',
          'OkayOneNormalOptionalPositional',
          'OkayOnlyOptionalPositional',
          'Order',
          'Person',
          'TypedConvertMethods',
        ]);
      });

      for (var annotatedElement in annotatedElements) {
        var element = annotatedElement.element;

        var matcher =
            _matcherFromShouldGenerateAnnotation(annotatedElement.annotation);

        test(element.name, () {
          var output = _runForElementNamed(generator, element.name);
          expect(output, matcher);
        });
      }
    });
  }

  group('explicit toJson', () {
    test('nullable', () {
      var output = _runForElementNamed(
          JsonSerializableGenerator(
              explicitToJson: true, useWrappers: generator.useWrappers),
          'TrivialNestedNullable');

      var expected = generator.useWrappers
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
      var output = _runForElementNamed(
          JsonSerializableGenerator(
              explicitToJson: true, useWrappers: generator.useWrappers),
          'TrivialNestedNonNullable');

      var expected = generator.useWrappers
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
    String flavorMessage(String flavor) =>
        'Could not generate `$flavor` code for `number` '
        'because the type is undefined.';

    String flavorTodo(String flavor) =>
        'Check your imports. If you\'re trying to generate code for a '
        'Platform-provided type, you may have to specify a custom `$flavor` '
        'in the associated `@JsonKey` annotation.';

    group('fromJson', () {
      var msg = flavorMessage('fromJson');
      var todo = flavorTodo('fromJson');
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
      var output = runForElementNamed('UnknownFieldTypeWithConvert');
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
    var generateResult = runForElementNamed('FinalFields');
    expect(
        generateResult,
        contains(
            r'Map<String, dynamic> _$FinalFieldsToJson(FinalFields instance)'));
  });

  if (!generator.useWrappers) {
    test('includes final field in toJson when set in ctor', () {
      var generateResult = runForElementNamed('FinalFields');
      expect(generateResult, contains('FinalFields(json[\'a\'] as int);'));
      expect(generateResult, contains('<String, dynamic>{\'a\': instance.a};'));
    });

    test('excludes final field in toJson when not set in ctor', () {
      var generateResult = runForElementNamed('FinalFieldsNotSetInCtor');
      expect(
          generateResult, isNot(contains('FinalFields(json[\'a\'] as int);')));
      expect(generateResult,
          isNot(contains('toJson() => <String, dynamic>{\'a\': a};')));
    });
  }

  group('valid inputs', () {
    test('class with fromJson() constructor with optional parameters', () {
      var output = runForElementNamed('FromJsonOptionalParameters');

      expect(output, contains('ChildWithFromJson.fromJson'));
    });

    test('class with child json-able object', () {
      var output = runForElementNamed('ParentObject');

      expect(
          output,
          contains("ChildObject.fromJson(json['child'] "
              'as Map<String, dynamic>)'));
    });

    test('class with child json-able object - anyMap', () {
      var output = _runForElementNamed(
          JsonSerializableGenerator(
              anyMap: true, useWrappers: generator.useWrappers),
          'ParentObject');

      expect(output, contains("ChildObject.fromJson(json['child'] as Map)"));
    });

    test('class with child list of json-able objects', () {
      var output = runForElementNamed('ParentObjectWithChildren');

      expect(output, contains('.toList()'));
      expect(output, contains('ChildObject.fromJson'));
    });

    test('class with child list of dynamic objects is left alone', () {
      var output = runForElementNamed('ParentObjectWithDynamicChildren');

      expect(output, contains('children = json[\'children\'] as List;'));
    });

    test('class with list of int is cast for strong mode', () {
      var output = runForElementNamed('Person');

      expect(output,
          contains("json['listOfInts'] as List)?.map((e) => e as int)"));
    });
  });

  group('includeIfNull', () {
    test('some', () {
      var output = runForElementNamed('IncludeIfNullAll');
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

  test('generic classes', () {
    var output = runForElementNamed('GenericClass');

    var expected = generator.useWrappers
        ? r'''
GenericClass<T, S> _$GenericClassFromJson<T extends num, S>(
    Map<String, dynamic> json) {
  return GenericClass<T, S>()
    ..fieldObject =
        json['fieldObject'] == null ? null : _dataFromJson(json['fieldObject'])
    ..fieldDynamic = json['fieldDynamic'] == null
        ? null
        : _dataFromJson(json['fieldDynamic'])
    ..fieldInt =
        json['fieldInt'] == null ? null : _dataFromJson(json['fieldInt'])
    ..fieldT = json['fieldT'] == null ? null : _dataFromJson(json['fieldT'])
    ..fieldS = json['fieldS'] == null ? null : _dataFromJson(json['fieldS']);
}

Map<String, dynamic> _$GenericClassToJson<T extends num, S>(
        GenericClass<T, S> instance) =>
    _$GenericClassJsonMapWrapper<T, S>(instance);

class _$GenericClassJsonMapWrapper<T extends num, S> extends $JsonMapWrapper {
  final GenericClass<T, S> _v;
  _$GenericClassJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys =>
      const ['fieldObject', 'fieldDynamic', 'fieldInt', 'fieldT', 'fieldS'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'fieldObject':
          return _v.fieldObject == null ? null : _dataToJson(_v.fieldObject);
        case 'fieldDynamic':
          return _v.fieldDynamic == null ? null : _dataToJson(_v.fieldDynamic);
        case 'fieldInt':
          return _v.fieldInt == null ? null : _dataToJson(_v.fieldInt);
        case 'fieldT':
          return _v.fieldT == null ? null : _dataToJson(_v.fieldT);
        case 'fieldS':
          return _v.fieldS == null ? null : _dataToJson(_v.fieldS);
      }
    }
    return null;
  }
}
'''
        : r'''
GenericClass<T, S> _$GenericClassFromJson<T extends num, S>(
    Map<String, dynamic> json) {
  return GenericClass<T, S>()
    ..fieldObject =
        json['fieldObject'] == null ? null : _dataFromJson(json['fieldObject'])
    ..fieldDynamic = json['fieldDynamic'] == null
        ? null
        : _dataFromJson(json['fieldDynamic'])
    ..fieldInt =
        json['fieldInt'] == null ? null : _dataFromJson(json['fieldInt'])
    ..fieldT = json['fieldT'] == null ? null : _dataFromJson(json['fieldT'])
    ..fieldS = json['fieldS'] == null ? null : _dataFromJson(json['fieldS']);
}

Map<String, dynamic> _$GenericClassToJson<T extends num, S>(
        GenericClass<T, S> instance) =>
    <String, dynamic>{
      'fieldObject': instance.fieldObject == null
          ? null
          : _dataToJson(instance.fieldObject),
      'fieldDynamic': instance.fieldDynamic == null
          ? null
          : _dataToJson(instance.fieldDynamic),
      'fieldInt':
          instance.fieldInt == null ? null : _dataToJson(instance.fieldInt),
      'fieldT': instance.fieldT == null ? null : _dataToJson(instance.fieldT),
      'fieldS': instance.fieldS == null ? null : _dataToJson(instance.fieldS)
    };
''';

    expect(output, expected);
  });

  test('super types', () {
    var output = runForElementNamed('SubType');

    var expected = generator.useWrappers
        ? r'''
SubType _$SubTypeFromJson(Map<String, dynamic> json) {
  return SubType(
      json['subTypeViaCtor'] as int, json['super-type-via-ctor'] as int)
    ..superTypeReadWrite = json['superTypeReadWrite'] as int
    ..subTypeReadWrite = json['subTypeReadWrite'] as int;
}

Map<String, dynamic> _$SubTypeToJson(SubType instance) =>
    _$SubTypeJsonMapWrapper(instance);

class _$SubTypeJsonMapWrapper extends $JsonMapWrapper {
  final SubType _v;
  _$SubTypeJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys sync* {
    yield 'super-type-via-ctor';
    if (_v.superTypeReadWrite != null) {
      yield 'superTypeReadWrite';
    }
    yield 'subTypeViaCtor';
    yield 'subTypeReadWrite';
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'super-type-via-ctor':
          return _v.superTypeViaCtor;
        case 'superTypeReadWrite':
          return _v.superTypeReadWrite;
        case 'subTypeViaCtor':
          return _v.subTypeViaCtor;
        case 'subTypeReadWrite':
          return _v.subTypeReadWrite;
      }
    }
    return null;
  }
}
'''
        : r'''
SubType _$SubTypeFromJson(Map<String, dynamic> json) {
  return SubType(
      json['subTypeViaCtor'] as int, json['super-type-via-ctor'] as int)
    ..superTypeReadWrite = json['superTypeReadWrite'] as int
    ..subTypeReadWrite = json['subTypeReadWrite'] as int;
}

Map<String, dynamic> _$SubTypeToJson(SubType instance) {
  var val = <String, dynamic>{
    'super-type-via-ctor': instance.superTypeViaCtor,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('superTypeReadWrite', instance.superTypeReadWrite);
  val['subTypeViaCtor'] = instance.subTypeViaCtor;
  val['subTypeReadWrite'] = instance.subTypeReadWrite;
  return val;
}
''';

    expect(output, expected);
  });
}
