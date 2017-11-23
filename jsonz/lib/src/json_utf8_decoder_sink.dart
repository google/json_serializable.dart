// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:convert' hide JsonDecoder;

import 'build_json_listener.dart';
import 'json_utf8_parser.dart';
import 'reviver_json_listener.dart';

/**
 * Implements the chunked conversion from a UTF-8 encoding of JSON
 * to its corresponding object.
 */
class JsonUtf8DecoderSink extends ByteConversionSinkBase {
  final JsonUtf8Parser _parser;
  final Sink<Object> _sink;

  JsonUtf8DecoderSink(Reviver reviver, this._sink, bool allowMalformed)
      : _parser = createParser(reviver, allowMalformed);

  static JsonUtf8Parser createParser(Reviver reviver, bool allowMalformed) {
    BuildJsonListener listener;
    if (reviver == null) {
      listener = new BuildJsonListener();
    } else {
      listener = new ReviverJsonListener(reviver);
    }
    return new JsonUtf8Parser(listener, allowMalformed);
  }

  @override
  void addSlice(List<int> chunk, int start, int end, bool isLast) {
    _addChunk(chunk, start, end);
    if (isLast) close();
  }

  @override
  void add(List<int> chunk) {
    _addChunk(chunk, 0, chunk.length);
  }

  void _addChunk(List<int> chunk, int start, int end) {
    _parser.chunk = chunk;
    _parser.chunkEnd = end;
    _parser.parse(start);
  }

  @override
  void close() {
    _parser.close();
    var decoded = _parser.result;
    _sink.add(decoded);
    _sink.close();
  }
}
