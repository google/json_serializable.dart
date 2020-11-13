## Should we treat the default value in the ctor as a default value JSON key?

```dart
@JsonSerializable()
class Experiment {
  @JsonKey(defaultValue: 0)
  int bob;

  Experiment({this.bob = 0});
}

Experiment _$ExperimentFromJson(Map<String, dynamic> json) {
  return Experiment(
    bob: json['bob'] as int? ?? 0,
  );
}
```

## warning that disallowNullValue: true is pointless ?

```dart
@JsonSerializable()
class Experiment {
  @JsonKey(disallowNullValue: true)
  final int bob;

  Experiment(this.bob);
}
```
