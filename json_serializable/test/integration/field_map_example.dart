import 'package:json_annotation/json_annotation.dart';

part 'field_map_example.g.dart';

@JsonSerializable(createFieldMap: true, fieldRename: FieldRename.kebab)
class Model {
  Model({
    required this.firstName,
    required this.lastName,
    this.ignoredName,
  });

  factory Model.fromJson(Map<String, Object?> json) => _$ModelFromJson(json);

  final String firstName;

  @JsonKey(name: 'LAST_NAME')
  final String lastName;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? ignoredName;

  String get fullName => '$firstName $lastName';

  Map<String, Object?> toJson() => _$ModelToJson(this);
}

const modelFieldMap = _$ModelFieldMap;

@JsonSerializable(
  createFieldMap: true,
  fieldRename: FieldRename.kebab,
  createFactory: false,
)
class _PrivateModel {
  _PrivateModel(this.fullName);

  final String fullName;

  Map<String, Object?> toJson() => _$PrivateModelToJson(this);
}

const privateModelFieldMap = _$PrivateModelFieldMap;
