import 'package:json_annotation/json_annotation.dart';

part 'field_matrix.field_matrix.g.dart';

@JsonSerializable()
class UsageBothPublic {
  UsageBothPublic();

  int? aField;

  @JsonKey(
    usage: FieldUsage.both,
  )
  int? field;

  int? zField;

  factory UsageBothPublic.fromJson(Map<String, dynamic> json) =>
      _$UsageBothPublicFromJson(json);

  Map<String, dynamic> toJson() => _$UsageBothPublicToJson(this);

  @override
  String toString() => 'UsageBothPublic: field: $field';
}

@JsonSerializable()
class UsageToJsonPublic {
  UsageToJsonPublic();

  int? aField;

  @JsonKey(
    usage: FieldUsage.toJson,
  )
  int? field;

  int? zField;

  factory UsageToJsonPublic.fromJson(Map<String, dynamic> json) =>
      _$UsageToJsonPublicFromJson(json);

  Map<String, dynamic> toJson() => _$UsageToJsonPublicToJson(this);

  @override
  String toString() => 'UsageToJsonPublic: field: $field';
}

@JsonSerializable()
class UsageFromJsonPublic {
  UsageFromJsonPublic();

  int? aField;

  @JsonKey(
    usage: FieldUsage.fromJson,
  )
  int? field;

  int? zField;

  factory UsageFromJsonPublic.fromJson(Map<String, dynamic> json) =>
      _$UsageFromJsonPublicFromJson(json);

  Map<String, dynamic> toJson() => _$UsageFromJsonPublicToJson(this);

  @override
  String toString() => 'UsageFromJsonPublic: field: $field';
}

@JsonSerializable()
class UsageNonePublic {
  UsageNonePublic();

  int? aField;

  @JsonKey(
    usage: FieldUsage.none,
  )
  int? field;

  int? zField;

  factory UsageNonePublic.fromJson(Map<String, dynamic> json) =>
      _$UsageNonePublicFromJson(json);

  Map<String, dynamic> toJson() => _$UsageNonePublicToJson(this);

  @override
  String toString() => 'UsageNonePublic: field: $field';
}

@JsonSerializable()
class UsageNullPublic {
  UsageNullPublic();

  int? aField;

  int? field;

  int? zField;

  factory UsageNullPublic.fromJson(Map<String, dynamic> json) =>
      _$UsageNullPublicFromJson(json);

  Map<String, dynamic> toJson() => _$UsageNullPublicToJson(this);

  @override
  String toString() => 'UsageNullPublic: field: $field';
}

@JsonSerializable()
class UsageBothPrivate {
  UsageBothPrivate();

  int? aField;

  @JsonKey(usage: FieldUsage.both, name: 'field')
  int? _field;

  int? zField;

  factory UsageBothPrivate.fromJson(Map<String, dynamic> json) =>
      _$UsageBothPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$UsageBothPrivateToJson(this);

  @override
  String toString() => 'UsageBothPrivate: _field: $_field';
}

@JsonSerializable()
class UsageToJsonPrivate {
  UsageToJsonPrivate();

  int? aField;

  @JsonKey(usage: FieldUsage.toJson, name: 'field')
  int? _field;

  int? zField;

  factory UsageToJsonPrivate.fromJson(Map<String, dynamic> json) =>
      _$UsageToJsonPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$UsageToJsonPrivateToJson(this);

  @override
  String toString() => 'UsageToJsonPrivate: _field: $_field';
}

@JsonSerializable()
class UsageFromJsonPrivate {
  UsageFromJsonPrivate();

  int? aField;

  @JsonKey(usage: FieldUsage.fromJson, name: 'field')
  int? _field;

  int? zField;

  factory UsageFromJsonPrivate.fromJson(Map<String, dynamic> json) =>
      _$UsageFromJsonPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$UsageFromJsonPrivateToJson(this);

  @override
  String toString() => 'UsageFromJsonPrivate: _field: $_field';
}

@JsonSerializable()
class UsageNonePrivate {
  UsageNonePrivate();

  int? aField;

  @JsonKey(usage: FieldUsage.none, name: 'field')
  int? _field;

  int? zField;

  factory UsageNonePrivate.fromJson(Map<String, dynamic> json) =>
      _$UsageNonePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$UsageNonePrivateToJson(this);

  @override
  String toString() => 'UsageNonePrivate: _field: $_field';
}

@JsonSerializable()
class UsageNullPrivate {
  UsageNullPrivate();

  int? aField;

  @JsonKey(name: 'field')
  int? _field;

  int? zField;

  factory UsageNullPrivate.fromJson(Map<String, dynamic> json) =>
      _$UsageNullPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$UsageNullPrivateToJson(this);

  @override
  String toString() => 'UsageNullPrivate: _field: $_field';
}
