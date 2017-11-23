// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'dart:convert' hide JsonDecoder;

import 'my_json_decoder.dart';
import 'reviver_json_listener.dart';

typedef _ToEncodable(var o);

const json = const MyJsonCodec();

/**
 * A [MyJsonCodec] encodes JSON objects to strings and decodes strings to
 * JSON objects.
 *
 * Examples:
 *
 *     var encoded = json.encode([1, 2, { "a": null }]);
 *     var decoded = json.decode('["foo", { "bar": 499 }]');
 */
class MyJsonCodec extends Codec<Object, String> {
  final Reviver _reviver;
  final _ToEncodable _toEncodable;

  /**
   * Creates a `JsonCodec` with the given reviver and encoding function.
   *
   * The [reviver] function is called during decoding. It is invoked once for
   * each object or list property that has been parsed.
   * The `key` argument is either the integer list index for a list property,
   * the string map key for object properties, or `null` for the final result.
   *
   * If [reviver] is omitted, it defaults to returning the value argument.
   *
   * The [toEncodable] function is used during encoding. It is invoked for
   * values that are not directly encodable to a string (a value that is not a
   * number, boolean, string, null, list or a map with string keys). The
   * function must return an object that is directly encodable. The elements of
   * a returned list and values of a returned map do not need to be directly
   * encodable, and if they aren't, `toEncodable` will be used on them as well.
   * Please notice that it is possible to cause an infinite recursive regress
   * in this way, by effectively creating an infinite data structure through
   * repeated call to `toEncodable`.
   *
   * If [toEncodable] is omitted, it defaults to a function that returns the
   * result of calling `.toJson()` on the unencodable object.
   */
  const MyJsonCodec({Reviver reviver, toEncodable(var object)})
      : _reviver = reviver,
        _toEncodable = toEncodable;

  /**
   * Creates a `JsonCodec` with the given reviver.
   *
   * The [reviver] function is called once for each object or list property
   * that has been parsed during decoding. The `key` argument is either the
   * integer list index for a list property, the string map key for object
   * properties, or `null` for the final result.
   */
  MyJsonCodec.withReviver(reviver(var key, var value)) : this(reviver: reviver);

  /**
   * Parses the string and returns the resulting Json object.
   *
   * The optional [reviver] function is called once for each object or list
   * property that has been parsed during decoding. The `key` argument is either
   * the integer list index for a list property, the string map key for object
   * properties, or `null` for the final result.
   *
   * The default [reviver] (when not provided) is the identity function.
   */
  @override
  dynamic decode(String source, {Reviver reviver}) {
    if (reviver == null) reviver = _reviver;
    if (reviver == null) return decoder.convert(source);
    return new MyJsonDecoder(reviver).convert(source);
  }

  /**
   * Converts [value] to a JSON string.
   *
   * If value contains objects that are not directly encodable to a JSON
   * string (a value that is not a number, boolean, string, null, list or a map
   * with string keys), the [toEncodable] function is used to convert it to an
   * object that must be directly encodable.
   *
   * If [toEncodable] is omitted, it defaults to a function that returns the
   * result of calling `.toJson()` on the unencodable object.
   */
  @override
  String encode(Object value, {toEncodable(object)}) {
    if (toEncodable == null) toEncodable = _toEncodable;
    if (toEncodable == null) return encoder.convert(value);
    return new JsonEncoder(toEncodable).convert(value);
  }

  @override
  JsonEncoder get encoder {
    if (_toEncodable == null) return const JsonEncoder();
    return new JsonEncoder(_toEncodable);
  }

  @override
  MyJsonDecoder get decoder {
    if (_reviver == null) return const MyJsonDecoder();
    return new MyJsonDecoder(_reviver);
  }
}

//// Implementation ///////////////////////////////////////////////////////////
