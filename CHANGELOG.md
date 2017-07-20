## 0.1.0

* Split off from [source_gen](https://pub.dartlang.org/packages/source_gen).
* Add `/* unsafe */` comments to generated output likely to be unsafe.
* Support (de)serializing values in `Map`.
* Fix ordering of fields when they are initialized via constructor.
* Don't use static members when calculating fields to (de)serialize.
