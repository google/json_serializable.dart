[![Pub Package](https://img.shields.io/pub/v/json_serializable.svg)](https://pub.dev/packages/json_serializable)

Provides [Dart Build System] builders for handling JSON.

The builders generate code when they find members annotated with classes defined
in [package:json_annotation].

- To generate to/from JSON code for a class, annotate it with
  `@JsonSerializable`. You can provide arguments to `JsonSerializable` to
  configure the generated code. You can also customize individual fields by
  annotating them with `@JsonKey` and providing custom arguments. See the table
  below for details on the [annotation values](#annotation-values).

- To generate a Dart field with the contents of a file containing JSON, use the
  `JsonLiteral` annotation.

## Setup

To configure your project for the latest released version of,
`json_serializable` see the [example].

## Example

Given a library `example.dart` with an `Person` class annotated with
`@JsonSerializable()`:

<!-- REPLACE example.dart -->

Building creates the corresponding part `example.g.dart`:

<!-- REPLACE example.g.dart -->

# Running the code generator

Once you have added the annotations to your code you then need to run the code
generator to generate the missing `.g.dart` generated dart files.

With a Dart package, run `pub run build_runner build` in the package directory.

With a Flutter package, run `flutter pub run build_runner build` in your package
directory.

# Annotation values

The only annotation required to use this package is `@JsonSerializable`. When
applied to a class (in a correctly configured package), `toJson` and `fromJson`
code will be generated when you build. There are three ways to control how code
is generated:

1. Set properties on `@JsonSerializable`.
2. Add a `@JsonKey` annotation to a field and set properties there.
3. Add configuration to `build.yaml` – [see below](#build-configuration).

<!-- REPLACE api.md -->

> Note: every `JsonSerializable` field is configurable via `build.yaml` – see
> the table for the corresponding key. If you find you want all or most of your
> classes with the same configuration, it may be easier to specify values once
> in the YAML file. Values set explicitly on `@JsonSerializable` take precedence
> over settings in `build.yaml`.

> Note: There is some overlap between fields on `JsonKey` and
> `JsonSerializable`. In these cases, if a value is set explicitly via `JsonKey`
> it will take precedence over any value set on `JsonSerializable`.

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
