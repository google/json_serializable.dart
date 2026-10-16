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

@ShouldGenerate(r'''
Issue1208<T> _$Issue1208FromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => Issue1208<T>(
  child: Issue1208Child<String>.fromJson(
    json['child'] as Map<String, dynamic>,
    (value) => value as String,
  ),
  genericChild: Issue1208Child<T>.fromJson(
    json['genericChild'] as Map<String, dynamic>,
    (value) => fromJsonT(value),
  ),
  reordered: Issue1208ChildReordered<int, DateTime>.fromJson(
    json['reordered'] as Map<String, dynamic>,
    (value) => (value as num).toInt(),
    (value) => DateTime.parse(value as String),
  ),
  mixinApp: Issue1208MixinApp<T>.fromJson(
    json['mixinApp'] as Map<String, dynamic>,
    (value) => fromJsonT(value),
  ),
);

Map<String, dynamic> _$Issue1208ToJson<T>(
  Issue1208<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'child': instance.child.toJson((value) => value),
  'genericChild': instance.genericChild.toJson((value) => toJsonT(value)),
  'reordered': instance.reordered.toJson((value) => value.toIso8601String()),
  'mixinApp': instance.mixinApp.toJson((value) => toJsonT(value)),
};
''')
@JsonSerializable(genericArgumentFactories: true)
class Issue1208<T> {
  final Issue1208Child<String> child;
  final Issue1208Child<T> genericChild;
  final Issue1208ChildReordered<int, DateTime> reordered;
  final Issue1208MixinApp<T> mixinApp;

  Issue1208({
    required this.child,
    required this.genericChild,
    required this.reordered,
    required this.mixinApp,
  });
}

abstract class Issue1208Interface<T> {
  Map<String, dynamic> toJson(Object? Function(T value) encoder);
}

mixin Issue1208BaseMixin<T> {
  Map<String, dynamic> toJson(Object? Function(T value) encoder) =>
      throw UnimplementedError();
}

class Issue1208Child<T>
    with Issue1208BaseMixin<T>, Issue1208ChildMixin<T>
    implements Issue1208Interface<T> {
  final T content;

  Issue1208Child({required this.content});

  factory Issue1208Child.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => Issue1208Child(content: fromJsonT(json['content']));
}

class Issue1208ChildReordered<A, B> with Issue1208ChildMixin<B> {
  final A first;
  final B second;

  Issue1208ChildReordered({required this.first, required this.second});

  factory Issue1208ChildReordered.fromJson(
    Map<String, dynamic> json,
    A Function(Object? json) fromJsonA,
    B Function(Object? json) fromJsonB,
  ) => Issue1208ChildReordered(
    first: fromJsonA(json['first']),
    second: fromJsonB(json['second']),
  );
}

mixin Issue1208ChildMixin<T> {
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      throw UnimplementedError();
}

class Issue1208Base<U> with Issue1208ChildMixin<U> {
  final U value;

  Issue1208Base.fromJson(
    Map<String, dynamic> json,
    U Function(Object? json) fromJsonU,
  ) : value = fromJsonU(json['value']);
}

mixin Issue1208TagMixin {}

class Issue1208MixinApp<T> = Issue1208Base<T> with Issue1208TagMixin;
