import 'package:json_annotation/json_annotation.dart';

part 'complex_sealed_class_examples.g.dart';

@JsonSerializable(
  unionDiscriminator: 'base_base_base_type',
)
sealed class BaseBaseBaseType {
  BaseBaseBaseType();

  factory BaseBaseBaseType.fromJson(Map<String, dynamic> json) =>
      _$BaseBaseBaseTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BaseBaseBaseTypeToJson(this);
}

@JsonSerializable(
  unionDiscriminator: 'base_base_type',
)
sealed class BaseBase extends BaseBaseBaseType {
  BaseBase();
}

@JsonSerializable(
  unionDiscriminator: 'base_type',
)
sealed class Base extends BaseBase {
  Base();
}

@JsonSerializable()
class FirstBaseImpl extends Base {
  FirstBaseImpl(this.value);

  String value;
}

@JsonSerializable()
class SecondBaseImpl extends Base {
  SecondBaseImpl(this.value);

  String value;
}

@JsonSerializable()
class BaseBaseImpl extends BaseBase {
  BaseBaseImpl(this.value);

  String value;
}

@JsonSerializable(
  createToJson: false,
)
sealed class SecondBase {
  SecondBase();

  factory SecondBase.fromJson(Map<String, dynamic> json) =>
      _$SecondBaseFromJson(json);
}

@JsonSerializable(
  createToJson: false,
)
sealed class ThirdBase {
  ThirdBase();

  factory ThirdBase.fromJson(Map<String, dynamic> json) =>
      _$ThirdBaseFromJson(json);
}

@JsonSerializable(
  createToJson: false,
)
class ImplAll implements SecondBase, ThirdBase {
  ImplAll(this.value);

  String value;
}
