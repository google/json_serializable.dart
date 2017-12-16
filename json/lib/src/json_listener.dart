/// Listener for parsing events from `ChunkedJsonParser`.
abstract class JsonListener {
  void handleString(String value);
  void handleNumber(num value);
  void handleBool(bool value);
  void handleNull();

  JsonListener objectStart();
  void propertyName();
  void propertyValue();
  JsonListener objectEnd();

  JsonListener arrayStart();
  void arrayElement();
  JsonListener arrayEnd();

  /// Read out the final result of parsing a JSON string.
  ///
  /// Must only be called when the entire input has been parsed.
  Object get result;
}
