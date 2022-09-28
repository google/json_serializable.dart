import 'package:json_annotation/json_annotation.dart';

part 'readme_examples.g.dart';

// # simple_example
enum StatusCode {
  @JsonValue(200)
  success,
  @JsonValue(301)
  movedPermanently,
  @JsonValue(302)
  found,
  @JsonValue(500)
  internalServerError,
}

// # enhanced_example
@JsonEnum(valueField: 'code')
enum StatusCodeEnhanced {
  success(200),
  movedPermanently(301),
  found(302),
  internalServerError(500);

  const StatusCodeEnhanced(this.code);
  final int code;
}

// # to_from
@JsonSerializable()
class Sample1 {
  Sample1(this.value);

  factory Sample1.fromJson(Map<String, dynamic> json) =>
      _$Sample1FromJson(json);

  // Sample2 is NOT annotated with @JsonSerializable(), but that's okay
  // The class has a `fromJson` constructor and a `toJson` method, which is
  // all that is required.
  final Sample2 value;

  Map<String, dynamic> toJson() => _$Sample1ToJson(this);
}

class Sample2 {
  Sample2(this.value);

  // The convention is for `fromJson` to take a single parameter of type
  // `Map<String, dynamic>` but any JSON-compatible type is allowed.
  factory Sample2.fromJson(int value) => Sample2(value);
  final int value;

  // The convention is for `toJson` to take return a type of
  // `Map<String, dynamic>` but any JSON-compatible type is allowed.
  int toJson() => value;
}

// # json_key
@JsonSerializable()
class Sample3 {
  Sample3(this.value);

  factory Sample3.fromJson(Map<String, dynamic> json) =>
      _$Sample3FromJson(json);

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final DateTime value;

  Map<String, dynamic> toJson() => _$Sample3ToJson(this);

  static int _toJson(DateTime value) => value.millisecondsSinceEpoch;
  static DateTime _fromJson(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value);
}

// # json_converter
@JsonSerializable()
class Sample4 {
  Sample4(this.value);

  factory Sample4.fromJson(Map<String, dynamic> json) =>
      _$Sample4FromJson(json);

  @EpochDateTimeConverter()
  final DateTime value;

  Map<String, dynamic> toJson() => _$Sample4ToJson(this);
}

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
