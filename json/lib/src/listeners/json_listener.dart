import 'package:meta/meta.dart';

/// Listener for parsing events from `ChunkedJsonParser`.
abstract class JsonListener<T> {
  void handleString(String value) => _notImplemented();
  void handleNumber(num value) => _notImplemented();
  void handleBool(bool value) => _notImplemented();
  void handleNull() => _notImplemented();

  JsonListener objectStart() => _notImplemented();
  void propertyName() => _notImplemented();
  void propertyValue() => _notImplemented();
  JsonListener objectEnd() => _notImplemented();

  JsonListener arrayStart() => _notImplemented();
  void arrayElement() => _notImplemented();
  JsonListener arrayEnd() => _notImplemented();

  /// Read out the final result of parsing a JSON string.
  ///
  /// Must only be called when the entire input has been parsed.
  T get result;

  @alwaysThrows
  T _notImplemented<T>() {
    throw new UnsupportedError('Nope - $runtimeType');
  }
}
