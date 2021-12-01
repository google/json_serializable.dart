// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen_test/annotations.dart';

part 'checked_test_input.dart';
part 'constants_copy.dart';
part 'core_subclass_type_input.dart';
part 'default_value_input.dart';
part 'field_namer_input.dart';
part 'generic_test_input.dart';
part 'inheritance_test_input.dart';
part 'json_converter_test_input.dart';
part 'map_key_variety_test_input.dart';
part 'setter_test_input.dart';
part 'to_from_json_test_input.dart';
part 'unknown_enum_value_test_input.dart';

@ShouldThrow('`@JsonSerializable` can only be used on classes.')
@JsonSerializable() // ignore: invalid_annotation_target
const theAnswer = 42;

@ShouldThrow('`@JsonSerializable` can only be used on classes.')
@JsonSerializable() // ignore: invalid_annotation_target
enum unsupportedEnum { not, valid }

@ShouldThrow('`@JsonSerializable` can only be used on classes.')
@JsonSerializable() // ignore: invalid_annotation_target
Object annotatedMethod() => throw UnimplementedError();

@ShouldGenerate(
  r'''
OnlyStaticMembers _$OnlyStaticMembersFromJson(Map<String, dynamic> json) =>
    OnlyStaticMembers();

Map<String, dynamic> _$OnlyStaticMembersToJson(OnlyStaticMembers instance) =>
    <String, dynamic>{};
''',
)
@JsonSerializable()
class OnlyStaticMembers {
  // To ensure static members are not considered for serialization.
  static const answer = 42;
  static final reason = DateTime.now();

  static int get understand => 42;
}

@ShouldGenerate(r'''
GeneralTestClass1 _$GeneralTestClass1FromJson(Map<String, dynamic> json) =>
    GeneralTestClass1()
      ..firstName = json['firstName'] as String
      ..lastName = json['lastName'] as String
      ..height = json['h'] as int
      ..dateOfBirth = DateTime.parse(json['dateOfBirth'] as String)
      ..dynamicType = json['dynamicType']
      ..varType = json['varType']
      ..listOfInts =
          (json['listOfInts'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$GeneralTestClass1ToJson(GeneralTestClass1 instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'h': instance.height,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'dynamicType': instance.dynamicType,
      'varType': instance.varType,
      'listOfInts': instance.listOfInts,
    };
''')
@JsonSerializable()
class GeneralTestClass1 {
  late String firstName, lastName;
  @JsonKey(name: 'h')
  late int height;
  late DateTime dateOfBirth;
  dynamic dynamicType;

  //ignore: prefer_typing_uninitialized_variables,type_annotate_public_apis
  var varType;
  late List<int> listOfInts;
}

@ShouldGenerate(r'''
GeneralTestClass2 _$GeneralTestClass2FromJson(Map<String, dynamic> json) =>
    GeneralTestClass2(
      json['height'] as int,
      json['firstName'] as String,
      json['lastName'] as String?,
    )..dateOfBirth = DateTime.parse(json['dateOfBirth'] as String);

Map<String, dynamic> _$GeneralTestClass2ToJson(GeneralTestClass2 instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'height': instance.height,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
    };
''')
@JsonSerializable()
class GeneralTestClass2 {
  final String firstName;
  final String? lastName;
  late int height;
  late DateTime dateOfBirth;

  GeneralTestClass2(this.height, String firstName, [this.lastName])
      :
        // ignore: prefer_initializing_formals
        firstName = firstName;
}

@ShouldGenerate(r'''
FinalFields _$FinalFieldsFromJson(Map<String, dynamic> json) => FinalFields(
      json['a'] as int,
    );

Map<String, dynamic> _$FinalFieldsToJson(FinalFields instance) =>
    <String, dynamic>{
      'a': instance.a,
    };
''')
@JsonSerializable()
class FinalFields {
  final int a;

  int get b => 4;

  FinalFields(this.a);
}

@ShouldGenerate(
  r'''
FinalFieldsNotSetInCtor _$FinalFieldsNotSetInCtorFromJson(
        Map<String, dynamic> json) =>
    FinalFieldsNotSetInCtor();

Map<String, dynamic> _$FinalFieldsNotSetInCtorToJson(
        FinalFieldsNotSetInCtor instance) =>
    <String, dynamic>{};
''',
)
@JsonSerializable()
class FinalFieldsNotSetInCtor {
  final int a = 1;

  FinalFieldsNotSetInCtor();
}

@ShouldGenerate(r'''
SetSupport _$SetSupportFromJson(Map<String, dynamic> json) => SetSupport(
      (json['values'] as List<dynamic>).map((e) => e as int).toSet(),
    );

Map<String, dynamic> _$SetSupportToJson(SetSupport instance) =>
    <String, dynamic>{
      'values': instance.values.toList(),
    };
''')
@JsonSerializable()
class SetSupport {
  final Set<int> values;

  SetSupport(this.values);
}

@ShouldThrow(
  '''
Could not generate `toJson` code for `watch`.
To support the type `Stopwatch` you can:
$converterOrKeyInstructions''',
)
@JsonSerializable(createFactory: false)
class NoSerializeFieldType {
  Stopwatch? watch;
}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `watch`.
To support the type `Stopwatch` you can:
$converterOrKeyInstructions''',
)
@JsonSerializable(createToJson: false)
class NoDeserializeFieldType {
  Stopwatch? watch;
}

@ShouldThrow(
  '''
Could not generate `toJson` code for `durationDateTimeMap` because of type `Duration`.
Map keys must be one of: Object, dynamic, enum, String, BigInt, DateTime, int, Uri.''',
)
@JsonSerializable(createFactory: false)
class NoSerializeBadKey {
  late Map<Duration, DateTime> durationDateTimeMap;
}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `durationDateTimeMap` because of type `Duration`.
Map keys must be one of: Object, dynamic, enum, String, BigInt, DateTime, int, Uri.''',
)
@JsonSerializable(createToJson: false)
class NoDeserializeBadKey {
  late Map<Duration, DateTime> durationDateTimeMap;
}

@ShouldGenerate(
  r'''
Map<String, dynamic> _$IncludeIfNullOverrideToJson(
    IncludeIfNullOverride instance) {
  final val = <String, dynamic>{
    'number': instance.number,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('str', instance.str);
  return val;
}
''',
)
@JsonSerializable(createFactory: false, includeIfNull: false)
class IncludeIfNullOverride {
  @JsonKey(includeIfNull: true)
  int? number;
  String? str;
}

// https://github.com/google/json_serializable.dart/issues/7 regression
@ShouldThrow(
  'The class `NoCtorClass` has no default constructor.',
)
@JsonSerializable()
class NoCtorClass {
  late final int member;

  //ignore: avoid_unused_constructor_parameters
  factory NoCtorClass.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

// https://github.com/google/json_serializable.dart/issues/7 regression
@ShouldThrow(
  'The class `WrongConstructorNameClass` does not have a constructor with the '
  'name `bob`.',
)
@JsonSerializable(constructor: 'bob')
class WrongConstructorNameClass {
  late final int member;
}

@ShouldThrow(
  'More than one field has the JSON key for name "str".',
  element: 'str',
)
@JsonSerializable(createFactory: false)
class KeyDupesField {
  @JsonKey(name: 'str')
  late int number;

  late String str;
}

@ShouldThrow(
  'More than one field has the JSON key for name "a".',
  element: 'str',
)
@JsonSerializable(createFactory: false)
class DupeKeys {
  @JsonKey(name: 'a')
  late int number;

  @JsonKey(name: 'a')
  late String str;
}

@ShouldGenerate(r'''
Map<String, dynamic> _$IgnoredFieldClassToJson(IgnoredFieldClass instance) =>
    <String, dynamic>{
      'ignoredFalseField': instance.ignoredFalseField,
      'ignoredNullField': instance.ignoredNullField,
    };
''')
@JsonSerializable(createFactory: false)
class IgnoredFieldClass {
  @JsonKey(ignore: true)
  late int ignoredTrueField;

  @JsonKey(ignore: false)
  late int ignoredFalseField;

  late int ignoredNullField;
}

@ShouldThrow(
  'Cannot populate the required constructor argument: '
  'ignoredTrueField. It is assigned to an ignored field.',
  element: '',
)
@JsonSerializable()
class IgnoredFieldCtorClass {
  @JsonKey(ignore: true)
  int ignoredTrueField;

  IgnoredFieldCtorClass(this.ignoredTrueField);
}

@ShouldThrow(
  'Cannot populate the required constructor argument: '
  '_privateField. It is assigned to a private field.',
  element: '',
)
@JsonSerializable()
class PrivateFieldCtorClass {
  // ignore: unused_field
  final int _privateField;

  PrivateFieldCtorClass(this._privateField);
}

@ShouldThrow(
  'Error with `@JsonKey` on the `field` field. '
  'Cannot set both `disallowNullValue` and `includeIfNull` to `true`. '
  'This leads to incompatible `toJson` and `fromJson` behavior.',
  element: 'field',
)
@JsonSerializable()
class IncludeIfNullDisallowNullClass {
  @JsonKey(includeIfNull: true, disallowNullValue: true)
  late int field;
}

@ShouldThrow(
  'The `JsonValue` annotation on `BadEnum.value` does not have a value '
  'of type String, int, or null.',
  element: 'value',
)
@JsonSerializable()
class JsonValueWithBool {
  late BadEnum field;
}

enum BadEnum {
  @JsonValue(true)
  value
}

@ShouldGenerate(r'''const _$GoodEnumEnumMap = {
  GoodEnum.noAnnotation: 'noAnnotation',
  GoodEnum.stringAnnotation: 'string annotation',
  GoodEnum.stringAnnotationWeird: r"string annotation with $ funky 'values'",
  GoodEnum.intValue: 42,
  GoodEnum.nullValue: null,
};
''', contains: true)
@JsonSerializable()
class JsonValueValid {
  late GoodEnum field;
}

enum GoodEnum {
  noAnnotation,
  @JsonValue('string annotation')
  stringAnnotation,
  @JsonValue("string annotation with \$ funky 'values'")
  stringAnnotationWeird,
  @JsonValue(42)
  intValue,
  @JsonValue(null)
  nullValue
}

@ShouldGenerate(r'''
FieldWithFromJsonCtorAndTypeParams _$FieldWithFromJsonCtorAndTypeParamsFromJson(
        Map<String, dynamic> json) =>
    FieldWithFromJsonCtorAndTypeParams()
      ..customOrders = json['customOrders'] == null
          ? null
          : MyList<GeneralTestClass2, int>.fromJson((json['customOrders']
                  as List<dynamic>)
              .map((e) => GeneralTestClass2.fromJson(e as Map<String, dynamic>))
              .toList());
''')
@JsonSerializable(createToJson: false)
class FieldWithFromJsonCtorAndTypeParams {
  MyList<GeneralTestClass2, int>? customOrders;
}

class MyList<T, Q> extends ListBase<T> {
  final List<T> _data;

  MyList(Iterable<T> source) : _data = source.toList();

  factory MyList.fromJson(List<T> items) => MyList(items);

  @override
  int get length => _data.length;

  @override
  set length(int value) {
    _data.length = value;
  }

  @override
  T operator [](int index) => _data[index];

  @override
  void operator []=(int index, T value) {
    _data[index] = value;
  }
}

mixin _PropInMixinI448RegressionMixin {
  late int nullable;
}

@ShouldGenerate(r'''
PropInMixinI448Regression _$PropInMixinI448RegressionFromJson(
        Map<String, dynamic> json) =>
    PropInMixinI448Regression()
      ..nullable = json['nullable'] as int
      ..notNullable = json['notNullable'] as int;

Map<String, dynamic> _$PropInMixinI448RegressionToJson(
        PropInMixinI448Regression instance) =>
    <String, dynamic>{
      'nullable': instance.nullable,
      'notNullable': instance.notNullable,
    };
''')
@JsonSerializable()
class PropInMixinI448Regression with _PropInMixinI448RegressionMixin {
  @JsonKey()
  late int notNullable;
}

@ShouldGenerate(
  r'''
IgnoreUnannotated _$IgnoreUnannotatedFromJson(Map<String, dynamic> json) =>
    IgnoreUnannotated()..annotated = json['annotated'] as int;

Map<String, dynamic> _$IgnoreUnannotatedToJson(IgnoreUnannotated instance) =>
    <String, dynamic>{
      'annotated': instance.annotated,
    };
''',
)
@JsonSerializable(ignoreUnannotated: true)
class IgnoreUnannotated {
  @JsonKey()
  late int annotated;

  late int unannotated;
}

@ShouldGenerate(
  r'''
SubclassedJsonKey _$SubclassedJsonKeyFromJson(Map<String, dynamic> json) =>
    SubclassedJsonKey()..annotatedWithSubclass = json['bob'] as int;

Map<String, dynamic> _$SubclassedJsonKeyToJson(SubclassedJsonKey instance) =>
    <String, dynamic>{
      'bob': instance.annotatedWithSubclass,
    };
''',
)
@JsonSerializable(ignoreUnannotated: true)
class SubclassedJsonKey {
  @MyJsonKey()
  late int annotatedWithSubclass;
}

class MyJsonKey extends JsonKey {
  const MyJsonKey() : super(name: 'bob');
}

@ShouldGenerate(
  r'''
OverrideGetterExampleI613 _$OverrideGetterExampleI613FromJson(
        Map<String, dynamic> json) =>
    OverrideGetterExampleI613()..id = json['id'] as String;

Map<String, dynamic> _$OverrideGetterExampleI613ToJson(
        OverrideGetterExampleI613 instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
''',
)
@JsonSerializable()
class OverrideGetterExampleI613 extends OverrideGetterExampleI613Super {
  @override
  String get id => throw UnimplementedError();
}

class OverrideGetterExampleI613Super {
  set id(String value) => throw UnimplementedError();

  String get id => throw UnimplementedError();
}

@ShouldThrow(
  'Expecting a `fromJson` constructor with exactly one positional parameter. '
  'Found a constructor with 0 parameters.',
  element: 'fromJson',
)
@JsonSerializable()
class InvalidChildClassFromJson {
  late NoParamFromJsonCtor field;
}

class NoParamFromJsonCtor {
  NoParamFromJsonCtor.fromJson();
}

@ShouldThrow(
  'Expecting a `fromJson` constructor with exactly one positional parameter. '
  'The only extra parameters allowed are functions of the form '
  '`T Function(Object?) fromJsonT` '
  'where `T` is a type parameter of the target type.',
  element: 'fromJson',
)
@JsonSerializable()
class InvalidChildClassFromJson2 {
  late ExtraParamFromJsonCtor field;
}

class ExtraParamFromJsonCtor {
  // ignore: avoid_unused_constructor_parameters
  ExtraParamFromJsonCtor.fromJson(Map<String, dynamic> json, int oops);

  Map<String, dynamic> toJson() => throw UnimplementedError();
}

@ShouldThrow(
  'Expecting a `toJson` function with no required parameters. '
  'The only extra parameters allowed are functions of the form '
  '`Object Function(T) toJsonT` where `T` is a type parameter of the target '
  ' type.',
  element: 'toJson',
)
@JsonSerializable()
class InvalidChildClassFromJson3 {
  late ExtraParamToJson field;
}

class ExtraParamToJson {
  // ignore: avoid_unused_constructor_parameters
  ExtraParamToJson.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(int bob) => throw UnimplementedError();
}

@ShouldGenerate(r'''
Map<String, dynamic> _$Issue1038RegressionTestToJson(
        Issue1038RegressionTest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ean': instance.ean,
    };
''')
@JsonSerializable(createFactory: false)
class Issue1038RegressionTest {
  final String? id;
  final String? ean;

  Issue1038RegressionTest.id(this.id) : ean = null;

  Issue1038RegressionTest.ean(this.ean) : id = null;
}
