// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'json_serializable_test_input.dart';

int _toInt(bool input) => 42;
int _twoArgFunction(int a, int b) => 42;

dynamic _toDynamic(dynamic input) => null;
Object _toObject(Object input) => null;

@JsonSerializable()
class BadFromFuncReturnType {
  @JsonKey(fromJson: _toInt)
  String field;
}

@JsonSerializable()
class InvalidFromFunc2Args {
  @JsonKey(fromJson: _twoArgFunction)
  String field;
}

@JsonSerializable()
class InvalidFromFuncClassStatic {
  static Duration _staticFunc(int param) => null;

  @JsonKey(fromJson: _staticFunc)
  String field;
}

@JsonSerializable()
class BadToFuncReturnType {
  @JsonKey(toJson: _toInt)
  String field;
}

@JsonSerializable()
class InvalidToFunc2Args {
  @JsonKey(toJson: _twoArgFunction)
  String field;
}

@JsonSerializable()
class InvalidToFuncClassStatic {
  static Duration _staticFunc(int param) => null;

  @JsonKey(toJson: _staticFunc)
  String field;
}

@JsonSerializable()
class ObjectConvertMethods {
  @JsonKey(fromJson: _toObject, toJson: _toObject)
  String field;
}

@JsonSerializable()
class DynamicConvertMethods {
  @JsonKey(fromJson: _toDynamic, toJson: _toDynamic)
  String field;
}

String _toString(String input) => null;

@JsonSerializable()
class TypedConvertMethods {
  @JsonKey(fromJson: _toString, toJson: _toString)
  String field;
}

String _fromDynamicMap(Map input) => null;
String _fromDynamicList(List input) => null;
String _fromDynamicIterable(Iterable input) => null;

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

@JsonSerializable(createToJson: false)
class BadNoArgs {
  @JsonKey(fromJson: _noArgs)
  String field;
}

String _twoArgs(a, b) => null;

@JsonSerializable(createToJson: false)
class BadTwoRequiredPositional {
  @JsonKey(fromJson: _twoArgs)
  String field;
}

String _oneNamed({a}) => null;

@JsonSerializable(createToJson: false)
class BadOneNamed {
  @JsonKey(fromJson: _oneNamed)
  String field;
}

String _oneNormalOnePositional(a, [b]) => null;

@JsonSerializable(createToJson: false)
class OkayOneNormalOptionalPositional {
  @JsonKey(fromJson: _oneNormalOnePositional)
  String field;
}

String _oneNormalOptionalNamed(a, {b}) => null;

@JsonSerializable(createToJson: false)
class OkayOneNormalOptionalNamed {
  @JsonKey(fromJson: _oneNormalOptionalNamed)
  String field;
}

String _onlyOptionalPositional([a, b]) => null;

@JsonSerializable(createToJson: false)
class OkayOnlyOptionalPositional {
  @JsonKey(fromJson: _onlyOptionalPositional)
  String field;
}
