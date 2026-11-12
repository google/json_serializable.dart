# `package:js_codable` (Prototype)

Generates standalone `.js_codable.dart` libraries containing zero-copy
`dart:js_interop` extension types and `Dart <-> JS` converters for
`@JsonSerializable` classes.

Because `.js_codable.dart` is generated as a standalone library rather than a
`part` file, your domain models remain 100% pure Dart (with zero
`dart:js_interop` imports) and compile on the Dart VM, `dart2js`, and
`dart2wasm`.

## Example

Given a pure-Dart model library `models.dart`:

```dart
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Person {
  final String firstName;
  final int? age;

  Person({required this.firstName, this.age});
}
```

`js_codable` generates `models.js_codable.dart`:

```dart
import 'dart:js_interop';
import 'models.dart';

extension type const PersonJS._(JSObject _) implements JSObject {
  external factory PersonJS({
    @JS('first_name') required String firstName,
    int? age,
  });

  factory PersonJS.fromDart(Person instance) => $PersonToJs(instance);

  @JS('first_name')
  external String get firstName;

  external int? get age;

  Person toDart() => $PersonFromJs(this);
}

extension PersonJsCodableExtension on Person {
  PersonJS toJs() => $PersonToJs(this);
}

Person $PersonFromJs(PersonJS js) =>
    Person(firstName: js.firstName, age: js.age);

PersonJS $PersonToJs(Person instance) =>
    PersonJS(firstName: instance.firstName, age: instance.age);
```

## Known Limitations & Prototype Gaps (vs. `json_serializable`)

### Hard JS & Standalone-Library Constraints

- **Public declarations only**: Because `.js_codable.dart` is a separate library
  (keeping `models.dart` free of `dart:js_interop`), private classes
  (`_Person`), private constructors (`Person._()`), private
  fields/getters/setters, and private `@JsonKey(fromJson: _parse)` or
  `_CustomConverter` symbols cannot be accessed and are rejected at build time.
- **No `genericArgumentFactories: true`**: `dart:js_interop` requires type
  parameters on `extension type` external members to be bounded by `JSAny?`
  (boxed `JSString` / `JSNumber`, not Dart `String` / `int`), and `external`
  getters cannot invoke runtime `T Function(Object?) fromJsonT` callbacks.
- **JavaScript `Number` semantics (`int` vs. `double` and 53-bit precision)**:
  JS `Number` is an IEEE-754 double limited to safe integers within
  `+/-(2^53 - 1)`. In addition, on `dart2wasm`, `.dartify()` converts all JS
  numbers to Dart `double`, so custom `JsonConverter`s or `fromJson` functions
  taking `Map<String, dynamic>` receive `double` for integer JSON values where
  VM `jsonDecode` produces `int`.
- **`null` vs. `undefined` coalescing on `external` getters**: Reading a missing
  JS property (`undefined`) and reading `{key: null}` through
  `external T? get key` both evaluate to Dart `null`.

### Current Prototype Gaps (Possible Future Enhancements)

- **True key omission for `includeIfNull: false`**: Passing `key: null` to a
  static `external factory` object-literal constructor still emits `{key: null}`
  on the underlying JS object in `dart2js` and `dart2wasm`. Omitting `null` keys
  when `includeIfNull: false` could be supported by constructing an empty
  `JSObject()` (or an `external factory` with only required non-nullable fields)
  and conditionally invoking setters when nullable fields are non-null.
- **Unannotated classes with `.toJson()` / `fromJson()`**: `json_serializable`
  falls back to calling `.toJson()` and `Type.fromJson(...)` on arbitrary types
  that are not annotated with `@JsonSerializable`. Currently, `js_codable`
  requires nested classes either to be annotated with `@JsonSerializable` (so
  `<Type>JS` exists) or to use a `JsonConverter`; unannotated classes could be
  auto-bridged via `.jsify()` / `.dartify()`.
- **`Map`-centric `@JsonKey` / `@JsonSerializable` validation & hooks**:
  - `@JsonKey(readValue: ...)` expects `Object? Function(Map, String)`, which
    would require either `.dartify()`ing the full `JSObject` into a `Map` or a
    JS-specific `JSAny? Function(JSObject, String)` hook.
  - `@JsonSerializable(disallowUnrecognizedKeys: true)`,
    `@JsonKey(required: true)`, `@JsonKey(disallowNullValue: true)`, and
    `@JsonSerializable(checked: true)` are not yet wired up; these could be
    implemented using `Object.keys(js)`, `js.hasProperty(...)` from
    `dart:js_interop_unsafe`, and per-field `try`/`catch` wrappers.
- **Custom JS class bindings via a pure-Dart `@JsCodable(...)` annotation**:
  Currently, `js_codable` always emits a named-parameter `external factory` with
  no class-level `@JS(...)` binding, producing and consuming plain `{...}` JS
  object literals (`Object.prototype`). Because `models.dart` cannot import
  `@JS(...)` from `dart:js_interop` without breaking Dart VM compatibility, a
  pure-Dart annotation (in a lightweight annotation package or
  `package:json_annotation`) could configure:
  - `jsName` + constructor strategy (e.g., positional `new Person(...)`,
    zero-arg `new Person()` with setter cascades, or options-object
    `new Person({...})`), which also unlocks `js.isA<PersonJS>()` (`instanceof`)
    checks in `dart:js_interop`.
  - `typeName` to override the generated Dart extension type identifier
    (`PersonJS`).
  - `existingJsType` to generate `$PersonFromJs` / `$PersonToJs` against an
    existing hand-written or `js_interop_gen`-generated extension type instead
    of emitting a duplicate `PersonJS`.
