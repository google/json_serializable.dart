import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable(anyMap: true, checked: true, createToJson: false)
class Configuration {
  final String name;
  final int count;

  Configuration({this.name, this.count});

  factory Configuration.fromJson(Map json) => _$ConfigurationFromJson(json);
}
