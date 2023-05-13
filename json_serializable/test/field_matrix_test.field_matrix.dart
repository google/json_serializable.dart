import 'package:json_annotation/json_annotation.dart';

part 'field_matrix_test.field_matrix.g.dart';

@JsonSerializable()
class ToJsonNullFromJsonNullPublic {
  ToJsonNullFromJsonNullPublic();

  int? aField;

  int? field;

  int? zField;

  factory ToJsonNullFromJsonNullPublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonNullFromJsonNullPublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonNullFromJsonNullPublicToJson(this);

  @override
  String toString() => 'ToJsonNullFromJsonNullPublic: field: $field';
}

@JsonSerializable()
class ToJsonNullFromJsonTruePublic {
  ToJsonNullFromJsonTruePublic();

  int? aField;

  @JsonKey(
    includeFromJson: true,
  )
  int? field;

  int? zField;

  factory ToJsonNullFromJsonTruePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonNullFromJsonTruePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonNullFromJsonTruePublicToJson(this);

  @override
  String toString() => 'ToJsonNullFromJsonTruePublic: field: $field';
}

@JsonSerializable()
class ToJsonNullFromJsonFalsePublic {
  ToJsonNullFromJsonFalsePublic();

  int? aField;

  @JsonKey(
    includeFromJson: false,
  )
  int? field;

  int? zField;

  factory ToJsonNullFromJsonFalsePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonNullFromJsonFalsePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonNullFromJsonFalsePublicToJson(this);

  @override
  String toString() => 'ToJsonNullFromJsonFalsePublic: field: $field';
}

@JsonSerializable()
class ToJsonTrueFromJsonNullPublic {
  ToJsonTrueFromJsonNullPublic();

  int? aField;

  @JsonKey(
    includeToJson: true,
  )
  int? field;

  int? zField;

  factory ToJsonTrueFromJsonNullPublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonTrueFromJsonNullPublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonTrueFromJsonNullPublicToJson(this);

  @override
  String toString() => 'ToJsonTrueFromJsonNullPublic: field: $field';
}

@JsonSerializable()
class ToJsonTrueFromJsonTruePublic {
  ToJsonTrueFromJsonTruePublic();

  int? aField;

  @JsonKey(
    includeFromJson: true,
    includeToJson: true,
  )
  int? field;

  int? zField;

  factory ToJsonTrueFromJsonTruePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonTrueFromJsonTruePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonTrueFromJsonTruePublicToJson(this);

  @override
  String toString() => 'ToJsonTrueFromJsonTruePublic: field: $field';
}

@JsonSerializable()
class ToJsonTrueFromJsonFalsePublic {
  ToJsonTrueFromJsonFalsePublic();

  int? aField;

  @JsonKey(
    includeFromJson: false,
    includeToJson: true,
  )
  int? field;

  int? zField;

  factory ToJsonTrueFromJsonFalsePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonTrueFromJsonFalsePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonTrueFromJsonFalsePublicToJson(this);

  @override
  String toString() => 'ToJsonTrueFromJsonFalsePublic: field: $field';
}

@JsonSerializable()
class ToJsonFalseFromJsonNullPublic {
  ToJsonFalseFromJsonNullPublic();

  int? aField;

  @JsonKey(
    includeToJson: false,
  )
  int? field;

  int? zField;

  factory ToJsonFalseFromJsonNullPublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonFalseFromJsonNullPublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonFalseFromJsonNullPublicToJson(this);

  @override
  String toString() => 'ToJsonFalseFromJsonNullPublic: field: $field';
}

@JsonSerializable()
class ToJsonFalseFromJsonTruePublic {
  ToJsonFalseFromJsonTruePublic();

  int? aField;

  @JsonKey(
    includeFromJson: true,
    includeToJson: false,
  )
  int? field;

  int? zField;

  factory ToJsonFalseFromJsonTruePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonFalseFromJsonTruePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonFalseFromJsonTruePublicToJson(this);

  @override
  String toString() => 'ToJsonFalseFromJsonTruePublic: field: $field';
}

@JsonSerializable()
class ToJsonFalseFromJsonFalsePublic {
  ToJsonFalseFromJsonFalsePublic();

  int? aField;

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  int? field;

  int? zField;

  factory ToJsonFalseFromJsonFalsePublic.fromJson(Map<String, dynamic> json) =>
      _$ToJsonFalseFromJsonFalsePublicFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonFalseFromJsonFalsePublicToJson(this);

  @override
  String toString() => 'ToJsonFalseFromJsonFalsePublic: field: $field';
}

@JsonSerializable()
class ToJsonNullFromJsonNullPrivate {
  ToJsonNullFromJsonNullPrivate();

  int? aField;

  @JsonKey(name: 'field')
  int? _field;

  int? zField;

  factory ToJsonNullFromJsonNullPrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonNullFromJsonNullPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonNullFromJsonNullPrivateToJson(this);

  @override
  String toString() => 'ToJsonNullFromJsonNullPrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonNullFromJsonTruePrivate {
  ToJsonNullFromJsonTruePrivate();

  int? aField;

  @JsonKey(includeFromJson: true, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonNullFromJsonTruePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonNullFromJsonTruePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonNullFromJsonTruePrivateToJson(this);

  @override
  String toString() => 'ToJsonNullFromJsonTruePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonNullFromJsonFalsePrivate {
  ToJsonNullFromJsonFalsePrivate();

  int? aField;

  @JsonKey(includeFromJson: false, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonNullFromJsonFalsePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonNullFromJsonFalsePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonNullFromJsonFalsePrivateToJson(this);

  @override
  String toString() => 'ToJsonNullFromJsonFalsePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonTrueFromJsonNullPrivate {
  ToJsonTrueFromJsonNullPrivate();

  int? aField;

  @JsonKey(includeToJson: true, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonTrueFromJsonNullPrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonTrueFromJsonNullPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonTrueFromJsonNullPrivateToJson(this);

  @override
  String toString() => 'ToJsonTrueFromJsonNullPrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonTrueFromJsonTruePrivate {
  ToJsonTrueFromJsonTruePrivate();

  int? aField;

  @JsonKey(includeFromJson: true, includeToJson: true, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonTrueFromJsonTruePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonTrueFromJsonTruePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonTrueFromJsonTruePrivateToJson(this);

  @override
  String toString() => 'ToJsonTrueFromJsonTruePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonTrueFromJsonFalsePrivate {
  ToJsonTrueFromJsonFalsePrivate();

  int? aField;

  @JsonKey(includeFromJson: false, includeToJson: true, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonTrueFromJsonFalsePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonTrueFromJsonFalsePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonTrueFromJsonFalsePrivateToJson(this);

  @override
  String toString() => 'ToJsonTrueFromJsonFalsePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonFalseFromJsonNullPrivate {
  ToJsonFalseFromJsonNullPrivate();

  int? aField;

  @JsonKey(includeToJson: false, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonFalseFromJsonNullPrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonFalseFromJsonNullPrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonFalseFromJsonNullPrivateToJson(this);

  @override
  String toString() => 'ToJsonFalseFromJsonNullPrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonFalseFromJsonTruePrivate {
  ToJsonFalseFromJsonTruePrivate();

  int? aField;

  @JsonKey(includeFromJson: true, includeToJson: false, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonFalseFromJsonTruePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonFalseFromJsonTruePrivateFromJson(json);

  Map<String, dynamic> toJson() => _$ToJsonFalseFromJsonTruePrivateToJson(this);

  @override
  String toString() => 'ToJsonFalseFromJsonTruePrivate: _field: $_field';
}

@JsonSerializable()
class ToJsonFalseFromJsonFalsePrivate {
  ToJsonFalseFromJsonFalsePrivate();

  int? aField;

  @JsonKey(includeFromJson: false, includeToJson: false, name: 'field')
  int? _field;

  int? zField;

  factory ToJsonFalseFromJsonFalsePrivate.fromJson(Map<String, dynamic> json) =>
      _$ToJsonFalseFromJsonFalsePrivateFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ToJsonFalseFromJsonFalsePrivateToJson(this);

  @override
  String toString() => 'ToJsonFalseFromJsonFalsePrivate: _field: $_field';
}

const fromJsonFactories = <Object Function(Map<String, dynamic>)>{
  ToJsonNullFromJsonNullPublic.fromJson,
  ToJsonNullFromJsonTruePublic.fromJson,
  ToJsonNullFromJsonFalsePublic.fromJson,
  ToJsonTrueFromJsonNullPublic.fromJson,
  ToJsonTrueFromJsonTruePublic.fromJson,
  ToJsonTrueFromJsonFalsePublic.fromJson,
  ToJsonFalseFromJsonNullPublic.fromJson,
  ToJsonFalseFromJsonTruePublic.fromJson,
  ToJsonFalseFromJsonFalsePublic.fromJson,
  ToJsonNullFromJsonNullPrivate.fromJson,
  ToJsonNullFromJsonTruePrivate.fromJson,
  ToJsonNullFromJsonFalsePrivate.fromJson,
  ToJsonTrueFromJsonNullPrivate.fromJson,
  ToJsonTrueFromJsonTruePrivate.fromJson,
  ToJsonTrueFromJsonFalsePrivate.fromJson,
  ToJsonFalseFromJsonNullPrivate.fromJson,
  ToJsonFalseFromJsonTruePrivate.fromJson,
  ToJsonFalseFromJsonFalsePrivate.fromJson,
};
