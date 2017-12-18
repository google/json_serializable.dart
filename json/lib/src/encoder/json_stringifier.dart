// ignore_for_file: slash_for_doc_comments, prefer_single_quotes

import 'package:meta/meta.dart';

import 'errors.dart';
import 'json_writer.dart';
import 'to_encodable.dart';

// TODO(kevmoo): remove seen tracking. Just have a max-depth counter?

Object _defaultToEncodable(dynamic object) => object.toJson();
bool _defaultJsonWriter(Object source, JsonWriter writer) => false;

/**
 * JSON encoder that traverses an object structure and writes JSON source.
 *
 * This is an abstract implementation that doesn't decide on the output
 * format, but writes the JSON through abstract methods like [writeString].
 */
abstract class JsonStringifier implements JsonWriter {
  // TODO: convert in-line characters to use 'package:charcode/charcode.dart'
  // Character code constants.
  static const int backspace = 0x08;
  static const int tab = 0x09;
  static const int newline = 0x0a;
  static const int carriageReturn = 0x0d;
  static const int formFeed = 0x0c;
  static const int quote = 0x22;
  static const int char_0 = 0x30;
  static const int backslash = 0x5c;
  static const int char_b = 0x62;
  static const int char_f = 0x66;
  static const int char_n = 0x6e;
  static const int char_r = 0x72;
  static const int char_t = 0x74;
  static const int char_u = 0x75;

  /** List of objects currently being traversed. Used to detect cycles. */
  final List _seen = new List();

  /** Function called for each un-encodable object encountered. */
  final ToEncodable _toEncodable;

  final WriteJson _jsonWriter;

  JsonStringifier(toEncodable(dynamic o), WriteJson jsonWriter)
      : _toEncodable = toEncodable ?? _defaultToEncodable,
        _jsonWriter = jsonWriter ?? _defaultJsonWriter;

  @protected
  String get partialResult;

  /** Append a string to the JSON output. */
  void writeString(String characters);
  /** Append part of a string to the JSON output. */
  void writeStringSlice(String characters, int start, int end);
  /** Append a single character, given by its code point, to the JSON output. */
  void writeCharCode(int charCode);
  /** Write a number to the JSON output. */
  void writeNumber(num number);

  // ('0' + x) or ('a' + x - 10)
  static int _hexDigit(int x) => x < 10 ? 48 + x : 87 + x;

  /**
   * Write, and suitably escape, a string's content as a JSON string literal.
   */
  void writeStringContent(String s) {
    int offset = 0;
    final int length = s.length;
    for (int i = 0; i < length; i++) {
      int charCode = s.codeUnitAt(i);
      if (charCode > backslash) continue;
      if (charCode < 32) {
        if (i > offset) writeStringSlice(s, offset, i);
        offset = i + 1;
        writeCharCode(backslash);
        switch (charCode) {
          case backspace:
            writeCharCode(char_b);
            break;
          case tab:
            writeCharCode(char_t);
            break;
          case newline:
            writeCharCode(char_n);
            break;
          case formFeed:
            writeCharCode(char_f);
            break;
          case carriageReturn:
            writeCharCode(char_r);
            break;
          default:
            writeCharCode(char_u);
            writeCharCode(char_0);
            writeCharCode(char_0);
            writeCharCode(_hexDigit((charCode >> 4) & 0xf));
            writeCharCode(_hexDigit(charCode & 0xf));
            break;
        }
      } else if (charCode == quote || charCode == backslash) {
        if (i > offset) writeStringSlice(s, offset, i);
        offset = i + 1;
        writeCharCode(backslash);
        writeCharCode(charCode);
      }
    }
    if (offset == 0) {
      writeString(s);
    } else if (offset < length) {
      writeStringSlice(s, offset, length);
    }
  }

  /**
   * Check if an encountered object is already being traversed.
   *
   * Records the object if it isn't already seen. Should have a matching call to
   * [_removeSeen] when the object is no longer being traversed.
   */
  void _checkCycle(object) {
    for (int i = 0; i < _seen.length; i++) {
      if (identical(object, _seen[i])) {
        throw new JsonCyclicError(object);
      }
    }
    _seen.add(object);
  }

  /**
   * Remove [object] from the list of currently traversed objects.
   *
   * Should be called in the opposite order of the matching [_checkCycle]
   * calls.
   */
  void _removeSeen(object) {
    assert(_seen.isNotEmpty);
    assert(identical(_seen.last, object));
    _seen.removeLast();
  }

  /**
   * Write an object.
   *
   * If [object] isn't directly encodable, the [_toEncodable] function gets one
   * chance to return a replacement which is encodable.
   */
  void writeObject(object) {
    // Tries stringifying object directly. If it's not a simple value, List or
    // Map, call toJson() to get a custom representation and try serializing
    // that.
    if (_writeJsonValue(object)) return;
    _checkCycle(object);
    try {
      var customJson = _toEncodable(object);
      if (!_writeJsonValue(customJson)) {
        throw new JsonUnsupportedObjectError(object,
            partialResult: partialResult);
      }
      _removeSeen(object);
    } catch (e) {
      throw new JsonUnsupportedObjectError(object,
          cause: e, partialResult: partialResult);
    }
  }

  /**
   * Serialize a [num], [String], [bool], [Null], [List] or [Map] value.
   *
   * Returns true if the value is one of these types, and false if not.
   * If a value is both a [List] and a [Map], it's serialized as a [List].
   */
  bool _writeJsonValue(Object object) {
    if (object is num) {
      if (!object.isFinite) return false;
      writeNumber(object);
      return true;
    } else if (identical(object, true)) {
      writeString('true');
      return true;
    } else if (identical(object, false)) {
      writeString('false');
      return true;
    } else if (object == null) {
      writeString('null');
      return true;
    } else if (object is String) {
      writeString('"');
      writeStringContent(object);
      writeString('"');
      return true;
    } else if (object is List) {
      _checkCycle(object);
      writeList(object);
      _removeSeen(object);
      return true;
    } else if (object is Map) {
      _checkCycle(object);
      // writeMap can fail if keys are not all strings.
      var success = writeMap(object);
      _removeSeen(object);
      return success;
    } else {
      return _jsonWriter(object, this);
    }
  }

  /** Serialize a [List]. */
  void writeList(List list) {
    writeString('[');
    if (list.length > 0) {
      writeObject(list[0]);
      for (int i = 1; i < list.length; i++) {
        writeString(',');
        writeObject(list[i]);
      }
    }
    writeString(']');
  }

  /** Serialize a [Map]. */
  bool writeMap(Map map) {
    if (map.isEmpty) {
      startMap();
      endMap();
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
    startMap();
    for (int i = 0; i < keyValueList.length; i += 2) {
      writeKeyValue(keyValueList[i] as String, keyValueList[i + 1]);
    }
    endMap();
    return true;
  }

  int _mapWritingDepth = 0;
  bool _writtenValue;

  @override
  void startMap() {
    if (_writtenValue != null) {
      _mapWritingDepth++;
    }
    _writtenValue = false;
    writeString("{");
  }

  @override
  void writeKeyValue(String key, Object value) {
    assert(_writtenValue != null);
    if (_writtenValue) {
      writeString(',"');
    } else {
      _writtenValue = true;
      writeString('"');
    }
    writeStringContent(key);
    writeString('":');
    writeObject(value);
  }

  @override
  void endMap() {
    assert(_writtenValue != null);
    writeString('}');
    if (_mapWritingDepth > 0) {
      _mapWritingDepth--;
      _writtenValue = true;
    } else {
      _writtenValue = null;
    }
  }
}

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

  @override
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

  @override
  void writeKeyValue(String key, Object value) {
    assert(_writtenValue != null);
    if (_writtenValue) {
      writeString(',\n');
    } else {
      _indentLevel++;
      writeString('\n');
      _writtenValue = true;
    }
    writeIndentation(_indentLevel);
    writeString('"');
    writeStringContent(key);
    writeString('": ');
    writeObject(value);
  }

  @override
  void endMap() {
    if (_writtenValue) {
      _indentLevel--;
      writeString('\n');
      writeIndentation(_indentLevel);
    }
    super.endMap();
  }
}
