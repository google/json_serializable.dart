// ignore_for_file: slash_for_doc_comments

import 'dart:typed_data' show Uint8List;

/**
 * Buffer holding parts of a numeral.
 *
 * The buffer contains the characters of a JSON number.
 * These are all ASCII, so an [Uint8List] is used as backing store.
 *
 * This buffer is used when a JSON number is split between separate chunks.
 *
 */
class NumberBuffer {
  static const int kDefaultOverhead = 5;
  Uint8List list;
  int length = 0;
  NumberBuffer(int initialCapacity)
      : list = new Uint8List(_initialCapacity(initialCapacity));

  // Pick an initial capacity greater than the first part's size.
  // The typical use case has two parts, this is the attempt at
  // guessing the size of the second part without overdoing it.
  // The default estimate of the second part is [kDefaultOverhead],
  // then round to multiple of four, and return the result,
  // or [minCapacity] if that is greater.
  static int _initialCapacity(int minCapacity) {
    minCapacity += kDefaultOverhead;
    if (minCapacity < minCapacity) return minCapacity;
    minCapacity = (minCapacity + 3) & ~3; // Round to multiple of four.
    return minCapacity;
  }

  // Grows to the exact size asked for.
  void ensureCapacity(int newCapacity) {
    Uint8List list = this.list;
    if (newCapacity <= list.length) return;
    Uint8List newList = new Uint8List(newCapacity);
    newList.setRange(0, list.length, list, 0);
    this.list = newList;
  }

  String _getString() => new String.fromCharCodes(list, 0, length);

  // TODO(lrn): See if parsing of numbers can be abstracted to something
  // not only working on strings, but also on char-code lists, without loosing
  // performance.
  int parseInt() => int.parse(_getString());
  double parseDouble() => double.parse(_getString());
}
