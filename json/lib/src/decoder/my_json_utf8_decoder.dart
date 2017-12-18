import '../dart_convert_exports.dart';
import '../listeners/any_value_listener.dart';
import '../parser/json_utf8_parser.dart';
import 'json_utf8_decoder_sink.dart';

// TODO(kevmoo): test!
class MyJsonUtf8Decoder extends Converter<List<int>, Object> {
  final bool _allowMalformed;

  const MyJsonUtf8Decoder({bool allowMalformed})
      : _allowMalformed = allowMalformed ?? false;

  @override
  Object convert(List<int> input) {
    var parser = new JsonUtf8Parser(anyValueListener(), _allowMalformed);
    parser.parse(input, 0, input.length);
    return parser.close();
  }

  @override
  ByteConversionSink startChunkedConversion(Sink<Object> sink) {
    return new JsonUtf8DecoderSink(sink, _allowMalformed);
  }
}
