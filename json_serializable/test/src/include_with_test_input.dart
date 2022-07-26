// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
IncludeWithToJson<T, S> _$IncludeWithToJsonFromJson<T extends num, S>(
        Map<String, dynamic> json) =>
    IncludeWithToJson<T, S>()..someString = json['someString'] as String;

Map<String, dynamic> _$IncludeWithToJsonToJson<T extends num, S>(
        IncludeWithToJson<T, S> instance) =>
    <String, dynamic>{
      'someString': instance.someString,
      'getterIncluded': instance.getterIncluded,
      'finalFieldIncluded': instance.finalFieldIncluded,
    };
''')
@JsonSerializable()
class IncludeWithToJson<T extends num, S> {
  late String someString;

  String get getterExcluded => someString.toLowerCase();

  @JsonKey(includeWith: IncludeWith.toJson)
  String get getterIncluded => someString.toLowerCase();

  final finalFieldExcluded = 'finalFieldExcluded';

  @JsonKey(includeWith: IncludeWith.toJson)
  final finalFieldIncluded = 'finalFieldIncluded';

  IncludeWithToJson();
}

@ShouldGenerate(r'''
Map<String, dynamic> _$IncludeWithToJsonNoFactoryToJson<T extends num, S>(
        IncludeWithToJsonNoFactory<T, S> instance) =>
    <String, dynamic>{
      'someString': instance.someString,
      'getterIncludeWithNull': instance.getterIncludeWithNull,
      'getterIncludeWithToJson': instance.getterIncludeWithToJson,
      'getterIncludeWithBoth': instance.getterIncludeWithBoth,
    };
''')
@JsonSerializable(createFactory: false)
class IncludeWithToJsonNoFactory<T extends num, S> {
  late String someString;

  String get getterIncludeWithNull => someString.toLowerCase();

  @JsonKey(includeWith: IncludeWith.ignore)
  String get getterIncludeWithIgnore => someString.toLowerCase();

  @JsonKey(includeWith: IncludeWith.toJson)
  String get getterIncludeWithToJson => someString.toLowerCase();

  @JsonKey(includeWith: IncludeWith.fromJson)
  String get getterIncludeWithFromJson => someString.toLowerCase();

  @JsonKey(includeWith: IncludeWith.both)
  String get getterIncludeWithBoth => someString.toLowerCase();

  IncludeWithToJsonNoFactory();
}

@ShouldGenerate(r'''
IncludeWithFromJson<T, S> _$IncludeWithFromJsonFromJson<T extends num, S>(
        Map<String, dynamic> json) =>
    IncludeWithFromJson<T, S>()
      ..someString = json['someString'] as String
      ..setter = json['setter'] as String;

Map<String, dynamic> _$IncludeWithFromJsonToJson<T extends num, S>(
        IncludeWithFromJson<T, S> instance) =>
    <String, dynamic>{};
''')
@JsonSerializable()
class IncludeWithFromJson<T extends num, S> {
  @JsonKey(includeWith: IncludeWith.fromJson)
  late String someString;

  @JsonKey(includeWith: IncludeWith.fromJson)
  String get setter => someString;

  set setter(String value) => someString = value;

  IncludeWithFromJson();
}
