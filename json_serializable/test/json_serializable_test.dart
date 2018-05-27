// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')

import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_style/dart_style.dart' as dart_style;
import 'package:json_serializable/json_serializable.dart';
import 'package:json_serializable/src/constants.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'analysis_utils.dart';
import 'test_file_utils.dart';
import 'test_utils.dart';

Matcher _throwsInvalidGenerationSourceError(messageMatcher, todoMatcher) =>
    throwsA(allOf(
        const isInstanceOf<InvalidGenerationSourceError>(),
        new FeatureMatcher<InvalidGenerationSourceError>(
            'message', (e) => e.message, messageMatcher),
        new FeatureMatcher<InvalidGenerationSourceError>(
            'todo', (e) => e.todo, todoMatcher),
        new FeatureMatcher<InvalidGenerationSourceError>(
            'element', (e) => e.element, isNotNull)));

final _formatter = new dart_style.DartFormatter();

CompilationUnit _compilationUnit;

void main() {
  setUpAll(() async {
    var path = testFilePath('test', 'src', 'json_serializable_test_input.dart');
    _compilationUnit = await resolveCompilationUnit(path);
  });

  group('without wrappers',
      () => _registerTests(const JsonSerializableGenerator()));
  group('with wrapper',
      () => _registerTests(const JsonSerializableGenerator(useWrappers: true)));
}

Future<String> _runForElementNamed(
    JsonSerializableGenerator generator, String name) async {
  var library = new LibraryReader(_compilationUnit.element.library);
  var element = library.allElements.singleWhere((e) => e.name == name);
  var annotation = generator.typeChecker.firstAnnotationOf(element);
  var generated = await generator.generateForAnnotatedElement(
      element, new ConstantReader(annotation), null);

  var output = _formatter.format(generated);
  printOnFailure(output);
  return output;
}

void _registerTests(JsonSerializableGenerator generator) {
  Future<String> runForElementNamed(String name) =>
      _runForElementNamed(generator, name);

  void expectThrows(String elementName, messageMatcher, [todoMatcher]) {
    todoMatcher ??= isEmpty;
    expect(() => runForElementNamed(elementName),
        _throwsInvalidGenerationSourceError(messageMatcher, todoMatcher));
  }

  group('explicit toJson', () {
    test('nullable', () async {
      var output = await _runForElementNamed(
          new JsonSerializableGenerator(
              explicitToJson: true, useWrappers: generator.useWrappers),
          'TrivialNestedNullable');

      var expected = generator.useWrappers
          ? r'''abstract class _$TrivialNestedNullableSerializerMixin {
  TrivialNestedNullable get child;
  int get otherField;
  Map<String, dynamic> toJson() =>
      new _$TrivialNestedNullableJsonMapWrapper(this);
}

class _$TrivialNestedNullableJsonMapWrapper extends $JsonMapWrapper {
  final _$TrivialNestedNullableSerializerMixin _v;
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
          : r'''abstract class _$TrivialNestedNullableSerializerMixin {
  TrivialNestedNullable get child;
  int get otherField;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'child': child?.toJson(), 'otherField': otherField};
}
''';

      expect(output, expected);
    });
    test('non-nullable', () async {
      var output = await _runForElementNamed(
          new JsonSerializableGenerator(
              explicitToJson: true, useWrappers: generator.useWrappers),
          'TrivialNestedNonNullable');

      var expected = generator.useWrappers
          ? r'''abstract class _$TrivialNestedNonNullableSerializerMixin {
  TrivialNestedNonNullable get child;
  int get otherField;
  Map<String, dynamic> toJson() =>
      new _$TrivialNestedNonNullableJsonMapWrapper(this);
}

class _$TrivialNestedNonNullableJsonMapWrapper extends $JsonMapWrapper {
  final _$TrivialNestedNonNullableSerializerMixin _v;
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
          : r'''abstract class _$TrivialNestedNonNullableSerializerMixin {
  TrivialNestedNonNullable get child;
  int get otherField;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'child': child.toJson(), 'otherField': otherField};
}
''';

      expect(output, expected);
    });
  });

  group('non-classes', () {
    test('const field', () {
      expectThrows('theAnswer', 'Generator cannot target `theAnswer`.',
          'Remove the JsonSerializable annotation from `theAnswer`.');
    });

    test('method', () {
      expectThrows(
          'annotatedMethod',
          'Generator cannot target `annotatedMethod`.',
          'Remove the JsonSerializable annotation from `annotatedMethod`.');
    });
  });
  group('unknown types', () {
    test('in constructor arguments', () {
      expectThrows(
          'UnknownCtorParamType',
          'At least one constructor argument has an invalid type: `number`.',
          'Check names and imports.');
    });

    test('in fields', () {
      expectThrows(
          'UnknownFieldType',
          'At least one field has an invalid type: `number`.',
          'Check names and imports.');
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

    final mapKeyFyi = 'Could not generate `toJson` code for '
        '`intDateTimeMap` because of type `int`.\n'
        'The type of the Map key must be `String`, `Object` or `dynamic`.';

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

  test('class with final fields', () async {
    var generateResult = await runForElementNamed('FinalFields');
    expect(generateResult, contains('Map<String, dynamic> toJson()'));
  });

  if (!generator.useWrappers) {
    test('includes final field in toJson when set in ctor', () async {
      var generateResult = await runForElementNamed('FinalFields');
      expect(generateResult, contains('new FinalFields(json[\'a\'] as int);'));
      expect(
          generateResult, contains('toJson() => <String, dynamic>{\'a\': a};'));
    });

    test('excludes final field in toJson when not set in ctor', () async {
      var generateResult = await runForElementNamed('FinalFieldsNotSetInCtor');
      expect(generateResult,
          isNot(contains('new FinalFields(json[\'a\'] as int);')));
      expect(generateResult,
          isNot(contains('toJson() => <String, dynamic>{\'a\': a};')));
    });
  }

  group('valid inputs', () {
    if (!generator.useWrappers) {
      test('class with no ctor params', () async {
        var output = await runForElementNamed('Person');
        expect(output, r'''Person _$PersonFromJson(Map<String, dynamic> json) {
  return new Person()
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
        var output = await runForElementNamed('Order');
        expect(output, r'''Order _$OrderFromJson(Map<String, dynamic> json) {
  return new Order(json['height'] as int, json['firstName'] as String,
      json['lastName'] as String)
    ..dateOfBirth = json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String);
}

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
    }

    test('class with fromJson() constructor with optional parameters',
        () async {
      var output = await runForElementNamed('FromJsonOptionalParameters');

      expect(output, contains('new ChildWithFromJson.fromJson'));
    });

    test('class with child json-able object', () async {
      var output = await runForElementNamed('ParentObject');

      expect(
          output,
          contains("new ChildObject.fromJson(json['child'] "
              'as Map<String, dynamic>)'));
    });

    test('class with child json-able object - anyMap', () async {
      var output = await _runForElementNamed(
          new JsonSerializableGenerator(
              anyMap: true, useWrappers: generator.useWrappers),
          'ParentObject');

      expect(
          output, contains("new ChildObject.fromJson(json['child'] as Map)"));
    });

    test('class with child list of json-able objects', () async {
      var output = await runForElementNamed('ParentObjectWithChildren');

      expect(output, contains('.toList()'));
      expect(output, contains('new ChildObject.fromJson'));
    });

    test('class with child list of dynamic objects is left alone', () async {
      var output = await runForElementNamed('ParentObjectWithDynamicChildren');

      expect(output, contains('children = json[\'children\'] as List;'));
    });

    test('class with list of int is cast for strong mode', () async {
      var output = await runForElementNamed('Person');

      expect(output,
          contains("json['listOfInts'] as List)?.map((e) => e as int)"));
    });
  });

  group('JsonKey', () {
    if (!generator.useWrappers) {
      test('works to change the name of a field', () async {
        var output = await runForElementNamed('Person');

        expect(output, contains("'h': height,"));
        expect(output, contains("..height = json['h']"));
      });

      test('works to ignore a field', () async {
        var output = await runForElementNamed('IgnoredFieldClass');

        expect(output, contains("'ignoredFalseField': ignoredFalseField,"));
        expect(output, contains("'ignoredNullField': ignoredNullField"));
        expect(output, isNot(contains("'ignoredTrueField': ignoredTrueField")));
      });

      test('fails if ignored field is referenced by ctor', () {
        expect(
            () => runForElementNamed('IgnoredFieldCtorClass'),
            throwsA(new FeatureMatcher<UnsupportedError>(
                'message',
                (e) => e.message,
                'Cannot populate the required constructor argument: '
                'ignoredTrueField. It is assigned to an ignored field.')));
      });

      test('fails if private field is referenced by ctor', () {
        expect(
            () => runForElementNamed('PrivateFieldCtorClass'),
            throwsA(new FeatureMatcher<UnsupportedError>(
                'message',
                (e) => e.message,
                'Cannot populate the required constructor argument: '
                '_privateField. It is assigned to a private field.')));
      });
    }

    test('fails if name duplicates existing field', () {
      expectThrows(
          'KeyDupesField',
          'More than one field has the JSON key `str`.',
          'Check the `JsonKey` annotations on fields.');
    });

    test('fails if two names collide', () {
      expectThrows('DupeKeys', 'More than one field has the JSON key `a`.',
          'Check the `JsonKey` annotations on fields.');
    });
  });

  group('includeIfNull', () {
    test('some', () async {
      var output = await runForElementNamed('IncludeIfNullAll');
      expect(output, isNot(contains(generatedLocalVarName)));
      expect(output, isNot(contains(toJsonMapHelperName)));
    });

    if (!generator.useWrappers) {
      test('all', () async {
        var output = await runForElementNamed('IncludeIfNullOverride');
        expect(output, contains("'number': number,"));
        expect(output, contains("$toJsonMapHelperName('str', str);"));
      });
    }
  });

  group('functions', () {
    group('fromJsonFunction', () {
      test('with bad fromJson return type', () {
        expectThrows(
            'BadFromFuncReturnType',
            'Error with `@JsonKey` on `field`. The `fromJson` function `_toInt` '
            'return type `int` is not compatible with field type `String`.');
      });
      test('with 2 arg fromJson function', () {
        expectThrows(
            'InvalidFromFunc2Args',
            'Error with `@JsonKey` on `field`. The `fromJson` function '
            '`_twoArgFunction` must have one positional paramater.');
      });
      test('with class static function', () {
        expectThrows(
            'InvalidFromFuncClassStatic',
            'Error with `@JsonKey` on `field`. '
            'The function provided for `fromJson` must be top-level. '
            'Static class methods (`_staticFunc`) are not supported.');
      });
      test('BadNoArgs', () {
        expectThrows('BadNoArgs',
            'Error with `@JsonKey` on `field`. The `fromJson` function `_noArgs` must have one positional paramater.');
      });
      test('BadTwoRequiredPositional', () {
        expectThrows('BadTwoRequiredPositional',
            'Error with `@JsonKey` on `field`. The `fromJson` function `_twoArgs` must have one positional paramater.');
      });
      test('BadOneNamed', () {
        expectThrows('BadOneNamed',
            'Error with `@JsonKey` on `field`. The `fromJson` function `_oneNamed` must have one positional paramater.');
      });
    });

    group('toJsonFunction', () {
      test('with bad fromJson return type', () {
        expectThrows(
            'BadToFuncReturnType',
            'Error with `@JsonKey` on `field`. The `toJson` function `_toInt` '
            'argument type `bool` is not compatible with field type `String`.');
      });
      test('with 2 arg fromJson function', () {
        expectThrows(
            'InvalidToFunc2Args',
            'Error with `@JsonKey` on `field`. The `toJson` function '
            '`_twoArgFunction` must have one positional paramater.');
      });
      test('with class static function', () {
        expectThrows(
            'InvalidToFuncClassStatic',
            'Error with `@JsonKey` on `field`. '
            'The function provided for `toJson` must be top-level. '
            'Static class methods (`_staticFunc`) are not supported.');
      });
    });

    if (!generator.useWrappers) {
      test('object', () async {
        var output = await runForElementNamed('ObjectConvertMethods');
        expect(output, contains("_toObject(json['field'])"));
      });
      test('dynamic', () async {
        var output = await runForElementNamed('DynamicConvertMethods');
        expect(output, contains("_toDynamic(json['field'])"));
      });
      test('typed', () async {
        var output = await runForElementNamed('TypedConvertMethods');
        expect(output, contains("_toString(json['field'] as String)"));
      });
      test('dynamic collections', () async {
        var output = await runForElementNamed('FromDynamicCollection');
        expect(output, r'''
FromDynamicCollection _$FromDynamicCollectionFromJson(
    Map<String, dynamic> json) {
  return new FromDynamicCollection()
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
      test('OkayOneNormalOptionalPositional', () async {
        var output =
            await runForElementNamed('OkayOneNormalOptionalPositional');
        expect(output, contains("_oneNormalOnePositional(json['field'])"));
      });
      test('OkayOneNormalOptionalNamed', () async {
        var output = await runForElementNamed('OkayOneNormalOptionalNamed');
        expect(output, contains("_oneNormalOptionalNamed(json['field'])"));
      });
      test('OkayOnlyOptionalPositional', () async {
        var output = await runForElementNamed('OkayOnlyOptionalPositional');
        expect(output, contains("_onlyOptionalPositional(json['field'])"));
      });
    }
  });

  test('missing default ctor with a factory', () async {
    expect(
        () => runForElementNamed('NoCtorClass'),
        throwsA(new FeatureMatcher<UnsupportedError>(
            'message',
            (e) => e.message,
            'The class `NoCtorClass` has no default constructor.')));
  });

  test('generic classes', () async {
    var output = await runForElementNamed('GenericClass');

    var expected = generator.useWrappers
        ? r'''
GenericClass<T, S> _$GenericClassFromJson<T extends num, S>(
    Map<String, dynamic> json) {
  return new GenericClass<T, S>()
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

abstract class _$GenericClassSerializerMixin<T extends num, S> {
  Object get fieldObject;
  dynamic get fieldDynamic;
  int get fieldInt;
  T get fieldT;
  S get fieldS;
  Map<String, dynamic> toJson() => new _$GenericClassJsonMapWrapper<T, S>(this);
}

class _$GenericClassJsonMapWrapper<T extends num, S> extends $JsonMapWrapper {
  final _$GenericClassSerializerMixin<T, S> _v;
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
  return new GenericClass<T, S>()
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

abstract class _$GenericClassSerializerMixin<T extends num, S> {
  Object get fieldObject;
  dynamic get fieldDynamic;
  int get fieldInt;
  T get fieldT;
  S get fieldS;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'fieldObject': fieldObject == null ? null : _dataToJson(fieldObject),
        'fieldDynamic': fieldDynamic == null ? null : _dataToJson(fieldDynamic),
        'fieldInt': fieldInt == null ? null : _dataToJson(fieldInt),
        'fieldT': fieldT == null ? null : _dataToJson(fieldT),
        'fieldS': fieldS == null ? null : _dataToJson(fieldS)
      };
}
''';

    expect(output, expected);
  });

  test('super types', () async {
    var output = await runForElementNamed('SubType');

    var expected = generator.useWrappers
        ? r'''
SubType _$SubTypeFromJson(Map<String, dynamic> json) {
  return new SubType(
      json['subTypeViaCtor'] as int, json['super-type-via-ctor'] as int)
    ..superTypeReadWrite = json['superTypeReadWrite'] as int
    ..subTypeReadWrite = json['subTypeReadWrite'] as int;
}

abstract class _$SubTypeSerializerMixin {
  int get superTypeViaCtor;
  int get superTypeReadWrite;
  int get subTypeViaCtor;
  int get subTypeReadWrite;
  Map<String, dynamic> toJson() => new _$SubTypeJsonMapWrapper(this);
}

class _$SubTypeJsonMapWrapper extends $JsonMapWrapper {
  final _$SubTypeSerializerMixin _v;
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
  return new SubType(
      json['subTypeViaCtor'] as int, json['super-type-via-ctor'] as int)
    ..superTypeReadWrite = json['superTypeReadWrite'] as int
    ..subTypeReadWrite = json['subTypeReadWrite'] as int;
}

abstract class _$SubTypeSerializerMixin {
  int get superTypeViaCtor;
  int get superTypeReadWrite;
  int get subTypeViaCtor;
  int get subTypeReadWrite;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{
      'super-type-via-ctor': superTypeViaCtor,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('superTypeReadWrite', superTypeReadWrite);
    val['subTypeViaCtor'] = subTypeViaCtor;
    val['subTypeReadWrite'] = subTypeReadWrite;
    return val;
  }
}
''';

    expect(output, expected);
  });

  if (!generator.useWrappers) {
    group('default values fail with', () {
      test('symbols', () {
        expectThrows(
            'DefaultWithSymbol',
            'Error with `@JsonKey` on `field`. '
            '`defaultValue` is `Symbol`, it must be a literal.');
      });
      test('functions', () {
        expectThrows(
            'DefaultWithFunction',
            'Error with `@JsonKey` on `field`. '
            '`defaultValue` is `Function`, it must be a literal.');
      });
      test('type', () {
        expectThrows(
            'DefaultWithType',
            'Error with `@JsonKey` on `field`. '
            '`defaultValue` is `Type`, it must be a literal.');
      });
      test('const object', () {
        expectThrows(
            'DefaultWithConstObject',
            'Error with `@JsonKey` on `field`. '
            '`defaultValue` is `Duration`, it must be a literal.');
      });
      test('enum value', () {
        expectThrows(
            'DefaultWithNestedEnum',
            'Error with `@JsonKey` on `field`. '
            '`defaultValue` is `List > Enum`, it must be a literal.');
      });
      test('non-nullable field', () {
        expectThrows(
            'DefaultWithNonNullableField',
            'Error with `@JsonKey` on `field`. '
            'Cannot use `defaultValue` on a field with `nullable` false.');
      });
      test('non-nullable class', () {
        expectThrows(
            'DefaultWithNonNullableClass',
            'Error with `@JsonKey` on `field`. '
            'Cannot use `defaultValue` on a field with `nullable` false.');
      });
    });

    test('`disallowNullvalue` and `includeIfNull` both `true`', () {
      expectThrows(
          'IncludeIfNullDisallowNullClass',
          'Error with `@JsonKey` on `field`. '
          'Cannot set both `disallowNullvalue` and `includeIfNull` to `true`. '
          'This leads to incompatible `toJson` and `fromJson` behavior.');
    });
  }
}
