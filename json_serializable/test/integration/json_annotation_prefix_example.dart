import 'package:json_annotation/json_annotation.dart' as ja;

part 'json_annotation_prefix_example.g.dart';

@ja.JsonSerializable(checked: true)
class CheckedPrefixModel {
  final String field1;
  final String field2;

  CheckedPrefixModel({required this.field1, required this.field2});

  factory CheckedPrefixModel.fromJson(Map<String, dynamic> json) =>
      _$CheckedPrefixModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckedPrefixModelToJson(this);
}

@ja.JsonSerializable()
class EnumPrefixModel {
  @ja.JsonKey(required: true, disallowNullValue: true)
  final PrefixModelGender gender;

  EnumPrefixModel({required this.gender});

  factory EnumPrefixModel.fromJson(Map<String, dynamic> json) =>
      _$EnumPrefixModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnumPrefixModelToJson(this);
}

enum PrefixModelGender { male, female, other }
