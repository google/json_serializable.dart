import 'dart:convert' hide JsonDecoder;

import 'json_utf8_decoder_sink.dart';

class MyJsonUtf8Decoder extends Converter<List<int>, Object> {
  final bool _allowMalformed;

  MyJsonUtf8Decoder(this._allowMalformed);

  @override
  Object convert(List<int> input) {
    var parser = JsonUtf8DecoderSink.createParser(_allowMalformed);
    parser.chunk = input;
    parser.parse(0, input.length);
    return parser.result;
  }

  @override
  ByteConversionSink startChunkedConversion(Sink<Object> sink) {
    return new JsonUtf8DecoderSink(sink, _allowMalformed);
  }
}
