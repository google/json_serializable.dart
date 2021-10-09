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

@JsonSerializable(
  createToJson: false,
)
class Issue559Regression {
  Issue559Regression({
    required this.status,
  });

  factory Issue559Regression.fromJson(Map<String, dynamic> json) =>
      _$Issue559RegressionFromJson(json);

  @JsonKey(
    disallowNullValue: true,
    required: true,
    unknownEnumValue: JsonKey.nullForUndefinedEnumValue,
  )
  final Issue559RegressionEnum? status;
}

enum Issue559RegressionEnum {
  alpha,
  beta,
  gamma,
}
