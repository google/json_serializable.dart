*This example assumes you're using a recent version of the Dart or Flutter SDK.*

* Dart: you need a [v2 pre-release](https://www.dartlang.org/dart-2).
* Flutter: at least 0.4.4 (May 11, 2018).

To use [package:json_serializable][json_serializable] in your package, add these
dependencies to your `pubspec.yaml`.

```yaml
dependencies:
  json_annotation: ^0.2.5

dev_dependencies:
  build_runner: ^0.8.9
  json_serializable: ^0.5.4
```

Annotate your code with classes defined in
[package:json_annotation][json_annotation].

* See [`lib/example.dart`][example] for an example of a file using these
  annotations.

* See [`lib/example.g.dart`][example_g] for the generated file.

If you would like to use a custom header, or enable the wrapper option, add a
[`build.yaml`][build_config] file and a default target.

Run `pub run build_runner build` to generate files into your source directory.

```console
> pub run build_runner build
[INFO] ensureBuildScript: Generating build script completed, took 368ms
[INFO] BuildDefinition: Reading cached asset graph completed, took 54ms
[INFO] BuildDefinition: Checking for updates since last build completed, took 663ms
[INFO] Build: Running build completed, took 10ms
[INFO] Build: Caching finalized dependency graph completed, took 44ms
[INFO] Build: Succeeded after 4687ms with 1 outputs
```

*NOTE*: If you're using Flutter, running a script from a Dart package is a bit
tricky. Replace `pub run` with `flutter packages pub run`.

[example]: lib/example.dart
[example_g]: lib/example.g.dart
[build_config]: build.yaml
[json_annotation]: https://pub.dartlang.org/packages/json_annotation
[json_serializable]: https://pub.dartlang.org/packages/json_serializable
