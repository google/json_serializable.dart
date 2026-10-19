import glob, os
from pathlib import Path

content = open('/usr/local/google/home/kevmoo/github/_json_serializable.dart-v6.15.1/json_serializable/lib/src/utils.dart').read()

old_ext1 = '''extension DartTypeExtension on DartType {
  DartType promoteNonNullable() => switch (this) {
    final TypeParameterType t => t.element.instantiate(
      nullabilitySuffix: NullabilitySuffix.none,
    ),
    final RecordType r when _typeSystemFor(r) == null => RecordType(
      positional: [for (final f in r.positionalFields) f.type],
      named: {for (final f in r.namedFields) f.name: f.type},
      nullabilitySuffix: NullabilitySuffix.none,
    ),
    _ => _typeSystemFor(this)?.promoteToNonNull(this) ?? this,
  };

  String toStringNonNullable() {
    final val = getDisplayString();
    if (val.endsWith('?')) return val.substring(0, val.length - 1);
    return val;
  }
}'''

new_ext1 = '''extension DartTypeExtensionJsonSerializable on DartType {
  DartType promoteNonNullable() => switch (this) {
    final TypeParameterType t => t.element.instantiate(
      nullabilitySuffix: NullabilitySuffix.none,
    ),
    final RecordType r when _typeSystemFor(r) == null => RecordType(
      positional: [for (final f in r.positionalFields) f.type],
      named: {for (final f in r.namedFields) f.name: f.type},
      nullabilitySuffix: NullabilitySuffix.none,
    ),
    _ => _typeSystemFor(this)?.promoteToNonNull(this) ?? this,
  };
}

String toStringNonNullableHelper(DartType type) {
  final val = type.getDisplayString();
  if (val.endsWith('?')) return val.substring(0, val.length - 1);
  return val;
}'''

content = content.replace(old_ext1, new_ext1)

old_ext2 = "String get qualifiedName {\n    if (this is TopLevelFunctionElement) {\n      return name!;\n    }\n\n    if (this is MethodElement) {\n      return '${enclosingElement!.name}.$name';\n    }\n\n    if (this is ConstructorElement) {\n      // The default constructor.\n      if (name == 'new') {\n        return enclosingElement!.name!;\n      }\n      return '${enclosingElement!.name}.$name';\n    }\n\n    throw UnsupportedError('Not sure how to support typeof $runtimeType');\n  }"
new_ext2 = "String get qualifiedNameJson {\n    if (this is TopLevelFunctionElement) {\n      return name!;\n    }\n\n    if (this is MethodElement) {\n      return '${enclosingElement!.name}.$name';\n    }\n\n    if (this is ConstructorElement) {\n      // The default constructor.\n      if (name == 'new') {\n        return enclosingElement!.name!;\n      }\n      return '${enclosingElement!.name}.$name';\n    }\n\n    throw UnsupportedError('Not sure how to support typeof $runtimeType');\n  }"
content = content.replace(old_ext2, new_ext2)

content = content.replace("extension ExecutableElementExtension on ExecutableElement {", "extension ExecutableElementExtensionJsonSerializable on ExecutableElement {")
content = content.replace("constructorByName(ClassElement", "constructorByNameJson(ClassElement")
content = content.replace("constructorByName(classElement", "constructorByNameJson(classElement")

open('/usr/local/google/home/kevmoo/github/_json_serializable.dart-v6.15.1/json_serializable/lib/src/utils.dart', 'w').write(content)

replacements = {
    'error.type.toStringNonNullable()': 'toStringNonNullableHelper(error.type)',
    'type.toStringNonNullable()': 'toStringNonNullableHelper(type)',
    'targetEnumType.toStringNonNullable()': 'toStringNonNullableHelper(targetEnumType)',
    'annotationType.toStringNonNullable()': 'toStringNonNullableHelper(annotationType)',
    '.qualifiedName': '.qualifiedNameJson',
    'qualifiedName {': 'qualifiedNameJson {',
    'constructorByName(': 'constructorByNameJson(',
    'createSortedFieldSet(': 'createSortedFieldSetJson('
}

for filepath in Path('/usr/local/google/home/kevmoo/github/_json_serializable.dart-v6.15.1/json_serializable').rglob('*.dart'):
    if filepath.is_file() and filepath.name != 'utils.dart':
        file_content = filepath.read_text()
        new_content = file_content
        for k, v in replacements.items():
            new_content = new_content.replace(k, v)
        if new_content != file_content:
            filepath.write_text(new_content)
            print(f'Updated {filepath.name}')
