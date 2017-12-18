// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:typed_data';
import 'chunked_json_parser.dart';
import 'listeners/json_listener.dart';

/**
 * Chunked JSON parser that parses UTF-8 chunks.
 */
class JsonUtf8Parser extends ChunkedJsonParser<List<int>> {
  final bool allowMalformed;

  JsonUtf8Parser(JsonListener listener, this.allowMalformed) : super(listener);

  @override
  int getChar(int position) => chunk[position];

  @override
  String getString(int start, int end, int bits) {
    const int maxAsciiChar = 0x7f;
    if (bits <= maxAsciiChar) {
      return new String.fromCharCodes(chunk, start, end);
    }
    beginString();
    if (start < end) addSliceToString(start, end);
    String result = endString();
    return result;
  }

  @override
  void beginString() {
    buffer = new _Utf8StringBuffer(allowMalformed);
  }

  @override
  void addSliceToString(int start, int end) {
    _Utf8StringBuffer buffer = this.buffer;
    buffer.addSlice(chunk, start, end);
  }

  @override
  void addCharToString(int charCode) {
    _Utf8StringBuffer buffer = this.buffer;
    buffer.addCharCode(charCode);
  }

  @override
  String endString() {
    _Utf8StringBuffer buffer = this.buffer;
    this.buffer = null;
    return buffer.toString();
  }

  @override
  void copyCharsToList(int start, int end, List target, int offset) {
    int length = end - start;
    target.setRange(offset, offset + length, chunk, start);
  }

  @override
  double parseDouble(int start, int end) {
    String string = getString(start, end, 0x7f);
    return double.parse(string);
  }
}

class _Utf8StringBuffer {
  static const int INITIAL_CAPACITY = 32;
  // Partial state encoding.
  static const int MASK_TWO_BIT = 0x03;
  static const int MASK_SIZE = MASK_TWO_BIT;
  static const int SHIFT_MISSING = 2;
  static const int SHIFT_VALUE = 4;
  static const int NO_PARTIAL = 0;

  // UTF-8 encoding and limits.
  static const int MAX_ASCII = 127;
  static const int MAX_TWO_BYTE = 0x7ff;
  static const int MAX_THREE_BYTE = 0xffff;
  static const int MAX_UNICODE = 0X10ffff;
  static const int MASK_TWO_BYTE = 0x1f;
  static const int MASK_THREE_BYTE = 0x0f;
  static const int MASK_FOUR_BYTE = 0x07;
  static const int MASK_CONTINUE_TAG = 0xC0;
  static const int MASK_CONTINUE_VALUE = 0x3f;
  static const int CONTINUE_TAG = 0x80;

  // UTF-16 surrogate encoding.
  static const int LEAD_SURROGATE = 0xD800;
  static const int TAIL_SURROGATE = 0xDC00;
  static const int SHIFT_HIGH_SURROGATE = 10;
  static const int MASK_LOW_SURROGATE = 0x3ff;

  // The internal buffer starts as Uint8List, but may change to Uint16List
  // if the string contains non-Latin-1 characters.
  List<int> buffer = new Uint8List(INITIAL_CAPACITY);
  // Number of elements in buffer.
  int length = 0;
  // Partial decoding state, for cases where an UTF-8 sequences is split
  // between chunks.
  int partialState = NO_PARTIAL;
  // Whether all characters so far have been Latin-1 (and the buffer is
  // still a Uint8List). Set to false when the first non-Latin-1 character
  // is encountered, and the buffer is then also converted to a Uint16List.
  bool isLatin1 = true;
  // If allowing malformed, invalid UTF-8 sequences are converted to
  // U+FFFD.
  bool allowMalformed;

  _Utf8StringBuffer(this.allowMalformed);

  /**
   * Parse the continuation of a multi-byte UTF-8 sequence.
   *
   * Parse [utf8] from [position] to [end]. If the sequence extends beyond
   * `end`, store the partial state in [partialState], and continue from there
   * on the next added slice.
   *
   * The [size] is the number of expected continuation bytes total,
   * and [missing] is the number of remaining continuation bytes.
   * The [size] is used to detect overlong encodings.
   * The [value] is the value collected so far.
   *
   * When called after seeing the first multi-byte marker, the [size] and
   * [missing] values are always the same, but they may differ if continuing
   * after a partial sequence.
   */
  int addContinuation(
      List<int> utf8, int position, int end, int size, int missing, int value) {
    int codeEnd = position + missing;
    do {
      if (position == end) {
        missing = codeEnd - position;
        partialState =
            size | (missing << SHIFT_MISSING) | (value << SHIFT_VALUE);
        return end;
      }
      int char = utf8[position];
      if ((char & MASK_CONTINUE_TAG) != CONTINUE_TAG) {
        if (allowMalformed) {
          addCharCode(0xFFFD);
          return position;
        }
        throw new FormatException(
            "Expected UTF-8 continuation byte, "
            "found $char",
            utf8,
            position);
      }
      value = 64 * value + (char & MASK_CONTINUE_VALUE);
      position++;
    } while (position < codeEnd);
    if (value <= const [0, MAX_ASCII, MAX_TWO_BYTE, MAX_THREE_BYTE][size]) {
      // Over-long encoding.
      if (allowMalformed) {
        value = 0xFFFD;
      } else {
        throw new FormatException(
            "Invalid encoding: U+${value.toRadixString(16).padLeft(4, '0')}"
            " encoded in ${size + 1} bytes.",
            utf8,
            position - 1);
      }
    }
    addCharCode(value);
    return position;
  }

  void addCharCode(int char) {
    assert(char >= 0);
    assert(char <= MAX_UNICODE);
    if (partialState != NO_PARTIAL) {
      if (allowMalformed) {
        partialState = NO_PARTIAL;
        addCharCode(0xFFFD);
      } else {
        throw new FormatException("Incomplete UTF-8 sequence");
      }
    }
    if (isLatin1 && char > 0xff) {
      _to16Bit(); // Also grows a little if close to full.
    }
    int length = this.length;
    if (char <= MAX_THREE_BYTE) {
      if (length == buffer.length) _grow();
      buffer[length] = char;
      this.length = length + 1;
      return;
    }
    if (length + 2 > buffer.length) _grow();
    int bits = char - 0x10000;
    buffer[length] = LEAD_SURROGATE | (bits >> SHIFT_HIGH_SURROGATE);
    buffer[length + 1] = TAIL_SURROGATE | (bits & MASK_LOW_SURROGATE);
    this.length = length + 2;
  }

  void _to16Bit() {
    assert(isLatin1);
    Uint16List newBuffer;
    if ((length + INITIAL_CAPACITY) * 2 <= buffer.length) {
      // Reuse existing buffer if it's big enough.
      newBuffer = new Uint16List.view((buffer as Uint8List).buffer);
    } else {
      int newCapacity = buffer.length;
      if (newCapacity - length < INITIAL_CAPACITY) {
        newCapacity = length + INITIAL_CAPACITY;
      }
      newBuffer = new Uint16List(newCapacity);
    }
    newBuffer.setRange(0, length, buffer);
    buffer = newBuffer;
    isLatin1 = false;
  }

  void _grow() {
    int newCapacity = buffer.length * 2;
    List<int> newBuffer;
    if (isLatin1) {
      newBuffer = new Uint8List(newCapacity);
    } else {
      newBuffer = new Uint16List(newCapacity);
    }
    newBuffer.setRange(0, length, buffer);
    buffer = newBuffer;
  }

  void addSlice(List<int> utf8, int position, int end) {
    assert(position < end);
    if (partialState > 0) {
      int continueByteCount = (partialState & MASK_TWO_BIT);
      int missing = (partialState >> SHIFT_MISSING) & MASK_TWO_BIT;
      int value = partialState >> SHIFT_VALUE;
      partialState = NO_PARTIAL;
      position = addContinuation(
          utf8, position, end, continueByteCount, missing, value);
      if (position == end) return;
    }
    // Keep index and capacity in local variables while looping over
    // ASCII characters.
    int index = length;
    int capacity = buffer.length;
    while (position < end) {
      int char = utf8[position];
      if (char <= MAX_ASCII) {
        if (index == capacity) {
          length = index;
          _grow();
          capacity = buffer.length;
        }
        buffer[index++] = char;
        position++;
        continue;
      }
      length = index;
      if ((char & MASK_CONTINUE_TAG) == CONTINUE_TAG) {
        if (allowMalformed) {
          addCharCode(0xFFFD);
          position++;
        } else {
          throw new FormatException(
              "Unexepected UTF-8 continuation byte", utf8, position);
        }
      } else if (char < 0xE0) {
        // C0-DF
        // Two-byte.
        position = addContinuation(
            utf8, position + 1, end, 1, 1, char & MASK_TWO_BYTE);
      } else if (char < 0xF0) {
        // E0-EF
        // Three-byte.
        position = addContinuation(
            utf8, position + 1, end, 2, 2, char & MASK_THREE_BYTE);
      } else if (char < 0xF8) {
        // F0-F7
        // Four-byte.
        position = addContinuation(
            utf8, position + 1, end, 3, 3, char & MASK_FOUR_BYTE);
      } else {
        if (allowMalformed) {
          addCharCode(0xFFFD);
          position++;
        } else {
          throw new FormatException(
              "Invalid UTF-8 byte: $char", utf8, position);
        }
      }
      index = length;
      capacity = buffer.length;
    }
    length = index;
  }

  @override
  String toString() {
    if (partialState != NO_PARTIAL) {
      if (allowMalformed) {
        partialState = NO_PARTIAL;
        addCharCode(0xFFFD);
      } else {
        int continueByteCount = (partialState & MASK_TWO_BIT);
        int missing = (partialState >> SHIFT_MISSING) & MASK_TWO_BIT;
        int value = partialState >> SHIFT_VALUE;
        int seenByteCount = continueByteCount - missing + 1;
        List source = new Uint8List(seenByteCount);
        while (seenByteCount > 1) {
          seenByteCount--;
          source[seenByteCount] = CONTINUE_TAG | (value & MASK_CONTINUE_VALUE);
          value >>= 6;
        }
        source[0] = value | (0x3c0 >> (continueByteCount - 1));
        throw new FormatException(
            "Incomplete UTF-8 sequence", source, source.length);
      }
    }
    return new String.fromCharCodes(buffer, 0, length);
  }
}
