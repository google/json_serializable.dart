// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'package:test/test.dart';
import 'package:json/json.dart';

import "src/expect.dart";

class Pair<T> {
  final List<int> bytes;
  final T target;

  const Pair(this.bytes, this.target);
}

void testAll<T>(Iterable<T> items, testBody(T item)) {
  var count = 1;
  for (var item in items) {
    test('item ${count++}', () => testBody(item));
  }
}

void testThrows(String jsonText) {
  test(jsonText, () {
    Expect.throwsFormatException(
        () => json.decode(jsonText), "json = '${escape(jsonText)}'");
  });
}

void testJson(String jsonText, expected) {
  compare(expected, actual, String path) {
    if (expected is List) {
      Expect.isTrue(actual is List);
      Expect.equals(
          expected.length, (actual as List).length, "$path: List length");
      for (int i = 0; i < expected.length; i++) {
        compare(expected[i], actual[i], "$path[$i]");
      }
    } else if (expected is Map) {
      Expect.isTrue(actual is Map);
      Expect.equals(expected.length, (actual as Map).length, "$path: Map size");
      expected.forEach((key, value) {
        Expect.isTrue(actual.containsKey(key));
        compare(value, actual[key], "$path[$key]");
      });
    } else if (expected is num) {
      Expect.equals(expected is int, actual is int, "$path: same number type");
      Expect.isTrue(expected.compareTo(actual as num) == 0,
          "$path: Expected: $expected, was: $actual");
    } else {
      // String, bool, null.
      Expect.equals(expected, actual, path);
    }
  }

  group('chunked conversion for `$jsonText`', () {
    for (var split in [0, 1, 2, 3]) {
      test("with split `$split`", () {
        var sink = new ChunkedConversionSink.withCallback((values) {
          var value = values[0];
          compare(expected, value, "$value");
        });
        var decoderSink = json.decoder.startChunkedConversion(sink);
        switch (split) {
          case 0:
            // Split after first char.
            decoderSink.add(jsonText.substring(0, 1));
            decoderSink.add(jsonText.substring(1));
            decoderSink.close();
            break;
          case 1:
            // Split before last char.
            int length = jsonText.length;
            decoderSink.add(jsonText.substring(0, length - 1));
            decoderSink.add(jsonText.substring(length - 1));
            decoderSink.close();
            break;
          case 2:
            // Split in middle.
            int half = jsonText.length ~/ 2;
            decoderSink.add(jsonText.substring(0, half));
            decoderSink.add(jsonText.substring(half));
            decoderSink.close();
            break;
          case 3:
            // Split in three chunks.
            int length = jsonText.length;
            int third = length ~/ 3;
            decoderSink.add(jsonText.substring(0, third));
            decoderSink.add(jsonText.substring(third, 2 * third));
            decoderSink.add(jsonText.substring(2 * third));
            decoderSink.close();
            break;
        }
      });
    }
  });
}
