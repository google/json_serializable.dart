// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'package:json_serializable/json_serializable.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

void main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_json_serializable_test_input.dart',
  );

  testAnnotatedElements(
    reader,
    const JsonSerializableGenerator(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
  );
}

const _expectedAnnotatedTests = [
  'annotatedMethod',
  'BadFromFuncReturnType',
  'BadNoArgs',
  'BadOneNamed',
  'BadToFuncReturnType',
  'BadTwoRequiredPositional',
  'DefaultWithConstObject',
  'DefaultWithDisallowNullRequiredClass',
  'DefaultWithFunction',
  'DefaultWithNestedEnum',
  'DefaultWithNonNullableClass',
  'DefaultWithNonNullableField',
  'DefaultWithSymbol',
  'DefaultWithToJsonClass',
  'DefaultWithType',
  'DupeKeys',
  'DynamicConvertMethods',
  'EmptyCollectionAsNullAndIncludeIfNullClass',
  'EmptyCollectionAsNullAndIncludeIfNullField',
  'EncodeEmptyCollectionAsNullOnField',
  'EncodeEmptyCollectionAsNullOnNonCollectionField',
  'FieldNamerKebab',
  'FieldNamerNone',
  'FieldNamerSnake',
  'FieldWithFromJsonCtorAndTypeParams',
  'FinalFields',
  'FinalFieldsNotSetInCtor',
  'FromDynamicCollection',
  'GeneralTestClass1',
  'GeneralTestClass2',
  'GenericClass',
  'IgnoredFieldClass',
  'IgnoredFieldCtorClass',
  'IncludeIfNullDisallowNullClass',
  'IncludeIfNullOverride',
  'InvalidFromFunc2Args',
  'InvalidToFunc2Args',
  'JsonConverterCtorParams',
  'JsonConverterDuplicateAnnotations',
  'JsonConverterNamedCtor',
  'JsonConverterWithBadTypeArg',
  'JsonConvertOnField',
  'JsonValueValid',
  'JsonValueWithBool',
  'JustSetter',
  'JustSetterNoFromJson',
  'JustSetterNoToJson',
  'KeyDupesField',
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
  'PrivateFieldCtorClass',
  'PropInMixinI448Regression',
  'SetSupport',
  'SubType',
  'SubTypeWithAnnotatedFieldOverrideExtends',
  'SubTypeWithAnnotatedFieldOverrideExtendsWithOverrides',
  'SubTypeWithAnnotatedFieldOverrideImplements',
  'theAnswer',
  'ToJsonNullableFalseIncludeIfNullFalse',
  'TypedConvertMethods',
  'UnknownCtorParamType',
  'UnknownFieldType',
  'UnknownFieldTypeToJsonOnly',
  'UnknownFieldTypeWithConvert',
  'UnsupportedDateTimeField',
  'UnsupportedDurationField',
  'UnsupportedListField',
  'UnsupportedMapField',
  'UnsupportedSetField',
  'UnsupportedUriField',
  'ValidToFromFuncClassStatic',
  'WithANonCtorGetter',
  'WithANonCtorGetterChecked',
];
