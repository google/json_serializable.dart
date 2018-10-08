// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'decode_helper.dart';
import 'encoder_helper.dart';
import 'field_helpers.dart';
import 'generator_config.dart';
import 'helper_core.dart';
import 'type_helper.dart';
import 'type_helpers/convert_helper.dart';
import 'type_helpers/date_time_helper.dart';
import 'type_helpers/duration_helper.dart';
import 'type_helpers/enum_helper.dart';
import 'type_helpers/iterable_helper.dart';
import 'type_helpers/json_converter_helper.dart';
import 'type_helpers/json_helper.dart';
import 'type_helpers/map_helper.dart';
import 'type_helpers/uri_helper.dart';
import 'type_helpers/value_helper.dart';
import 'utils.dart';

class JsonSerializableGenerator
    extends GeneratorForAnnotation<JsonSerializable> {
  static const _coreHelpers = <TypeHelper>[
    IterableHelper(),
    MapHelper(),
    EnumHelper(),
    ValueHelper(),
  ];

  static const _defaultHelpers = <TypeHelper>[
    JsonHelper(),
    DateTimeHelper(),
    UriHelper(),
    DurationHelper(),
  ];

  final List<TypeHelper> _typeHelpers;

  Iterable<TypeHelper> get _allHelpers => const <TypeHelper>[
        ConvertHelper(),
        JsonConverterHelper()
      ].followedBy(_typeHelpers).followedBy(_coreHelpers);

  final GeneratorConfig config;

  /// Creates an instance of [JsonSerializableGenerator].
  ///
  /// If [typeHelpers] is not provided, three built-in helpers are used:
  /// [JsonHelper], [DateTimeHelper], [DurationHelper] and [UriHelper].
  const JsonSerializableGenerator({
    GeneratorConfig config,
    List<TypeHelper> typeHelpers,
  })  : this.config = config ?? const GeneratorConfig(),
        this._typeHelpers = typeHelpers ?? _defaultHelpers;

  /// Creates an instance of [JsonSerializableGenerator].
  ///
  /// [typeHelpers] provides a set of [TypeHelper] that will be used along with
  /// the built-in helpers:
  /// [JsonHelper], [DateTimeHelper], [DurationHelper] and [UriHelper].
  factory JsonSerializableGenerator.withDefaultHelpers(
          Iterable<TypeHelper> typeHelpers,
          {GeneratorConfig config}) =>
      JsonSerializableGenerator(
          config: config,
          typeHelpers:
              List.unmodifiable(typeHelpers.followedBy(_defaultHelpers)));

  @override
  Iterable<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      final name = element.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the JsonSerializable annotation from `$name`.',
          element: element);
    }

    final classElement = element as ClassElement;
    final classAnnotation = valueForAnnotation(annotation);
    final helper = _GeneratorHelper(this, classElement, classAnnotation);
    return helper._generate();
  }
}

class _GeneratorHelper extends HelperCore with EncodeHelper, DecodeHelper {
  _GeneratorHelper(JsonSerializableGenerator generator, ClassElement element,
      JsonSerializable annotation)
      : super(generator, element, annotation);

  final _addedMembers = Set<String>();

  @override
  void addMember(String memberContent) {
    _addedMembers.add(memberContent);
  }

  @override
  Iterable<TypeHelper> get allTypeHelpers => generator._allHelpers;

  Iterable<String> _generate() sync* {
    assert(_addedMembers.isEmpty);
    final sortedFields = createSortedFieldSet(element);

    // Used to keep track of why a field is ignored. Useful for providing
    // helpful errors when generating constructor calls that try to use one of
    // these fields.
    final unavailableReasons = <String, String>{};

    final accessibleFields = sortedFields.fold<Map<String, FieldElement>>(
        <String, FieldElement>{}, (map, field) {
      if (!field.isPublic) {
        unavailableReasons[field.name] = 'It is assigned to a private field.';
      } else if (field.getter == null) {
        assert(field.setter != null);
        unavailableReasons[field.name] =
            'Setter-only properties are not supported.';
        log.warning('Setters are ignored: ${element.name}.${field.name}');
      } else if (jsonKeyFor(field).ignore) {
        unavailableReasons[field.name] = 'It is assigned to an ignored field.';
      } else {
        assert(!map.containsKey(field.name));
        map[field.name] = field;
      }

      return map;
    });

    var accessibleFieldSet = accessibleFields.values.toSet();
    if (annotation.createFactory) {
      final createResult = createFactory(accessibleFields, unavailableReasons);
      yield createResult.output;

      accessibleFieldSet = accessibleFields.entries
          .where((e) => createResult.usedFields.contains(e.key))
          .map((e) => e.value)
          .toSet();
    }

    // Check for duplicate JSON keys due to colliding annotations.
    // We do this now, since we have a final field list after any pruning done
    // by `_writeCtor`.
    accessibleFieldSet.fold(Set<String>(), (Set<String> set, fe) {
      final jsonKey = nameAccess(fe);
      if (!set.add(jsonKey)) {
        throw InvalidGenerationSourceError(
            'More than one field has the JSON key `$jsonKey`.',
            todo: 'Check the `JsonKey` annotations on fields.',
            element: fe);
      }
      return set;
    });

    if (annotation.createToJson) {
      yield* createToJson(accessibleFieldSet);
    }

    yield* _addedMembers;
  }
}
