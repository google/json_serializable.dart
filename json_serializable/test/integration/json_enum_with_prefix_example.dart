import 'package:json_annotation/json_annotation.dart' as j;

part 'json_enum_with_prefix_example.g.dart';

@j.JsonEnum(alwaysCreate: true)
enum StandAloneEnum {
  @j.JsonValue('a')
  alpha,
  @j.JsonValue('b')
  beta,
  @j.JsonValue('g')
  gamma,
  @j.JsonValue('d')
  delta,
}

Iterable<String> get standAloneEnumValues => _$StandAloneEnumEnumMap.values;

@j.JsonEnum(alwaysCreate: true, fieldRename: j.FieldRename.kebab)
enum DayType {
  noGood,
  rotten,
  veryBad,
}

Iterable<String> get dayTypeEnumValues => _$DayTypeEnumMap.values;

@j.JsonSerializable(
  createToJson: false,
)
class Issue559Regression {
  Issue559Regression({
    required this.status,
  });

  factory Issue559Regression.fromJson(Map<String, dynamic> json) =>
      _$Issue559RegressionFromJson(json);

  @j.JsonKey(
    disallowNullValue: true,
    required: true,
  )
  final Issue559RegressionEnum? status;
}

enum Issue559RegressionEnum {
  alpha,
  beta,
  gamma,
}
