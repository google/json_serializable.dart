import 'package:json_annotation/json_annotation.dart';

part 'sealed_class_example.g.dart';

@JsonSerializable(
  unionDiscriminator: 'runtimeType',
  unionRename: UnionRename.snake,
)
sealed class MySealedClass {
  MySealedClass(this.value);

  factory MySealedClass.fromJson(Map<String, dynamic> json) =>
      _$MySealedClassFromJson(json);

  String value;

  Map<String, dynamic> toJson() => _$MySealedClassToJson(this);
}

@JsonSerializable()
class FirstSubtype extends MySealedClass {
  final String someAttribute;

  FirstSubtype(
    this.someAttribute,
    super.value,
  );
}

@JsonSerializable()
class SecondSubtype extends MySealedClass {
  final String someOtherAttribute;

  SecondSubtype(
    this.someOtherAttribute,
    super.value,
  );
}
