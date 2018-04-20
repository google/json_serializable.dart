import 'base_listener.dart';
import 'json_listener.dart';

typedef JsonListener<T> ListenerFactory<T>(ListenerParent<T> parent);

class CustomObjectListenerRoot<T> extends JsonListener<T>
    implements ListenerParent<T> {
  final ListenerFactory<T> _factory;

  T _value;

  CustomObjectListenerRoot(this._factory);

  @override
  JsonListener objectStart() => _factory(this);

  @override
  JsonListener childListenerFinish(T value) {
    _value = value;
    return this;
  }

  @override
  T get result => _value;
}
