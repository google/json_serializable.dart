// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'json_listener.dart';

/**
 * A [JsonListener] that builds data objects from the parser events.
 *
 * This is a simple stack-based object builder. It keeps the most recently
 * seen value in a variable, and uses it depending on the following event.
 */
class BuildJsonListener extends JsonListener {
  /**
   * Stack used to handle nested containers.
   *
   * The current container is pushed on the stack when a new one is
   * started. If the container is a [Map], there is also a current [_key]
   * which is also stored on the stack.
   */
  final _stack = [];
  /** The current [Map] or [List] being built. */
  Object _currentContainer;
  /** The most recently read property key. */
  String _key;
  /** The most recently read value. */
  Object _value;

  /** Pushes the currently active container */
  void _pushContainer() {
    _stack.add(_currentContainer);
  }

  /** Pops the top container from the [_stack], including a key if applicable. */
  void _popContainer() {
    _value = _currentContainer;
    _currentContainer = _stack.removeLast();
  }

  @override
  void handleString(String value) {
    _value = value;
  }

  @override
  void handleNumber(num value) {
    _value = value;
  }

  @override
  void handleBool(bool value) {
    _value = value;
  }

  @override
  void handleNull() {
    _value = null;
  }

  @override
  JsonListener objectStart() {
    _stack.add(_key);
    _pushContainer();
    _currentContainer = <String, dynamic>{};
    return this;
  }

  @override
  void propertyName() {
    _key = _value as String;
    _value = null;
  }

  @override
  void propertyValue() {
    Map map = _currentContainer;
    map[_key] = _value;
    _key = _value = null;
  }

  @override
  JsonListener objectEnd() {
    _popContainer();
    _key = _stack.removeLast() as String;
    return this;
  }

  @override
  JsonListener arrayStart() {
    _pushContainer();
    _currentContainer = [];
    return this;
  }

  @override
  void arrayElement() {
    (_currentContainer as List).add(_value);
    _value = null;
  }

  @override
  JsonListener arrayEnd() {
    _popContainer();
    return this;
  }

  /** Read out the final result of parsing a JSON string. */
  @override
  get result {
    assert(_stack.isEmpty);
    assert(_currentContainer == null);
    return _value;
  }
}
