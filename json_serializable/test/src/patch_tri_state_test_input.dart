// @dart=3.8

part of '_json_serializable_test_input.dart';

sealed class PatchValue<T> {
  const PatchValue();

  const factory PatchValue.present(T value) = PatchValuePresent;
  const factory PatchValue.none() = PatchValueNone;

  factory PatchValue.fromJson(
    Object? json,
    T Function(Object? json) fromJsonT,
  ) => json == null
      ? const PatchValue.none()
      : PatchValue.present(fromJsonT(json));

  Object? toJson(Object? Function(T value) toJsonT);
}

final class PatchValuePresent<T> extends PatchValue<T> {
  const PatchValuePresent(this.value);

  final T value;

  @override
  Object? toJson(Object? Function(T value) toJsonT) => toJsonT(value);
}

final class PatchValueNone<T> extends PatchValue<T> {
  const PatchValueNone();

  @override
  Object? toJson(Object? Function(T value) toJsonT) => null;
}

@JsonSerializable()
class PatchInner {
  const PatchInner(this.id);

  factory PatchInner.fromJson(Map<String, dynamic> json) =>
      PatchInner(json['id'] as int);

  final int id;

  Map<String, dynamic> toJson() => {'id': id};
}

@ShouldGenerate(r'''
PatchEntity _$PatchEntityFromJson(Map<String, dynamic> json) => PatchEntity(
  name: json['name'] as String,
  inner: !json.containsKey('inner')
      ? null
      : PatchValue<PatchInner>.fromJson(
          json['inner'],
          (value) => PatchInner.fromJson(value as Map<String, dynamic>),
        ),
);

Map<String, dynamic> _$PatchEntityToJson(
  PatchEntity instance,
) => <String, dynamic>{
  'name': instance.name,
  if (instance.inner case final value?) 'inner': value.toJson((value) => value),
};
''')
@JsonSerializable()
class PatchEntity {
  const PatchEntity({required this.name, this.inner});

  final String name;

  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final PatchValue<PatchInner>? inner;
}

@ShouldThrow(
  'Fields with `explicitJsonNullWhenNonNullField` cannot deserialize '
  'explicit JSON `null` through `BadPatchInner.fromJson` because its first '
  'parameter is non-nullable `Map<String, dynamic>`. Use a nullable parameter '
  '(for example `Object?`) or provide a custom `@JsonKey(fromJson: ...)` that '
  'accepts nullable input.',
)
@JsonSerializable()
class BadPatchEntity {
  const BadPatchEntity({this.inner});

  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final BadPatchInner? inner;
}

class BadPatchInner {
  const BadPatchInner(this.id);

  factory BadPatchInner.fromJson(Map<String, dynamic> json) =>
      BadPatchInner(json['id'] as int);

  final int id;
}

PatchValue<PatchInner>? _patchValueFromJson(Object? json) =>
    PatchValue.fromJson(
      json,
      (value) => PatchInner.fromJson(value as Map<String, dynamic>),
    );

Object? _patchValueToJson(PatchValue<PatchInner>? value) =>
    value?.toJson((v) => v.toJson());

@ShouldGenerate(r'''
PatchEntityChecked _$PatchEntityCheckedFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PatchEntityChecked', json, ($checkedConvert) {
      final val = PatchEntityChecked(
        name: $checkedConvert('name', (v) => v as String),
        inner: $checkedConvert(
          'inner',
          (v) => !json.containsKey('inner')
              ? null
              : PatchValue<PatchInner>.fromJson(
                  v,
                  (value) => PatchInner.fromJson(value as Map<String, dynamic>),
                ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PatchEntityCheckedToJson(
  PatchEntityChecked instance,
) => <String, dynamic>{
  'name': instance.name,
  if (instance.inner case final value?) 'inner': value.toJson((value) => value),
};
''')
@JsonSerializable(checked: true)
class PatchEntityChecked {
  const PatchEntityChecked({required this.name, this.inner});

  final String name;

  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final PatchValue<PatchInner>? inner;
}

@ShouldGenerate(r'''
PatchNullableStringEntity _$PatchNullableStringEntityFromJson(
  Map<String, dynamic> json,
) => PatchNullableStringEntity(
  note: !json.containsKey('note') ? null : json['note'] as String?,
);

Map<String, dynamic> _$PatchNullableStringEntityToJson(
  PatchNullableStringEntity instance,
) => <String, dynamic>{if (instance.note case final value?) 'note': value};
''')
@JsonSerializable()
class PatchNullableStringEntity {
  const PatchNullableStringEntity({this.note});

  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final String? note;
}

@ShouldGenerate(r'''
PatchWithCustomFromJson _$PatchWithCustomFromJsonFromJson(
  Map<String, dynamic> json,
) => PatchWithCustomFromJson(
  value: !json.containsKey('value') ? null : _patchValueFromJson(json['value']),
);

Map<String, dynamic> _$PatchWithCustomFromJsonToJson(
  PatchWithCustomFromJson instance,
) => <String, dynamic>{
  if (instance.value case final value?) 'value': _patchValueToJson(value),
};
''')
@JsonSerializable()
class PatchWithCustomFromJson {
  const PatchWithCustomFromJson({this.value});

  @JsonKey(
    explicitJsonNullWhenNonNullField: true,
    fromJson: _patchValueFromJson,
    toJson: _patchValueToJson,
  )
  final PatchValue<PatchInner>? value;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `inner` field. Fields with '
  '`explicitJsonNullWhenNonNullField` must be nullable so a missing JSON key '
  'can be represented as Dart `null`.',
  element: 'inner',
)
@JsonSerializable()
class PatchNonNullableField {
  const PatchNonNullableField({required this.inner});

  @JsonKey(explicitJsonNullWhenNonNullField: true)
  final PatchValue<PatchInner> inner;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `inner` field. Cannot set both '
  '`explicitJsonNullWhenNonNullField` and `disallowNullValue` to `true`.',
  element: 'inner',
)
@JsonSerializable()
class PatchDisallowNullWithExplicit {
  const PatchDisallowNullWithExplicit({this.inner});

  @JsonKey(explicitJsonNullWhenNonNullField: true, disallowNullValue: true)
  final PatchValue<PatchInner>? inner;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `inner` field. Cannot set both '
  '`explicitJsonNullWhenNonNullField` and `required` to `true`.',
  element: 'inner',
)
@JsonSerializable()
class PatchRequiredWithExplicit {
  const PatchRequiredWithExplicit({this.inner});

  @JsonKey(explicitJsonNullWhenNonNullField: true, required: true)
  final PatchValue<PatchInner>? inner;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `note` field. Cannot set `defaultValue` when '
  '`explicitJsonNullWhenNonNullField` is `true`.',
  element: 'note',
)
@JsonSerializable()
class PatchDefaultValueWithExplicit {
  const PatchDefaultValueWithExplicit({this.note});

  @JsonKey(explicitJsonNullWhenNonNullField: true, defaultValue: '')
  final String? note;
}

String _nonNullableStringFromJson(String value) => value;

@ShouldThrow(
  'Error with `@JsonKey` on the `note` field. Fields with '
  '`explicitJsonNullWhenNonNullField` require `fromJson` to accept a nullable '
  'JSON input (for example `Object?`), but `_nonNullableStringFromJson` has a '
  'non-nullable parameter type `String`.',
  element: 'note',
)
@JsonSerializable()
class PatchBadCustomFromJson {
  const PatchBadCustomFromJson({this.note});

  @JsonKey(
    explicitJsonNullWhenNonNullField: true,
    fromJson: _nonNullableStringFromJson,
  )
  final String? note;
}
