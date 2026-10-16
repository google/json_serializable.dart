// @dart=3.8

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
UnknownEnumValue _$UnknownEnumValueFromJson(Map<String, dynamic> json) =>
    UnknownEnumValue()
      ..value =
          $enumDecodeNullable(
            _$UnknownEnumValueItemsEnumMap,
            json['value'],
            unknownValue: UnknownEnumValueItems.vUnknown,
          ) ??
          UnknownEnumValueItems.vNull;

const _$UnknownEnumValueItemsEnumMap = {
  UnknownEnumValueItems.v0: 'v0',
  UnknownEnumValueItems.v1: 'v1',
  UnknownEnumValueItems.v2: 'v2',
  UnknownEnumValueItems.vUnknown: 'vUnknown',
  UnknownEnumValueItems.vNull: 'vNull',
};
''')
@JsonSerializable(createToJson: false)
class UnknownEnumValue {
  @JsonKey(
    defaultValue: UnknownEnumValueItems.vNull,
    unknownEnumValue: UnknownEnumValueItems.vUnknown,
  )
  UnknownEnumValueItems? value;
}

enum UnknownEnumValueItems { v0, v1, v2, vUnknown, vNull }

@ShouldGenerate(r'''
UnknownEnumValueMap _$UnknownEnumValueMapFromJson(Map<String, dynamic> json) =>
    UnknownEnumValueMap()
      ..stringKeyMap = (json['stringKeyMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          $enumDecode(
            _$UnknownEnumValueItemsEnumMap,
            e,
            unknownValue: UnknownEnumValueItems.vUnknown,
          ),
        ),
      )
      ..nullableValueMap = (json['nullableValueMap'] as Map<String, dynamic>)
          .map(
            (k, e) => MapEntry(
              k,
              $enumDecodeNullable(
                _$UnknownEnumValueItemsEnumMap,
                e,
                unknownValue: JsonKey.nullForUndefinedEnumValue,
              ),
            ),
          )
      ..enumKeyMap = (json['enumKeyMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          $enumDecode(_$WrongEnumTypeEnumMap, k),
          $enumDecode(
            _$UnknownEnumValueItemsEnumMap,
            e,
            unknownValue: UnknownEnumValueItems.vUnknown,
          ),
        ),
      )
      ..enumKeyNullableValueMap =
          (json['enumKeyNullableValueMap'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              $enumDecode(_$WrongEnumTypeEnumMap, k),
              $enumDecodeNullable(
                _$UnknownEnumValueItemsEnumMap,
                e,
                unknownValue: JsonKey.nullForUndefinedEnumValue,
              ),
            ),
          )
      ..nestedListMap = (json['nestedListMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map(
                (e) => $enumDecode(
                  _$UnknownEnumValueItemsEnumMap,
                  e,
                  unknownValue: UnknownEnumValueItems.vUnknown,
                ),
              )
              .toList(),
        ),
      );

const _$UnknownEnumValueItemsEnumMap = {
  UnknownEnumValueItems.v0: 'v0',
  UnknownEnumValueItems.v1: 'v1',
  UnknownEnumValueItems.v2: 'v2',
  UnknownEnumValueItems.vUnknown: 'vUnknown',
  UnknownEnumValueItems.vNull: 'vNull',
};

const _$WrongEnumTypeEnumMap = {WrongEnumType.otherValue: 'otherValue'};
''')
@JsonSerializable(createToJson: false)
class UnknownEnumValueMap {
  @JsonKey(unknownEnumValue: UnknownEnumValueItems.vUnknown)
  late Map<String, UnknownEnumValueItems> stringKeyMap;

  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  late Map<String, UnknownEnumValueItems?> nullableValueMap;

  @JsonKey(unknownEnumValue: UnknownEnumValueItems.vUnknown)
  late Map<WrongEnumType, UnknownEnumValueItems> enumKeyMap;

  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  late Map<WrongEnumType, UnknownEnumValueItems?> enumKeyNullableValueMap;

  @JsonKey(unknownEnumValue: UnknownEnumValueItems.vUnknown)
  late Map<String, List<UnknownEnumValueItems>> nestedListMap;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `value` field. `unknownEnumValue` has type '
  '`int`, but the provided unknownEnumValue is of type `_NullAsDefault`.',
)
@JsonSerializable()
class UnknownEnumValueMapNullForUndefinedWrongType {
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  late Map<String, int?> value;
}

@ShouldThrow(
  '`JsonKey.nullForUndefinedEnumValue` cannot be used with '
  '`JsonKey.unknownEnumValue` unless the field is nullable.',
  element: 'value',
)
@JsonSerializable()
class UnknownEnumValueMapNotNullable {
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  late Map<String, UnknownEnumValueItems> value;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `value` field. `unknownEnumValue` has type '
  '`int`, but the provided unknownEnumValue is of type '
  '`WrongEnumType`.',
)
@JsonSerializable()
class UnknownEnumValueListWrongType {
  @JsonKey(unknownEnumValue: WrongEnumType.otherValue)
  late List<int> value;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `value` field. `unknownEnumValue` has type '
  '`UnknownEnumValueItems`, but the provided unknownEnumValue is of type '
  '`WrongEnumType`.',
)
@JsonSerializable()
class UnknownEnumValueListWrongEnumType {
  @JsonKey(unknownEnumValue: WrongEnumType.otherValue)
  late List<UnknownEnumValueItems> value;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `value` field. `unknownEnumValue` has type '
  '`int`, but the provided unknownEnumValue is of type '
  '`WrongEnumType`.',
)
@JsonSerializable()
class UnknownEnumValueMapValueWrongType {
  @JsonKey(unknownEnumValue: WrongEnumType.otherValue)
  late Map<String, int> value;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `value` field. `unknownEnumValue` has type '
  '`UnknownEnumValueItems`, but the provided unknownEnumValue is of type '
  '`WrongEnumType`.',
)
@JsonSerializable()
class UnknownEnumValueMapValueWrongEnumType {
  @JsonKey(unknownEnumValue: WrongEnumType.otherValue)
  late Map<String, UnknownEnumValueItems> value;
}

enum WrongEnumType { otherValue }

@ShouldThrow(
  'Error with `@JsonKey` on the `value` field. `unknownEnumValue` has type '
  '`UnknownEnumValueItems`, but the provided unknownEnumValue is of type '
  '`WrongEnumType`.',
)
@JsonSerializable()
class UnknownEnumValueWrongEnumType {
  @JsonKey(unknownEnumValue: WrongEnumType.otherValue)
  late UnknownEnumValueItems value;
}

@ShouldThrow(
  'Error with `@JsonKey` on the `value` field. `unknownEnumValue` can only be '
  'set on fields of type enum or on Iterable, List, Set or Map instances of an '
  'enum type.',
)
@JsonSerializable()
class UnknownEnumValueNotEnumField {
  @JsonKey(unknownEnumValue: UnknownEnumValueItems.vUnknown)
  int? value;
}
