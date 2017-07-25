## 0.2.0

* **BREAKING** Types are now segmented into their own libraries.

  * `package:json_serializable/generators.dart` contains the `Generator` 
    implementations.

  * `package:json_serializable/annotations.dart` contains the annotations.
    This library should be imported with your target classes.

  * `package:json_serializable/type_helpers.dart` contains `TypeHelper` classes
    which allows custom generation for specific types. 

* **BREAKING** Fail generation for types that are not a JSON primitive or that
  do not explicitly supports JSON serialization. 

* **BREAKING** `TypeHelper`:

  * Removed `can` methods. Return `null` from `(de)serialize` if the provided
    type is not supported.

  * Added `(de)serializeNested` arguments to `(de)serialize` methods allowing
    generic types. This is (now) how support for `Iterable`, `List`, and `Map`
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
