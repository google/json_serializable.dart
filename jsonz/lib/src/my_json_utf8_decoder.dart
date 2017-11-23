import 'dart:convert' hide JsonDecoder;

import 'json_utf8_decoder_sink.dart';
import 'reviver_json_listener.dart';

class MyJsonUtf8Decoder extends Converter<List<int>, Object> {
  final Reviver _reviver;
  final bool _allowMalformed;

  MyJsonUtf8Decoder(this._reviver, this._allowMalformed);

  @override
  Object convert(List<int> input) {
    var parser = JsonUtf8DecoderSink.createParser(_reviver, _allowMalformed);
    parser.chunk = input;
    parser.chunkEnd = input.length;
    parser.parse(0);
    return parser.result;
  }

  @override
  ByteConversionSink startChunkedConversion(Sink<Object> sink) {
    return new JsonUtf8DecoderSink(_reviver, sink, _allowMalformed);
  }
}
