// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library test;

import 'package:json_serializable/json_serializable.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  initializeBuildLogTracking();
  final jsonSerializableTestReader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_json_serializable_test_input.dart',
  );

  testAnnotatedElements(
    jsonSerializableTestReader,
    JsonSerializableGenerator(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
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
}

const _expectedAnnotatedTests = {
  'BadEnumDefaultValue',
  'BadFromFuncReturnType',
  'BadNoArgs',
  'BadOneNamed',
  'BadToFuncReturnType',
  'BadTwoRequiredPositional',
  'CtorDefaultValueAndJsonKeyDefaultValue',
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
  'IgnoreUnannotated',
  'IgnoredFieldClass',
  'IgnoredFieldCtorClass',
  'IncludeIfNullDisallowNullClass',
  'IncludeIfNullOverride',
  'InvalidChildClassFromJson',
  'InvalidChildClassFromJson2',
  'InvalidChildClassFromJson3',
  'InvalidFromFunc2Args',
  'InvalidToFunc2Args',
  'Issue1038RegressionTest',
  'Issue713',
  'JsonConvertOnField',
  'JsonConverterCtorParams',
  'JsonConverterDuplicateAnnotations',
  'JsonConverterNamedCtor',
  'JsonConverterNullableToNonNullable',
  'JsonConverterOnGetter',
  'JsonConverterWithBadTypeArg',
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
  'PrivateFieldCtorClass',
  'PropInMixinI448Regression',
  'Reproduce869NullableGenericType',
  'Reproduce869NullableGenericTypeWithDefault',
  'SameCtorAndJsonKeyDefaultValue',
  'SetSupport',
  'SubType',
  'SubTypeWithAnnotatedFieldOverrideExtends',
  'SubTypeWithAnnotatedFieldOverrideExtendsWithOverrides',
  'SubTypeWithAnnotatedFieldOverrideImplements',
  'SubclassedJsonKey',
  'TearOffFromJsonClass',
  'ToJsonNullableFalseIncludeIfNullFalse',
  'TypedConvertMethods',
  'UnknownEnumValue',
  'UnknownEnumValueListWrongEnumType',
  'UnknownEnumValueListWrongType',
  'UnknownEnumValueNotEnumField',
  'UnknownEnumValueWrongEnumType',
  'UnsupportedDateTimeField',
  'UnsupportedDurationField',
  'UnsupportedEnum',
  'UnsupportedListField',
  'UnsupportedMapField',
  'UnsupportedSetField',
  'UnsupportedUriField',
  'ValidToFromFuncClassStatic',
  'WithANonCtorGetter',
  'WithANonCtorGetterChecked',
  'WrongConstructorNameClass',
  '_BetterPrivateNames',
  'annotatedMethod',
  'theAnswer',
};
