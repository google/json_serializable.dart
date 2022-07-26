// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
UnusedFieldsClass<T, S> _$UnusedFieldsClassFromJson<T extends num, S>(
        Map<String, dynamic> json) =>
    UnusedFieldsClass<T, S>()..someString = json['someString'] as String;

Map<String, dynamic> _$UnusedFieldsClassToJson<T extends num, S>(
        UnusedFieldsClass<T, S> instance) =>
    <String, dynamic>{
      'someString': instance.someString,
      'getterIncluded': instance.getterIncluded,
      'finalFieldIncluded': instance.finalFieldIncluded,
    };
''')
@JsonSerializable()
class UnusedFieldsClass<T extends num, S> {
  late String someString;

  String get getterExcluded => someString.toLowerCase();

  @JsonKey(includeWith: IncludeWith.toJson)
  String get getterIncluded => someString.toLowerCase();

  final finalFieldExcluded = 'finalFieldExcluded';

  @JsonKey(includeWith: IncludeWith.toJson)
  final finalFieldIncluded = 'finalFieldIncluded';

  UnusedFieldsClass();
}
