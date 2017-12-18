// ignore_for_file: slash_for_doc_comments, annotate_overrides, prefer_single_quotes

import 'dart:async';

import '../dart_convert_exports.dart';
import 'errors.dart';
import 'json_string_stringifier.dart';
import 'json_utf8_encoder.dart';
import 'to_encodable.dart';

/**
 * This class converts JSON objects to strings.
 */
class JsonEncoder extends Converter<Object, String> {
  /**
   * The string used for indention.
   *
   * When generating multi-line output, this string is inserted once at the
   * beginning of each indented line for each level of indentation.
   *
   * If `null`, the output is encoded as a single line.
   */
  final String indent;

  /**
   * Function called on non-encodable objects to return a replacement
   * encodable object that will be encoded in the orignal's place.
   */
  final ToEncodable _toEncodable;

  /**
   * Creates a JSON encoder.
   *
   * The JSON encoder handles numbers, strings, booleans, null, lists and
   * maps with string keys directly.
   *
   * Any other object is attempted converted by [toEncodable] to an
   * object that is of one of the convertible types.
   *
   * If [toEncodable] is omitted, it defaults to calling `.toJson()` on
   * the object.
   *
   * The encoding of elements of lists and maps are indented and put on separate
   * lines. The [indent] string is prepended to these elements, once for each
   * level of indentation.
   *
   * If [indent] is `null`, the output is encoded as a single line.
   */
  const JsonEncoder({toEncodable(object), this.indent})
      : this._toEncodable = toEncodable;

  /**
   * Converts [object] to a JSON [String].
   *
   * Directly serializable values are [num], [String], [bool], and [Null], as
   * well as some [List] and [Map] values. For [List], the elements must all be
   * serializable. For [Map], the keys must be [String] and the values must be
   * serializable.
   *
   * If a value of any other type is attempted to be serialized, the
   * `toEncodable` function provided in the constructor is called with the value
   * as argument. The result, which must be a directly serializable value, is
   * serialized instead of the original value.
   *
   * If the conversion throws, or returns a value that is not directly
   * serializable, a [JsonUnsupportedObjectError] exception is thrown.
   * If the call throws, the error is caught and stored in the
   * [JsonUnsupportedObjectError]'s [:cause:] field.
   *
   * If a [List] or [Map] contains a reference to itself, directly or through
   * other lists or maps, it cannot be serialized and a [JsonCyclicError] is
   * thrown.
   *
   * [object] should not change during serialization.
   *
   * If an object is serialized more than once, [convert] may cache the text
   * for it. In other words, if the content of an object changes after it is
   * first serialized, the new values may not be reflected in the result.
   */
  String convert(Object object) =>
      JsonStringStringifier.stringify(object, _toEncodable, indent);

  /**
   * Starts a chunked conversion.
   *
   * The converter works more efficiently if the given [sink] is a
   * [StringConversionSink].
   *
   * Returns a chunked-conversion sink that accepts at most one object. It is
   * an error to invoke `add` more than once on the returned sink.
   */
  ChunkedConversionSink<Object> startChunkedConversion(Sink<String> sink) {
    final scs = (sink is StringConversionSink)
        ? sink
        : new StringConversionSink.from(sink);

    // NOTE: no access to private _Utf8EncoderSink
    //else if (sink is _Utf8EncoderSink) {
    //  return new _JsonUtf8EncoderSink(
    //      sink._sink,
    //      _toEncodable,
    //      JsonUtf8Encoder._utf8Encode(indent),
    //      JsonUtf8Encoder._defaultBufferSize);
    //}

    return new _JsonEncoderSink(scs, _toEncodable, indent);
  }

  // Override the base class's bind, to provide a better type.
  Stream<String> bind(Stream<Object> stream) => super.bind(stream);

  Converter<Object, T> fuse<T>(Converter<String, T> other) {
    if (other is Utf8Encoder) {
      // The instance check guarantees that `T` is (a subtype of) List<int>,
      // but the static type system doesn't know that, and so we cast.
      // Cast through dynamic to keep the cast implicit for builds using
      // unchecked implicit casts.
      return new JsonUtf8Encoder(indent: indent, toEncodable: _toEncodable)
          as Converter<Object, T>;
    }
    return super.fuse<T>(other);
  }
}

/**
 * Implements the chunked conversion from object to its JSON representation.
 *
 * The sink only accepts one value, but will produce output in a chunked way.
 */
class _JsonEncoderSink extends ChunkedConversionSink<Object> {
  final String _indent;
  final ToEncodable _toEncodable;
  final StringConversionSink _sink;
  bool _isDone = false;

  _JsonEncoderSink(this._sink, this._toEncodable, this._indent);

  /**
   * Encodes the given object [o].
   *
   * It is an error to invoke this method more than once on any instance. While
   * this makes the input effectively non-chunked the output will be generated
   * in a chunked way.
   */
  void add(Object o) {
    if (_isDone) {
      throw new StateError("Only one call to add allowed");
    }
    _isDone = true;
    ClosableStringSink stringSink = _sink.asStringSink();
    JsonStringStringifier.printOn(o, stringSink, _toEncodable, _indent);
    stringSink.close();
  }

  void close() {/* do nothing */}
}
