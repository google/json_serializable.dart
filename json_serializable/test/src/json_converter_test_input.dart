// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=3.8

// ignore_for_file: inference_failure_on_instance_creation

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
JsonConverterNamedCtor<E> _$JsonConverterNamedCtorFromJson<E>(
  Map<String, dynamic> json,
) => JsonConverterNamedCtor<E>()
  ..value = const _DurationMillisecondConverter.named().fromJson(
    (json['value'] as num).toInt(),
  )
  ..genericValue = _GenericConverter<E>.named().fromJson(
    (json['genericValue'] as num).toInt(),
  )
  ..keyAnnotationFirst = JsonConverterNamedCtor._fromJson(
    (json['keyAnnotationFirst'] as num).toInt(),
  );

Map<String, dynamic> _$JsonConverterNamedCtorToJson<E>(
  JsonConverterNamedCtor<E> instance,
) => <String, dynamic>{
  'value': const _DurationMillisecondConverter.named().toJson(instance.value),
  'genericValue': _GenericConverter<E>.named().toJson(instance.genericValue),
  'keyAnnotationFirst': JsonConverterNamedCtor._toJson(
    instance.keyAnnotationFirst,
  ),
};
''')
@JsonSerializable()
@_DurationMillisecondConverter.named()
@_GenericConverter.named()
class JsonConverterNamedCtor<E> {
  late Duration value;
  late E genericValue;

  // Field annotations have precedence over class annotations
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  late Duration keyAnnotationFirst;

  static Duration _fromJson(int value) => throw UnimplementedError();

  static int _toJson(Duration object) => 42;
}

@ShouldGenerate(r'''
JsonConvertOnField<E> _$JsonConvertOnFieldFromJson<E>(
  Map<String, dynamic> json,
) => JsonConvertOnField<E>()
  ..annotatedField = const _DurationMillisecondConverter().fromJson(
    (json['annotatedField'] as num).toInt(),
  )
  ..annotatedWithNamedCtor = const _DurationMillisecondConverter.named()
      .fromJson((json['annotatedWithNamedCtor'] as num).toInt())
  ..classAnnotatedWithField = _durationConverter.fromJson(
    (json['classAnnotatedWithField'] as num).toInt(),
  )
  ..genericValue = _GenericConverter<E>().fromJson(
    (json['genericValue'] as num).toInt(),
  );

Map<String, dynamic> _$JsonConvertOnFieldToJson<E>(
  JsonConvertOnField<E> instance,
) => <String, dynamic>{
  'annotatedField': const _DurationMillisecondConverter().toJson(
    instance.annotatedField,
  ),
  'annotatedWithNamedCtor': const _DurationMillisecondConverter.named().toJson(
    instance.annotatedWithNamedCtor,
  ),
  'classAnnotatedWithField': _durationConverter.toJson(
    instance.classAnnotatedWithField,
  ),
  'genericValue': _GenericConverter<E>().toJson(instance.genericValue),
};
''')
@JsonSerializable()
@_durationConverter
class JsonConvertOnField<E> {
  @_DurationMillisecondConverter()
  late Duration annotatedField;

  @_DurationMillisecondConverter.named()
  late Duration annotatedWithNamedCtor;

  late Duration classAnnotatedWithField;

  @_GenericConverter()
  late E genericValue;
}

class _GenericConverter<T> implements JsonConverter<T, int> {
  const _GenericConverter();

  const _GenericConverter.named();

  @override
  T fromJson(int json) => throw UnimplementedError();

  @override
  int toJson(T object) => 0;
}

@ShouldThrow(
  '`JsonConverter` implementations can have no more than one type argument. '
  '`_BadConverter` has 2.',
  element: '_BadConverter',
)
@JsonSerializable()
@_BadConverter()
class JsonConverterWithBadTypeArg<T> {
  late T value;
}

class _BadConverter<T, S> implements JsonConverter<S, int> {
  const _BadConverter();

  @override
  S fromJson(int json) => throw UnimplementedError();

  @override
  int toJson(S object) => 0;
}

@ShouldThrow(
  'Found more than one matching converter for `Duration`.',
  element: 'new',
)
@JsonSerializable()
@_durationConverter
@_DurationMillisecondConverter()
class JsonConverterDuplicateAnnotations {
  late Duration value;
}

const _durationConverter = _DurationMillisecondConverter();

class _DurationMillisecondConverter implements JsonConverter<Duration, int> {
  const _DurationMillisecondConverter();

  const _DurationMillisecondConverter.named();

  @override
  Duration fromJson(int json) => throw UnimplementedError();

  @override
  int toJson(Duration object) => throw UnimplementedError();
}

@ShouldThrow(
  'Generators with constructor arguments are not supported.',
  element: 'new',
)
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
Map<String, dynamic> _$JsonConverterOnGetterToJson(
  JsonConverterOnGetter instance,
) => <String, dynamic>{
  'annotatedGetter': const _NeedsConversionConverter().toJson(
    instance.annotatedGetter,
  ),
};
''')
@JsonSerializable(createFactory: false)
class JsonConverterOnGetter {
  @JsonKey()
  @_NeedsConversionConverter()
  NeedsConversion get annotatedGetter => NeedsConversion();
}

class NeedsConversion {}

class _NeedsConversionConverter implements JsonConverter<NeedsConversion, int> {
  const _NeedsConversionConverter();

  @override
  NeedsConversion fromJson(int json) => NeedsConversion();

  @override
  int toJson(NeedsConversion object) => 0;
}

@ShouldThrow('''
Could not generate `fromJson` code for `value`.
To support the type `NeedsConversion` you can:
$converterOrKeyInstructions''')
@_NullableConverter()
@JsonSerializable()
class JsonConverterNullableToNonNullable {
  late NeedsConversion value;
}

class _NullableConverter implements JsonConverter<NeedsConversion?, Object?> {
  const _NullableConverter();

  @override
  NeedsConversion? fromJson(Object? json) => null;

  @override
  Object? toJson(NeedsConversion? object) => null;
}

@ShouldGenerate(r'''
JsonConverterNullableAndNonNullable<T>
_$JsonConverterNullableAndNonNullableFromJson<T extends Object>(
  Map<String, dynamic> json,
) => JsonConverterNullableAndNonNullable<T>()
  ..value = const _DurationMillisecondConverter().fromJson(
    (json['value'] as num).toInt(),
  )
  ..nullableValue = const _NullableDurationMillisecondConverter().fromJson(
    (json['nullableValue'] as num?)?.toInt(),
  )
  ..intValue = const _DynamicIntConverter().fromJson(json['intValue'])
  ..nullableIntValue = const _NullableDynamicIntConverter().fromJson(
    json['nullableIntValue'],
  )
  ..nullableNeedsConversion = const _NeedsConversionDynamicConverter().fromJson(
    json['nullableNeedsConversion'],
  )
  ..genericValue = _GenericConverter<T>().fromJson(
    (json['genericValue'] as num).toInt(),
  )
  ..nullableGenericValue = _$JsonConverterFromJson<int, T>(
    json['nullableGenericValue'],
    _NullableGenericConverter<T>().fromJson,
  );

Map<String, dynamic> _$JsonConverterNullableAndNonNullableToJson<
  T extends Object
>(JsonConverterNullableAndNonNullable<T> instance) => <String, dynamic>{
  'value': const _DurationMillisecondConverter().toJson(instance.value),
  'nullableValue': const _NullableDurationMillisecondConverter().toJson(
    instance.nullableValue,
  ),
  'intValue': const _DynamicIntConverter().toJson(instance.intValue),
  'nullableIntValue': const _NullableDynamicIntConverter().toJson(
    instance.nullableIntValue,
  ),
  'nullableNeedsConversion': _$JsonConverterToJson<dynamic, NeedsConversion>(
    instance.nullableNeedsConversion,
    const _NeedsConversionDynamicConverter().toJson,
  ),
  'genericValue': _GenericConverter<T>().toJson(instance.genericValue),
  'nullableGenericValue': _NullableGenericConverter<T>().toJson(
    instance.nullableGenericValue,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
''')
@JsonSerializable(
  converters: [_DynamicIntConverter(), _NullableDynamicIntConverter()],
)
@_DurationMillisecondConverter()
@_NullableDurationMillisecondConverter()
@_NeedsConversionDynamicConverter()
@_GenericConverter()
@_NullableGenericConverter()
class JsonConverterNullableAndNonNullable<T extends Object> {
  late Duration value;
  Duration? nullableValue;
  late int intValue;
  int? nullableIntValue;
  NeedsConversion? nullableNeedsConversion;
  late T genericValue;
  @JsonKey(includeIfNull: false)
  T? nullableGenericValue;
}

class _NullableGenericConverter<T extends Object>
    implements JsonConverter<T?, int> {
  const _NullableGenericConverter();

  @override
  T? fromJson(int json) => null;

  @override
  int toJson(T? object) => 0;
}

class _NullableDurationMillisecondConverter
    implements JsonConverter<Duration?, int?> {
  const _NullableDurationMillisecondConverter();

  @override
  Duration? fromJson(int? json) => null;

  @override
  int? toJson(Duration? object) => null;
}

class _DynamicIntConverter implements JsonConverter<int, dynamic> {
  const _DynamicIntConverter();

  @override
  int fromJson(dynamic json) => 0;

  @override
  dynamic toJson(int object) => object;
}

class _NullableDynamicIntConverter implements JsonConverter<int?, dynamic> {
  const _NullableDynamicIntConverter();

  @override
  int? fromJson(dynamic json) => null;

  @override
  dynamic toJson(int? object) => object;
}

class _NeedsConversionDynamicConverter
    implements JsonConverter<NeedsConversion, dynamic> {
  const _NeedsConversionDynamicConverter();

  @override
  NeedsConversion fromJson(dynamic json) => NeedsConversion();

  @override
  dynamic toJson(NeedsConversion object) => 0;
}
