// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '_json_serializable_test_input.dart';

int _toInt(bool input) => 42;

int _twoArgFunction(int a, int b) => 42;

dynamic _toDynamic(dynamic input) => null;

Object _toObject(Object input) => throw UnimplementedError();

String _toStringFromObject(Object? input) => throw UnimplementedError();

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. The `fromJson` function '
  '`_toInt` return type `int` is not compatible with field type `String`.',
  element: 'field',
)
@JsonSerializable()
class BadFromFuncReturnType {
  @JsonKey(fromJson: _toInt)
  late String field;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. The `fromJson` function '
  '`_twoArgFunction` must have one positional parameter.',
  element: 'field',
)
@JsonSerializable()
class InvalidFromFunc2Args {
  @JsonKey(fromJson: _twoArgFunction)
  late String field;
}

@ShouldGenerate(
  r'''
ValidToFromFuncClassStatic _$ValidToFromFuncClassStaticFromJson(
        Map<String, dynamic> json) =>
    ValidToFromFuncClassStatic()
      ..field = ValidToFromFuncClassStatic._staticFunc(json['field'] as String);

Map<String, dynamic> _$ValidToFromFuncClassStaticToJson(
        ValidToFromFuncClassStatic instance) =>
    <String, dynamic>{
      'field': ValidToFromFuncClassStatic._staticFunc(instance.field),
    };
''',
)
@JsonSerializable()
class ValidToFromFuncClassStatic {
  static String _staticFunc(String param) => throw UnimplementedError();

  @JsonKey(fromJson: _staticFunc, toJson: _staticFunc)
  late String field;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. The `toJson` function `_toInt` '
  'argument type `bool` is not compatible with field type `String`.',
  element: 'field',
)
@JsonSerializable()
class BadToFuncReturnType {
  @JsonKey(toJson: _toInt)
  late String field;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `values` field. The `fromJson` function '
  '`_fromList` return type `List<int>?` is not compatible with field type '
  '`List<int>`.',
  element: 'values',
)
@JsonSerializable()
class Reproduce869NullableGenericType {
  @JsonKey(
    toJson: _toList, // nullable
    fromJson: _fromList, // nullable
  )
  late final List<int> values;
}

@ShouldGenerate(
  r'''
Reproduce869NullableGenericTypeWithDefault
    _$Reproduce869NullableGenericTypeWithDefaultFromJson(
            Map<String, dynamic> json) =>
        Reproduce869NullableGenericTypeWithDefault()
          ..values =
              json['values'] == null ? [] : _fromList(json['values'] as List?)
          ..valuesNullable = json['valuesNullable'] == null
              ? []
              : _fromList(json['valuesNullable'] as List?);

Map<String, dynamic> _$Reproduce869NullableGenericTypeWithDefaultToJson(
        Reproduce869NullableGenericTypeWithDefault instance) =>
    <String, dynamic>{
      'values': _toList(instance.values),
      'valuesNullable': _toList(instance.valuesNullable),
    };
''',
)
@JsonSerializable()
class Reproduce869NullableGenericTypeWithDefault {
  @JsonKey(
    toJson: _toList, // nullable
    fromJson: _fromList, // nullable
    defaultValue: <int>[],
  )
  late List<int> values;

  @JsonKey(
    toJson: _toList, // nullable
    fromJson: _fromList, // nullable
    defaultValue: <int>[],
  )
  List<int>? valuesNullable;
}

List<int>? _fromList(List? pairs) =>
    pairs?.map((it) => it as int).toList(growable: false);

List<List>? _toList(List<int>? pairs) =>
    pairs?.map((it) => [it]).toList(growable: false);

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. The `toJson` function '
  '`_twoArgFunction` must have one positional parameter.',
  element: 'field',
)
@JsonSerializable()
class InvalidToFunc2Args {
  @JsonKey(toJson: _twoArgFunction)
  late String field;
}

@ShouldGenerate(
  "_toStringFromObject(json['field'])",
  contains: true,
)
@JsonSerializable()
class ObjectConvertMethods {
  @JsonKey(fromJson: _toStringFromObject, toJson: _toObject)
  late String field;
}

@ShouldGenerate(
  "_toDynamic(json['field'])",
  contains: true,
)
@JsonSerializable()
class DynamicConvertMethods {
  @JsonKey(fromJson: _toDynamic, toJson: _toDynamic)
  late String field;
}

String _toString(String input) => 'null';

@ShouldGenerate(
  "_toString(json['field'] as String)",
  contains: true,
)
@JsonSerializable()
class TypedConvertMethods {
  @JsonKey(fromJson: _toString, toJson: _toString)
  late String field;
}

String? _toStringNullOnEmpty(String input) => input.isEmpty ? null : input;

@ShouldGenerate(
  r'''
Map<String, dynamic> _$ToJsonNullableFalseIncludeIfNullFalseToJson(
    ToJsonNullableFalseIncludeIfNullFalse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('field', _toStringNullOnEmpty(instance.field));
  return val;
}
''',
)
@JsonSerializable(createFactory: false)
class ToJsonNullableFalseIncludeIfNullFalse {
  @JsonKey(toJson: _toStringNullOnEmpty, includeIfNull: false)
  late String field;
}

String _fromDynamicMap(Map input) => '';

String _fromDynamicList(List input) => 'null';

String _fromDynamicIterable(Iterable input) => 'null';

@ShouldGenerate(
  r'''
FromDynamicCollection _$FromDynamicCollectionFromJson(
        Map<String, dynamic> json) =>
    FromDynamicCollection()
      ..mapField = _fromDynamicMap(json['mapField'] as Map)
      ..listField = _fromDynamicList(json['listField'] as List)
      ..iterableField = _fromDynamicIterable(json['iterableField'] as List);
''',
)
@JsonSerializable(createToJson: false)
class FromDynamicCollection {
  @JsonKey(fromJson: _fromDynamicMap)
  late String mapField;
  @JsonKey(fromJson: _fromDynamicList)
  late String listField;
  @JsonKey(fromJson: _fromDynamicIterable)
  late String iterableField;
}

String _fromNullableDynamicMap(Map? input) => '';

String _fromNullableDynamicList(List? input) => 'null';

String _fromNullableDynamicIterable(Iterable? input) => 'null';

@ShouldGenerate(
  r'''
FromNullableDynamicCollection _$FromNullableDynamicCollectionFromJson(
        Map<String, dynamic> json) =>
    FromNullableDynamicCollection()
      ..mapField = _fromNullableDynamicMap(json['mapField'] as Map?)
      ..listField = _fromNullableDynamicList(json['listField'] as List?)
      ..iterableField =
          _fromNullableDynamicIterable(json['iterableField'] as List?);
''',
)
@JsonSerializable(createToJson: false)
class FromNullableDynamicCollection {
  @JsonKey(fromJson: _fromNullableDynamicMap)
  late String mapField;
  @JsonKey(fromJson: _fromNullableDynamicList)
  late String listField;
  @JsonKey(fromJson: _fromNullableDynamicIterable)
  late String iterableField;
}

String _noArgs() => throw UnimplementedError();

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. The `fromJson` function '
  '`_noArgs` must have one positional parameter.',
  element: 'field',
)
@JsonSerializable(createToJson: false)
class BadNoArgs {
  @JsonKey(fromJson: _noArgs)
  String? field;
}

String? _twoArgs(a, b) => null;

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. The `fromJson` function '
  '`_twoArgs` must have one positional parameter.',
  element: 'field',
)
@JsonSerializable(createToJson: false)
class BadTwoRequiredPositional {
  @JsonKey(fromJson: _twoArgs)
  String? field;
}

String? _oneNamed({a}) => null;

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. The `fromJson` function '
  '`_oneNamed` must have one positional parameter.',
  element: 'field',
)
@JsonSerializable(createToJson: false)
class BadOneNamed {
  @JsonKey(fromJson: _oneNamed)
  String? field;
}

String _oneNormalOnePositional(a, [b]) => throw UnimplementedError();

@ShouldGenerate("_oneNormalOnePositional(json['field'])", contains: true)
@JsonSerializable(createToJson: false)
class OkayOneNormalOptionalPositional {
  @JsonKey(fromJson: _oneNormalOnePositional)
  String? field;
}

String _oneNormalOptionalNamed(a, {b}) => throw UnimplementedError();

@ShouldGenerate("_oneNormalOptionalNamed(json['field'])", contains: true)
@JsonSerializable(createToJson: false)
class OkayOneNormalOptionalNamed {
  @JsonKey(fromJson: _oneNormalOptionalNamed)
  String? field;
}

String _onlyOptionalPositional([a, b]) => throw UnimplementedError();

@ShouldGenerate("_onlyOptionalPositional(json['field'])", contains: true)
@JsonSerializable(createToJson: false)
class OkayOnlyOptionalPositional {
  @JsonKey(fromJson: _onlyOptionalPositional)
  String? field;
}

@ShouldGenerate(
  r'''
_BetterPrivateNames _$BetterPrivateNamesFromJson(Map<String, dynamic> json) =>
    _BetterPrivateNames(
      name: json['name'] as String,
    );

Map<String, dynamic> _$BetterPrivateNamesToJson(_BetterPrivateNames instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
''',
)
@JsonSerializable(createFactory: true, createToJson: true)
// ignore: unused_element
class _BetterPrivateNames {
  final String name;

  _BetterPrivateNames({required this.name});
}
