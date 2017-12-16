/// Listener for parsing events from `ChunkedJsonParser`.
abstract class JsonListener<T> {
  void handleString(String value) => throw new UnsupportedError('Nope!');
  void handleNumber(num value) => throw new UnsupportedError('Nope!');
  void handleBool(bool value) => throw new UnsupportedError('Nope!');
  void handleNull() => throw new UnsupportedError('Nope!');

  JsonListener objectStart() => throw new UnsupportedError('Nope!');
  void propertyName() => throw new UnsupportedError('Nope!');
  void propertyValue() => throw new UnsupportedError('Nope!');
  JsonListener objectEnd() => throw new UnsupportedError('Nope!');

  JsonListener arrayStart() => throw new UnsupportedError('Nope!');
  void arrayElement() => throw new UnsupportedError('Nope!');
  JsonListener arrayEnd() => throw new UnsupportedError('Nope!');

  /// Read out the final result of parsing a JSON string.
  ///
  /// Must only be called when the entire input has been parsed.
  T get result;
}
