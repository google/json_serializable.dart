## 0.1.1

* Fail generation when undefined types are encountered.
  Throw a helpful error.

## 0.1.0+1

* Fix homepage in `pubspec.yaml`.

## 0.1.0

* Split off from [source_gen](https://pub.dartlang.org/packages/source_gen).
* Add `/* unsafe */` comments to generated output likely to be unsafe.
* Support (de)serializing values in `Map`.
* Fix ordering of fields when they are initialized via constructor.
* Don't use static members when calculating fields to (de)serialize.
