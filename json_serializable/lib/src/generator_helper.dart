// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../type_helper.dart';
import 'decode_helper.dart';
import 'encoder_helper.dart';
import 'field_helpers.dart';
import 'helper_core.dart';
import 'schema_helper.dart';
import 'settings.dart';
import 'utils.dart';

class GeneratorHelper extends HelperCore
    with EncodeHelper, DecodeHelper, SchemaHelper {
  final Settings _generator;
  final _addedMembers = <String>{};

  GeneratorHelper(
    this._generator,
    ClassElement element,
    ConstantReader annotation,
  ) : super(
        element,
        mergeConfig(_generator.config, annotation, classElement: element),
      );

  @override
  void addMember(String memberContent) {
    if (memberContent.trim().isNotEmpty) {
      _addedMembers.add(memberContent);
    }
  }

  @override
  Iterable<TypeHelper> get allTypeHelpers => _generator.allHelpers;

  Iterable<Spec> generate() sync* {
    assert(_addedMembers.isEmpty);

    if (config.genericArgumentFactories && element.typeParameters.isEmpty) {
      log.warning(
        'The class `${element.displayName}` is annotated '
        'with `JsonSerializable` field `genericArgumentFactories: true`. '
        '`genericArgumentFactories: true` only affects classes with type '
        'parameters. For classes without type parameters, the option is '
        'ignored.',
      );
    }

    final result = _processFields();
    if (result.fromJsonMethod case final fromJsonMethod?) {
      yield fromJsonMethod;
    }

    final accessibleFieldSet = result.accessibleFields;

    if (config.createFieldMap) {
      yield createFieldMap(accessibleFieldSet);
    }

    if (config.createJsonKeys) {
      yield createJsonKeys(accessibleFieldSet);
    }

    if (config.createPerFieldToJson) {
      yield createPerFieldToJson(accessibleFieldSet);
    }

    if (config.createToJson) {
      yield createToJson(accessibleFieldSet);
    }

    if (config.createJsonSchema) {
      yield createJsonSchema();
    }

    for (final member in _addedMembers) {
      assert(member.trim().isNotEmpty);
      yield Code(member);
    }
  }

  ({Set<FieldElement> accessibleFields, Spec? fromJsonMethod})
  _processFields() {
    final sortedFields = createSortedFieldSet(element);

    final unavailableReasons = <String, String>{};

    final accessibleFieldsMap = sortedFields.fold<Map<String, FieldElement>>(
      <String, FieldElement>{},
      (map, field) {
        final jsonKey = jsonKeyFor(field);
        if (!field.isPublic && !jsonKey.explicitYesFromJson) {
          unavailableReasons[field.name!] =
              'It is assigned to a private field.';
        } else if (field.getter == null) {
          assert(field.setter != null);
          unavailableReasons[field.name!] =
              'Setter-only properties are not supported.';
          log.warning('Setters are ignored: ${element.name}.${field.name}');
        } else if (jsonKey.explicitNoFromJson) {
          unavailableReasons[field.name!] =
              'It is assigned to a field not meant to be used in fromJson.';
        } else {
          assert(!map.containsKey(field.name));
          map[field.name!] = field;
        }

        return map;
      },
    );

    var accessibleFieldSet = accessibleFieldsMap.values.toSet();
    Spec? fromJsonMethod;

    if (config.createFactory) {
      final createResult = createFactory(
        accessibleFieldsMap,
        unavailableReasons,
      );
      fromJsonMethod = createResult.method;

      final fieldsToUse = accessibleFieldsMap.entries
          .where((e) => createResult.usedFields.contains(e.key))
          .map((e) => e.value)
          .toList();

      for (var candidate in sortedFields.where(
        (element) =>
            jsonKeyFor(element).explicitYesToJson &&
            !fieldsToUse.contains(element),
      )) {
        fieldsToUse.add(candidate);
      }

      fieldsToUse.sort(
        (a, b) => sortedFields.indexOf(a).compareTo(sortedFields.indexOf(b)),
      );

      accessibleFieldSet = fieldsToUse.toSet();
    }

    accessibleFieldSet
      ..removeWhere((element) => jsonKeyFor(element).explicitNoToJson)
      ..fold(<String>{}, (Set<String> set, fe) {
        final jsonKey = nameAccess(fe);
        if (!set.add(jsonKey)) {
          throw InvalidGenerationSourceError(
            'More than one field has the JSON key for name "$jsonKey".',
            element: fe,
          );
        }
        return set;
      });

    return (
      accessibleFields: accessibleFieldSet,
      fromJsonMethod: fromJsonMethod,
    );
  }
}
