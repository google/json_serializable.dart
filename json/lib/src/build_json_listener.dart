// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'json_listener.dart';

JsonListener anyValueListener() => new _AnyValueListener();

class _ObjectListener extends _ContainerListener<Map<String, dynamic>> {
  String _key;

  _ObjectListener([_BaseListener parent]) : super(<String, dynamic>{}, parent);

  @override
  void propertyName() {
    _key = _value as String;
    assert(_key != null);
    _value = null;
  }

  @override
  void propertyValue() {
    result[_key] = _value;
    _key = _value = null;
  }

  @override
  JsonListener objectEnd() => _parent.finish(result);
}

class _ArrayListener extends _ContainerListener<List> {
  _ArrayListener([_BaseListener parent]) : super([], parent);

  @override
  void arrayElement() {
    result.add(_value);
    _value = null;
  }

  @override
  JsonListener arrayEnd() => _parent.finish(result);
}

class _ContainerListener<T> extends _BaseListener<T> {
  @override
  final T result;

  _ContainerListener(this.result, [_BaseListener parent]) : super(parent);
}

class _AnyValueListener extends _BaseListener<Object> {
  _AnyValueListener([_BaseListener parent]) : super(parent);

  /** Read out the final result of parsing a JSON string. */
  @override
  Object get result => _value;
}

/**
 * A [JsonListener] that builds data objects from the parser events.
 *
 * This is a simple stack-based object builder. It keeps the most recently
 * seen value in a variable, and uses it depending on the following event.
 */
abstract class _BaseListener<T> extends JsonListener<T> {
  final _BaseListener _parent;

  _BaseListener([this._parent]);

  /** The most recently read value. */
  Object _value;

  JsonListener finish(Object value) {
    assert(value != null);
    assert(_value == null);
    _value = value;
    return this;
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
  JsonListener objectStart() => new _ObjectListener(this);

  @override
  JsonListener arrayStart() => new _ArrayListener(this);
}
