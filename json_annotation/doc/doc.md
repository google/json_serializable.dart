# fields

| Field | JsonSerializable | JsonKey | Description |
| --- | :---: | :---: | --- |
| `anyMap` | ✓ |  | If `true`, `Map` types are *not* assumed to be `Map<String, dynamic>` – which is the default type of `Map` instances return by JSON decode in `dart:convert`. |
| `checked` | ✓ |  | If `true`, generated `fromJson` functions include extra checks to validate proper deserialization of types. |
| `createFactory` | ✓ |  | If `true`, a private, static `_$ExampleFromJson` method is created in the generated part file. |
| `createToJson` | ✓ |  | If `true`, code for decoding JSON is generated fon this class. |
| `disallowUnrecognizedKeys` | ✓ |  | If `false`, then any unrecognized keys passed to the generated FromJson factory will be ignored. |
| `explicitToJson` | ✓ |  | If `true`, generated `toJson` methods will explicitly call `toJson` on nested objects. |
| `fieldRename` | ✓ |  | Defines the automatic naming strategy when converting class field names into JSON map keys. |
| `generateToJsonFunction` | ✓ |  | Controls how `toJson` functionality is generated for all types processed by this generator. |
| `includeIfNull` | ✓ | ✓ | Whether the generator should include fields with `null` values in the serialized output. |
| `nullable` | ✓ | ✓ | When `true`, `null` values are handled gracefully when serializing to JSON and when deserializing `null` and nonexistent values from a JSON map. |
| `useWrappers` | ✓ |  | If `true`, wrappers are used to minimize the number of `Map` and `List` instances created during serialization. |
| `name` |  | ✓ | The key in a JSON map to use when reading and writing values corresponding to the annotated fields. |
| `ignore` |  | ✓ | `true` if the generator should ignore this field completely. |
| `fromJson` |  | ✓ | A top-level `Function` to use when deserializing the associated JSON value to the annotated field. |
| `toJson` |  | ✓ | A top-level `Function` to use when serializing the annotated field to JSON. |
| `defaultValue` |  | ✓ | The value to use if the source JSON does not contain this key or if the value is `null`. |
| `required` |  | ✓ | When `true`, generated code for `fromJson` will verify that the source JSON map contains the associated key. |
| `disallowNullValue` |  | ✓ | If `true`, generated code will throw a `DisallowedNullValueException` if the corresponding key exits, but the value is `null`. |
