// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'sealed_class_examples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => switch (json['type']) {
  'Car' => _$CarFromJson(json),
  'Bicycle' => _$BicycleFromJson(json),
  _ => throw UnrecognizedUnionTypeException('${json['type']}', Vehicle, json),
};

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => switch (instance) {
  final Car instance => {'type': 'Car', ..._$CarToJson(instance)},
  final Bicycle instance => {'type': 'Bicycle', ..._$BicycleToJson(instance)},
};

Car _$CarFromJson(Map<String, dynamic> json) => Car(
  numberOfDoors: (json['numberOfDoors'] as num).toInt(),
  vehicleID: json['vehicleID'] as String,
);

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
  'vehicleID': instance.vehicleID,
  'numberOfDoors': instance.numberOfDoors,
};

Bicycle _$BicycleFromJson(Map<String, dynamic> json) => Bicycle(
  hasBell: json['hasBell'] as bool,
  vehicleID: json['vehicleID'] as String,
);

Map<String, dynamic> _$BicycleToJson(Bicycle instance) => <String, dynamic>{
  'vehicleID': instance.vehicleID,
  'hasBell': instance.hasBell,
};

Delivery _$DeliveryFromJson(Map<String, dynamic> json) =>
    switch (json['delivery_type']) {
      'drone_delivery' => _$DroneDeliveryFromJson(json),
      'truck_delivery' => _$TruckDeliveryFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['delivery_type']}',
        Delivery,
        json,
      ),
    };

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => switch (instance) {
  final DroneDelivery instance => {
    'delivery_type': 'drone_delivery',
    ..._$DroneDeliveryToJson(instance),
  },
  final TruckDelivery instance => {
    'delivery_type': 'truck_delivery',
    ..._$TruckDeliveryToJson(instance),
  },
};

DroneDelivery _$DroneDeliveryFromJson(Map<String, dynamic> json) =>
    DroneDelivery(
      droneModel: (json['droneModel'] as num).toInt(),
      deliveryID: (json['deliveryID'] as num).toInt(),
    );

Map<String, dynamic> _$DroneDeliveryToJson(DroneDelivery instance) =>
    <String, dynamic>{
      'deliveryID': instance.deliveryID,
      'droneModel': instance.droneModel,
    };

TruckDelivery _$TruckDeliveryFromJson(Map<String, dynamic> json) =>
    TruckDelivery(
      weightCapacity: (json['weightCapacity'] as num).toDouble(),
      deliveryID: (json['deliveryID'] as num).toInt(),
    );

Map<String, dynamic> _$TruckDeliveryToJson(TruckDelivery instance) =>
    <String, dynamic>{
      'deliveryID': instance.deliveryID,
      'weightCapacity': instance.weightCapacity,
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) =>
    switch (json['organization']) {
      'Department' => _$DepartmentFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['organization']}',
        Organization,
        json,
      ),
    };

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    switch (instance) {
      final Department instance => {
        'organization': 'Department',
        ..._$DepartmentToJson(instance),
      },
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) =>
    switch (json['department']) {
      'Team' => _$TeamFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['department']}',
        Department,
        json,
      ),
    };

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    switch (instance) {
      final Team instance => {'department': 'Team', ..._$TeamToJson(instance)},
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
  teamLead: json['teamLead'] as String,
  departmentHead: json['departmentHead'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
  'name': instance.name,
  'departmentHead': instance.departmentHead,
  'teamLead': instance.teamLead,
};

Transportable _$TransportableFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      'Ship' => _$ShipFromJson(json),
      'Package' => _$PackageFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['type']}',
        Transportable,
        json,
      ),
    };

Map<String, dynamic> _$TransportableToJson(Transportable instance) =>
    switch (instance) {
      final Ship instance => {'type': 'Ship', ..._$ShipToJson(instance)},
      final Package instance => {
        'type': 'Package',
        ..._$PackageToJson(instance),
      },
    };

Trackable _$TrackableFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      'GPSDevice' => _$GPSDeviceFromJson(json),
      'Package' => _$PackageFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['type']}',
        Trackable,
        json,
      ),
    };

Map<String, dynamic> _$TrackableToJson(Trackable instance) =>
    switch (instance) {
      final GPSDevice instance => {
        'type': 'GPSDevice',
        ..._$GPSDeviceToJson(instance),
      },
      final Package instance => {
        'type': 'Package',
        ..._$PackageToJson(instance),
      },
    };

Ship _$ShipFromJson(Map<String, dynamic> json) =>
    Ship(cargoCapacity: (json['cargoCapacity'] as num).toDouble());

Map<String, dynamic> _$ShipToJson(Ship instance) => <String, dynamic>{
  'cargoCapacity': instance.cargoCapacity,
};

GPSDevice _$GPSDeviceFromJson(Map<String, dynamic> json) =>
    GPSDevice(serialNumber: json['serialNumber'] as String);

Map<String, dynamic> _$GPSDeviceToJson(GPSDevice instance) => <String, dynamic>{
  'serialNumber': instance.serialNumber,
};

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
  label: json['label'] as String,
  weight: (json['weight'] as num).toDouble(),
);

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
  'label': instance.label,
  'weight': instance.weight,
};

Container _$ContainerFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      'Box' => _$BoxFromJson(json),
      'Parcel' => _$ParcelFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['type']}',
        Container,
        json,
      ),
    };

Map<String, dynamic> _$ContainerToJson(Container instance) =>
    switch (instance) {
      final Box instance => {'type': 'Box', ..._$BoxToJson(instance)},
      final Parcel instance => {'type': 'Parcel', ..._$ParcelToJson(instance)},
    };

StorageItem _$StorageItemFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      'Product' => _$ProductFromJson(json),
      'Equipment' => _$EquipmentFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['type']}',
        StorageItem,
        json,
      ),
    };

Map<String, dynamic> _$StorageItemToJson(StorageItem instance) =>
    switch (instance) {
      final Product instance => {
        'type': 'Product',
        ..._$ProductToJson(instance),
      },
      final Equipment instance => {
        'type': 'Equipment',
        ..._$EquipmentToJson(instance),
      },
    };

Box _$BoxFromJson(Map<String, dynamic> json) => Box(
  containerID: json['containerID'] as String,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => StorageItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$BoxToJson(Box instance) => <String, dynamic>{
  'containerID': instance.containerID,
  'items': instance.items,
};

Parcel _$ParcelFromJson(Map<String, dynamic> json) => Parcel(
  containerID: json['containerID'] as String,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => StorageItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ParcelToJson(Parcel instance) => <String, dynamic>{
  'containerID': instance.containerID,
  'items': instance.items,
};

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  name: json['name'] as String,
  itemID: json['itemID'] as String,
  nestedContainer: json['nestedContainer'] == null
      ? null
      : Container.fromJson(json['nestedContainer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'itemID': instance.itemID,
  'nestedContainer': instance.nestedContainer,
  'name': instance.name,
};

Equipment _$EquipmentFromJson(Map<String, dynamic> json) => Equipment(
  label: json['label'] as String,
  itemID: json['itemID'] as String,
  nestedContainer: json['nestedContainer'] == null
      ? null
      : Container.fromJson(json['nestedContainer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
  'itemID': instance.itemID,
  'nestedContainer': instance.nestedContainer,
  'label': instance.label,
};
