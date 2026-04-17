import 'package:json_annotation/json_annotation.dart';

part 'sealed_class_example.g.dart';

@JsonSerializable(
  unionDiscriminator: 'vehicle_type',
  unionRename: FieldRename.snake,
)
sealed class Vehicle {
  final String vehicleID;

  Vehicle({required this.vehicleID});

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}

@JsonSerializable()
class Car extends Vehicle {
  final int numberOfDoors;

  Car({required this.numberOfDoors, required super.vehicleID});
}

@JsonSerializable()
class Bicycle extends Vehicle {
  final bool hasBell;

  Bicycle({required this.hasBell, required super.vehicleID});
}
