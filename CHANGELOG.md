## 0.2.0

* **BREAKING** Fail generation for types that are not a JSON primitive or that
  do not explicitly supports JSON serialization. 
  
* **BREAKING** Removed `can` methods from `TypeHelper`. Return `null` from
  `(de)serialize` if the provided type is not supported.
   
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
