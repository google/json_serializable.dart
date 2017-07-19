[![Build Status](https://travis-ci.org/dart-lang/json_serializable.svg?branch=master)](https://travis-ci.org/dart-lang/json_serializable)

Provides `source_gen` `Generator`s which generate code to
make it simple to serialize to and from JSON.

## Example

Given a library `example.dart` with an `Person` class annotated with
`@JsonSerializable`:

```dart
library source_gen.example;

import 'package:source_gen/generators/json_serializable.dart';
part 'example.g.dart';

@JsonSerializable()
class Person extends Object with _$PersonSerializerMixin {
  final String firstName, middleName, lastName;

  @JsonKey('date-of-birth')
  final DateTime dateOfBirth;

  Person(this.firstName, this.lastName, {this.middleName, this.dateOfBirth});

  factory Person.fromJson(json) => _$PersonFromJson(json);
}
```

`source_gen` creates the corresponding part `example.g.dart`:

```dart
part of source_gen.example;

Person _$PersonFromJson(Map json) => new Person(
    json['firstName'], json['lastName'],
    middleName: json['middleName'],
    dateOfBirth: json['date-of-birth'] == null
        ? null
        : DateTime.parse(json['date-of-birth']));

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get middleName;
  String get lastName;
  DateTime get dateOfBirth;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'date-of-birth': dateOfBirth?.toIso8601String(),
      };
}
```
