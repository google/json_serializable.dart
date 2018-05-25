## 0.2.6

* Added `JsonKey.defaultValue`.

* Added helpers for deserialization of `enum` values.
  These functions starting with `$` are  referenced by generated code.
  They are not meant for direct use.

## 0.2.5

* Added `CheckedFromJsonException` which is thrown by code generated when
 `checked` is enabled in `json_serializable`.

* Added functions to support the `checked` generation option.
  These functions starting with `$` are referenced by generated code.
  They are not meant for direct use.

## 0.2.4

* Added `fromJson` and `toJson` fields to `JsonKey` class.

## 0.2.3

* Added `ignore` field to `JsonKey` class annotation

## 0.2.2

* Added a helper class – `$JsonMapWrapper` – and helper functions – `$wrapMap`, 
  `$wrapMapHandleNull`, `$wrapList`, and `$wrapListHandleNull` – to support
  the `useWrappers` option added to `JsonSerializableGenerator` in `v0.3.0` of
  `package:json_serializable`.

## 0.2.1

* `JsonSerializable` class annotation
  * Added `nullable` field.
  * Fixed doc comment.

## 0.2.0

* Moved annotation classes for `JsonSerializable` and `JsonLiteral`.
