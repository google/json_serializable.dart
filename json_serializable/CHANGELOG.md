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
