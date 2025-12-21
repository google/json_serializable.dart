// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=3.8

part of '_json_serializable_test_input.dart';

@ShouldThrow(
  '''
Could not generate `fromJson` code for `result` because of type `TResult` (type parameter).
To support type parameters (generic types) you can:
$converterOrKeyInstructions
* Set `JsonSerializable.genericArgumentFactories` to `true`
  https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/genericArgumentFactories.html''',
  element: 'result',
)
@JsonSerializable()
class Issue713<TResult> {
  List<TResult>? result;
}

@ShouldGenerate(r'''
GenericClass<T, S> _$GenericClassFromJson<T extends num, S>(
  Map<String, dynamic> json,
) => GenericClass<T, S>()
  ..fieldObject = _dataFromJson(json['fieldObject'])
  ..fieldDynamic = _dataFromJson(json['fieldDynamic'])
  ..fieldInt = _dataFromJson(json['fieldInt'])
  ..fieldT = _dataFromJson(json['fieldT'])
  ..fieldS = _dataFromJson(json['fieldS']);

Map<String, dynamic> _$GenericClassToJson<T extends num, S>(
  GenericClass<T, S> instance,
) => <String, dynamic>{
  'fieldObject': _dataToJson(instance.fieldObject),
  'fieldDynamic': _dataToJson(instance.fieldDynamic),
  'fieldInt': _dataToJson(instance.fieldInt),
  'fieldT': _dataToJson(instance.fieldT),
  'fieldS': _dataToJson(instance.fieldS),
};
''')
@JsonSerializable()
class GenericClass<T extends num, S> {
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  late Object fieldObject;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  dynamic fieldDynamic;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  late int fieldInt;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  late T fieldT;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  late S fieldS;

  GenericClass();
}

T _dataFromJson<T extends num>(Object? input) => throw UnimplementedError();

Object _dataToJson<T extends num>(T input) => throw UnimplementedError();

@ShouldGenerate(
  r'''
GenericArgumentFactoriesFlagWithoutGenericType
_$GenericArgumentFactoriesFlagWithoutGenericTypeFromJson(
  Map<String, dynamic> json,
) => GenericArgumentFactoriesFlagWithoutGenericType();

Map<String, dynamic> _$GenericArgumentFactoriesFlagWithoutGenericTypeToJson(
  GenericArgumentFactoriesFlagWithoutGenericType instance,
) => <String, dynamic>{};
''',
  expectedLogItems: [
    'The class `GenericArgumentFactoriesFlagWithoutGenericType` is annotated '
        'with `JsonSerializable` field `genericArgumentFactories: true`. '
        '`genericArgumentFactories: true` only affects classes with type '
        'parameters. For classes without type parameters, the option is '
        'ignored.',
  ],
)
@JsonSerializable(genericArgumentFactories: true)
class GenericArgumentFactoriesFlagWithoutGenericType {}

@ShouldThrow(
  'The class `SuperWithGenericArgumentFactories` is annotated '
  'with `JsonSerializable` field `genericArgumentFactories: true`. '
  '`genericArgumentFactories: true` is not supported for classes '
  'that are sealed or have sealed superclasses.',
  todo:
      'Remove the `genericArgumentFactories` option or '
      'remove the `sealed` keyword from the class.',
  element: 'SuperWithGenericArgumentFactories',
)
@JsonSerializable(genericArgumentFactories: true)
sealed class SuperWithGenericArgumentFactories<T> {}

@JsonSerializable(genericArgumentFactories: false)
sealed class SuperWithoutGenericArgumentFactories {}

@ShouldThrow(
  'The class `SubWithSubGenericArgumentFactoriesExt` is annotated '
  'with `JsonSerializable` field `genericArgumentFactories: true`. '
  '`genericArgumentFactories: true` is not supported for classes '
  'that are sealed or have sealed superclasses.',
  todo:
      'Remove the `genericArgumentFactories` option or '
      'remove the `sealed` keyword from the class.',
  element: 'SubWithSubGenericArgumentFactoriesExt',
)
@JsonSerializable(genericArgumentFactories: true)
class SubWithSubGenericArgumentFactoriesExt<T>
    extends SuperWithoutGenericArgumentFactories {}

@ShouldThrow(
  'The class `SubWithSubGenericArgumentFactoriesImpl` is annotated '
  'with `JsonSerializable` field `genericArgumentFactories: true`. '
  '`genericArgumentFactories: true` is not supported for classes '
  'that are sealed or have sealed superclasses.',
  todo:
      'Remove the `genericArgumentFactories` option or '
      'remove the `sealed` keyword from the class.',
  element: 'SubWithSubGenericArgumentFactoriesImpl',
)
@JsonSerializable(genericArgumentFactories: true)
class SubWithSubGenericArgumentFactoriesImpl<T>
    implements SuperWithoutGenericArgumentFactories {}

@ShouldThrow(
  'The class `SubWithSubAndSuperGenericArgumentFactoriesExt` is annotated '
  'with `JsonSerializable` field `genericArgumentFactories: true`. '
  '`genericArgumentFactories: true` is not supported for classes '
  'that are sealed or have sealed superclasses.',
  todo:
      'Remove the `genericArgumentFactories` option or '
      'remove the `sealed` keyword from the class.',
  element: 'SubWithSubAndSuperGenericArgumentFactoriesExt',
)
@JsonSerializable(genericArgumentFactories: true)
class SubWithSubAndSuperGenericArgumentFactoriesExt<T>
    extends SuperWithGenericArgumentFactories<T> {}

@ShouldThrow(
  'The class `SubWithSubAndSuperGenericArgumentFactoriesImpl` is annotated '
  'with `JsonSerializable` field `genericArgumentFactories: true`. '
  '`genericArgumentFactories: true` is not supported for classes '
  'that are sealed or have sealed superclasses.',
  todo:
      'Remove the `genericArgumentFactories` option or '
      'remove the `sealed` keyword from the class.',
  element: 'SubWithSubAndSuperGenericArgumentFactoriesImpl',
)
@JsonSerializable(genericArgumentFactories: true)
class SubWithSubAndSuperGenericArgumentFactoriesImpl<T>
    implements SuperWithGenericArgumentFactories<T> {}
