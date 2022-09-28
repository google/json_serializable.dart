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

@JsonEnum(alwaysCreate: true, valueField: 'value')
enum MyStatusCode {
  success(200),
  @JsonValue(701) // explicit value always takes precedence
  weird(601);

  const MyStatusCode(this.value);

  final int value;
}

Iterable<int> get myStatusCodeEnumValues => _$MyStatusCodeEnumMap.values;

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

enum Issue1145RegressionEnum {
  alpha,
  beta,
  gamma,
}

@JsonSerializable(
  createFactory: false,
)
class Issue1145RegressionA {
  Issue1145RegressionA({
    required this.status,
  });

  Map<String, dynamic> toJson() => _$Issue1145RegressionAToJson(this);

  final Map<Issue1145RegressionEnum, bool> status;
}

@JsonSerializable(
  createFactory: false,
)
class Issue1145RegressionB {
  Issue1145RegressionB({
    required this.status,
  });

  Map<String, dynamic> toJson() => _$Issue1145RegressionBToJson(this);

  final List<Issue1145RegressionEnum?> status;
}
