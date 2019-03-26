import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:json_serializable/src/utils.dart';
import 'package:source_gen/source_gen.dart';

Builder docBuilder([_]) => _DocBuilder();

class _DocBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final lib = LibraryReader(await buildStep.resolver.libraryFor(
        AssetId.resolve('package:json_annotation/json_annotation.dart')));

    final descriptionMap = <String, List<_FieldInfo>>{};

    for (var className in _annotationClasses) {
      final descriptions = <_FieldInfo>[];

      for (var fe
          in lib.findType(className).fields.where((fe) => !fe.isStatic)) {
        descriptions.add(_FieldInfo(className, fe));
      }

      descriptions.sort();

      descriptionMap[className] = descriptions;
    }

    final buffer = StringBuffer();

    for (var entry in descriptionMap.entries) {
      buffer.writeln('<h2>${entry.key}</h2>');
      buffer.writeln('<dl>');

      for (var description in entry.value) {
        final anchor = _anchorUriForName(entry.key, description.field.name);
        buffer.writeln('''
  <dt><code><a name="$anchor">${description.parent}.${description.field.name}</a></code></dt>
  <dd>

${description.description}
  </dd>''');
      }

      buffer.writeln('</dl>');
    }

    await buildStep.writeAsString(
        AssetId(buildStep.inputId.package, 'doc/doc.md'), buffer.toString());
  }

  @override
  final buildExtensions = const {
    r'lib/json_serializable.dart': ['doc/doc.md']
  };
}

const _annotationClasses = ['JsonSerializable', 'JsonKey'];

String _anchorUriForName(String owner, String name) => '$owner-$name';

class _FieldInfo implements Comparable<_FieldInfo> {
  static final _ref = RegExp('\\[([^\\]]+)\\]');
  static final _knownEntities = <String, Set<String>>{};

  final String parent;
  final FieldElement field;

  String get description {
    var description =
        LineSplitter.split(field.documentationComment).map((line) {
      if (line.startsWith('///')) {
        line = line.substring(3).trimRight();
      }
      if (line.startsWith(' ')) {
        // If the line is not empty, then it starts with a blank space
        line = line.substring(1);
      }
      return line;
    }).join('\n');

    description = description.replaceAllMapped(_ref, (m) {
      final ref = m[1];

      String refParentClass, refName;
      if (_knownEntities[parent].contains(ref)) {
        refName = ref;
        refParentClass = parent;
      } else if (ref.contains('.')) {
        final split = ref.split('.');
        if (split.length == 2 &&
            _annotationClasses.contains(split[0]) &&
            _knownEntities[split[0]].contains(split[1])) {
          refParentClass = split[0];
          refName = split[1];
        }
      }

      if (refParentClass != null) {
        assert(refName != null);
        return '[`$refParentClass.$refName`]'
            '(#${_anchorUriForName(refParentClass, refName)})';
      }

      return '`$ref`';
    });

    if (parent == 'JsonSerializable') {
      final yamlConfigKey = snakeCase(field.name);
      description = '`build.yaml` config key: `$yamlConfigKey`\n\n$description';
    }

    return description;
  }

  _FieldInfo(this.parent, this.field) {
    _knownEntities.putIfAbsent(parent, () => Set<String>()).add(field.name);
  }

  @override
  int compareTo(_FieldInfo other) => field.name.compareTo(other.field.name);

  @override
  String toString() => '_FieldThing($field)';
}
