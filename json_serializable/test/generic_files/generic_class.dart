// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import '../test_utils.dart';

part 'generic_class.g.dart';

@JsonSerializable()
class GenericClass<T extends num, S> {
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  Object? fieldObject;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  dynamic fieldDynamic;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  int? fieldInt;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T? fieldT;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  S? fieldS;

  GenericClass();

  factory GenericClass.fromJson(Map<String, dynamic> json) =>
      _$GenericClassFromJson<T, S>(json);

  Map<String, dynamic> toJson() => _$GenericClassToJson(this);

  static T _dataFromJson<T, S, U>(Map<String, dynamic> input,
          [S? other1, U? other2]) =>
      input['value'] as T;

  static Map<String, dynamic> _dataToJson<T, S, U>(T input,
          [S? other1, U? other2]) =>
      {'value': input};
}

@JsonSerializable()
@_DurationMillisecondConverter.named()
@_DurationListMillisecondConverter()
class GenericClassWithConverter<T extends num, S> {
  @_SimpleConverter()
  Object? fieldObject;

  @_SimpleConverter()
  dynamic fieldDynamic;

  @_SimpleConverter()
  int? fieldInt;

  @_SimpleConverter()
  T? fieldT;

  @_SimpleConverter()
  S? fieldS;

  Duration? duration;

  List<Duration>? listDuration;

  GenericClassWithConverter();

  factory GenericClassWithConverter.fromJson(Map<String, dynamic> json) =>
      _$GenericClassWithConverterFromJson<T, S>(json);

  Map<String, dynamic> toJson() => _$GenericClassWithConverterToJson(this);
}

class _SimpleConverter<T> implements JsonConverter<T, Map<String, dynamic>> {
  const _SimpleConverter();

  @override
  T fromJson(Map<String, dynamic> json) => json['value'] as T;

  @override
  Map<String, dynamic> toJson(T object) => {'value': object};
}

class _DurationMillisecondConverter implements JsonConverter<Duration?, int?> {
  const _DurationMillisecondConverter.named();

  @override
  Duration? fromJson(int? json) =>
      json == null ? null : Duration(milliseconds: json);

  @override
  int? toJson(Duration? object) => object?.inMilliseconds;
}

class _DurationListMillisecondConverter
    implements JsonConverter<List<Duration>?, int?> {
  const _DurationListMillisecondConverter();

  @override
  List<Duration>? fromJson(int? json) =>
      json == null ? null : [Duration(milliseconds: json)];

  @override
  int? toJson(List<Duration>? object) =>
      object?.fold<int>(0, (sum, obj) => sum + obj.inMilliseconds);
}

class Issue980GenericClass<T> {
  final T value;

  Issue980GenericClass(this.value);

  factory Issue980GenericClass.fromJson(Map<String, dynamic> json) =>
      Issue980GenericClass(json['value'] as T);

  Map<String, dynamic> toJson() => {'value': value};

  @override
  bool operator ==(Object other) =>
      other is Issue980GenericClass && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@JsonSerializable()
class Issue980ParentClass {
  final List<Issue980GenericClass<int>> list;

  Issue980ParentClass(this.list);

  factory Issue980ParentClass.fromJson(Map<String, dynamic> json) =>
      _$Issue980ParentClassFromJson(json);

  Map<String, dynamic> toJson() => _$Issue980ParentClassToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Issue980ParentClass && deepEquals(list, other.list);

  @override
  int get hashCode => const DeepCollectionEquality().hash(list);
}
