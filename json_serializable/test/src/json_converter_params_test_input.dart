// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=3.8

// ignore_for_file: inference_failure_on_instance_creation

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
JsonConverterCtorParams _$JsonConverterCtorParamsFromJson(
  Map<String, dynamic> json,
) => JsonConverterCtorParams()
  ..value = const _ConverterWithCtorParams(
    42,
  ).fromJson((json['value'] as num).toInt());

Map<String, dynamic> _$JsonConverterCtorParamsToJson(
  JsonConverterCtorParams instance,
) => <String, dynamic>{
  'value': const _ConverterWithCtorParams(42).toJson(instance.value),
};
''')
@JsonSerializable()
@_ConverterWithCtorParams(42)
class JsonConverterCtorParams {
  late Duration value;
}

class _ConverterWithCtorParams implements JsonConverter<Duration, int> {
  final int param;

  const _ConverterWithCtorParams(this.param);

  @override
  Duration fromJson(int json) => throw UnimplementedError();

  @override
  int toJson(Duration object) => 0;
}

@ShouldGenerate(r'''
JsonConverterStringParams _$JsonConverterStringParamsFromJson(
  Map<String, dynamic> json,
) => JsonConverterStringParams()
  ..value = const _ConverterWithStringParams(
    'cool',
  ).fromJson((json['value'] as num).toInt());

Map<String, dynamic> _$JsonConverterStringParamsToJson(
  JsonConverterStringParams instance,
) => <String, dynamic>{
  'value': const _ConverterWithStringParams('cool').toJson(instance.value),
};
''')
@JsonSerializable()
@_ConverterWithStringParams('cool')
class JsonConverterStringParams {
  late Duration value;
}

class _ConverterWithStringParams implements JsonConverter<Duration, int> {
  final String param;

  const _ConverterWithStringParams(this.param);

  @override
  Duration fromJson(int json) => throw UnimplementedError();

  @override
  int toJson(Duration object) => 0;
}

@ShouldGenerate(r'''
JsonConverterListParams _$JsonConverterListParamsFromJson(
  Map<String, dynamic> json,
) => JsonConverterListParams()
  ..value = const _ConverterWithListParams([
    42,
  ]).fromJson((json['value'] as num).toInt());

Map<String, dynamic> _$JsonConverterListParamsToJson(
  JsonConverterListParams instance,
) => <String, dynamic>{
  'value': const _ConverterWithListParams([42]).toJson(instance.value),
};
''')
@JsonSerializable()
@_ConverterWithListParams([42])
class JsonConverterListParams {
  late Duration value;
}

class _ConverterWithListParams implements JsonConverter<Duration, int> {
  final List<int> param;

  const _ConverterWithListParams(this.param);

  @override
  Duration fromJson(int json) => throw UnimplementedError();

  @override
  int toJson(Duration object) => 0;
}

@ShouldGenerate(r'''
JsonConverterNamedParams _$JsonConverterNamedParamsFromJson(
  Map<String, dynamic> json,
) => JsonConverterNamedParams()
  ..value = const _ConverterWithNamedParams(
    param: 42,
  ).fromJson((json['value'] as num).toInt());

Map<String, dynamic> _$JsonConverterNamedParamsToJson(
  JsonConverterNamedParams instance,
) => <String, dynamic>{
  'value': const _ConverterWithNamedParams(param: 42).toJson(instance.value),
};
''')
@JsonSerializable()
@_ConverterWithNamedParams(param: 42)
class JsonConverterNamedParams {
  late Duration value;
}

class _ConverterWithNamedParams implements JsonConverter<Duration, int> {
  final int param;

  const _ConverterWithNamedParams({required this.param});

  @override
  Duration fromJson(int json) => throw UnimplementedError();

  @override
  int toJson(Duration object) => 0;
}
