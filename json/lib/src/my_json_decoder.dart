// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:async';
import 'dart:convert' hide JsonDecoder;

import 'build_json_listener.dart';
import 'json_string_decoder_sink.dart';
import 'json_string_parser.dart';

/**
 * This class parses JSON strings and builds the corresponding objects.
 */
class MyJsonDecoder extends Converter<String, Object> {
  /**
   * Constructs a new JsonDecoder.
   */
  const MyJsonDecoder();

  /**
   * Converts the given JSON-string [input] to its corresponding object.
   *
   * Parsed JSON values are of the types [num], [String], [bool], [Null],
   * [List]s of parsed JSON values or [Map]s from [String] to parsed JSON
   * values.
   *
   * If `this` was initialized with a reviver, then the parsing operation
   * invokes the reviver on every object or list property that has been parsed.
   * The arguments are the property name ([String]) or list index ([int]), and
   * the value is the parsed value. The return value of the reviver is used as
   * the value of that property instead the parsed value.
   *
   * Throws [FormatException] if the input is not valid JSON text.
   */
  @override
  dynamic convert(String input) => _parseJson(input);

  /**
   * Starts a conversion from a chunked JSON string to its corresponding object.
   *
   * The output [sink] receives exactly one decoded element through `add`.
   */
  @override
  StringConversionSink startChunkedConversion(Sink<Object> sink) {
    return new JsonStringDecoderSink(sink);
  }

  // Override the base class's bind, to provide a better type.
  @override
  Stream<Object> bind(Stream<String> stream) => super.bind(stream);
}

_parseJson(String source) {
  final listener = new BuildJsonListener();
  var parser = new JsonStringParser(listener);
  parser.chunk = source;
  parser.chunkEnd = source.length;
  parser.parse(0);
  parser.close();
  return listener.result;
}
