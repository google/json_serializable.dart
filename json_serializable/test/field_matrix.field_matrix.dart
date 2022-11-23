import 'package:json_annotation/json_annotation.dart';

part 'field_matrix.field_matrix.g.dart';

@JsonSerializable()
class ToJsonnullFromJsonnullPublic {
  ToJsonnullFromJsonnullPublic();

  int? aField;

  int? field;

  int? zField;

  factory ToJsonnullFromJsonnullPublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonnullFromJsonnullPublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonnullFromJsonnullPublicToJson(this);

  @override
  String toString() => 'ToJsonnullFromJsonnullPublic: field: $field';
}

@JsonSerializable()
class ToJsonnullFromJsontruePublic {
  ToJsonnullFromJsontruePublic();

  int? aField;

  @JsonKey(
    includeFromJson: true,
  )
  int? field;

  int? zField;

  factory ToJsonnullFromJsontruePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonnullFromJsontruePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonnullFromJsontruePublicToJson(this);

  @override
  String toString() => 'ToJsonnullFromJsontruePublic: field: $field';
}

@JsonSerializable()
class ToJsonnullFromJsonfalsePublic {
  ToJsonnullFromJsonfalsePublic();

  int? aField;

  @JsonKey(
    includeFromJson: false,
  )
  int? field;

  int? zField;

  factory ToJsonnullFromJsonfalsePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonnullFromJsonfalsePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonnullFromJsonfalsePublicToJson(this);

  @override
  String toString() => 'ToJsonnullFromJsonfalsePublic: field: $field';
}

@JsonSerializable()
class ToJsontrueFromJsonnullPublic {
  ToJsontrueFromJsonnullPublic();

  int? aField;

  @JsonKey(
    includeToJson: true,
  )
  int? field;

  int? zField;

  factory ToJsontrueFromJsonnullPublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsontrueFromJsonnullPublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsontrueFromJsonnullPublicToJson(this);

  @override
  String toString() => 'ToJsontrueFromJsonnullPublic: field: $field';
}

@JsonSerializable()
class ToJsontrueFromJsontruePublic {
  ToJsontrueFromJsontruePublic();

  int? aField;

  @JsonKey(
    includeFromJson: true,
    includeToJson: true,
  )
  int? field;

  int? zField;

  factory ToJsontrueFromJsontruePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsontrueFromJsontruePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsontrueFromJsontruePublicToJson(this);

  @override
  String toString() => 'ToJsontrueFromJsontruePublic: field: $field';
}

@JsonSerializable()
class ToJsontrueFromJsonfalsePublic {
  ToJsontrueFromJsonfalsePublic();

  int? aField;

  @JsonKey(
    includeFromJson: false,
    includeToJson: true,
  )
  int? field;

  int? zField;

  factory ToJsontrueFromJsonfalsePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsontrueFromJsonfalsePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsontrueFromJsonfalsePublicToJson(this);

  @override
  String toString() => 'ToJsontrueFromJsonfalsePublic: field: $field';
}

@JsonSerializable()
class ToJsonfalseFromJsonnullPublic {
  ToJsonfalseFromJsonnullPublic();

  int? aField;

  @JsonKey(
    includeToJson: false,
  )
  int? field;

  int? zField;

  factory ToJsonfalseFromJsonnullPublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonfalseFromJsonnullPublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonfalseFromJsonnullPublicToJson(this);

  @override
  String toString() => 'ToJsonfalseFromJsonnullPublic: field: $field';
}

@JsonSerializable()
class ToJsonfalseFromJsontruePublic {
  ToJsonfalseFromJsontruePublic();

  int? aField;

  @JsonKey(
    includeFromJson: true,
    includeToJson: false,
  )
  int? field;

  int? zField;

  factory ToJsonfalseFromJsontruePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonfalseFromJsontruePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonfalseFromJsontruePublicToJson(this);

  @override
  String toString() => 'ToJsonfalseFromJsontruePublic: field: $field';
}

@JsonSerializable()
class ToJsonfalseFromJsonfalsePublic {
  ToJsonfalseFromJsonfalsePublic();

  int? aField;

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  int? field;

  int? zField;

  factory ToJsonfalseFromJsonfalsePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonfalseFromJsonfalsePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonfalseFromJsonfalsePublicToJson(this);

  @override
  String toString() => 'ToJsonfalseFromJsonfalsePublic: field: $field';
}

@JsonSerializable()
class ToJsonnullFromJsonnullPrivate {
  ToJsonnullFromJsonnullPrivate();

  int? aField;

  @JsonKey(name: 'field')
  int? _field;

  int? zField;

  factory ToJsonnullFromJsonnullPrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonnullFromJsonnullPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonnullFromJsonnullPrivateToJson(this);

  @override
  String toString() => 'ToJsonnullFromJsonnullPrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonnullFromJsontruePrivate {
  ToJsonnullFromJsontruePrivate();

  int? aField;

  @JsonKey(includeFromJson: true, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonnullFromJsontruePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonnullFromJsontruePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonnullFromJsontruePrivateToJson(this);

  @override
  String toString() => 'ToJsonnullFromJsontruePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonnullFromJsonfalsePrivate {
  ToJsonnullFromJsonfalsePrivate();

  int? aField;

  @JsonKey(includeFromJson: false, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonnullFromJsonfalsePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonnullFromJsonfalsePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonnullFromJsonfalsePrivateToJson(this);

  @override
  String toString() => 'ToJsonnullFromJsonfalsePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsontrueFromJsonnullPrivate {
  ToJsontrueFromJsonnullPrivate();

  int? aField;

  @JsonKey(includeToJson: true, name: 'field')
  int? _field;

  int? zField;

  factory ToJsontrueFromJsonnullPrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsontrueFromJsonnullPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsontrueFromJsonnullPrivateToJson(this);

  @override
  String toString() => 'ToJsontrueFromJsonnullPrivate: _field: $_field';
}

@JsonSerializable()
class ToJsontrueFromJsontruePrivate {
  ToJsontrueFromJsontruePrivate();

  int? aField;

  @JsonKey(includeFromJson: true, includeToJson: true, name: 'field')
  int? _field;

  int? zField;

  factory ToJsontrueFromJsontruePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsontrueFromJsontruePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsontrueFromJsontruePrivateToJson(this);

  @override
  String toString() => 'ToJsontrueFromJsontruePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsontrueFromJsonfalsePrivate {
  ToJsontrueFromJsonfalsePrivate();

  int? aField;

  @JsonKey(includeFromJson: false, includeToJson: true, name: 'field')
  int? _field;

  int? zField;

  factory ToJsontrueFromJsonfalsePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsontrueFromJsonfalsePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsontrueFromJsonfalsePrivateToJson(this);

  @override
  String toString() => 'ToJsontrueFromJsonfalsePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonfalseFromJsonnullPrivate {
  ToJsonfalseFromJsonnullPrivate();

  int? aField;

  @JsonKey(includeToJson: false, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonfalseFromJsonnullPrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonfalseFromJsonnullPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonfalseFromJsonnullPrivateToJson(this);

  @override
  String toString() => 'ToJsonfalseFromJsonnullPrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonfalseFromJsontruePrivate {
  ToJsonfalseFromJsontruePrivate();

  int? aField;

  @JsonKey(includeFromJson: true, includeToJson: false, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonfalseFromJsontruePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonfalseFromJsontruePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonfalseFromJsontruePrivateToJson(this);

  @override
  String toString() => 'ToJsonfalseFromJsontruePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonfalseFromJsonfalsePrivate {
  ToJsonfalseFromJsonfalsePrivate();

  int? aField;

  @JsonKey(includeFromJson: false, includeToJson: false, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonfalseFromJsonfalsePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonfalseFromJsonfalsePrivateFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ToJsonfalseFromJsonfalsePrivateToJson(this);

  @override
  String toString() => 'ToJsonfalseFromJsonfalsePrivate: _field: $_field';
}
