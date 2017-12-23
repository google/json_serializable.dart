import 'package:meta/meta.dart';

import 'array_listener.dart';
import 'json_listener.dart';
import 'object_listener.dart';

abstract class ListenerParent<T> {
  JsonListener childListenerFinish(T value);
}

abstract class BaseListener<T> extends JsonListener<T>
    implements ListenerParent<Object> {
  final ListenerParent parent;

  BaseListener(this.parent);

  @protected
  Object storage;

  @protected
  @override
  JsonListener childListenerFinish(Object value) {
    assert(value != null);
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
  JsonListener objectStart() {
    return new ObjectListener(this);
  }

  @override
  JsonListener arrayStart() {
    return new ArrayListener(this);
  }
}
