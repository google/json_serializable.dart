An simple example of a Dart package using [json_serializable].

* `lib/example.dart`: A library configured with annotations – 
  `JsonSerializable` and `JsonLiteral` – to enable code generation.

  * Note: the annotations are defined in `package:json_annotation`.
    This is the only package required in the `dependencies` section of your
    `pubspec.yaml`.

* `tool/`: Contains the code run during development to create and update
  generated code.

  * `build_actions.dart`: A convention when using `package:build` to 
    have one location to define the actions to be run by `build.dart` and 
    `watch.dart`. See the comments in the source file for more information.

  * `build.dart`: Runs one build using the actions defined in
    `build_actions.dart`.

  * `watch.dart`: Starts a watcher that (re)runs the actions defined in
    `build_actions.dart` when files change.

[json_serializable]: https://pub.dartlang.org/packages/json_serializable
