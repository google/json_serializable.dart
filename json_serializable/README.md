[![Build Status](https://travis-ci.org/dart-lang/json_serializable.svg?branch=master)](https://travis-ci.org/dart-lang/json_serializable)

Provides [source_gen] `Generator`s to create code for JSON serialization and
deserialization.

See the [example] to understand how to configure your project for the latest
released version of `json_serializable`.

## User defined and generated code

Given a library `example.dart` with an `Person` class annotated with
`@JsonSerializable()`:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable()
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

Person _$PersonFromJson(Map<String, dynamic> json) => new Person(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    dateOfBirth: json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String));

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get lastName;
  DateTime get dateOfBirth;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth?.toIso8601String()
      };
}
```

[example]: https://github.com/dart-lang/json_serializable/blob/master/example
[source_gen]: https://pub.dartlang.org/packages/source_gen
