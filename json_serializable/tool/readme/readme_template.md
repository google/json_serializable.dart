[![Pub Package](https://img.shields.io/pub/v/json_serializable.svg)](https://pub.dev/packages/json_serializable)

Provides [Dart Build System] builders for handling JSON.

The builders generate code when they find members annotated with classes defined
in [package:json_annotation].

- To generate to/from JSON code for a class, annotate it with
  `ja:JsonSerializable`. You can provide arguments to `ja:JsonSerializable` to
  configure the generated code. You can also customize individual fields by
  annotating them with `ja:JsonKey` and providing custom arguments. See the
  table below for details on the [annotation values](#annotation-values).

- To generate a Dart field with the contents of a file containing JSON, use the
  `ja:JsonLiteral` annotation.

## Setup

To configure your project for the latest released version of
`json_serializable`, see the [example].

## Example

Given a library `example.dart` with an `Person` class annotated with
`ja:JsonSerializable`:

<!-- REPLACE example/example.dart -->

Building creates the corresponding part `example.g.dart`:

<!-- REPLACE example/example.g.dart -->

# Running the code generator

Once you have added the annotations to your code you then need to run the code
generator to generate the missing `.g.dart` generated dart files.

With a Dart package, run `dart run build_runner build` in the package directory.

With a Flutter package, run `flutter pub run build_runner build` in your package
directory.

# Annotation values

The only annotation required to use this package is `ja:JsonSerializable`. When
applied to a class (in a correctly configured package), `toJson` and `fromJson`
code will be generated when you build. There are three ways to control how code
is generated:

1. Setting properties on `ja:JsonKey` annotating the target field.
1. Set properties on `ja:JsonSerializable` annotating the target type.
1. Add configuration to `build.yaml` – [see below](#build-configuration).

Every `ja:JsonSerializable` field is configurable via `build.yaml`. If you find
you want all or most of your classes with the same configuration, it may be
easier to specify values once in the YAML file. Values set explicitly on
`ja:JsonSerializable` take precedence over settings in `build.yaml`.

There is some overlap between settings on `ja:JsonKey` and
`ja:JsonSerializable`. In these cases, the property on `ja:JsonKey` takes
precedence over any value set on `ja:JsonSerializable`.

<!-- TODO: add an example! -->

## Enums

Annotate `enum` types with `ja:JsonEnum` (new in `json_annotation` 4.2.0) to:

1. Specify the default rename logic for each enum value using `fieldRename`. For
   instance, use `fieldRename: FieldRename.kebab` to encode `enum` value
   `noGood` as `"no-good"`.
1. Force the generation of the `enum` helpers, even if the `enum` is not
   referenced in code. This is an edge scenario, but useful for some.

Annotate `enum` values with `ja:JsonValue` to specify the encoded value to map
to target `enum` entries. Values can be of type `core:String` or `core:int`.

<!-- REPLACE tool/readme/readme_examples.dart-simple_example -->

If you are annotating an
[enhanced enum](https://dart.dev/guides/language/language-tour#declaring-enhanced-enums),
you can use `ja:JsonEnum.valueField` to specify the field to use for the
serialized value.

<!-- REPLACE tool/readme/readme_examples.dart-enhanced_example -->

# Supported types

Out of the box, `json_serializable` supports many common types in the
[dart:core](https://api.dart.dev/stable/dart-core/dart-core-library.html)
library: 
<!-- REPLACE supported_types -->

The collection types –
<!-- REPLACE collection_types -->
– can contain values of all the above types.

For `core:Map`, the key value must be one of
<!-- REPLACE map_key_types -->

# Custom types and custom encoding

If you want to use types that are not supported out-of-the-box or if you want to
customize the encoding/decoding of any type, you have a few options.

1. If you own/control the desired type, add a `fromJson` constructor and/or a
   `toJson()` function to the type. Note: while you can use `json_serializable`
   for these types, you don't have to! The generator code only looks for these
   methods. It doesn't care how they were created.

    <!-- REPLACE tool/readme/readme_examples.dart-to_from -->

1. Use the `ja:JsonKey.toJson` and `ja:JsonKey.fromJson` properties to specify
   custom conversions on the annotated field. The functions specified must be
   top-level or static. See the documentation of these properties for details.

    <!-- REPLACE tool/readme/readme_examples.dart-json_key -->

1. Create an implementation of `ja:JsonConverter` and annotate either the
   corresponding field or the containing class. `ja:JsonConverter` is convenient
   if you want to use the same conversion logic on many fields. It also allows
   you to support a type within collections. Check out
   [these examples](https://github.com/google/json_serializable.dart/blob/master/example/lib/json_converter_example.dart).

    <!-- REPLACE tool/readme/readme_examples.dart-json_converter -->

# Build configuration

Aside from setting arguments on the associated annotation classes, you can also
configure code generation by setting values in `build.yaml`.

```yaml
targets:
  $default:
    builders:
      json_serializable:
        options:
          # Options configure how source code is generated for every
          # `@JsonSerializable`-annotated class in the package.
          #
          # The default value for each is listed.
          any_map: false
          checked: false
          constructor: ""
          create_factory: true
          create_field_map: false
          create_per_field_to_json: false
          create_to_json: true
          disallow_unrecognized_keys: false
          explicit_to_json: false
          field_rename: none
          generic_argument_factories: false
          ignore_unannotated: false
          include_if_null: true
```

[example]: https://github.com/google/json_serializable.dart/tree/master/example
[dart build system]: https://github.com/dart-lang/build
[package:json_annotation]: https://pub.dev/packages/json_annotation
