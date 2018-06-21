// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart'
    show InheritanceManager;
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'decode_helper.dart';
import 'encoder_helper.dart';
import 'helper_core.dart';
import 'type_helper.dart';
import 'type_helpers/convert_helper.dart';
import 'type_helpers/date_time_helper.dart';
import 'type_helpers/enum_helper.dart';
import 'type_helpers/iterable_helper.dart';
import 'type_helpers/json_helper.dart';
import 'type_helpers/map_helper.dart';
import 'type_helpers/uri_helper.dart';
import 'type_helpers/value_helper.dart';
import 'utils.dart';

Iterable<TypeHelper> allHelpersImpl(JsonSerializableGenerator generator) =>
    generator._allHelpers;

class JsonSerializableGenerator
    extends GeneratorForAnnotation<JsonSerializable> {
  static const _coreHelpers = const [
    const IterableHelper(),
    const MapHelper(),
    const EnumHelper(),
    const ValueHelper()
  ];

  static const _defaultHelpers = const [
    const JsonHelper(),
    const DateTimeHelper(),
    const UriHelper()
  ];

  final List<TypeHelper> _typeHelpers;

  Iterable<TypeHelper> get _allHelpers => const <TypeHelper>[
        const ConvertHelper()
      ].followedBy(_typeHelpers).followedBy(_coreHelpers);

  /// If `true`, wrappers are used to minimize the number of
  /// [Map] and [List] instances created during serialization.
  ///
  /// This will increase the code size, but it may improve runtime performance,
  /// especially for large object graphs.
  final bool useWrappers;

  /// If `true`, [Map] types are *not* assumed to be [Map<String, dynamic>]
  /// – which is the default type of [Map] instances return by JSON decode in
  /// `dart:convert`.
  ///
  /// This will increase the code size, but allows [Map] types returned
  /// from other sources, such as `package:yaml`.
  ///
  /// *Note: in many cases the key values are still assumed to be [String]*.
  final bool anyMap;

  /// If `true`, generated `fromJson` functions include extra checks to validate
  /// proper deserialization of types.
  ///
  /// If an exception is thrown during deserialization, a
  /// [CheckedFromJsonException] is thrown.
  final bool checked;

  /// If `true`, generated `toJson` methods will explicitly call `toJson` on
  /// nested objects.
  ///
  /// When using JSON encoding support in `dart:convert`, `toJson` is
  /// automatically called on objects, so the default behavior
  /// (`explicitToJson: false`) is to omit the `toJson` call.
  ///
  /// Example of `explicitToJson: false` (default)
  ///
  /// ```dart
  /// Map<String, dynamic> toJson() => {'child': child};
  /// ```
  ///
  /// Example of `explicitToJson: true`
  ///
  /// ```dart
  /// Map<String, dynamic> toJson() => {'child': child?.toJson()};
  /// ```
  final bool explicitToJson;

  /// Controls how `toJson` functionality is generated for all types processed
  /// by this generator.
  ///
  /// If `false` (the default), a private `_$ClassNameSerializerMixin` class is
  /// created in the generated part file which contains a `toJson` method.
  ///
  /// Mix in this class to the source class:
  ///
  /// ```dart
  /// @JsonSerializable()
  /// class Example extends Object with _$ExampleSerializerMixin {
  ///   // ...
  /// }
  /// ```
  ///
  /// If `true`, then a top-level function is created that you can reference
  /// from your class.
  ///
  /// ```dart
  /// @JsonSerializable()
  /// class Example {
  ///   // ...
  ///   Map<String, dynamic> toJson() => _$ExampleToJson(this);
  /// }
  /// ```
  final bool generateToJsonFunction;

  /// Creates an instance of [JsonSerializableGenerator].
  ///
  /// If [typeHelpers] is not provided, three built-in helpers are used:
  /// [JsonHelper], [DateTimeHelper], and [UriHelper].
  const JsonSerializableGenerator({
    List<TypeHelper> typeHelpers,
    bool useWrappers = false,
    bool anyMap = false,
    bool checked = false,
    bool explicitToJson = false,
    bool generateToJsonFunction = false,
  })  : this.useWrappers = useWrappers ?? false,
        this.anyMap = anyMap ?? false,
        this.checked = checked ?? false,
        this.explicitToJson = explicitToJson ?? false,
        this.generateToJsonFunction = generateToJsonFunction ?? false,
        this._typeHelpers = typeHelpers ?? _defaultHelpers;

  /// Creates an instance of [JsonSerializableGenerator].
  ///
  /// [typeHelpers] provides a set of [TypeHelper] that will be used along with
  /// the built-in helpers:
  /// [JsonHelper], [DateTimeHelper], and [UriHelper].
  factory JsonSerializableGenerator.withDefaultHelpers(
    Iterable<TypeHelper> typeHelpers, {
    bool useWrappers = false,
    bool anyMap = false,
    bool checked = false,
    bool generateToJsonFunction = false,
  }) =>
      new JsonSerializableGenerator(
          useWrappers: useWrappers,
          anyMap: anyMap,
          checked: checked,
          generateToJsonFunction: generateToJsonFunction,
          typeHelpers:
              new List.unmodifiable(typeHelpers.followedBy(_defaultHelpers)));

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      var name = element.name;
      throw new InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the JsonSerializable annotation from `$name`.',
          element: element);
    }

    var classElement = element as ClassElement;
    var classAnnotation = valueForAnnotation(annotation);
    var helper = new _GeneratorHelper(this, classElement, classAnnotation);
    return helper._generate().join('\n\n');
  }
}

class _GeneratorHelper extends HelperCore with EncodeHelper, DecodeHelper {
  _GeneratorHelper(JsonSerializableGenerator generator, ClassElement element,
      JsonSerializable annotation)
      : super(generator, element, annotation);

  Iterable<String> _generate() sync* {
    var sortedFields = _createSortedFieldSet(element);

    // Used to keep track of why a field is ignored. Useful for providing
    // helpful errors when generating constructor calls that try to use one of
    // these fields.
    var unavailableReasons = <String, String>{};

    var accessibleFields = sortedFields.fold<Map<String, FieldElement>>(
        <String, FieldElement>{}, (map, field) {
      if (!field.isPublic) {
        unavailableReasons[field.name] = 'It is assigned to a private field.';
      } else if (jsonKeyFor(field).ignore) {
        unavailableReasons[field.name] = 'It is assigned to an ignored field.';
      } else {
        map[field.name] = field;
      }

      return map;
    });

    if (annotation.createFactory) {
      yield createFactory(accessibleFields, unavailableReasons);
    }

    var accessibleFieldSet = accessibleFields.values.toSet();

    // Check for duplicate JSON keys due to colliding annotations.
    // We do this now, since we have a final field list after any pruning done
    // by `_writeCtor`.
    accessibleFieldSet.fold(new Set<String>(), (Set<String> set, fe) {
      var jsonKey = nameAccess(fe);
      if (!set.add(jsonKey)) {
        throw new InvalidGenerationSourceError(
            'More than one field has the JSON key `$jsonKey`.',
            todo: 'Check the `JsonKey` annotations on fields.',
            element: fe);
      }
      return set;
    });

    if (annotation.createToJson) {
      yield* createToJson(accessibleFieldSet);
    }
  }
}

/// Returns a [Set] of all instance [FieldElement] items for [element] and
/// super classes, sorted first by their location in the inheritance hierarchy
/// (super first) and then by their location in the source file.
Set<FieldElement> _createSortedFieldSet(ClassElement element) {
  // Get all of the fields that need to be assigned
  // TODO: support overriding the field set with an annotation option
  var fieldsList = element.fields.where((e) => !e.isStatic).toList();

  var manager = new InheritanceManager(element.library);

  for (var v in manager.getMembersInheritedFromClasses(element).values) {
    assert(v is! FieldElement);
    if (_dartCoreObjectChecker.isExactly(v.enclosingElement)) {
      continue;
    }

    if (v is PropertyAccessorElement && v.variable is FieldElement) {
      fieldsList.add(v.variable as FieldElement);
    }
  }

  warnUndefinedElements(fieldsList);

  // Sort these in the order in which they appear in the class
  // Sadly, `classElement.fields` puts properties after fields
  fieldsList.sort(_sortByLocation);

  return fieldsList.toSet();
}

int _sortByLocation(FieldElement a, FieldElement b) {
  var checkerA = new TypeChecker.fromStatic(a.enclosingElement.type);

  if (!checkerA.isExactly(b.enclosingElement)) {
    // in this case, you want to prioritize the enclosingElement that is more
    // "super".

    if (checkerA.isSuperOf(b.enclosingElement)) {
      return -1;
    }

    var checkerB = new TypeChecker.fromStatic(b.enclosingElement.type);

    if (checkerB.isSuperOf(a.enclosingElement)) {
      return 1;
    }
  }

  /// Returns the offset of given field/property in its source file – with a
  /// preference for the getter if it's defined.
  int _offsetFor(FieldElement e) {
    if (e.getter != null && e.getter.nameOffset != e.nameOffset) {
      assert(e.nameOffset == -1);
      return e.getter.nameOffset;
    }
    return e.nameOffset;
  }

  return _offsetFor(a).compareTo(_offsetFor(b));
}

final _dartCoreObjectChecker = const TypeChecker.fromRuntime(Object);
