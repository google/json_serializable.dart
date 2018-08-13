// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '_json_serializable_test_input.dart';

int _toInt(bool input) => 42;
int _twoArgFunction(int a, int b) => 42;

dynamic _toDynamic(dynamic input) => null;
Object _toObject(Object input) => null;

@ShouldThrow(
    'fromJson with function with incompatible return type',
    'Error with `@JsonKey` on `field`. The `fromJson` function `_toInt` '
    'return type `int` is not compatible with field type `String`.')
@JsonSerializable()
class BadFromFuncReturnType {
  @JsonKey(fromJson: _toInt)
  String field;
}

@ShouldThrow(
    'fromJson function with 2 arg fromJson function',
    'Error with `@JsonKey` on `field`. The `fromJson` function '
    '`_twoArgFunction` must have one positional paramater.')
@JsonSerializable()
class InvalidFromFunc2Args {
  @JsonKey(fromJson: _twoArgFunction)
  String field;
}

@ShouldThrow(
    'with class static function',
    'Error with `@JsonKey` on `field`. '
    'The function provided for `fromJson` must be top-level. '
    'Static class methods (`_staticFunc`) are not supported.')
@JsonSerializable()
class InvalidFromFuncClassStatic {
  static Duration _staticFunc(int param) => null;

  @JsonKey(fromJson: _staticFunc)
  String field;
}

@ShouldThrow(
    'mismatched toJson return value',
    'Error with `@JsonKey` on `field`. The `toJson` function `_toInt` '
    'argument type `bool` is not compatible with field type `String`.')
@JsonSerializable()
class BadToFuncReturnType {
  @JsonKey(toJson: _toInt)
  String field;
}

@ShouldThrow(
    'toJson function with 2 potitional required args',
    'Error with `@JsonKey` on `field`. The `toJson` function '
    '`_twoArgFunction` must have one positional paramater.')
@JsonSerializable()
class InvalidToFunc2Args {
  @JsonKey(toJson: _twoArgFunction)
  String field;
}

@ShouldThrow(
    'toJson with class static function',
    'Error with `@JsonKey` on `field`. '
    'The function provided for `toJson` must be top-level. '
    'Static class methods (`_staticFunc`) are not supported.')
@JsonSerializable()
class InvalidToFuncClassStatic {
  static Duration _staticFunc(int param) => null;

  @JsonKey(toJson: _staticFunc)
  String field;
}

@ShouldGenerate("_toObject(json['field'])", contains: true)
@JsonSerializable()
class ObjectConvertMethods {
  @JsonKey(fromJson: _toObject, toJson: _toObject)
  String field;
}

@ShouldGenerate("_toDynamic(json['field'])", contains: true)
@JsonSerializable()
class DynamicConvertMethods {
  @JsonKey(fromJson: _toDynamic, toJson: _toDynamic)
  String field;
}

String _toString(String input) => null;

@ShouldGenerate("_toString(json['field'] as String)", contains: true)
@JsonSerializable()
class TypedConvertMethods {
  @JsonKey(fromJson: _toString, toJson: _toString)
  String field;
}

String _fromDynamicMap(Map input) => null;
String _fromDynamicList(List input) => null;
String _fromDynamicIterable(Iterable input) => null;

@ShouldGenerate(r'''
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
''')
@JsonSerializable(createToJson: false)
class FromDynamicCollection {
  @JsonKey(fromJson: _fromDynamicMap)
  String mapField;
  @JsonKey(fromJson: _fromDynamicList)
  String listField;
  @JsonKey(fromJson: _fromDynamicIterable)
  String iterableField;
}

String _noArgs() => null;

@ShouldThrow(
    'fromJson with zero-arg function',
    'Error with `@JsonKey` on `field`. The `fromJson` function '
    '`_noArgs` must have one positional paramater.')
@JsonSerializable(createToJson: false)
class BadNoArgs {
  @JsonKey(fromJson: _noArgs)
  String field;
}

String _twoArgs(a, b) => null;

@ShouldThrow(
    'fromJson with function with two positional args',
    'Error with `@JsonKey` on `field`. The `fromJson` function '
    '`_twoArgs` must have one positional paramater.')
@JsonSerializable(createToJson: false)
class BadTwoRequiredPositional {
  @JsonKey(fromJson: _twoArgs)
  String field;
}

String _oneNamed({a}) => null;

@ShouldThrow(
    'fromJson with function with one named arg',
    'Error with `@JsonKey` on `field`. The `fromJson` function '
    '`_oneNamed` must have one positional paramater.')
@JsonSerializable(createToJson: false)
class BadOneNamed {
  @JsonKey(fromJson: _oneNamed)
  String field;
}

String _oneNormalOnePositional(a, [b]) => null;

@ShouldGenerate("_oneNormalOnePositional(json['field'])", contains: true)
@JsonSerializable(createToJson: false)
class OkayOneNormalOptionalPositional {
  @JsonKey(fromJson: _oneNormalOnePositional)
  String field;
}

String _oneNormalOptionalNamed(a, {b}) => null;

@ShouldGenerate("_oneNormalOptionalNamed(json['field'])", contains: true)
@JsonSerializable(createToJson: false)
class OkayOneNormalOptionalNamed {
  @JsonKey(fromJson: _oneNormalOptionalNamed)
  String field;
}

String _onlyOptionalPositional([a, b]) => null;

@ShouldGenerate("_onlyOptionalPositional(json['field'])", contains: true)
@JsonSerializable(createToJson: false)
class OkayOnlyOptionalPositional {
  @JsonKey(fromJson: _onlyOptionalPositional)
  String field;
}
