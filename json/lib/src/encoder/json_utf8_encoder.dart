// ignore_for_file: slash_for_doc_comments, annotate_overrides, prefer_single_quotes

import 'dart:typed_data';

import '../dart_convert_exports.dart';
import 'json_utf8_stringifier.dart';
import 'to_encodable.dart';

/**
 * Encoder that encodes a single object as a UTF-8 encoded JSON string.
 *
 * This encoder works equivalently to first converting the object to
 * a JSON string, and then UTF-8 encoding the string, but without
 * creating an intermediate string.
 */
class JsonUtf8Encoder extends Converter<Object, List<int>> {
  /** Default buffer size used by the JSON-to-UTF-8 encoder. */
  static const int _defaultBufferSize = 256;
  /** Indentation used in pretty-print mode, `null` if not pretty. */
  final List<int> _indent;
  /** Function called with each un-encodable object encountered. */
  final ToEncodable _toEncodable;
  /** UTF-8 buffer size. */
  final int _bufferSize;

  /**
   * Create converter.
   *
   * If [indent] is non-`null`, the converter attempts to "pretty-print" the
   * JSON, and uses `indent` as the indentation. Otherwise the result has no
   * whitespace outside of string literals.
   * If `indent` contains characters that are not valid JSON whitespace
   * characters, the result will not be valid JSON. JSON whitespace characters
   * are space (U+0020), tab (U+0009), line feed (U+000a) and carriage return
   * (U+000d) ([ECMA
   * 404](http://www.ecma-international.org/publications/standards/Ecma-404.htm)).
   *
   * The [bufferSize] is the size of the internal buffers used to collect
   * UTF-8 code units.
   * If using [startChunkedConversion], it will be the size of the chunks.
   *
   * The JSON encoder handles numbers, strings, booleans, null, lists and maps
   * directly.
   *
   * Any other object is attempted converted by [toEncodable] to an object that
   * is of one of the convertible types.
   *
   * If [toEncodable] is omitted, it defaults to calling `.toJson()` on the
   * object.
   */
  JsonUtf8Encoder(
      {String indent, toEncodable(object), int bufferSize = _defaultBufferSize})
      : _indent = _utf8Encode(indent),
        _toEncodable = toEncodable,
        _bufferSize = bufferSize;

  static List<int> _utf8Encode(String string) {
    if (string == null) return null;
    if (string.isEmpty) return new Uint8List(0);
    checkAscii:
    {
      for (int i = 0; i < string.length; i++) {
        if (string.codeUnitAt(i) >= 0x80) break checkAscii;
      }
      return string.codeUnits;
    }
    return utf8.encode(string);
  }

  /** Convert [object] into UTF-8 encoded JSON. */
  List<int> convert(Object object) {
    List<List<int>> bytes = [];
    // The `stringify` function always converts into chunks.
    // Collect the chunks into the `bytes` list, then combine them afterwards.
    void addChunk(Uint8List chunk, int start, int end) {
      if (start > 0 || end < chunk.length) {
        int length = end - start;
        chunk = new Uint8List.view(
            chunk.buffer, chunk.offsetInBytes + start, length);
      }
      bytes.add(chunk);
    }

    JsonUtf8Stringifier.stringify(
        object, _indent, _toEncodable, _bufferSize, addChunk);
    if (bytes.length == 1) return bytes[0];
    int length = 0;
    for (int i = 0; i < bytes.length; i++) {
      length += bytes[i].length;
    }
    Uint8List result = new Uint8List(length);
    for (int i = 0, offset = 0; i < bytes.length; i++) {
      var byteList = bytes[i];
      int end = offset + byteList.length;
      result.setRange(offset, end, byteList);
      offset = end;
    }
    return result;
  }

  /**
   * Start a chunked conversion.
   *
   * Only one object can be passed into the returned sink.
   *
   * The argument [sink] will receive byte lists in sizes depending on the
   * `bufferSize` passed to the constructor when creating this encoder.
   */
  ChunkedConversionSink<Object> startChunkedConversion(Sink<List<int>> sink) {
    ByteConversionSink byteSink;
    if (sink is ByteConversionSink) {
      byteSink = sink;
    } else {
      byteSink = new ByteConversionSink.from(sink);
    }
    return new _JsonUtf8EncoderSink(
        byteSink, _toEncodable, _indent, _bufferSize);
  }
}

/**
 * Sink returned when starting a chunked conversion from object to bytes.
 */
class _JsonUtf8EncoderSink extends ChunkedConversionSink<Object> {
  /** The byte sink receiving the encoded chunks. */
  final ByteConversionSink _sink;
  final List<int> _indent;
  final ToEncodable _toEncodable;
  final int _bufferSize;
  bool _isDone = false;
  _JsonUtf8EncoderSink(
      this._sink, this._toEncodable, this._indent, this._bufferSize);

  /** Callback called for each slice of result bytes. */
  void _addChunk(Uint8List chunk, int start, int end) {
    _sink.addSlice(chunk, start, end, false);
  }

  void add(Object object) {
    if (_isDone) {
      throw new StateError("Only one call to add allowed");
    }
    _isDone = true;
    JsonUtf8Stringifier.stringify(
        object, _indent, _toEncodable, _bufferSize, _addChunk);
    _sink.close();
  }

  void close() {
    if (!_isDone) {
      _isDone = true;
      _sink.close();
    }
  }
}
