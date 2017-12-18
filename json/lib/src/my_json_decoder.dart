// ignore_for_file: slash_for_doc_comments

import 'dart_convert_exports.dart';
import 'json_string_decoder_sink.dart';
import 'json_string_parser.dart';
import 'listeners/build_json_listener.dart';

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
}

Object _parseJson(String source) {
  final listener = anyValueListener();
  var parser = new JsonStringParser(listener);
  parser.parse(source, 0, source.length);
  parser.close();
  return listener.result;
}
