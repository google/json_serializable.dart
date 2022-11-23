import 'package:json_annotation/json_annotation.dart';

part 'create_per_field_to_json_example.g.dart';

@JsonSerializable(
  createPerFieldToJson: true,
  explicitToJson: true,
)
class Model {
  Model({
    required this.firstName,
    required this.lastName,
    this.ignoredName,
    this.enumValue,
    this.nested,
    this.nestedExcludeIfNull,
    this.nestedGeneric,
  });

  factory Model.fromJson(Map<String, Object?> json) => _$ModelFromJson(json);

  final String firstName;
  final String lastName;
  final EnumValue? enumValue;
  final Nested? nested;
  final GenericFactory<int>? nestedGeneric;

  @JsonKey(includeIfNull: false)
  final Nested? nestedExcludeIfNull;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? ignoredName;

  String get fullName => '$firstName $lastName';

  Map<String, Object?> toJson() => _$ModelToJson(this);
}

typedef ModelPerFieldToJson = _$ModelPerFieldToJson;

@JsonEnum()
enum EnumValue {
  @JsonValue('1')
  first,
  second,
}

@JsonSerializable()
class Nested {
  Nested(this.value);

  factory Nested.fromJson(Map<String, Object?> json) => _$NestedFromJson(json);

  final String value;

  Map<String, Object?> toJson() => _$NestedToJson(this);
}

@JsonSerializable(
  createPerFieldToJson: true,
  genericArgumentFactories: true,
)
class GenericFactory<T> {
  GenericFactory(
    this.value,
    this.map,
  );

  factory GenericFactory.fromJson(
    Map<String, Object?> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$GenericFactoryFromJson(json, fromJsonT);

  final T value;
  final Map<String, T> map;

  Map<String, Object?> toJson(Object? Function(T value) toJsonT) =>
      _$GenericFactoryToJson(this, toJsonT);
}

typedef GenericFactoryPerFieldToJson = _$GenericFactoryPerFieldToJson;

@JsonSerializable(
  createPerFieldToJson: true,
  fieldRename: FieldRename.kebab,
  createFactory: false,
)
class _PrivateModel {
  _PrivateModel(this.fullName);

  final String fullName;

  Map<String, Object?> toJson() => _$PrivateModelToJson(this);
}

typedef PrivatePerFieldToJson = _$PrivateModelPerFieldToJson;
