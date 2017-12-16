/// Listener for parsing events from `ChunkedJsonParser`.
abstract class JsonListener {
  void handleString(String value) {}
  void handleNumber(num value) {}
  void handleBool(bool value) {}
  void handleNull() {}
  void beginObject() {}
  void propertyName() {}
  void propertyValue() {}
  void endObject() {}
  void beginArray() {}
  void arrayElement() {}
  void endArray() {}

  /// Read out the final result of parsing a JSON string.
  ///
  /// Must only be called when the entire input has been parsed.
  Object get result;
}
