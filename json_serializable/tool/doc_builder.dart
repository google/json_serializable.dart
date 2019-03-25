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
    final description = LineSplitter.split(field.documentationComment)
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

final _doubleTickEscape = RegExp('`([ &;,:\\\$_a-zA-Z]+)`');

String _escapeDescription(String input) {
  input = htmlEscape.convert(input);
  input = input.replaceAllMapped(_doubleTickEscape, (e) {
    return '<code>${e[1]}</code>';
  });

  return input;
}

class _DocBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final lib = LibraryReader(await buildStep.resolver.libraryFor(
        AssetId.resolve('package:json_annotation/json_annotation.dart')));

    final descriptions = <String, _FieldInfo>{};
    final fieldMap = <String, List<_FieldInfo>>{};

    void processClass(ClassElement ce) {
      for (var fe in ce.fields.where((fe) => !fe.isStatic)) {
        final list = fieldMap.putIfAbsent(ce.name, () => <_FieldInfo>[]);
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

    final buffer = StringBuffer('# fields\n\n');
    buffer.writeln('<dl>');

    for (var description in descriptions.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key))) {
      final supportedClasses = fieldMap.entries
          .where((e) =>
              e.value.indexWhere(
                  (fe) => fe.field.name == description.value.field.name) >=
              0)
          .map((e) => e.key)
          .toList();

      final supportedClassesHtml =
          supportedClasses.map((c) => '<code>$c</code>').join(', ');

      buffer.writeln('''
  <dt><code>${description.key}</code></dt>
  <dd>
     Support classes: $supportedClassesHtml<br>
     ${_escapeDescription(description.value.description)}
  </dd>''');
    }

    buffer.writeln('</dl>');

    await buildStep.writeAsString(
        AssetId(buildStep.inputId.package, 'doc/doc.md'), buffer.toString());
  }

  @override
  final buildExtensions = const {
    r'lib/json_serializable.dart': ['doc/doc.md']
  };
}
