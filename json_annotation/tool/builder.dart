import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder docBuilder([_]) => _DocBuilder();

final _ref = RegExp('\\[([^\\]]+)\\]');

class _FieldInfo implements Comparable<_FieldInfo> {
  final FieldElement field;

  ClassElement get owner => field.enclosingElement;

  String get description {
    var description = LineSplitter.split(field.documentationComment)
        .map((line) {
          if (line.startsWith('///')) {
            line = line.substring(3).trim();
          }
          return line;
        })
        .takeWhile((line) => line.isNotEmpty)
        .join(' ');

    return description
        .replaceAllMapped(_ref, (m) => '`${m[1]}`')
        .replaceAll(' (the default)', '');
  }

  String get defaultValue => owner.constructors.single.parameters
      .singleWhere((pe) => pe.name == field.name)
      .defaultValueCode;

  _FieldInfo(this.field);

  @override
  int compareTo(_FieldInfo other) => field.name.compareTo(other.field.name);

  @override
  String toString() => '_FieldThing($field)';
}

class _DocBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    var lib = LibraryReader(await buildStep.inputLibrary);

    var descriptions = <String, _FieldInfo>{};
    var fieldMap = <String, List<_FieldInfo>>{};

    void processClass(ClassElement ce) {
      for (var fe in ce.fields.where((fe) => !fe.isStatic)) {
        var list = fieldMap.putIfAbsent(ce.name, () => <_FieldInfo>[]);
        final newThing = descriptions[fe.name] = _FieldInfo(fe);
        list.add(newThing);
        list.sort();

        final existing = descriptions[fe.name];
        if (existing != null && newThing.description != existing.description) {
          log.severe([
            'Duplicate field with different description',
            fe.name,
            existing.description,
            newThing.description
          ].join('\n'));
        }
      }
    }

    for (var ce in [
      lib.findType('JsonSerializable'),
      lib.findType('JsonKey')
    ]) {
      processClass(ce);
    }

    var buffer = StringBuffer('# fields\n\n');

    void writeRow(List<String> row) {
      buffer.writeln('| ${row.join(' | ')} |');
    }

    writeRow(['Field']
      ..addAll(fieldMap.keys)
      ..add('Description'));

    writeRow(['---']
      ..addAll(fieldMap.keys.map((k) => ':---:'))
      ..add('---'));

    for (var description in descriptions.entries) {
      writeRow(['`${description.key}`']
        ..addAll(fieldMap.keys.map((clazz) {
          final matchingElement = fieldMap[clazz].singleWhere(
              (fe) => fe.description == description.value.description,
              orElse: () => null);

          if (matchingElement == null) {
            return '';
          }

          return '\u2713';
        }))
        ..add(description.value.description));
    }

    await buildStep.writeAsString(
        AssetId(buildStep.inputId.package, 'doc/doc.md'), buffer.toString());
  }

  @override
  final buildExtensions = const {
    r'lib/json_annotation.dart': ['doc/doc.md']
  };
}
