// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:json_serializable/json_serializable.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  initializeBuildLogTracking();
  final jsonSerializableTestReader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_json_serializable_test_input.dart',
  );

  final jsonSchemaTestReader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_json_schema_test_input.dart',
  );

  testAnnotatedElements(
    jsonSerializableTestReader,
    JsonSerializableGenerator(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
  );

  testAnnotatedElements(
    jsonSchemaTestReader,
    JsonSerializableGenerator(),
    expectedAnnotatedTests: _expectedSchemaTests,
  );

  final jsonEnumTestReader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_json_enum_test_input.dart',
  );

  testAnnotatedElements(
    jsonEnumTestReader,
    const JsonEnumGenerator(),
    expectedAnnotatedTests: {
      'EnumValueIssue1147',
      'EnumValueNotAField',
      'EnumValueNotSupportType',
      'EnumValueWeirdField',
      'UnsupportedClass',
    },
  );

  final primaryConstructorsRelease =
      Feature.primary_constructors.releaseVersion;
  final currentSdkVersion = Version.parse(Platform.version.split(' ').first);
  if (primaryConstructorsRelease != null &&
      currentSdkVersion >= primaryConstructorsRelease) {
    final primaryConstructorTestReader = await initializeLibraryReader({
      'primary_constructor_test_input.dart': _primaryConstructorTestInput,
    }, 'primary_constructor_test_input.dart');

    testAnnotatedElements(
      primaryConstructorTestReader,
      JsonSerializableGenerator(),
      expectedAnnotatedTests: {
        'PrimaryConstructorLargeClass',
        'PrimaryConstructorMixedWithBodyFields',
      },
    );
  } else {
    test(
      'primary constructors',
      () {},
      skip: 'Requires primary-constructors support in SDK and analyzer.',
    );
  }
}

const _expectedAnnotatedTests = {
  '_BetterPrivateNames',
  'annotatedMethod',
  'BadEnumDefaultValue',
  'BadFromFuncReturnType',
  'BadPatchEntity',
  'PatchBadConverterFromJson',
  'PatchBadCustomFromJson',
  'PatchDefaultValueWithExplicit',
  'PatchDisallowNullWithExplicit',
  'PatchEntityChecked',
  'PatchNonNullableField',
  'PatchNullableStringEntity',
  'PatchRequiredWithExplicit',
  'PatchWithCustomFromJson',
  'PatchReadValueWithExplicit',
  'BadNoArgs',
  'BadOneNamed',
  'BadToFuncReturnType',
  'BadTwoRequiredPositional',
  'CtorDefaultValueAndJsonKeyDefaultValue',
  'CtorParamJsonKey',
  'CtorParamJsonKeyWithExtends',
  'DateTimeUtcTestClass',
  'DefaultDoubleConstants',
  'DefaultWithConstObject',
  'DefaultWithDisallowNullRequiredClass',
  'DefaultWithFunction',
  'DefaultWithFunctionInList',
  'DefaultWithNestedEnum',
  'DefaultWithSymbol',
  'DefaultWithToJsonClass',
  'DefaultWithType',
  'DupeKeys',
  'DynamicConvertMethods',
  'FieldNamerKebab',
  'FieldNamerNone',
  'FieldNamerPascal',
  'FieldNamerScreamingSnake',
  'FieldNamerSnake',
  'FieldWithFromJsonCtorAndTypeParams',
  'FinalFields',
  'FinalFieldsNotSetInCtor',
  'FromDynamicCollection',
  'FromNullableDynamicCollection',
  'GeneralTestClass1',
  'GeneralTestClass2',
  'GenericArgumentFactoriesFlagWithoutGenericType',
  'GenericClass',
  'IgnoreAndIncludeFromJsonFieldCtorClass',
  'IgnoreAndIncludeToJsonFieldCtorClass',
  'IgnoredFieldClass',
  'IgnoredFieldCtorClass',
  'IgnoreUnannotated',
  'IncludeIfNullDisallowNullClass',
  'IncludeIfNullOverride',
  'InvalidChildClassFromJson',
  'InvalidChildClassFromJson2',
  'InvalidChildClassFromJson3',
  'InvalidFromFunc2Args',
  'InvalidToFunc2Args',
  'Issue1038RegressionTest',
  'Issue1208',
  'Issue713',
  'JsonConverterCtorParams',
  'JsonConverterDuplicateAnnotations',
  'JsonConverterNamedCtor',
  'JsonConverterNullableAndNonNullable',
  'JsonConverterNullableToNonNullable',
  'JsonConverterOnGetter',
  'JsonConverterWithBadTypeArg',
  'JsonConvertOnField',
  'JsonSchemaTestClass',
  'JsonValueValid',
  'JsonValueWithBool',
  'JustSetter',
  'JustSetterNoFromJson',
  'JustSetterNoToJson',
  'KeyDupesField',
  'MapKeyNoNullableInt',
  'MapKeyNoNullableObject',
  'MapKeyNoNullableString',
  'MapKeyVariety',
  'NoCtorClass',
  'NoDeserializeBadKey',
  'NoDeserializeFieldType',
  'NoSerializeBadKey',
  'NoSerializeFieldType',
  'ObjectConvertMethods',
  'OkayOneNormalOptionalNamed',
  'OkayOneNormalOptionalPositional',
  'OkayOnlyOptionalPositional',
  'OnlyStaticMembers',
  'OverrideGetterExampleI613',
  'PatchEntity',
  'PrivateFieldCtorClass',
  'PropInMixinI448Regression',
  'RecordDoubleConverter',
  'RecordNamedDoubleConverter',
  'RecordNullableDoubleConverter',
  'RecordSingleDoubleConverter',
  'RecordWithFunction',
  'RecordWithNamedFunction',
  'RecordWithSinglePositionalFunction',
  'Reproduce869NullableGenericType',
  'Reproduce869NullableGenericTypeWithDefault',
  'SameCtorAndJsonKeyDefaultValue',
  'SetSupport',
  'StandaloneCtorParamClass',
  'SubclassedJsonKey',
  'SubType',
  'SubTypeWithAnnotatedFieldOverrideExtends',
  'SubTypeWithAnnotatedFieldOverrideExtendsWithOverrides',
  'SubTypeWithAnnotatedFieldOverrideImplements',
  'TearOffFromJsonClass',
  'theAnswer',
  'ToJsonNullableFalseIncludeIfNullFalse',
  'TypedConvertMethods',
  'UnknownEnumValue',
  'UnknownEnumValueListWrongEnumType',
  'UnknownEnumValueListWrongType',
  'UnknownEnumValueMap',
  'UnknownEnumValueMapNotNullable',
  'UnknownEnumValueMapNullForUndefinedWrongType',
  'UnknownEnumValueMapValueWrongEnumType',
  'UnknownEnumValueMapValueWrongType',
  'UnknownEnumValueNotEnumField',
  'UnknownEnumValueWrongEnumType',
  'UnsupportedDateTimeField',
  'UnsupportedDurationField',
  'UnsupportedEnum',
  'UnsupportedListField',
  'UnsupportedMapField',
  'UnsupportedNestedFunctionType',
  'UnsupportedMapKeyRecord',
  'UnsupportedSetField',
  'UnsupportedUriField',
  'ValidToFromFuncClassStatic',
  'WithANonCtorGetter',
  'WithANonCtorGetterChecked',
  'WrongConstructorNameClass',
};

const _expectedSchemaTests = {
  'JsonSchemaDocsTest',
  'JsonSchemaCollectionsTest',
  'JsonSchemaDefaultsTest',
  'JsonSchemaNullableTest',
  'JsonSchemaNestedTest',
  'JsonSchemaNonCollectionTest',
  'JsonSchemaGetterTest',
  'JsonSchemaRecursiveListTest',
  'JsonSchemaRecursiveListIssue',
  'JsonSchemaEnumTest',
};

const _primaryConstructorTestInput = r'''
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r"""
PrimaryConstructorLargeClass _$PrimaryConstructorLargeClassFromJson(
  Map<String, dynamic> json,
) => PrimaryConstructorLargeClass(
  param01: json['param01'] as bool,
  param02: json['param02'] as bool,
  param03: json['param03'] as bool,
  param04: json['param04'] as bool,
  param05: json['param05'] as bool,
  param06: json['param06'] as bool,
  param07: json['param07'] as bool,
  param08: json['param08'] as bool,
  param09: json['param09'] as bool,
  param10: json['param10'] as bool,
  param11: json['param11'] as bool,
  param12: json['param12'] as bool,
  param13: json['param13'] as bool,
  param14: json['param14'] as bool,
  param15: json['param15'] as bool,
  param16: json['param16'] as bool,
  param17: json['param17'] as bool,
  param18: json['param18'] as bool,
  param19: json['param19'] as bool,
  param20: json['param20'] as bool,
  param21: json['param21'] as bool,
  param22: json['param22'] as bool,
  param23: json['param23'] as bool,
  param24: json['param24'] as bool,
  param25: json['param25'] as bool,
  param26: json['param26'] as bool,
  param27: json['param27'] as bool,
  param28: json['param28'] as bool,
  param29: json['param29'] as bool,
  param30: json['param30'] as bool,
  param31: json['param31'] as bool,
  param32: json['param32'] as bool,
  param33: json['param33'] as bool,
  param34: json['param34'] as bool,
  param35: json['param35'] as bool,
);

Map<String, dynamic> _$PrimaryConstructorLargeClassToJson(
  PrimaryConstructorLargeClass instance,
) => <String, dynamic>{
  'param01': instance.param01,
  'param02': instance.param02,
  'param03': instance.param03,
  'param04': instance.param04,
  'param05': instance.param05,
  'param06': instance.param06,
  'param07': instance.param07,
  'param08': instance.param08,
  'param09': instance.param09,
  'param10': instance.param10,
  'param11': instance.param11,
  'param12': instance.param12,
  'param13': instance.param13,
  'param14': instance.param14,
  'param15': instance.param15,
  'param16': instance.param16,
  'param17': instance.param17,
  'param18': instance.param18,
  'param19': instance.param19,
  'param20': instance.param20,
  'param21': instance.param21,
  'param22': instance.param22,
  'param23': instance.param23,
  'param24': instance.param24,
  'param25': instance.param25,
  'param26': instance.param26,
  'param27': instance.param27,
  'param28': instance.param28,
  'param29': instance.param29,
  'param30': instance.param30,
  'param31': instance.param31,
  'param32': instance.param32,
  'param33': instance.param33,
  'param34': instance.param34,
  'param35': instance.param35,
};
""")
@JsonSerializable()
class PrimaryConstructorLargeClass({
  required final bool param01,
  required final bool param02,
  required final bool param03,
  required final bool param04,
  required final bool param05,
  required final bool param06,
  required final bool param07,
  required final bool param08,
  required final bool param09,
  required final bool param10,
  required final bool param11,
  required final bool param12,
  required final bool param13,
  required final bool param14,
  required final bool param15,
  required final bool param16,
  required final bool param17,
  required final bool param18,
  required final bool param19,
  required final bool param20,
  required final bool param21,
  required final bool param22,
  required final bool param23,
  required final bool param24,
  required final bool param25,
  required final bool param26,
  required final bool param27,
  required final bool param28,
  required final bool param29,
  required final bool param30,
  required final bool param31,
  required final bool param32,
  required final bool param33,
  required final bool param34,
  required final bool param35,
});

@ShouldGenerate(r"""
PrimaryConstructorMixedWithBodyFields
_$PrimaryConstructorMixedWithBodyFieldsFromJson(Map<String, dynamic> json) =>
    PrimaryConstructorMixedWithBodyFields(
        param01: json['param01'] as bool,
        param02: json['param02'] as bool,
        param03: json['param03'] as bool,
        param04: json['param04'] as bool,
        param05: json['param05'] as bool,
        param06: json['param06'] as bool,
        param07: json['param07'] as bool,
        param08: json['param08'] as bool,
        param09: json['param09'] as bool,
        param10: json['param10'] as bool,
        param11: json['param11'] as bool,
        param12: json['param12'] as bool,
        param13: json['param13'] as bool,
        param14: json['param14'] as bool,
        param15: json['param15'] as bool,
        param16: json['param16'] as bool,
        param17: json['param17'] as bool,
        param18: json['param18'] as bool,
        param19: json['param19'] as bool,
        param20: json['param20'] as bool,
      )
      ..body01 = json['body01'] as bool
      ..body02 = json['body02'] as bool
      ..body03 = json['body03'] as bool
      ..body04 = json['body04'] as bool
      ..body05 = json['body05'] as bool
      ..body06 = json['body06'] as bool
      ..body07 = json['body07'] as bool
      ..body08 = json['body08'] as bool
      ..body09 = json['body09'] as bool
      ..body10 = json['body10'] as bool
      ..body11 = json['body11'] as bool
      ..body12 = json['body12'] as bool
      ..body13 = json['body13'] as bool
      ..body14 = json['body14'] as bool
      ..body15 = json['body15'] as bool;

Map<String, dynamic> _$PrimaryConstructorMixedWithBodyFieldsToJson(
  PrimaryConstructorMixedWithBodyFields instance,
) => <String, dynamic>{
  'param01': instance.param01,
  'param02': instance.param02,
  'param03': instance.param03,
  'param04': instance.param04,
  'param05': instance.param05,
  'param06': instance.param06,
  'param07': instance.param07,
  'param08': instance.param08,
  'param09': instance.param09,
  'param10': instance.param10,
  'param11': instance.param11,
  'param12': instance.param12,
  'param13': instance.param13,
  'param14': instance.param14,
  'param15': instance.param15,
  'param16': instance.param16,
  'param17': instance.param17,
  'param18': instance.param18,
  'param19': instance.param19,
  'param20': instance.param20,
  'body01': instance.body01,
  'body02': instance.body02,
  'body03': instance.body03,
  'body04': instance.body04,
  'body05': instance.body05,
  'body06': instance.body06,
  'body07': instance.body07,
  'body08': instance.body08,
  'body09': instance.body09,
  'body10': instance.body10,
  'body11': instance.body11,
  'body12': instance.body12,
  'body13': instance.body13,
  'body14': instance.body14,
  'body15': instance.body15,
};
""")
@JsonSerializable()
class PrimaryConstructorMixedWithBodyFields({
  required final bool param01,
  required final bool param02,
  required final bool param03,
  required final bool param04,
  required final bool param05,
  required final bool param06,
  required final bool param07,
  required final bool param08,
  required final bool param09,
  required final bool param10,
  required final bool param11,
  required final bool param12,
  required final bool param13,
  required final bool param14,
  required final bool param15,
  required final bool param16,
  required final bool param17,
  required final bool param18,
  required final bool param19,
  required final bool param20,
}) {
  late bool body01;
  late bool body02;
  late bool body03;
  late bool body04;
  late bool body05;
  late bool body06;
  late bool body07;
  late bool body08;
  late bool body09;
  late bool body10;
  late bool body11;
  late bool body12;
  late bool body13;
  late bool body14;
  late bool body15;
}
''';
