import 'package:json_annotation/json_annotation.dart';

part 'schema_example.g.dart';

@JsonSerializable(createJsonSchema: true)
final class SchemaExample {
  /// Requried named constructor parameter
  final double requiredName;

  /// Nullable required named constructor parameter
  final double? nullableNotRequired;

  final double? nullableRequriedPositional;
  final double? nullableRequiredName;

  /// Requried named constructor parameter
  final List<SchemaExample> requiredBranch;

  @JsonKey(defaultValue: 3.145)
  final double? optionalNullableFieldWithJsonKeyDefault;

  SchemaExample(
    this.requiredBranch,
    this.nullableRequriedPositional, {
    required this.requiredName,
    this.nullableNotRequired = 3.145,
    required this.nullableRequiredName,
    this.optionalNullableFieldWithJsonKeyDefault,
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
