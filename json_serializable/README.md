[![Build Status](https://travis-ci.org/dart-lang/json_serializable.svg?branch=master)](https://travis-ci.org/dart-lang/json_serializable)

Provides [Dart Build System] builders for handling JSON.

The builders generate code when they find members annotated with classes defined
in [package:json_annotation].

- To generate to/from JSON code for a class, annotate it with
  `JsonSerializable`. You can provide arguments to `JsonSerializable` to
  configure the generated code. You can also customize individual fields
  by annotating them with `JsonKey` and providing custom arguments.

- To generate a Dart field with the contents of a file containting JSON, use the
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
class Person extends Object with _$PersonSerializerMixin {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  Person({this.firstName, this.lastName, this.dateOfBirth});
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
```

Building creates the corresponding part `example.g.dart`:

```dart
part of 'example.dart';

Person _$PersonFromJson(Map<String, dynamic> json) {
  return new Person(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String));
}

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get lastName;
  DateTime get dateOfBirth;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth.toIso8601String()
      };
}
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
          # Specifies a string to add to the top of every generated file.
          #
          # If not specified, the default is the value of `defaultFileHeader`
          # defined in `package:source_gen/source_gen.dart`.
          #
          # Note: use `|` to define a multi-line block.
          header: |
           // Copyright (c) 2018, the Dart project authors.

           // GENERATED CODE - DO NOT MODIFY BY HAND

          # Options configure how source code is generated for every
          # `@JsonSerializable`-annotated class in the package.
          #
          # The default value for each of them: `false`.
          #
          # For usage information, reference the corresponding field in
          # `JsonSerializableGenerator`.
          use_wrappers: true
          any_map: true
          checked: true
          explicit_to_json: true
```

[example]: https://github.com/dart-lang/json_serializable/blob/master/example
[Dart Build System]: https://github.com/dart-lang/build
[package:json_annotation]: https://pub.dartlang.org/packages/json_annotation
