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

  SchemaExample(
    this.requiredBranch,
    this.nullableRequiredPositional, {
    required this.requiredName,
    this.nullableNotRequired = 3.145,
    required this.nullableRequiredName,
    this.optionalNullableFieldWithJsonKeyDefault,
    required this.branch,
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
