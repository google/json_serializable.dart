[![Build Status](https://travis-ci.org/dart-lang/json_serializable.svg?branch=master)](https://travis-ci.org/dart-lang/json_serializable)

Provides `source_gen` `Generator`s which generate code to
make it simple to serialize to and from JSON.

## Example

Given a library `example.dart` with an `Person` class annotated with
`@JsonSerializable()`:

```dart
library json_serializable.example;

import 'package:json_annotation/json_annotation.dart';
part 'example.g.dart';

@JsonSerializable()
class Person extends Object with _$PersonSerializerMixin {
  final String firstName;
  @JsonKey(includeIfNull: false)
  final String middleName;
  final String lastName;

  @JsonKey(name: 'date-of-birth', nullable: false)
  final DateTime dateOfBirth;

  @JsonKey(name: 'last-order')
  final DateTime lastOrder;

  @JsonKey(nullable: false)
  List<Order> orders;

  Person(this.firstName, this.lastName, this.dateOfBirth,
      {this.middleName, this.lastOrder, List<Order> orders})
      : this.orders = orders ?? <Order>[];

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
```

`source_gen` creates the corresponding part `example.g.dart`:

```dart
Person _$PersonFromJson(Map<String, dynamic> json) => new Person(
    json['firstName'] as String,
    json['lastName'] as String,
    DateTime.parse(json['date-of-birth'] as String),
    middleName: json['middleName'] as String,
    lastOrder: json['last-order'] == null
        ? null
        : DateTime.parse(json['last-order'] as String),
    orders: (json['orders'] as List)
        .map((e) => new Order.fromJson(e as Map<String, dynamic>))
        .toList());

abstract class _$PersonSerializerMixin {
  String get firstName;
  String get middleName;
  String get lastName;
  DateTime get dateOfBirth;
  DateTime get lastOrder;
  List<Order> get orders;
  Map<String, dynamic> toJson() {
    var $map = <String, dynamic>{};
    void $writeNotNull(String key, dynamic value) {
      if (value != null) {
        $map[key] = value;
      }
    }

    $map['firstName'] = firstName;
    $writeNotNull('middleName', middleName);
    $map['lastName'] = lastName;
    $map['date-of-birth'] = dateOfBirth.toIso8601String();
    $map['last-order'] = lastOrder?.toIso8601String();
    $map['orders'] = orders;
    return $map;
  }
}
```
