To use [package:json_serializable][json_serializable] in your package, add these
dependencies to your `pubspec.yaml`.

```yaml
dependencies:
  json_annotation: ^0.2.2

dev_dependencies:
  build_runner: ^0.6.1
  json_serializable: ^0.3.0
```

Next, create the scripts to run code generation. The [`tool`][tool] directory
contains the conventional layout of these scripts.

* [`build_actions.dart`][tool]: A convention when using `package:build` to 
  have one location to define the actions to be run by [`build.dart`][build] and 
  [`watch.dart`][watch]. See the comments in the source file for more
  information.

* [`build.dart`][build]: Runs one build using the actions defined in
  [`build_actions.dart`][build_actions].

* [`watch.dart`][watch]: Starts a watcher that (re)runs the actions defined in
  [`build_actions.dart`][build_actions] when files change.

Finally, annotate your code with classes defined in
[package:json_annotation][json_annotation].

* See [`lib/example.dart`][example] for an example of a file using these
  annotations.

* See [`lib/example.g.dart`][example_g] for the generated file.

Run the build script to update the generated code after you modify of of the
source files.

```console
> dart bin/build.dart
[INFO] BuildDefinition: Reading cached asset graph completed, took 54ms
[INFO] BuildDefinition: Checking for updates since last build completed, took 663ms
[INFO] Build: Running build completed, took 10ms
[INFO] Build: Caching finalized dependency graph completed, took 44ms
[INFO] Build: Succeeded after 68ms with 0 outputs
```

*NOTE*: If you're using Flutter, running a Dart script is a bit tricky. You can
find the Dart entry point at `$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart`.
You can determine `FLUTTER_ROOT` by looking at the first few lines of
`flutter doctor`.

```console
> flutter doctor
[✓] Flutter (on Mac OS X 10.12.6 16G1114, locale en-US, channel master)
    • Flutter at YOUR_FLUTTER_ROOT_HERE
    • Framework revision 235b64ed2f (13 hours ago), 2017-12-14 20:38:39 -0800
...
```

[tool]: tool
[build_actions]: tool/build_actions.dart
[build]: tool/build.dart
[watch]: tool/watch.dart
[example]: lib/example.dart
[example_g]: lib/example.g.dart
[json_annotation]: https://pub.dartlang.org/packages/json_annotation
[json_serializable]: https://pub.dartlang.org/packages/json_serializable
