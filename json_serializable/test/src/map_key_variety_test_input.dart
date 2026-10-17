// @dart=3.8

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
MapKeyVariety _$MapKeyVarietyFromJson(Map<String, dynamic> json) =>
    MapKeyVariety()
      ..intIntMap = (json['intIntMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
      )
      ..dateTimeIntMap = (json['dateTimeIntMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k), (e as num).toInt()),
      )
      ..bigIntIntMap = (json['bigIntIntMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(BigInt.parse(k), (e as num).toInt()),
      )
      ..uriIntMap = (json['uriIntMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(Uri.parse(k), (e as num).toInt()),
      );

Map<String, dynamic> _$MapKeyVarietyToJson(MapKeyVariety instance) =>
    <String, dynamic>{
      'intIntMap': instance.intIntMap.map((k, e) => MapEntry(k.toString(), e)),
      'dateTimeIntMap': instance.dateTimeIntMap.map(
        (k, e) => MapEntry(k.toIso8601String(), e),
      ),
      'bigIntIntMap': instance.bigIntIntMap.map(
        (k, e) => MapEntry(k.toString(), e),
      ),
      'uriIntMap': instance.uriIntMap.map((k, e) => MapEntry(k.toString(), e)),
    };
''')
@JsonSerializable()
class MapKeyVariety {
  late Map<int, int> intIntMap;
  late Map<DateTime, int> dateTimeIntMap;
  late Map<BigInt, int> bigIntIntMap;
  late Map<Uri, int> uriIntMap;
}

@ShouldThrow(r'''
Could not generate `fromJson` code for `value` because of type `Object?`.
Map keys must be one of: Object, dynamic, enum, String, BigInt, DateTime, int, Uri.''')
@JsonSerializable()
class MapKeyNoNullableObject {
  late Map<Object?, int> value;
}

@ShouldThrow(r'''
Could not generate `fromJson` code for `value` because of type `String?`.
Map keys must be one of: Object, dynamic, enum, String, BigInt, DateTime, int, Uri.''')
@JsonSerializable()
class MapKeyNoNullableString {
  late Map<String?, int> value;
}

@ShouldThrow(r'''
Could not generate `fromJson` code for `value` because of type `int?`.
Map keys must be one of: Object, dynamic, enum, String, BigInt, DateTime, int, Uri.''')
@JsonSerializable()
class MapKeyNoNullableInt {
  late Map<int?, int> value;
}
