import 'package:json_annotation/json_annotation.dart';

part 'json_meta_example.g.dart';

@JsonSerializable(createJsonMeta: true, fieldRename: FieldRename.kebab)
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

  @JsonKey(ignore: true)
  final String? ignoredName;

  String get fullName => '$firstName $lastName';

  Map<String, Object?> toJson() => _$ModelToJson(this);
}

const modelMeta = _$ModelJsonMeta;
