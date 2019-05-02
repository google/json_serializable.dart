[![Pub Package](https://img.shields.io/pub/v/yaml_decode.svg)](https://pub.dartlang.org/packages/yaml_decode)

`package:yaml_decode` provides a `toParsedYamlException` function to create a
`ParsedYamlException` that contains source and error information that helps
provide actionable errors when decoding invalid YAML. 

You can use [`package:json_serializable`] generate classes that can parse the
[`YamlMap`] type provided by [`package:yaml`].

```dart
@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  nullable: false,
)
class Configuration {
  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true)
  final int count;

  Configuration({this.name, this.count}) {
    if (name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Cannot be empty.');
    }
  }

  factory Configuration.fromJson(Map json) => _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

  @override
  String toString() => 'Configuration: ${toJson()}';
}
```

The generated code for this class with throw `CheckedFromJsonException` if the
source value provided to `Configuration.fromJson(Map json)` is invalid.

```dart
void main(List<String> arguments) {
  final fileContents = File(arguments.single).readAsStringSync();

  final yamlMap =
      loadYaml(fileContents, sourceUrl: arguments.single) as YamlMap;

  try {
    final config = Configuration.fromJson(yamlMap);
    print(config);
  } on CheckedFromJsonException catch (e) {
    throw toParsedYamlException(e);
  }
}
```

When parsing an invalid YAML file, an actional error message is produced.

```console
$ dart example/example.dart no_count.yaml
Unhandled exception:
ParsedYamlException: line 1, column 1 of no_count.yaml: Required keys are missing: count.
  ╷
1 │ name: bob
  │ ^^^^^^^^^
  ╵
```

[`package:json_serializable`]: https://pub.dartlang.org/packages/json_serializable
[`package:yaml`]: https://pub.dartlang.org/packages/yaml
[`YamlMap`]: https://pub.dartlang.org/documentation/yaml/latest/yaml/YamlMap-class.html
