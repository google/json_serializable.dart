## 0.6.0

* **BREAKING** By default, code generated to support `toJson` now creates
  a top-level function instead of a mixin. The default for the
  `generate_to_json_function` is now `true`. To opt-out of this change,
  set `generate_to_json_function` to `false`.

* Now supports changing the serialized values of enums using `JsonValue`.

  ```dart
  enum AutoApply {
    none,
    dependents,
    @JsonValue('all_packages')
    allPackages,
    @JsonValue('root_package')
    rootPackage
  }
  ```

* `JsonSerializableGenerator.generateForAnnotatedElement` now returns
  `Iterable<String>` instead of `String`.

* `SerializeContext` and `DeserializeContext` now have an `addMember` function
  which allows `TypeHelper` instances to add additional members when handling
  a field. This is useful for generating shared helpers, for instance.

## 0.5.8+1

* Support the Dart 2.0 stable release.

## 0.5.8

* Small fixes to support Dart 2 runtime semantics.

* Support serializing types provided by platform-specific libraries (such as
  Flutter) if they use custom convert functions.

## 0.5.7

* Added support for `JsonKey.required`.
  * When `true`, generated code throws a `MissingRequiredKeysException` if
    the key does not exist in the JSON map used to populate the annotated field.
  * Will be captured and wrapped in a `CheckedFromJsonException` if
    `checked` is enabled in `json_serializable`.

* Added `JsonKey.disallowNullValue`.
  * When `true`, generated code throws a `DisallowedNullValueException` if
  the corresponding keys exist in in the JSON map, but it's value is null.
  * Will be captured and wrapped in a `CheckedFromJsonException` if
    `checked` is enabled in `json_serializable`.

* Added support for `Uri` conversion.

* Added missing `checked` parameter to the
  `JsonSerializableGenerator.withDefaultHelpers` constructor.

* Added `explicit_to_json` configuration option.
  * See `JsonSerializableGenerator.explicitToJson` for details.

* Added `generate_to_json_function` configuration option.
  * See `JsonSerializableGenerator.generateToJsonFunction` for details.

## 0.5.6

* Added support for `JsonSerializable.disallowUnrecognizedKeys`.
  * Throws an `UnrecognizedKeysException` if it finds unrecognized keys in the
    JSON map used to populate the annotated field.
  * Will be captured and wrapped in a `CheckedFromJsonException` if
    `checked` is enabled in `json_serializable`.
* All `fromJson` constructors now use block syntax instead of fat arrows.

## 0.5.5

* Added support for `JsonKey.defaultValue`.

* `enum` deserialization now uses helpers provided by `json_annotation`.

* Small change to how nullable `Map` values are deserialized.

* Small whitespace changes to `JsonLiteral` generation to align with `dartfmt`.

* Improve detection of `toJson` and `fromJson` in nested types.

## 0.5.4+1

* Fixed a bug introduced in `0.5.4` in some cases where enum values are nested
  in collections.

## 0.5.4

* Add `checked` configuration option. If `true`, generated `fromJson` functions
  include extra checks to validate proper deserialization of types.

* Added `any_map` to configuration. Allows `fromJson` code to
  support dynamic `Map` instances that are not explicitly
  `Map<String, dynaimc>`.

* Added support for classes with type arguments.

* Use `Map.map` for more map conversions. Simplifies generated code and fixes
  a subtle issue when the `Map` key type is `dynamic` or `Object`.

## 0.5.3

* Require the latest version of `package:analyzer` - `v0.32.0`.

* If `JsonKey.fromJson` function parameter is `Iterable` or `Map` with type
   arguments of `dynamic` or `Object`, omit the arguments when generating a
   cast.
   `_myHelper(json['key'] as Map)` instead of
   `_myHelper(json['key'] as Map<dynamic, dynamic>)`.

* `JsonKey.fromJson`/`.toJson` now support functions with optional arguments.

## 0.5.2

* If `JsonKey.fromJson`/`toJson` are set, apply them before any custom
  or default `TypeHelper` instances. This allows custom `DateTime` parsing,
  by preempting the existing `DateTime` `TypeHelper`.

## 0.5.1

* Support new `fromJson` and `toJson` fields on `JsonKey`.

* Use `log` exposed by `package:build`. This requires end-users to have at least
  `package:build_runner` `^0.8.2`.

* Updated minimum `package:source_gen` dependency to `0.8.1` which includes
  improved error messages.

## 0.5.0

* **BREAKING** Removed deprecated support for `require_library_directive` /
  `requireLibraryDirective` in `build_runner` configuration.

* **BREAKING** Removed the deprecated `generators.dart` library.

* **BREAKING** Removed `jsonPartBuilder` function from public API.

* Support the latest `package:source_gen`.

* Private and ignored fields are now excluded when generating serialization and
  deserialization code by using `@JsonKey(ignore: true)`.

* Throw an exception if a private field or an ignored field is referenced by a
  required constructor argument.

* More comprehensive escaping of string literals.

### `package:json_serializable/type_helper.dart`

* **Breaking** The `nullable` parameter on `TypeHelper.serialize` and
  `.deserialize` has been removed. It is now exposed in `SerializeContext` and
   `DeserializeContext` abstract classes as a read-only property.

* **Potentially Breaking** The `metadata` property on `SerializeContext` and
  `DeserializeContext` is now readonly. This would potentially break code that
  extends these classes – which is not expected.

## 0.4.0

* **Potentially Breaking** Inherited fields are now processed and used
  when generating serialization and deserialization code. There is a possibility
  that the generated code may change in undesired ways for classes annotated for
  `v0.3`.

* Avoid unnecessary braces in string escapes.

* Use single quotes when generating code.

## 0.3.2

* The `require_library_directive` option now defaults to `false`.
  The option will be removed entirely in `0.4.0`.

## 0.3.1+2

* Support the latest version of the `analyzer` package.

## 0.3.1+1

* Expanded `package:build` support to allow version `0.12.0`.

## 0.3.1

* Add a `build.yaml` so the builder can be consumed by users of `build_runner`
  version 0.7.0.

* Now requires a Dart `2.0.0-dev` release.

## 0.3.0

* **NEW** top-level library `json_serializable.dart`.

  * Replaces now deprecated `generators.dart` to access
  `JsonSerializableGenerator` and `JsonLiteralGenerator`.

  * Adds the `jsonPartBuilder` function to make it easy to create a
    `PartBuilder`, without creating an explicit dependency on `source_gen`.

* **BREAKING** `UnsupportedTypeError` added a new required constructor argument:
  `reason`.

* **BREAKING** The deprecated `annotations.dart` library has been removed.
  Use `package:json_annotation` instead.

* **BREAKING** The arguments to `TypeHelper` `serialize` and `deserialize` have
  changed.
  * `SerializeContext` and `DeserializeContext` (new classes) are now passed
    instead of the `TypeHelperGenerator` typedef (which has been deleted).

* `JsonSerializableGenerator` now supports an optional `useWrappers` argument
  when generates and uses wrapper classes to (hopefully) improve the speed and
  memory usage of serialization – at the cost of more code.

  **NOTE**: `useWrappers` is not guaranteed to improve the performance of
  serialization. Benchmarking is recommended.

* Make `null` field handling smarter. If a field is classified as not
  `nullable`, then use this knowledge when generating serialization code –  even
  if `includeIfNull` is `false`.

## 0.2.5

* Throw an exception if a duplicate JSON key is detected.

* Support the `nullable` field on the `JsonSerializable` class annotation.

## 0.2.4+1

* Throw a more helpful error when a constructor is missing.

## 0.2.4

* Moved the annotations in `annotations.dart` to `package:json_annotations`.
  * Allows package authors to release code that has the corresponding
    annotations without requiring package users to inherit all of the transitive
    dependencies.

* Deprecated `annotations.dart`.

## 0.2.3

* Write out `toJson` methods more efficiently when the first fields written are
  not intercepted by the null-checking method.

## 0.2.2+1

* Simplify the serialization of `Map` instances when no conversion is required
  for `values`.

* Handle `int` literals in JSON being assigned to `double` fields.

## 0.2.2

* Enable support for `enum` values.
* Added `asConst` to `JsonLiteral`.
* Improved the handling of Dart-specific characters in JSON strings.

## 0.2.1

* Upgrade to `package:source_gen` v0.7.0

## 0.2.0+1

* When serializing classes that implement their own `fromJson` constructor,
  honor their constructor parameter type.

## 0.2.0

* **BREAKING** Types are now segmented into their own libraries.

  * `package:json_serializable/generators.dart` contains `Generator`
    implementations.

  * `package:json_serializable/annotations.dart` contains annotations.
    This library should be imported with your target classes.

  * `package:json_serializable/type_helpers.dart` contains `TypeHelper` classes
    and related helpers which allow custom generation for specific types.

* **BREAKING** Generation fails for types that are not a JSON primitive or that
  do not explicitly supports JSON serialization.

* **BREAKING** `TypeHelper`:

  * Removed `can` methods. Return `null` from `(de)serialize` if the provided
    type is not supported.

  * Added `(de)serializeNested` arguments to `(de)serialize` methods allowing
    generic types. This is how support for `Iterable`, `List`, and `Map`
    is implemented.

* **BREAKING** `JsonKey.jsonName` was renamed to `name` and is now a named
  parameter.

* Added support for optional, non-nullable fields.

* Added support for excluding `null` values when generating JSON.

* Eliminated all implicit casts in generated code. These would end up being
  runtime checks in most cases.

* Provide a helpful error when generation fails due to undefined types.

## 0.1.0+1

* Fix homepage in `pubspec.yaml`.

## 0.1.0

* Split off from [source_gen](https://pub.dartlang.org/packages/source_gen).

* Add `/* unsafe */` comments to generated output likely to be unsafe.

* Support (de)serializing values in `Map`.

* Fix ordering of fields when they are initialized via constructor.

* Don't use static members when calculating fields to (de)serialize.
