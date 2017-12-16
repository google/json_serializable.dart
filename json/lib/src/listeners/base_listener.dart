
import 'array_listener.dart';
import 'json_listener.dart';
import 'object_listener.dart';

abstract class BaseListener<T> extends JsonListener<T> {
  final BaseListener parent;

  BaseListener(this.parent);

  Object _storage;

  set storage(Object value) {
    _storage = value;
  }

  Object get storage => _storage;

  JsonListener finish(Object value) {
    assert(value != null);
    assert(storage == null);
    storage = value;
    return this;
  }

  @override
  void handleString(String value) {
    storage = value;
  }

  @override
  void handleNumber(num value) {
    storage = value;
  }

  @override
  void handleBool(bool value) {
    storage = value;
  }

  @override
  void handleNull() {
    storage = null;
  }

  @override
  JsonListener objectStart() => new ObjectListener(this);

  @override
  JsonListener arrayStart() => new ArrayListener(this);
}
