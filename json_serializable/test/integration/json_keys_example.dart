import 'package:json_annotation/json_annotation.dart';

part 'json_keys_example.g.dart';

@JsonSerializable(createJsonKeys: true, fieldRename: FieldRename.kebab)
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

// TODO: use this once https://github.com/dart-lang/sdk/issues/54543 is fixed
typedef ModelJsonKeys = _$ModelJsonKeys;

// Work-around until https://github.com/dart-lang/sdk/issues/54543 is fixed
Set<String> get keys => {_$ModelJsonKeys.firstName, _$ModelJsonKeys.lastName};
