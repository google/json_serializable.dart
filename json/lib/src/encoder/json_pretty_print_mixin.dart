// ignore_for_file: slash_for_doc_comments, annotate_overrides, prefer_single_quotes

import 'json_stringifier.dart';

/**
 * A modification of [JsonStringifier] which indents the contents of [List] and
 * [Map] objects using the specified indent value.
 *
 * Subclasses should implement [writeIndentation].
 */
abstract class JsonPrettyPrintMixin implements JsonStringifier {
  int _indentLevel = 0;

  /**
   * Add [indentLevel] indentations to the JSON output.
   */
  void writeIndentation(int indentLevel);

  void writeList(List list) {
    if (list.isEmpty) {
      writeString('[]');
    } else {
      writeString('[\n');
      _indentLevel++;
      writeIndentation(_indentLevel);
      writeObject(list[0]);
      for (int i = 1; i < list.length; i++) {
        writeString(',\n');
        writeIndentation(_indentLevel);
        writeObject(list[i]);
      }
      writeString('\n');
      _indentLevel--;
      writeIndentation(_indentLevel);
      writeString(']');
    }
  }

  bool writeMap(Map map) {
    if (map.isEmpty) {
      writeString("{}");
      return true;
    }
    List keyValueList = new List(map.length * 2);
    int i = 0;
    bool allStringKeys = true;
    map.forEach((key, value) {
      if (key is! String) {
        allStringKeys = false;
      }
      keyValueList[i++] = key;
      keyValueList[i++] = value;
    });
    if (!allStringKeys) return false;
    writeString('{\n');
    _indentLevel++;
    String separator = "";
    for (int i = 0; i < keyValueList.length; i += 2) {
      writeString(separator);
      separator = ",\n";
      writeIndentation(_indentLevel);
      writeString('"');
      writeStringContent(keyValueList[i] as String);
      writeString('": ');
      writeObject(keyValueList[i + 1]);
    }
    writeString('\n');
    _indentLevel--;
    writeIndentation(_indentLevel);
    writeString('}');
    return true;
  }
}
