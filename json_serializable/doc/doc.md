<h2>JsonSerializable</h2>
<dl>
  <dt><code><a name="JsonSerializable-anyMap">JsonSerializable.anyMap</a></code></dt>
  <dd>

`build.yaml` config key: `any_map`

If `true`, `Map` types are *not* assumed to be `Map<String, dynamic>`
– which is the default type of `Map` instances return by JSON decode in
`dart:convert`.

This will increase the code size, but allows `Map` types returned
from other sources, such as `package:yaml`.

*Note: in many cases the key values are still assumed to be `String`*.
  </dd>
  <dt><code><a name="JsonSerializable-checked">JsonSerializable.checked</a></code></dt>
  <dd>

`build.yaml` config key: `checked`

If `true`, generated `fromJson` functions include extra checks to validate
proper deserialization of types.

If an exception is thrown during deserialization, a
`CheckedFromJsonException` is thrown.
  </dd>
  <dt><code><a name="JsonSerializable-createFactory">JsonSerializable.createFactory</a></code></dt>
  <dd>

`build.yaml` config key: `create_factory`

If `true` (the default), a private, static `_$ExampleFromJson` method
is created in the generated part file.

Call this method from a factory constructor added to the source class:

```dart
@JsonSerializable()
class Example {
  // ...
  factory Example.fromJson(Map<String, dynamic> json) =>
    _$ExampleFromJson(json);
}
```
  </dd>
  <dt><code><a name="JsonSerializable-createToJson">JsonSerializable.createToJson</a></code></dt>
  <dd>

`build.yaml` config key: `create_to_json`

If `true` (the default), code for encoding JSON is generated for this
class.

By default, a private `_$ClassNameMixin` class is created
in the generated part file which contains a `toJson` method.

Mix in this class to the source class:

```dart
@JsonSerializable()
class Example extends Object with _$ExampleSerializerMixin {
  // ...
}
```

If `json_serializable` is configured with
`generate_to_json_function: true`, then a top-level function is created
that you can reference from your class.

```dart
@JsonSerializable()
class Example {
  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
```
  </dd>
  <dt><code><a name="JsonSerializable-disallowUnrecognizedKeys">JsonSerializable.disallowUnrecognizedKeys</a></code></dt>
  <dd>

`build.yaml` config key: `disallow_unrecognized_keys`

If `false` (the default), then any unrecognized keys passed to the
generated FromJson factory will be ignored.

If `true`, any unrecognized keys will be treated as an error.
  </dd>
  <dt><code><a name="JsonSerializable-encodeEmptyCollection">JsonSerializable.encodeEmptyCollection</a></code></dt>
  <dd>

`build.yaml` config key: `encode_empty_collection`

Whether the generator should include empty collection field values in the
serialized output.

If `true` (the default), empty collection fields
(of type `Iterable`, `Set`, `List`, and `Map`)
are included in generated `toJson` functions.

If `false`, fields with empty collections are omitted from `toJson`.

Note: setting this property to `false` overrides the [`JsonSerializable.includeIfNull`](#JsonSerializable-includeIfNull)
value to `false` as well.

This value has no effect on non-collection fields.
  </dd>
  <dt><code><a name="JsonSerializable-explicitToJson">JsonSerializable.explicitToJson</a></code></dt>
  <dd>

`build.yaml` config key: `explicit_to_json`

If `true`, generated `toJson` methods will explicitly call `toJson` on
nested objects.

When using JSON encoding support in `dart:convert`, `toJson` is
automatically called on objects, so the default behavior
(`explicitToJson: false`) is to omit the `toJson` call.

Example of `explicitToJson: false` (default)

```dart
Map<String, dynamic> toJson() => {'child': child};
```

Example of `explicitToJson: true`

```dart
Map<String, dynamic> toJson() => {'child': child?.toJson()};
```
  </dd>
  <dt><code><a name="JsonSerializable-fieldRename">JsonSerializable.fieldRename</a></code></dt>
  <dd>

`build.yaml` config key: `field_rename`

Defines the automatic naming strategy when converting class field names
into JSON map keys.

With a value `FieldRename.none`, the default, the name of the field is
used without modification.

See `FieldRename` for details on the other options.

Note: the value for [`JsonKey.name`](#JsonKey-name) takes precedence over this option for
fields annotated with `JsonKey`.
  </dd>
  <dt><code><a name="JsonSerializable-generateToJsonFunction">JsonSerializable.generateToJsonFunction</a></code></dt>
  <dd>

`build.yaml` config key: `generate_to_json_function`

Controls how `toJson` functionality is generated for all types processed
by this generator.

If `true` (the default), then a top-level function is created that you can
reference from your class.

```dart
@JsonSerializable()
class Example {
  // ...
  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
```

If `false`, a private `_$ClassNameSerializerMixin` class is
created in the generated part file which contains a `toJson` method.

Mix in this class to the source class:

```dart
@JsonSerializable()
class Example extends Object with _$ExampleSerializerMixin {
  // ...
}
```
  </dd>
  <dt><code><a name="JsonSerializable-includeIfNull">JsonSerializable.includeIfNull</a></code></dt>
  <dd>

`build.yaml` config key: `include_if_null`

Whether the generator should include fields with `null` values in the
serialized output.

If `true` (the default), all fields are written to JSON, even if they are
`null`.

If a field is annotated with `JsonKey` with a non-`null` value for
`includeIfNull`, that value takes precedent.
  </dd>
  <dt><code><a name="JsonSerializable-nullable">JsonSerializable.nullable</a></code></dt>
  <dd>

`build.yaml` config key: `nullable`

When `true` (the default), `null` values are handled gracefully when
serializing to JSON and when deserializing `null` and nonexistent values
from a JSON map.

Setting to `false` eliminates `null` verification in the generated code,
which reduces the code size. Errors may be thrown at runtime if `null`
values are encountered, but the original class should also implement
`null` runtime validation if it's critical.
  </dd>
  <dt><code><a name="JsonSerializable-useWrappers">JsonSerializable.useWrappers</a></code></dt>
  <dd>

`build.yaml` config key: `use_wrappers`

If `true`, wrappers are used to minimize the number of
`Map` and `List` instances created during serialization.

This will increase the code size, but it may improve runtime performance,
especially for large object graphs.
  </dd>
</dl>
<h2>JsonKey</h2>
<dl>
  <dt><code><a name="JsonKey-defaultValue">JsonKey.defaultValue</a></code></dt>
  <dd>

The value to use if the source JSON does not contain this key or if the
value is `null`.
  </dd>
  <dt><code><a name="JsonKey-disallowNullValue">JsonKey.disallowNullValue</a></code></dt>
  <dd>

If `true`, generated code will throw a `DisallowedNullValueException` if
the corresponding key exits, but the value is `null`.

Note: this value does not affect the behavior of a JSON map *without* the
associated key.

If [`JsonKey.disallowNullValue`](#JsonKey-disallowNullValue) is `true`, [`JsonKey.includeIfNull`](#JsonKey-includeIfNull) will be treated as
`false` to ensure compatibility between `toJson` and `fromJson`.

If both [`JsonKey.includeIfNull`](#JsonKey-includeIfNull) and [`JsonKey.disallowNullValue`](#JsonKey-disallowNullValue) are set to `true` on the
same field, an exception will be thrown during code generation.
  </dd>
  <dt><code><a name="JsonKey-encodeEmptyCollection">JsonKey.encodeEmptyCollection</a></code></dt>
  <dd>

Whether the generator should include the annotated field value in the
serialized output if it is empty.

If `true` (the default), empty values are included in the generated
`toJson` function.

If `false`, fields with empty collections are omitted from `toJson`.

Note: setting this property to `false` overrides the [`JsonKey.includeIfNull`](#JsonKey-includeIfNull)
value to `false` as well. Explicitly setting [`JsonKey.includeIfNull`](#JsonKey-includeIfNull) to `true`
and setting this property to `false` will cause an error at build time.

Note: setting this property to `false` on a non-collection field
(of types other than `Iterable`, `Set`, `List`, and `Map`)
will cause an error at build time.
  </dd>
  <dt><code><a name="JsonKey-fromJson">JsonKey.fromJson</a></code></dt>
  <dd>

A top-level `Function` to use when deserializing the associated JSON
value to the annotated field.

The `Function` should take one argument that maps to the expected JSON
value and return a value that can be assigned to the type of the annotated
field.

When creating a class that supports both `toJson` and `fromJson`
(the default), you should also set [`JsonKey.toJson`](#JsonKey-toJson) if you set [`JsonKey.fromJson`](#JsonKey-fromJson).
Values returned by [`JsonKey.toJson`](#JsonKey-toJson) should "round-trip" through [`JsonKey.fromJson`](#JsonKey-fromJson).
  </dd>
  <dt><code><a name="JsonKey-ignore">JsonKey.ignore</a></code></dt>
  <dd>

`true` if the generator should ignore this field completely.

If `null` (the default) or `false`, the field will be considered for
serialization.
  </dd>
  <dt><code><a name="JsonKey-includeIfNull">JsonKey.includeIfNull</a></code></dt>
  <dd>

Whether the generator should include fields with `null` values in the
serialized output.

If `true`, the generator should include the field in the serialized
output, even if the value is `null`.

The default value, `null`, indicates that the behavior should be
acquired from the [`JsonSerializable.includeIfNull`](#JsonSerializable-includeIfNull) annotation on the
enclosing class.

If [`JsonKey.disallowNullValue`](#JsonKey-disallowNullValue) is `true`, this value is treated as `false` to
ensure compatibility between `toJson` and `fromJson`.

If both [`JsonKey.includeIfNull`](#JsonKey-includeIfNull) and [`JsonKey.disallowNullValue`](#JsonKey-disallowNullValue) are set to `true` on the
same field, an exception will be thrown during code generation.
  </dd>
  <dt><code><a name="JsonKey-name">JsonKey.name</a></code></dt>
  <dd>

The key in a JSON map to use when reading and writing values corresponding
to the annotated fields.

If `null`, the field name is used.
  </dd>
  <dt><code><a name="JsonKey-nullable">JsonKey.nullable</a></code></dt>
  <dd>

When `true`, `null` values are handled gracefully when serializing to JSON
and when deserializing `null` and nonexistent values from a JSON map.

Setting to `false` eliminates `null` verification in the generated code
for the annotated field, which reduces the code size. Errors may be thrown
at runtime if `null` values are encountered, but the original class should
also implement `null` runtime validation if it's critical.

The default value, `null`, indicates that the behavior should be
acquired from the [`JsonSerializable.nullable`](#JsonSerializable-nullable) annotation on the
enclosing class.
  </dd>
  <dt><code><a name="JsonKey-required">JsonKey.required</a></code></dt>
  <dd>

When `true`, generated code for `fromJson` will verify that the source
JSON map contains the associated key.

If the key does not exist, a `MissingRequiredKeysException` exception is
thrown.

Note: only the existence of the key is checked. A key with a `null` value
is considered valid.
  </dd>
  <dt><code><a name="JsonKey-toJson">JsonKey.toJson</a></code></dt>
  <dd>

A top-level `Function` to use when serializing the annotated field to
JSON.

The `Function` should take one argument that is compatible with the field
being serialized and return a JSON-compatible value.

When creating a class that supports both `toJson` and `fromJson`
(the default), you should also set [`JsonKey.fromJson`](#JsonKey-fromJson) if you set [`JsonKey.toJson`](#JsonKey-toJson).
Values returned by [`JsonKey.toJson`](#JsonKey-toJson) should "round-trip" through [`JsonKey.fromJson`](#JsonKey-fromJson).
  </dd>
</dl>
