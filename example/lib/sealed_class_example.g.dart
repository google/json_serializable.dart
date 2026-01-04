// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_class_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) =>
    switch (json['vehicle_type']) {
      'car' => _$CarFromJson(json),
      'bicycle' => _$BicycleFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['vehicle_type']}',
        Vehicle,
        json,
      ),
    };

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => switch (instance) {
  final Car instance => {'vehicle_type': 'car', ..._$CarToJson(instance)},
  final Bicycle instance => {
    'vehicle_type': 'bicycle',
    ..._$BicycleToJson(instance),
  },
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
