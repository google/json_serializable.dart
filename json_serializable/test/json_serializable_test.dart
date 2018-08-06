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
import 'src/annotation.dart';
import 'test_file_utils.dart';

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

const _shouldThrowChecker = TypeChecker.fromRuntime(ShouldThrow);

void main() async {
  var path = testFilePath('test', 'src', 'json_serializable_test_input.dart');
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
  printOnFailure(output);
  return output;
}

void _registerTests(JsonSerializableGenerator generator) {
  String runForElementNamed(String name) =>
      _runForElementNamed(generator, name);

  void expectThrows(String elementName, messageMatcher, [todoMatcher]) {
    if (messageMatcher == null) {
      var element =
          _library.allElements.singleWhere((e) => e.name == elementName);

      var constantValue = _shouldThrowChecker.firstAnnotationOfExact(element);
      messageMatcher = constantValue.getField('errorMessage').toStringValue();
      todoMatcher ??= constantValue.getField('todo').toStringValue();
    }
    todoMatcher ??= isEmpty;
    expect(() => runForElementNamed(elementName),
        _throwsInvalidGenerationSourceError(messageMatcher, todoMatcher));
  }

  group('fails when generating for', () {
    var annotatedElements = _library
        .annotatedWithExact(_shouldThrowChecker)
        .toList()
          ..sort((a, b) => a.element.name.compareTo(b.element.name));

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
        'IncludeIfNullDisallowNullClass',
        'InvalidFromFunc2Args',
        'InvalidFromFuncClassStatic',
        'InvalidToFunc2Args',
        'InvalidToFuncClassStatic',
        'JsonValueWithBool',
        'KeyDupesField',
        'annotatedMethod',
        'theAnswer',
      ]);
    });

    for (var annotatedElement in annotatedElements) {
      var element = annotatedElement.element;
      var constantValue = _shouldThrowChecker.firstAnnotationOfExact(element);
      var testDescription =
          constantValue.getField('testDescription').toStringValue();
      var messageMatcher =
          constantValue.getField('errorMessage').toStringValue();
      var todoMatcher = constantValue.getField('todo').toStringValue();

      test('$testDescription (${element.name})', () {
        expectThrows(
            annotatedElement.element.name, messageMatcher, todoMatcher);
      });
    }
  });

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
    if (!generator.useWrappers) {
      test('class with no ctor params', () {
        var output = runForElementNamed('Person');
        expect(output, r'''
Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..height = json['h'] as int
    ..dateOfBirth = json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String)
    ..dynamicType = json['dynamicType']
    ..varType = json['varType']
    ..listOfInts = (json['listOfInts'] as List)?.map((e) => e as int)?.toList();
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'h': instance.height,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'dynamicType': instance.dynamicType,
      'varType': instance.varType,
      'listOfInts': instance.listOfInts
    };
''');
      });

      test('class with ctor params', () {
        var output = runForElementNamed('Order');
        expect(output, r'''
Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(json['height'] as int, json['firstName'] as String,
      json['lastName'] as String)
    ..dateOfBirth = json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String);
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'height': instance.height,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String()
    };
''');
      });
    }

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

  group('JsonKey', () {
    if (!generator.useWrappers) {
      test('works to change the name of a field', () {
        var output = runForElementNamed('Person');

        expect(output, contains("'h': instance.height,"));
        expect(output, contains("..height = json['h']"));
      });

      test('works to ignore a field', () {
        var output = runForElementNamed('IgnoredFieldClass');

        expect(output,
            contains("'ignoredFalseField': instance.ignoredFalseField"));
        expect(
            output, contains("'ignoredNullField': instance.ignoredNullField"));
        expect(output,
            isNot(contains("'ignoredTrueField': instance.ignoredTrueField")));
      });

      test('fails if ignored field is referenced by ctor', () {
        expect(
            () => runForElementNamed('IgnoredFieldCtorClass'),
            _throwsUnsupportedError(
                'Cannot populate the required constructor argument: '
                'ignoredTrueField. It is assigned to an ignored field.'));
      });

      test('fails if private field is referenced by ctor', () {
        expect(
            () => runForElementNamed('PrivateFieldCtorClass'),
            _throwsUnsupportedError(
                'Cannot populate the required constructor argument: '
                '_privateField. It is assigned to a private field.'));
      });
    }
  });

  group('includeIfNull', () {
    test('some', () {
      var output = runForElementNamed('IncludeIfNullAll');
      expect(output, isNot(contains(generatedLocalVarName)));
      expect(output, isNot(contains(toJsonMapHelperName)));
    });

    if (!generator.useWrappers) {
      test('all', () {
        var output = runForElementNamed('IncludeIfNullOverride');
        expect(output, contains(r"'number': instance.number"));
        expect(output, contains(r"writeNotNull('str', instance.str);"));
      });
    }
  });

  group('functions', () {
    if (!generator.useWrappers) {
      test('object', () {
        var output = runForElementNamed('ObjectConvertMethods');
        expect(output, contains("_toObject(json['field'])"));
      });
      test('dynamic', () {
        var output = runForElementNamed('DynamicConvertMethods');
        expect(output, contains("_toDynamic(json['field'])"));
      });
      test('typed', () {
        var output = runForElementNamed('TypedConvertMethods');
        expect(output, contains("_toString(json['field'] as String)"));
      });
      test('dynamic collections', () {
        var output = runForElementNamed('FromDynamicCollection');
        expect(output, r'''
FromDynamicCollection _$FromDynamicCollectionFromJson(
    Map<String, dynamic> json) {
  return FromDynamicCollection()
    ..mapField = json['mapField'] == null
        ? null
        : _fromDynamicMap(json['mapField'] as Map)
    ..listField = json['listField'] == null
        ? null
        : _fromDynamicList(json['listField'] as List)
    ..iterableField = json['iterableField'] == null
        ? null
        : _fromDynamicIterable(json['iterableField'] as List);
}
''');
      });
      test('OkayOneNormalOptionalPositional', () {
        var output = runForElementNamed('OkayOneNormalOptionalPositional');
        expect(output, contains("_oneNormalOnePositional(json['field'])"));
      });
      test('OkayOneNormalOptionalNamed', () {
        var output = runForElementNamed('OkayOneNormalOptionalNamed');
        expect(output, contains("_oneNormalOptionalNamed(json['field'])"));
      });
      test('OkayOnlyOptionalPositional', () {
        var output = runForElementNamed('OkayOnlyOptionalPositional');
        expect(output, contains("_onlyOptionalPositional(json['field'])"));
      });
    }
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

  if (!generator.useWrappers) {
    group('enums annotated with JsonValue', () {
      test('can be interesting', () {
        var output = runForElementNamed('JsonValueValid');

        expect(output, contains(r'''
const _$GoodEnumEnumMap = <GoodEnum, dynamic>{
  GoodEnum.noAnnotation: 'noAnnotation',
  GoodEnum.stringAnnotation: 'string annotation',
  GoodEnum.stringAnnotationWeird: r"string annotation with $ funky 'values'",
  GoodEnum.intValue: 42,
  GoodEnum.nullValue: null
};
'''));
      });
    });
  }
}
