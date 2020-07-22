import 'package:meta/meta.dart';

import 'shared.dart';

const customEnumType = 'EnumType';

const _annotationImport =
    "import 'package:json_annotation/json_annotation.dart';";

class TestTypeData {
  final String defaultExpression;
  final String jsonExpression;
  final String altJsonExpression;
  final Map<String, String> genericTypes;

  TestTypeData({
    this.defaultExpression,
    String jsonExpression,
    @required String altJsonExpression,
    Set<String> genericArgs,
  })  : jsonExpression = jsonExpression ?? defaultExpression,
        altJsonExpression =
            altJsonExpression ?? jsonExpression ?? defaultExpression,
        genericTypes = Map<String, String>.fromEntries(
          (genericArgs ?? const {}).map(
            (e) => MapEntry<String, String>(
              e,
              'SimpleClass${_genericClassPart(e)}',
            ),
          ),
        );

  String libContent(String source, String type) {
    const classAnnotationSplit = '@JsonSerializable()';

    final split = source.split(classAnnotationSplit);

    assert(split.length == 2);

    final newPart = toTypeExtension(type, includeDotDart: false);

    final headerReplacements = [
      if (type == customEnumType ||
          genericTypes.keys.any((element) => element.contains(customEnumType)))
        const Replacement(
          _annotationImport,
          '$_annotationImport'
          "import 'enum_type.dart';",
        ),
      Replacement(
        "part 'input.g.dart';",
        "part 'input$newPart.g.dart';",
      )
    ];

    final buffer =
        StringBuffer(Replacement.generate(split[0], headerReplacements));

    final simpleClassContent = '$classAnnotationSplit${split[1]}';

    buffer.write(Replacement.generate(
      simpleClassContent,
      _libReplacements(type),
    ));

    for (var entry in genericTypes.entries) {
      final genericType = '$type<${entry.key}>';

      buffer.write(Replacement.generate(
        simpleClassContent.replaceAll(
          'SimpleClass',
          entry.value,
        ),
        _libReplacements(genericType),
      ));
    }

    return buffer.toString();
  }

  Iterable<Replacement> _libReplacements(String type) sync* {
    yield Replacement(
      'final int value;',
      'final $type value;',
    );
    yield Replacement(
      'final int nullable;',
      'final $type nullable;',
    );

    final defaultReplacement = (defaultExpression == null // no default provided
            ||
            type.contains('<') // no support for default values and generic args
        )
        ? ''
        : _defaultSource
            .replaceFirst('42', defaultExpression)
            .replaceFirst('int', type);

    yield Replacement(
      _defaultSource,
      defaultReplacement,
    );
  }

  String testContent(String sourceContent, String type) {
    sourceContent = Replacement.generate(
      sourceContent,
      _testReplacements(type),
    );

    if (genericTypes.isNotEmpty) {
      final buffer = StringBuffer();

      for (var entry in genericTypes.entries) {
        buffer.writeln("group('<${entry.key}>', () {});");
      }

      assert(sourceContent.contains(_testGenericPlaceHolder));
      sourceContent = sourceContent.replaceFirst(
          _testGenericPlaceHolder, buffer.toString());
    }

    return sourceContent;
  }

  Iterable<Replacement> _testReplacements(String type) sync* {
    yield Replacement(
      "import 'input.dart';",
      "import 'input.type_${typeToPathPart(type)}.dart';",
    );

    yield Replacement(
      '''
    final _defaultValue = 42;
    final _altValue = 43;
''',
      '''
    final _defaultValue = $jsonExpression;
    final _altValue = $altJsonExpression;
''',
    );

    if (defaultExpression == null) {
      yield const Replacement(
        "  'withDefault': _defaultValue,\n",
        '',
      );
      yield const Replacement(
        "  'withDefault': _altValue,\n",
        '',
      );
    }
  }

  static const _defaultSource = r'''
  @JsonKey(defaultValue: 42)
  int withDefault;

''';
}

const _testGenericPlaceHolder = '// Place-holder for generic tests, if any.';

String _genericClassPart(String genericArg) => genericArg
    .split(',')
    .map((e) => [
          e.substring(0, 1).toUpperCase(),
          e.substring(1),
        ].join())
    .join('To');

String toTypeExtension(String e, {bool includeDotDart = true}) =>
    '.type_${typeToPathPart(e)}${includeDotDart ? '.dart' : ''}';

String typeToPathPart(String type) => type.toLowerCase();
