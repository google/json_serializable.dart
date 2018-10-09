part of '_json_serializable_test_input.dart';

@JsonSerializable()
class ConfigurationImplicitDefaults {
  int field;
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: true,
    nullable: true,
    disallowUnrecognizedKeys: false,
    fieldRename: FieldRename.none,
    createFactory: true)
class ConfigurationExplicitDefaults {
  int field;
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: true,
    nullable: true,
    disallowUnrecognizedKeys: true,
    fieldRename: FieldRename.snake,
    createFactory: true)
class ConfigurationAllDefaultsOpposite {
  int field;
}
