## 6.11.0

- Support `JsonKey` annotation on constructor parameters.
- Require `analyzer: '>=7.4.0 <9.0.0'`
- Require `dart_style: ^3.0.0`
- Require `meta: ^1.15.0`
- Require `source_helper: ^1.3.6`
- Require `source_gen: ^3.1.0`, stop using deprecated `TypeChecker.fromRuntime`
  and use the new `TypeChecker.typeNamed` instead.

## 6.10.0

- Required `analyzer: ^7.4.0`.
- Switch to analyzer element2 model and `build: ^3.0.0-dev`.
- Move `package:collection` to a dev dependency.
- Use new `null-aware element` feature in generated code.
- Require Dart 3.8

## 6.9.5

- Support the `analyzer: '>=6.9.0 <8.0.0'`.
- Fixed use of deprecated analyzer APIs.

## 6.9.4

- Fix extra line being generated when targeting Dart 3.7 package.

## 6.9.3

- Error out if the target package does not have a language version of `3.0` or 
  greater.

## 6.9.2

- Support the latest `package:analyzer`.

## 6.9.1

- Support the latest `package:source_gen`.
- Require Dart 3.6

## 6.9.0

- Use conditional map syntax to clean up `null` handling in `toJson` functions.
- Fix core Dart type links in docs.
- Require Dart 3.5

## 6.8.0

- Add type arguments to `Map` literals used for `Record` serialization.
- Add support for `JsonSerializable(createJsonKeys: true)`.
  ([#1401](https://github.com/google/json_serializable.dart/pull/1401))
- Handle decoding an `int` value from a `double` literal. 
  This now matches the behavior of `double` values being encoded as `int`.

## 6.7.1

- Support the latest `package:analyzer`.

## 6.7.0

- Support `Record` types.
- Require Dart 3.0
- Require `analyzer: ^5.12.0`

## 6.6.2

- Better handling of `Object?` or `dynamic` as `fromJson` constructor param.
- Require Dart 2.19

## 6.6.1

- Fix bug when `JsonKey.includeToJson` is `false`.

## 6.6.0

- Support for `JsonKey.includeFromJson` and `JsonKey.includeToJson`.
- Support `JsonEnum.valueField` being set with `'index'`.
- Support `JsonSerializable.createPerFieldToJson`.
- Require Dart SDK `>=2.18.0`.
- Require `analyzer: ^5.2.0`
- Require `json_annotation: '>=4.8.0 <4.9.0'`

## 6.5.4

- Fixed handling of nullable fields with converters which return non-nullable
  values.

## 6.5.3

- Fixed handling of nullable `enum` fields with `includeIfNull: false`.

## 6.5.2

- Better handling of `null` when encoding `enum` values or values with
  conversions.

## 6.5.1

- Fixed `BigInt`, `DateTime`, and `Uri` support for `JsonKey.defaultValue` with
  a function value.

## 6.5.0

- Allow constructors to be passed to `JsonKey` parameters that support
  `Function` types.
- Accept `Function` values for `JsonKey.defaultValue`. The provided
  `Function` will be invoked for the default value if the target JSON element is
  missing or `null`.

## 6.4.1

- Fixed a bug when an `@JsonSerializable` class uses a mixin with fields.
- Added more documentation `@JsonEnum`.

## 6.4.0

- Add support for `JsonEnum.valueField` which allows specifying a field in an
  "enhanced enum" to use for serialization instead of specifying each value
  individually with `JsonValue
- Require `json_annotation: '>=4.7.0 <4.8.0'`

## 6.3.2

- Require `analyzer: '>=4.6.0 <6.0.0'`
- Require `sdk: '>=2.17.0 <3.0.0'`

## 6.3.1

- Fixed support for `Duration` fields with default values.
  ([#1170](https://github.com/google/json_serializable.dart/issues/1170))

## 6.3.0

- Added support for generating `_$ExampleFieldMap`, which can be used by other
  code-generators that needs to interact with JSON serialization.
  ([#1164](https://github.com/google/json_serializable.dart/pull/1164))
- Added support for using a `JsonConverter<MyClass, Object>` on properties of
  type `MyClass?`.
  ([#822](https://github.com/google/json_serializable.dart/issues/822))
- Added support for `JsonSerializable(converters: <JsonConverter>[])`
  ([#1072](https://github.com/google/json_serializable.dart/issues/1072))
- Fix issue with serialization of non-nullable enumerations emitting a nullable
  type ([#1146](https://github.com/google/json_serializable.dart/pull/1146))

## 6.2.0

- Added support for the new `FieldRename.screamingSnake` field in
  `package:json_annotation`.

## 6.1.6

- Allow latest `package:analyzer`.

## 6.1.5

- Fix enum support for upcoming enhanced enums in Dart 2.17.

## 6.1.4

- Fix issues with latest `package:analyzer` related to enums and annotations.

## 6.1.3

- Allow latest `package:analyzer`.

## 6.1.2

- Fix issue with nested generics and `genericArgumentFactories: true`.
  ([#1047](https://github.com/google/json_serializable.dart/issues/1047))

## 6.1.1

- Fix `JsonKey.readValue` support to allow static functions.

## 6.1.0

- Support `JsonKey.readValue` to allow customized reading of values from source
  JSON map objects.
- The check to make sure there is a correctly constrained dependency on
  `package:json_annotation` is now a warning and doesn't fail the build.
- Require `json_annotation` `'>=4.4.0 <4.5.0'`.

## 6.0.1

- Don't require `json_annotation` in `dependencies` if it's just used in tests.

## 6.0.0

- Added support for `JsonSerializable.constructor` to allow specifying an
  alternative constructor to invoke when creating a `fromJson` helper.
- Support the new `@JsonEnum` annotation in `package:json_annotation`.
- Support `JsonKey.nullForUndefinedEnumValue` as a value for
  `JsonKey.unknownEnumValue` when you want to use `null` as the unknown value.
- Use the new `$enumDecodeNullable` and `$enumDecode` in `json_annotation'
  instead of generating these for each library. **NOTE**: This is a potential
  breaking change if any user code relies on the previously generated private
  functions.
- The builder now checks to make sure there is a correctly constrained
  dependency on `package:json_annotation`.
- Require Dart SDK `>=2.14.0`.
- Require `json_annotation` `'>=4.3.0 <4.4.0'`.

## 5.0.2

- Include type arguments when invoking `fromJson` on custom types. This fixes an
  edge case where the generic arguments could not be inferred.

## 5.0.1

- Correctly handle nullable custom objects within `Iterable` and `Map`.
- Require the latest `package:source_helper`.

## 5.0.0

- Use the default value for optional constructor parameters if
  `JsonKey.defaultValue` is not provided. This could be a breaking behavior
  change in generated code in some cases.
- Fixed `fromJson` for `Map` fields with nullable values.
- Improve names of private classes generated for `toJson` and `fromJson`.
- Use the new `$checkedCreate` helper exposed in `package:json_annotation`
  v4.1+.
- Generated code now conforms to this `prefer_expression_function_bodies` lint.
- Support default values and types with a `fromJson` constructor.
- Support default values with class- and function-based converters.
- `type_helper.dart`:
  - **BREAKING**: removed `typeArgumentsOf`. This is now an extension exposed by
    `package:source_helper`.
- Require `package:analyzer` `^2.0.0`.

## 4.1.4

- Allow the latest `package:json_annotation`.

## 4.1.3

- Correctly handle nullable types with type arguments in generated code.

## 4.1.2

- Correctly decode `Map<String, double>` when the input has `int` literals.

## 4.1.1

- Allow the latest `package:build_config`.

## 4.1.0

- Implementation is now null-safe.
- Correctly handle nullable generic fields (`T?`) with
  `genericArgumentFactories`.

- `type_helper.dart` - **BREAKING changes**
  - The API is now null-safe.
  - new `KeyConfig` class replaces `JsonKey`.
  - new `ClassConfig` class replaces `JsonSerializable`.

## 4.0.3

- Correctly handle nullable values with `genericArgumentFactories`.
- Require the latest `package:build`.

## 4.0.2

- Correctly handle nullable `Map` and `Iterable` JSON types exposed by both
  class- and function-based converters.

## 4.0.1

- Allow latest `package:analyzer`.

## 4.0.0

- Requires Dart 2.12 or greater.
- Generates null-safe code.
  - The `nullable` field on `JsonKey` ignored. The nullability of a field is now
    determined by the Dart type system.
- **BREAKING** `bool defaultProvided` arg added to `TypeHelper.deserialize`.
  _Only applies to code using `TypeHelper` directly._

## 3.5.2

- Widen `package:analyzer` range to allow v1.x.

## 3.5.1

- Improved error messages for unsupported types.
- `package:json_serializable/type_helper.dart`
  - Made the third parameter to `UnsupportedTypeError` positional (optional).
- Require `package:analyzer` `>=0.39.0 <0.42.0`.

## 3.5.0

- Added support for populating generic helper functions for fields with generic
  type parameters.
- Added support for `JsonSerializable.genericArgumentFactories`. This adds extra
  parameters to generated `fromJson` and/or `toJson` functions to support
  encoding and decoding generic types.

  For example, the generated code for

  ```dart
  @JsonSerializable(genericArgumentFactories: true)
  class Response<T> {
    int status;
    T value;
  }
  ```

  Looks like

  ```dart
  Response<T> _$ResponseFromJson<T>(
    Map<String, dynamic> json,
    T Function(Object json) fromJsonT,
  ) {
    return Response<T>()
      ..status = json['status'] as int
      ..value = fromJsonT(json['value']);
  }

  Map<String, dynamic> _$ResponseToJson<T>(
    Response<T> instance,
    Object Function(T value) toJsonT,
  ) =>
      <String, dynamic>{
        'status': instance.status,
        'value': toJsonT(instance.value),
      };
  ```

- `JsonKey.unknownEnumValue`: Added support for `Iterable`, `List`, and `Set`.
- Require `package:analyzer` `>=0.39.0 <0.41.0`.

## 3.4.1

- Support properties where the getter is defined in a class with a corresponding
  setter in a super type.

## 3.4.0

- `JsonKey.defaultValue`
  - Added support for `double.infinity`, `double.negativeInfinity`, and
    `double.nan`.
  - Added support for `Set` literals.
- Require at least Dart `2.7.0`.

## 3.3.0

- Add support for fields annotated subclasses of `JsonKey`.
- Export the following `TypeHelper` implementations and interfaces in
  `package:json_serializable/type_helper.dart`:
  - `DurationHelper`
  - `TypeHelperContextWithConfig`

## 3.2.5

- Fix lint affecting `pub.dev` score.

## 3.2.4

- Require `package:analyzer` `^0.39.0`.

## 3.2.3

- Fixed bug related to `package:analyzer` 0.38.5.

## 3.2.2

- Support `JsonConverter` annotations on property getters

## 3.2.1

- Support `package:analyzer` `>=0.33.3 <0.39.0`

## 3.2.0

- Require `package:json_annotation` `^3.0.0`.
- Added support for `JsonSerializable.ignoreUnannotated`.
- Added support for `JsonKey.unknownEnumValue`.
- Small change to how `enum` support code is generated.
- Require at least Dart `2.3.0`.

## 3.1.0

- Support `Map` keys of type `int`, `BigInt`, `DateTime`, and `Uri`.
- Trailing commas are now added to generated constructor arguments and the
  elements in `Map` literals.
- Support `package:analyzer` `>=0.33.3 <0.38.0`

## 3.0.0

This release is entirely **BREAKING** changes. It removes underused features
that added disproportionate complexity to this package. This cleanup should ease
future feature work.

- Removed support for `JsonSerializable.useWrappers`.
- Removed support for `JsonSerializable.generateToJsonFunction`.
- Removed support for `encodeEmptyCollection`.
- If a field has a conversion function defined – either `JsonKey.toJson` or a
  custom `JsonConverter` annotation – don't intercept `null` values, even if
  `nullable` is explicitly set to `false`. This allows these functions to
  provide alternative values for `null` – such as an empty collection – which
  replaces the functionality provided by `encodeEmptyCollection`.
  - **NOTE: this is SILENTLY BREAKING.** There is no corresponding deprecation
    for this change. If you use converters, please make sure to test your code!

## 2.3.0

- Added `pascal` as an additional `fieldRename` option.

## 2.2.3

- Removed special handling of undefined types due to changes in
  `package:analyzer`. These types are now treated as `dynamic`.

## 2.2.2

- Require at least Dart `2.2.0`.
- Allow `build_config` `0.4.x`.

## 2.2.1

- Fixed an error when a property/field is defined in a `mixin`.

## 2.2.0

- If a field has a conversion function defined – either `JsonKey.toJson` or a
  custom `JsonConverter` annotation – handle the case where the function returns
  `null` and both `nullable` and `includeIfNull` are `false`.

## 2.1.2

- Support `package:json_annotation` `>=2.1.0 <2.3.0`.

## 2.1.1

- Support `package:analyzer` `>=0.33.3 <0.37.0`

## 2.1.0

- Require at least Dart `2.1.1`.

- Added support for `encodeEmptyCollection` on `JsonKey` and `JsonSerializable`.

- Added support for `BigInt`.

- Added `BigIntTypeHelper` to `type_helper.dart` library.

- Provide a more helpful error if the builder is improperly configured.

## 2.0.3

- When invoking a `fromJson` constructor on a field type, generate a conversion
  expression derived from the constructor parameter type.

- Be more strict about the supported `List`, `Set`, or `Map` types. This may
  cause errors to be raised in cases where invalid code was generated before. It
  also allows implementations of these types to add a `fromJson` constructor to
  support custom decoding.

- Small change to the whitespace around converted maps to improve a very slow
  path when formatting generated code.

## 2.0.2

- Log warnings when `JsonKey.defaultValue` is set with other fields.

  - With `toJson`: use `nullable: false` instead of `defaultValue`.
  - With both `disallowNullValue` and `required` set to `true`.

- Avoid no-op call to `map` when decoding a field of type `Set`.

- Support `package:analyzer` `>=0.33.3 <0.36.0`

## 2.0.1

- Support `package:analyzer` v0.34.0.

## 2.0.0

- Support all `build.yaml` configuration options on classes by adding a number
  of fields to `JsonSerializable`: `anyMap`, `checked`, `explicitToJson`,
  `generateToJsonFunction`, and `useWrappers`.

- Support decode/encode of `dart:core` `Duration`

- Code generated for fields and classes annotated with `JsonConverter` instances
  now properly handles nullable fields.

- Build configuration

  - You can now configure all settings exposed by the `JsonSerializable`
    annotation within `build.yaml`.

  - **BREAKING** Unsupported options defined in `build.yaml` will cause
    exceptions instead of being logged and ignored.

- `json_serializable.dart`

  - **BREAKING** `JsonSerializableGenerator` now exposes a `config` property of
    type `JsonSerializable` instead of individual properties for `checked`,
    `anyMay`, etc. This will affect creating or using this class via code.

- `type_helper.dart`

  - **BREAKING** `SerializeContext` and `DeserializeContext` have been replaced
    with new `TypeHelperContext` class.

  - `TypeHelper` now has a type argument allowing implementors to specify a
    specific implementation of `TypeHelperContext` for calls to `serialize` and
    `deserialize`. Many of the included `TypeHelper` implementations have been
    updated to indicate they expect more information from the source generator.

## 1.5.1

- Support the latest `package:analyzer`.

## 1.5.0

- Added support for `JsonConvert` annotation on fields.

## 1.4.0

- `type_helper.dart`

  - `TypeHelper` `serialize` and `deserialize` have return type `Object` instead
    of `String`. This allows coordination between instances to support more
    advanced features – like using the new `LambdaResult` class to avoid
    creating unnecessary lambdas. When creating `TypeHelper` implementations,
    handle non-`String` results by calling `toString()` on unrecognized values.

- Declare support for `package:build` version `1.x.x`.

## 1.3.0

- Add support for types annotated with classes that extend `JsonConverter` from
  `package:json_annotation`.

- Export the following `TypeHelper` implementations in
  `package:json_serializable/type_helper.dart`: `ConvertHelper`, `EnumHelper`,
  `IterableHelper`, `JsonConverterHelper`, `MapHelper`, `ValueHelper`

- Added support for `Set` type as a target.

## 1.2.1

- Added back `const` for maps generated with `checked: true` configuration.

## 1.2.0

- Now throws `InvalidGenerationSourceError` instead of `UnsupportedError` for
  some classes of constructor errors.

- Supports class-static functions for `toJson` and `fromJson` on `JsonKey`.

- Provide a warning about ignored setter-only properties instead of crashing.

- Added back `const` for lists generated with `disallowUnrecognizedKeys`,
  `required`, and `disallowNullValue`.

- Fixed a bug when `disallowUnrecognizedKeys` is enabled.

- Fixed a number of issues when dealing with inherited properties.

## 1.1.0

- Added support for automatically converting field names to JSON map keys as
  `kebab-case` or `snake_case` with a new option on the `JsonSerializable`
  annotation.

## 1.0.1

- Explicit `new` and `const` are no longer generated.

## 1.0.0

- Initial release

## 1.0.1

- Fix: generate list dynamic

- Fix: generate list with default value

## 1.0.2

- Fix: condition check is map and null
