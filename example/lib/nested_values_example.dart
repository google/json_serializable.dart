import 'package:json_annotation/json_annotation.dart';

part 'nested_values_example.g.dart';

/// An example work-around for
/// https://github.com/google/json_serializable.dart/issues/490
@JsonSerializable()
class NestedValueExample {
  NestedValueExample(this.nestedValues);

  factory NestedValueExample.fromJson(Map<String, dynamic> json) =>
      _$NestedValueExampleFromJson(json);

  @_NestedListConverter()
  @JsonKey(name: 'root_items')
  final List<String> nestedValues;

  Map<String, dynamic> toJson() => _$NestedValueExampleToJson(this);
}

class _NestedListConverter
    extends JsonConverter<List<String>, Map<String, dynamic>> {
  const _NestedListConverter();

  @override
  List<String> fromJson(Map<String, dynamic> json) => [
        for (var e in json['items'] as List)
          (e as Map<String, dynamic>)['name'] as String
      ];

  @override
  Map<String, dynamic> toJson(List<String> object) => {
        'items': [
          for (var item in object) {'name': item}
        ]
      };
}
