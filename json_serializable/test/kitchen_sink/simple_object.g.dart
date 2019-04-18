// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleObject _$SimpleObjectFromJson(Map json) {
  return SimpleObject(int.parse(json['value'].toString()));
}

abstract class _$SimpleObjectSerializerMixin {
  int get value;
  Map<String, dynamic> toJson() => <String, dynamic>{'value': value};
}
