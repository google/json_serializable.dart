part of 'generator_helper.dart';

void writeCrazy(
    _GeneratorHelper helper, StringBuffer buffer, Set<FieldElement> fields) {
  buffer.writeln('// crazy goes here!');

  var writerName = '${helper._prefix}Writer';

  buffer.writeln('''
bool $writerName(Object object, JsonWriter writer) {
  if (object is ${helper._element.name}) {
    writer.startMap();''');

  for (var field in fields) {
    var content =
        'writer.writeKeyValue(${escapeDartString(_nameAccess(field))}, object.${field.name});';

    if (helper._writeJsonValueNaive(field)) {
      buffer.writeln(content);
    } else {
      buffer.writeln('''
if (object.${field.name} != null) {
  $content
}''');
    }
  }

  buffer.writeln('''writer.endMap();
    return true;
  }
  return false;
}
''');
}
