// ignore_for_file: slash_for_doc_comments

import '../listeners/json_listener.dart';
import 'chunked_json_parser.dart';

/**
 * Chunked JSON parser that parses [String] chunks.
 */
class JsonStringParser extends ChunkedJsonParser<String> {
  JsonStringParser(JsonListener listener) : super(listener);

  @override
  int getChar(int position) => chunk.codeUnitAt(position);

  @override
  String getString(int start, int end, int bits) {
    return chunk.substring(start, end);
  }

  @override
  void beginString() {
    buffer = new StringBuffer();
  }

  @override
  void addSliceToString(int start, int end) {
    StringBuffer buffer = this.buffer;
    buffer.write(chunk.substring(start, end));
  }

  @override
  void addCharToString(int charCode) {
    StringBuffer buffer = this.buffer;
    buffer.writeCharCode(charCode);
  }

  @override
  String endString() {
    StringBuffer buffer = this.buffer;
    this.buffer = null;
    return buffer.toString();
  }

  @override
  void copyCharsToList(int start, int end, List target, int offset) {
    var length = end - start;
    for (var i = 0; i < length; i++) {
      target[offset + i] = chunk.codeUnitAt(start + i);
    }
  }

  @override
  double parseDouble(int start, int end) {
    // TODO(kevmoo): not efficient!
    return double.parse(chunk.substring(start, end));
  }
}
