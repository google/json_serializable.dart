// ignore_for_file: slash_for_doc_comments

import 'json_pretty_print_mixin.dart';
import 'json_stringifier.dart';
import 'to_encodable.dart';

/**
 * A specialization of [JsonStringifier] that writes its JSON to a string.
 */
class JsonStringStringifier extends JsonStringifier {
  final StringSink _sink;

  JsonStringStringifier(this._sink, ToEncodable _toEncodable)
      : super(_toEncodable);

  /**
   * Convert object to a string.
   *
   * The [toEncodable] function is used to convert non-encodable objects
   * to encodable ones.
   *
   * If [indent] is not `null`, the resulting JSON will be "pretty-printed"
   * with newlines and indentation. The `indent` string is added as indentation
   * for each indentation level. It should only contain valid JSON whitespace
   * characters (space, tab, carriage return or line feed).
   */
  static String stringify(
      Object object, ToEncodable toEncodable, String indent) {
    StringBuffer output = new StringBuffer();
    printOn(object, output, toEncodable, indent);
    return output.toString();
  }

  /**
   * Convert object to a string, and write the result to the [output] sink.
   *
   * The result is written piecemally to the sink.
   */
  static void printOn(Object object, StringSink output, ToEncodable toEncodable,
      String indent) {
    JsonStringifier stringifier;
    if (indent == null) {
      stringifier = new JsonStringStringifier(output, toEncodable);
    } else {
      stringifier =
          new _JsonStringStringifierPretty(output, toEncodable, indent);
    }
    stringifier.writeObject(object);
  }

  @override
  String get partialResult => _sink is StringBuffer ? _sink.toString() : null;

  @override
  void writeNumber(num number) {
    _sink.write(number.toString());
  }

  @override
  void writeString(String string) {
    _sink.write(string);
  }

  @override
  void writeStringSlice(String string, int start, int end) {
    _sink.write(string.substring(start, end));
  }

  @override
  void writeCharCode(int charCode) {
    _sink.writeCharCode(charCode);
  }
}

class _JsonStringStringifierPretty extends JsonStringStringifier
    with JsonPrettyPrintMixin {
  final String _indent;

  _JsonStringStringifierPretty(
      StringSink sink, ToEncodable toEncodable, this._indent)
      : super(sink, toEncodable);

  @override
  void writeIndentation(int count) {
    for (int i = 0; i < count; i++) writeString(_indent);
  }
}
