import 'package:json_annotation/json_annotation.dart';

part 'json_enum_example.g.dart';

@JsonEnum(alwaysCreate: true)
enum StandAloneEnum {
  @JsonValue('a')
  alpha,
  @JsonValue('b')
  beta,
  @JsonValue('g')
  gamma,
  @JsonValue('d')
  delta,
}

Iterable<String> get standAloneEnumValues => _$StandAloneEnumEnumMap.values;

@JsonEnum(alwaysCreate: true, fieldRename: FieldRename.kebab)
enum DayType {
  noGood,
  rotten,
  veryBad,
}

Iterable<String> get dayTypeEnumValues => _$DayTypeEnumMap.values;
