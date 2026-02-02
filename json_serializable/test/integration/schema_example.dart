import 'package:json_annotation/json_annotation.dart';

part 'schema_example.g.dart';

@JsonSerializable(createJsonSchema: true)
final class SchemaExample {
  /// Required named constructor parameter
  final double requiredName;

  /// Nullable required named constructor parameter
  final double? nullableNotRequired;

  final double? nullableRequiredPositional;
  final double? nullableRequiredName;

  /// Required named constructor parameter
  final List<SchemaExample> requiredBranch;

  @JsonKey(defaultValue: 3.145)
  final double? optionalNullableFieldWithJsonKeyDefault;

  final Branch branch;

  final ComprehensiveNested? nested;

  SchemaExample(
    this.requiredBranch,
    this.nullableRequiredPositional, {
    required this.requiredName,
    this.nullableNotRequired = 3.145,
    required this.nullableRequiredName,
    this.optionalNullableFieldWithJsonKeyDefault,
    required this.branch,
    this.nested,
  });

  factory SchemaExample.fromJson(Map<String, dynamic> json) =>
      _$SchemaExampleFromJson(json);

  Map<String, dynamic> toJson() => _$SchemaExampleToJson(this);

  /// Getter only - should not be in schema
  double get propGetterOnly => requiredName / requiredBranch.length;

  /// Non-nullable field with default value - should NOT be required
  bool propExtraField = false;

  /// Non-ctor field with `required: true` - should be required
  @JsonKey(required: true)
  bool propExtraFieldRequired = false;

  static const schema = _$SchemaExampleJsonSchema;
}

@JsonSerializable()
final class Branch {
  final double length;
  final List<Branch> branch;

  const Branch({required this.length, required this.branch});

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  // This getter should NOT be in the schema, especially as required
  @JsonKey(includeFromJson: false, includeToJson: false, required: false)
  double get proportion => length / branch.length;

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}

@JsonSerializable(createJsonSchema: true)
final class ComprehensiveNested {
  static const staticConst = 1;
  static int staticVar = 2;

  // ignore: unused_field
  final int _privateVar = 3;

  @JsonKey(includeToJson: false)
  int noIncludeToJson = 4;

  @JsonKey(includeFromJson: false)
  int noIncludeFromJson = 4;

  /// Writable field comment
  ///
  /// With a second line.
  int writableField = 5;

  @JsonKey(name: 'renamed_field')
  int renamedField = 6;

  int get getterOnly => 7;

  @JsonKey(includeToJson: true)
  int get getterIncluded => 8;

  @JsonKey(includeToJson: false)
  int get getterExcluded => 9;

  ComprehensiveNested();

  factory ComprehensiveNested.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveNestedFromJson(json);
  Map<String, dynamic> toJson() => _$ComprehensiveNestedToJson(this);

  static const schema = _$ComprehensiveNestedJsonSchema;
}
