// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
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
    expectedAnnotatedTests: {'UnsupportedClass'},
  );
}

const _expectedAnnotatedTests = {
  'annotatedMethod',
  'unsupportedEnum',
  'BadFromFuncReturnType',
  'BadNoArgs',
  'BadOneNamed',
  'BadToFuncReturnType',
  'BadTwoRequiredPositional',
  'BadEnumDefaultValue',
  '_BetterPrivateNames',
  'CtorDefaultValueAndJsonKeyDefaultValue',
  'SameCtorAndJsonKeyDefaultValue',
  'DefaultDoubleConstants',
  'DefaultWithConstObject',
  'DefaultWithDisallowNullRequiredClass',
  'DefaultWithFunction',
  'DefaultWithNestedEnum',
  'DefaultWithSymbol',
  'DefaultWithToJsonClass',
  'DefaultWithType',
  'DupeKeys',
  'DynamicConvertMethods',
  'FieldNamerKebab',
  'FieldNamerNone',
  'FieldNamerPascal',
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
  'Issue713',
  'Issue1038RegressionTest',
  'JsonConvertOnField',
  'JsonConverterCtorParams',
  'JsonConverterDuplicateAnnotations',
  'JsonConverterNamedCtor',
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
  'SetSupport',
  'SubclassedJsonKey',
  'SubType',
  'SubTypeWithAnnotatedFieldOverrideExtends',
  'SubTypeWithAnnotatedFieldOverrideExtendsWithOverrides',
  'SubTypeWithAnnotatedFieldOverrideImplements',
  'theAnswer',
  'ToJsonNullableFalseIncludeIfNullFalse',
  'TypedConvertMethods',
  'UnknownEnumValue',
  'UnknownEnumValueListWrongEnumType',
  'UnknownEnumValueListWrongType',
  'UnknownEnumValueWrongEnumType',
  'UnknownEnumValueNotEnumField',
  'UnsupportedDateTimeField',
  'UnsupportedDurationField',
  'UnsupportedListField',
  'UnsupportedMapField',
  'UnsupportedSetField',
  'UnsupportedUriField',
  'ValidToFromFuncClassStatic',
  'WithANonCtorGetter',
  'WithANonCtorGetterChecked',
  'WrongConstructorNameClass',
};
