// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:convert' hide JsonDecoder;

import 'build_json_listener.dart';
import 'json_string_parser.dart';
import 'json_utf8_decoder_sink.dart';

/**
 * Implements the chunked conversion from a JSON string to its corresponding
 * object.
 *
 * The sink only creates one object, but its input can be chunked.
 */
class JsonStringDecoderSink extends StringConversionSinkBase {
  JsonStringParser _parser;
  final Sink<Object> _sink;

  JsonStringDecoderSink(this._sink)
      : _parser = new JsonStringParser(new BuildJsonListener());

  @override
  void addSlice(String chunk, int start, int end, bool isLast) {
    _parser.parse(chunk, start, end);
    if (isLast) _parser.close();
  }

  @override
  void add(String chunk) {
    addSlice(chunk, 0, chunk.length, false);
  }

  @override
  void close() {
    var decoded = _parser.close();
    _sink.add(decoded);
    _sink.close();
  }

  @override
  ByteConversionSink asUtf8Sink(bool allowMalformed) {
    _parser = null;
    return new JsonUtf8DecoderSink(_sink, allowMalformed);
  }
}
