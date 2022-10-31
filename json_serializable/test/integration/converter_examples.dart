import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'converter_examples.g.dart';

@JsonEnum(valueField: 'value')
enum Issue1202RegressionEnum {
  normalValue(42),
  nullValue(null);

  const Issue1202RegressionEnum(this.value);

  final int? value;
}

@JsonSerializable(includeIfNull: false)
class Issue1202RegressionClass {
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final int valueWithFunctions;

  @_Issue1202RegressionNotNullConverter()
  final int notNullableValueWithConverter;

  final Issue1202RegressionEnum value;
  final int? normalNullableValue;

  @_Issue1202RegressionConverter()
  final int notNullableValueWithNullableConverter;

  @JsonKey(fromJson: _fromJsonNullable, toJson: _toJsonNullable)
  final int valueWithNullableFunctions;

  Issue1202RegressionClass({
    required this.value,
    required this.normalNullableValue,
    required this.notNullableValueWithNullableConverter,
    required this.notNullableValueWithConverter,
    required this.valueWithFunctions,
    required this.valueWithNullableFunctions,
  });

  factory Issue1202RegressionClass.fromJson(Map<String, dynamic> json) =>
      _$Issue1202RegressionClassFromJson(json);

  Map<String, dynamic> toJson() => _$Issue1202RegressionClassToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Issue1202RegressionClass &&
      jsonEncode(other) == jsonEncode(this);

  @override
  int get hashCode => jsonEncode(this).hashCode;

  static int _fromJsonNullable(String? json) {
    if (json == null) return _default;
    return int.parse(json);
  }

  static String? _toJsonNullable(int object) {
    if (object == _default) return null;
    return object.toString();
  }

  static int _fromJson(String json) => int.parse(json);

  static String _toJson(int object) => object.toString();
}

const _default = 42;

class _Issue1202RegressionConverter extends JsonConverter<int, String?> {
  const _Issue1202RegressionConverter();

  @override
  int fromJson(String? json) {
    if (json == null) return _default;
    return int.parse(json);
  }

  @override
  String? toJson(int object) {
    if (object == _default) return null;
    return object.toString();
  }
}

class _Issue1202RegressionNotNullConverter extends JsonConverter<int, String> {
  const _Issue1202RegressionNotNullConverter();

  @override
  int fromJson(String json) => int.parse(json);

  @override
  String toJson(int object) => object.toString();
}

class DateTimeConverter extends JsonConverter<DateTime, String> {
  const DateTimeConverter();
  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal();
  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}

@JsonSerializable()
@DateTimeConverter()
class Regression1229 {
  @JsonKey(includeIfNull: false)
  final DateTime? date;

  Regression1229({
    this.date,
  });

  factory Regression1229.fromJson(Map<String, dynamic> json) =>
      _$Regression1229FromJson(json);

  Map<String, dynamic> toJson() => _$Regression1229ToJson(this);
}
