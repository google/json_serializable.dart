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
   * started. If the container is a [Map], there is also a current [key]
   * which is also stored on the stack.
   */
  final _stack = [];
  /** The current [Map] or [List] being built. */
  Object currentContainer;
  /** The most recently read property key. */
  String key;
  /** The most recently read value. */
  Object value;

  /** Pushes the currently active container (and key, if a [Map]). */
  void _pushContainer() {
    _stack.add(currentContainer);
  }

  /** Pops the top container from the [_stack], including a key if applicable. */
  void _popContainer() {
    value = currentContainer;
    currentContainer = _stack.removeLast();
  }

  @override
  void handleString(String value) {
    this.value = value;
  }

  @override
  void handleNumber(num value) {
    this.value = value;
  }

  @override
  void handleBool(bool value) {
    this.value = value;
  }

  @override
  void handleNull() {
    this.value = null;
  }

  @override
  void beginObject() {
    _stack.add(key);
    _pushContainer();
    currentContainer = <String, dynamic>{};
  }

  @override
  void propertyName() {
    key = value as String;
    value = null;
  }

  @override
  void propertyValue() {
    Map map = currentContainer;
    map[key] = value;
    key = value = null;
  }

  @override
  void endObject() {
    _popContainer();
    key = _stack.removeLast() as String;
  }

  @override
  void beginArray() {
    _pushContainer();
    currentContainer = [];
  }

  @override
  void arrayElement() {
    List list = currentContainer;
    list.add(value);
    value = null;
  }

  @override
  void endArray() {
    _popContainer();
  }

  /** Read out the final result of parsing a JSON string. */
  @override
  get result {
    assert(currentContainer == null);
    return value;
  }
}
