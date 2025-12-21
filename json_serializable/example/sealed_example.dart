import 'package:json_annotation/json_annotation.dart';

part 'sealed_example.g.dart';

@JsonSerializable()
sealed class SealedBase {
  const SealedBase();

  factory SealedBase.fromJson(Map<String, dynamic> json) =>
      _$SealedBaseFromJson(json);

  Map<String, dynamic> toJson() => _$SealedBaseToJson(this);
}

@JsonSerializable()
class SealedSub1 extends SealedBase {
  final String exampleField1;

  SealedSub1({required this.exampleField1});
}

@JsonSerializable()
class SealedSub2 extends SealedBase {
  final String exampleField2;

  SealedSub2({required this.exampleField2});
}
