import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../test_utils.dart';

part 'sealed_class_examples.g.dart';

@JsonSerializable()
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Car &&
          runtimeType == other.runtimeType &&
          numberOfDoors == other.numberOfDoors &&
          vehicleID == other.vehicleID;

  @override
  int get hashCode => jsonEncode(this).hashCode;
}

@JsonSerializable()
class Bicycle extends Vehicle {
  final bool hasBell;

  Bicycle({required this.hasBell, required super.vehicleID});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bicycle &&
          runtimeType == other.runtimeType &&
          hasBell == other.hasBell &&
          vehicleID == other.vehicleID;

  @override
  int get hashCode => jsonEncode(this).hashCode;
}

@JsonSerializable(
  unionDiscriminator: 'delivery_type',
  unionRename: FieldRename.snake,
)
sealed class Delivery {
  final int deliveryID;

  Delivery({required this.deliveryID});

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryToJson(this);
}

@JsonSerializable()
class DroneDelivery extends Delivery {
  final int droneModel;

  DroneDelivery({required this.droneModel, required super.deliveryID});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DroneDelivery &&
          runtimeType == other.runtimeType &&
          droneModel == other.droneModel &&
          deliveryID == other.deliveryID;

  @override
  int get hashCode => jsonEncode(this).hashCode;
}

@JsonSerializable()
class TruckDelivery extends Delivery {
  final double weightCapacity;

  TruckDelivery({required this.weightCapacity, required super.deliveryID});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TruckDelivery &&
          runtimeType == other.runtimeType &&
          weightCapacity == other.weightCapacity &&
          deliveryID == other.deliveryID;

  @override
  int get hashCode => jsonEncode(this).hashCode;
}

@JsonSerializable(unionDiscriminator: 'organization')
sealed class Organization {
  final String name;

  Organization({required this.name});

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable(unionDiscriminator: 'department')
sealed class Department extends Organization {
  final String departmentHead;

  Department({required this.departmentHead, required super.name});

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
}

@JsonSerializable()
class Team extends Department {
  final String teamLead;

  Team({
    required this.teamLead,
    required super.departmentHead,
    required super.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team &&
          runtimeType == other.runtimeType &&
          teamLead == other.teamLead &&
          departmentHead == other.departmentHead &&
          name == other.name;

  @override
  int get hashCode => jsonEncode(this).hashCode;
}

@JsonSerializable()
sealed class Transportable {
  const Transportable();

  factory Transportable.fromJson(Map<String, dynamic> json) =>
      _$TransportableFromJson(json);

  Map<String, dynamic> toJson();
}

@JsonSerializable()
sealed class Trackable {
  const Trackable();

  factory Trackable.fromJson(Map<String, dynamic> json) =>
      _$TrackableFromJson(json);

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class Ship implements Transportable {
  final double cargoCapacity;

  Ship({required this.cargoCapacity});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ship &&
          runtimeType == other.runtimeType &&
          cargoCapacity == other.cargoCapacity;

  @override
  int get hashCode => jsonEncode(this).hashCode;

  @override
  Map<String, dynamic> toJson() => _$TransportableToJson(this);
}

@JsonSerializable()
class GPSDevice implements Trackable {
  final String serialNumber;

  GPSDevice({required this.serialNumber});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GPSDevice &&
          runtimeType == other.runtimeType &&
          serialNumber == other.serialNumber;

  @override
  int get hashCode => jsonEncode(this).hashCode;

  @override
  Map<String, dynamic> toJson() => _$TrackableToJson(this);
}

@JsonSerializable()
class Package implements Transportable, Trackable {
  final String label;
  final double weight;

  Package({required this.label, required this.weight});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Package &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          weight == other.weight;

  @override
  int get hashCode => jsonEncode(this).hashCode;

  @override
  Map<String, dynamic> toJson() => _$TrackableToJson(this);
}

@JsonSerializable()
sealed class Container {
  final String containerID;
  final List<StorageItem> items;

  Container({required this.containerID, this.items = const []});

  factory Container.fromJson(Map<String, dynamic> json) =>
      _$ContainerFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerToJson(this);
}

@JsonSerializable()
sealed class StorageItem {
  final String itemID;
  final Container? nestedContainer;

  StorageItem({required this.itemID, this.nestedContainer});

  factory StorageItem.fromJson(Map<String, dynamic> json) =>
      _$StorageItemFromJson(json);

  Map<String, dynamic> toJson() => _$StorageItemToJson(this);
}

@JsonSerializable()
class Box extends Container {
  Box({required super.containerID, super.items});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Box &&
          runtimeType == other.runtimeType &&
          containerID == other.containerID &&
          deepEquals(items, other.items);

  @override
  int get hashCode => jsonEncode(this).hashCode;
}

@JsonSerializable()
class Parcel extends Container {
  Parcel({required super.containerID, super.items});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Parcel &&
          runtimeType == other.runtimeType &&
          containerID == other.containerID &&
          deepEquals(items, items);

  @override
  int get hashCode => jsonEncode(this).hashCode;
}

@JsonSerializable()
class Product extends StorageItem {
  final String name;

  Product({required this.name, required super.itemID, super.nestedContainer});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          itemID == other.itemID &&
          nestedContainer == other.nestedContainer;

  @override
  int get hashCode => jsonEncode(this).hashCode;
}

@JsonSerializable()
class Equipment extends StorageItem {
  final String label;

  Equipment({
    required this.label,
    required super.itemID,
    super.nestedContainer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Equipment &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          itemID == other.itemID &&
          nestedContainer == other.nestedContainer;

  @override
  int get hashCode => jsonEncode(this).hashCode;
}
