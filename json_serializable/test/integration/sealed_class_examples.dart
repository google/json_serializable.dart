import 'package:json_annotation/json_annotation.dart';

part 'sealed_class_examples.g.dart';

@JsonSerializable()
sealed class SimpleSealedBase {
  final String commonField;

  SimpleSealedBase({required this.commonField});

  factory SimpleSealedBase.fromJson(Map<String, dynamic> json) =>
      _$SimpleSealedBaseFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleSealedBaseToJson(this);
}

@JsonSerializable()
class SimpleSealedImplOne extends SimpleSealedBase {
  final String testFieldOne;

  SimpleSealedImplOne({
    required this.testFieldOne,
    required super.commonField,
  });

  @override
  bool operator ==(Object other) =>
      other is SimpleSealedImplOne &&
      testFieldOne == other.testFieldOne &&
      commonField == other.commonField;

  @override
  int get hashCode => identityHashCode(this);
}

@JsonSerializable()
class SimpleSealedImplTwo extends SimpleSealedBase {
  final String testFieldTwo;

  SimpleSealedImplTwo({
    required this.testFieldTwo,
    required super.commonField,
  });

  @override
  bool operator ==(Object other) =>
      other is SimpleSealedImplTwo &&
      testFieldTwo == other.testFieldTwo &&
      commonField == other.commonField;

  @override
  int get hashCode => identityHashCode(this);
}

@JsonSerializable(
  unionDiscriminator: 'custom_discriminator',
  unionRename: UnionRename.snake,
)
sealed class SealedWithDiscriminatorAndRenameBase {
  final int common;

  SealedWithDiscriminatorAndRenameBase(this.common);

  factory SealedWithDiscriminatorAndRenameBase.fromJson(
          Map<String, dynamic> json) =>
      _$SealedWithDiscriminatorAndRenameBaseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SealedWithDiscriminatorAndRenameBaseToJson(this);
}

@JsonSerializable()
class SealedWithDiscriminatorAndRenameImplOne
    extends SealedWithDiscriminatorAndRenameBase {
  final int testOne;

  SealedWithDiscriminatorAndRenameImplOne(
    this.testOne,
    super.common,
  );

  @override
  bool operator ==(Object other) =>
      other is SealedWithDiscriminatorAndRenameImplOne &&
      testOne == other.testOne &&
      common == other.common;

  @override
  int get hashCode => identityHashCode(this);
}

@JsonSerializable()
class SealedWithDiscriminatorAndRenameImplTwo
    extends SealedWithDiscriminatorAndRenameBase {
  final int testTwo;

  SealedWithDiscriminatorAndRenameImplTwo(
    this.testTwo,
    super.common,
  );

  @override
  bool operator ==(Object other) =>
      other is SealedWithDiscriminatorAndRenameImplTwo &&
      testTwo == other.testTwo &&
      common == other.common;

  @override
  int get hashCode => identityHashCode(this);
}

// TODO(@O-Hannonen): Add more examples for round trip cases, add at least:
// - Nested sealed classes
// - Sealed classes with itself as instance field (nullable?)
// - Subclasses that implement multiple sealed classes
