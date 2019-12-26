[![Pub Package](https://img.shields.io/pub/v/json_serializable.svg)](https://pub.dev/packages/json_serializable)

Provides [Dart Build System] builders for handling JSON.

The builders generate code when they find members annotated with classes defined
in [package:json_annotation].

- To generate to/from JSON code for a class, annotate it with
  `@JsonSerializable`. You can provide arguments to `JsonSerializable` to
  configure the generated code. You can also customize individual fields
  by annotating them with `@JsonKey` and providing custom arguments.
  See the table below for details on the
  [annotation values](#annotation-values).

- To generate a Dart field with the contents of a file containing JSON, use the
  `JsonLiteral` annotation.

To configure your project for the latest released version of,
`json_serializable` see the [example].

## Example

Given a library `example.dart` with an `Person` class annotated with
`@JsonSerializable()`:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable(nullable: false)
class Person {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  Person({this.firstName, this.lastName, this.dateOfBirth});
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
```

Building creates the corresponding part `example.g.dart`:

```dart
part of 'example.dart';

Person _$PersonFromJson(Map<String, dynamic> json, {JsonOverrides overrides}) {
  return Person(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
    };
```

# Annotation values

The only annotation required to use this package is `@JsonSerializable`. When
applied to a class (in a correctly configured package), `toJson` and `fromJson`
code will be generated when you build. There are three ways to control how code
is generated:

1. Set properties on `@JsonSerializable`.
2. Add a `@JsonKey` annotation to a field and set properties there.
3. Add configuration to `build.yaml` – [see below](#build-configuration). 

| `build.yaml` key           | JsonSerializable                            | JsonKey                     |
| -------------------------- | ------------------------------------------- | --------------------------- |
| any_map                    | [JsonSerializable.anyMap]                   |                             |
| checked                    | [JsonSerializable.checked]                  |                             |
| create_factory             | [JsonSerializable.createFactory]            |                             |
| create_to_json             | [JsonSerializable.createToJson]             |                             |
| disallow_unrecognized_keys | [JsonSerializable.disallowUnrecognizedKeys] |                             |
| explicit_to_json           | [JsonSerializable.explicitToJson]           |                             |
| field_rename               | [JsonSerializable.fieldRename]              |                             |
| ignore_unannotated         | [JsonSerializable.ignoreUnannotated]        |                             |
| include_if_null            | [JsonSerializable.includeIfNull]            | [JsonKey.includeIfNull]     |
| nullable                   | [JsonSerializable.nullable]                 | [JsonKey.nullable]          |
|                            |                                             | [JsonKey.defaultValue]      |
|                            |                                             | [JsonKey.disallowNullValue] |
|                            |                                             | [JsonKey.fromJson]          |
|                            |                                             | [JsonKey.ignore]            |
|                            |                                             | [JsonKey.name]              |
|                            |                                             | [JsonKey.required]          |
|                            |                                             | [JsonKey.toJson]            |
|                            |                                             | [JsonKey.unknownEnumValue]  |

[JsonSerializable.anyMap]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/anyMap.html
[JsonSerializable.checked]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/checked.html
[JsonSerializable.createFactory]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/createFactory.html
[JsonSerializable.createToJson]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/createToJson.html
[JsonSerializable.disallowUnrecognizedKeys]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/disallowUnrecognizedKeys.html
[JsonSerializable.explicitToJson]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/explicitToJson.html
[JsonSerializable.fieldRename]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/fieldRename.html
[JsonSerializable.ignoreUnannotated]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/ignoreUnannotated.html
[JsonSerializable.includeIfNull]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/includeIfNull.html
[JsonKey.includeIfNull]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/includeIfNull.html
[JsonSerializable.nullable]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable/nullable.html
[JsonKey.nullable]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/nullable.html
[JsonKey.defaultValue]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/defaultValue.html
[JsonKey.disallowNullValue]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/disallowNullValue.html
[JsonKey.fromJson]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/fromJson.html
[JsonKey.ignore]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/ignore.html
[JsonKey.name]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/name.html
[JsonKey.required]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/required.html
[JsonKey.toJson]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/toJson.html
[JsonKey.unknownEnumValue]: https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/unknownEnumValue.html

> Note: every `JsonSerializable` field is configurable via `build.yaml` –
  see the table for the corresponding key.
  If you find you want all or most of your classes with the same configuration,
  it may be easier to specify values once in the YAML file. Values set
  explicitly on `@JsonSerializable` take precedence over settings in
  `build.yaml`.

> Note: There is some overlap between fields on `JsonKey` and
  `JsonSerializable`. In these cases, if a value is set explicitly via `JsonKey`
  it will take precedence over any value set on `JsonSerializable`.  

# Runtime overrides
There are times when you want to override a serialization setting at runtime.

The `JsonOverrides` class allows you to suppress a range of setting on specific 
classes or globally.

A common use case is to run with a tight set of rules during development
but relax those rules for production.

You can check if you are running in production mode via:
```dart
const bool.fromEnvironment("dart.vm.product");
 ```

You may also have specific classes that need to run with a more relaxed set of rules in some specific circumstances. If your class should ALWAYs run with a relaxed rules, then look to set a property on  `@JsonSerializable`.

`JsonOverrides` supports the following properties:

```dart
  JsonOverride allowedKeys;
  JsonOverride requiredKeys;
  JsonOverride disallowNullValues;
```  

with the following options for each property:

```dart
JsonOverride.none - there is no override, use the generated rule.
JsonOverride.off - suppress the generated rule.
```

## Setting an override
You have two ways of setting overrides.
 > globally

 > per class

 ### Global override
 To set a global override, call:
 
 ```dart
 import 'package:json_annotation/json_annotation.dart';

 JsonOverrides global = JsonOverrides(allowedKeys: JsonOverride.off);

 JsonOverrides.global(global);
 ```
Of course, you would normally make this call before doing any serialization,
but you can set it at any time.

To remove any global overrides call:

```dart
import 'package:json_annotation/json_annotation.dart';

JsonOverrides global = JsonOverrides(
    allowedKeys: JsonOverride.off,
    requiredKeys: JsonOverride.off,
    disallowNullValues: JsonOverride.off
    );

 JsonOverrides.global = global;
```

### Per class overrides
To override settings for a specific class, you need to modify your classes fromJson method.

if you have any class `User` with an existing fromJson

```dart
factory User.fromJson(Map<String, dynamic> json
    ) => _$UserFromJson(json);
```    

you can override one or more options by passing an override:

```dart
import 'package:json_annotation/json_annotation.dart';

JsonOverrides override = JsonOverrides(
    allowedKeys: JsonOverride.off,
    requiredKeys: JsonOverride.off,
    disallowNullValues: JsonOverride.off
    );

factory User.fromJson(Map<String, dynamic> json
    , overrides: override
    ) => _$UserFromJson(json);

```


# Build configuration

Besides setting arguments on the associated annotation classes, you can also
configure code generation by setting values in `build.yaml`.

```yaml
targets:
  $default:
    builders:
      json_serializable:
        options:
          # Options configure how source code is generated for every
          # `@JsonSerializable`-annotated class in the package.
          #
          # The default value for each is listed.
          any_map: false
          checked: false
          create_factory: true
          create_to_json: true
          disallow_unrecognized_keys: false
          explicit_to_json: false
          field_rename: none
          ignore_unannotated: false
          include_if_null: true
          nullable: true
```

[example]: https://github.com/dart-lang/json_serializable/blob/master/example
[Dart Build System]: https://github.com/dart-lang/build
[package:json_annotation]: https://pub.dev/packages/json_annotation
