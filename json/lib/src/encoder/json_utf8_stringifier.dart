// ignore_for_file: slash_for_doc_comments, annotate_overrides, prefer_single_quotes

import 'dart:typed_data';

import 'json_pretty_print_mixin.dart';
import 'json_stringifier.dart';
import 'to_encodable.dart';

typedef void _AddChunk(Uint8List list, int start, int end);

/**
 * Specialization of [JsonStringifier] that writes the JSON as UTF-8.
 *
 * The JSON text is UTF-8 encoded and written to [Uint8List] buffers.
 * The buffers are then passed back to a user provided callback method.
 */
class JsonUtf8Stringifier extends JsonStringifier {
  final int _bufferSize;
  final _AddChunk addChunk;
  Uint8List _buffer;
  int _index = 0;

  JsonUtf8Stringifier(ToEncodable toEncodable, int bufferSize, this.addChunk)
      : this._bufferSize = bufferSize,
        _buffer = new Uint8List(bufferSize),
        super(toEncodable);

  /**
   * Convert [object] to UTF-8 encoded JSON.
   *
   * Calls [addChunk] with slices of UTF-8 code units.
   * These will typically have size [bufferSize], but may be shorter.
   * The buffers are not reused, so the [addChunk] call may keep and reuse the
   * chunks.
   *
   * If [indent] is non-`null`, the result will be "pretty-printed" with extra
   * newlines and indentation, using [indent] as the indentation.
   */
  static void stringify(
      Object object,
      List<int> indent,
      ToEncodable toEncodable,
      int bufferSize,
      void addChunk(Uint8List chunk, int start, int end)) {
    JsonUtf8Stringifier stringifier;
    if (indent != null) {
      stringifier = new _JsonUtf8StringifierPretty(
          toEncodable, indent, bufferSize, addChunk);
    } else {
      stringifier = new JsonUtf8Stringifier(toEncodable, bufferSize, addChunk);
    }
    stringifier.writeObject(object);
    stringifier._flush();
  }

  /**
   * Must be called at the end to push the last chunk to the [addChunk]
   * callback.
   */
  void _flush() {
    if (_index > 0) {
      addChunk(_buffer, 0, _index);
    }
    _buffer = null;
    _index = 0;
  }

  String get partialResult => null;

  void writeNumber(num number) {
    writeAsciiString(number.toString());
  }

  /** Write a string that is known to not have non-ASCII characters. */
  void writeAsciiString(String string) {
    // TODO(lrn): Optimize by copying directly into buffer instead of going
    // through writeCharCode;
    for (int i = 0; i < string.length; i++) {
      int char = string.codeUnitAt(i);
      assert(char <= 0x7f);
      _writeByte(char);
    }
  }

  void writeString(String string) {
    writeStringSlice(string, 0, string.length);
  }

  void writeStringSlice(String string, int start, int end) {
    // TODO(lrn): Optimize by copying directly into buffer instead of going
    // through writeCharCode/writeByte. Assumption is the most characters
    // in starings are plain ASCII.
    for (int i = start; i < end; i++) {
      int char = string.codeUnitAt(i);
      if (char <= 0x7f) {
        _writeByte(char);
      } else {
        if ((char & 0xFC00) == 0xD800 && i + 1 < end) {
          // Lead surrogate.
          int nextChar = string.codeUnitAt(i + 1);
          if ((nextChar & 0xFC00) == 0xDC00) {
            // Tail surrogate.
            char = 0x10000 + ((char & 0x3ff) << 10) + (nextChar & 0x3ff);
            _writeFourByteCharCode(char);
            i++;
            continue;
          }
        }
        _writeMultiByteCharCode(char);
      }
    }
  }

  void writeCharCode(int charCode) {
    if (charCode <= 0x7f) {
      _writeByte(charCode);
      return;
    }
    _writeMultiByteCharCode(charCode);
  }

  void _writeMultiByteCharCode(int charCode) {
    if (charCode <= 0x7ff) {
      _writeByte(0xC0 | (charCode >> 6));
      _writeByte(0x80 | (charCode & 0x3f));
      return;
    }
    if (charCode <= 0xffff) {
      _writeByte(0xE0 | (charCode >> 12));
      _writeByte(0x80 | ((charCode >> 6) & 0x3f));
      _writeByte(0x80 | (charCode & 0x3f));
      return;
    }
    _writeFourByteCharCode(charCode);
  }

  void _writeFourByteCharCode(int charCode) {
    assert(charCode <= 0x10ffff);
    _writeByte(0xF0 | (charCode >> 18));
    _writeByte(0x80 | ((charCode >> 12) & 0x3f));
    _writeByte(0x80 | ((charCode >> 6) & 0x3f));
    _writeByte(0x80 | (charCode & 0x3f));
  }

  void _writeByte(int byte) {
    assert(byte <= 0xff);
    if (_index == _buffer.length) {
      addChunk(_buffer, 0, _index);
      _buffer = new Uint8List(_bufferSize);
      _index = 0;
    }
    _buffer[_index++] = byte;
  }
}

/**
 * Pretty-printing version of [JsonUtf8Stringifier].
 */
class _JsonUtf8StringifierPretty extends JsonUtf8Stringifier
    with JsonPrettyPrintMixin {
  final List<int> _indent;
  _JsonUtf8StringifierPretty(ToEncodable toEncodable, this._indent,
      int bufferSize, void addChunk(Uint8List buffer, int start, int end))
      : super(toEncodable, bufferSize, addChunk);

  void writeIndentation(int count) {
    int indentLength = _indent.length;
    if (indentLength == 1) {
      int char = _indent[0];
      while (count > 0) {
        _writeByte(char);
        count -= 1;
      }
      return;
    }
    while (count > 0) {
      count--;
      int end = _index + indentLength;
      if (end <= _buffer.length) {
        _buffer.setRange(_index, end, _indent);
        _index = end;
      } else {
        for (int i = 0; i < indentLength; i++) {
          _writeByte(_indent[i]);
        }
      }
    }
  }
}
