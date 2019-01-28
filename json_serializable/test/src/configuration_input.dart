part of '_json_serializable_test_input.dart';

@JsonSerializable()
class ConfigurationImplicitDefaults {
  int field;
}

@JsonSerializable(
  anyMap: false,
  checked: false,
  createFactory: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: false,
  fieldRename: FieldRename.none,
  generateToJsonFunction: true,
  includeIfNull: true,
  nullable: true,
  useWrappers: false,
)
class ConfigurationExplicitDefaults {
  int field;
}
