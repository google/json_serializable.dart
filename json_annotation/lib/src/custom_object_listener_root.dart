import 'package:json/json.dart';

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

abstract class CustomObjectListenerBase<T> extends BaseListener<T> {
  CustomObjectListenerBase(ListenerParent parent) : super(parent);
  String _key;

  String get key => _key;

  @override
  void propertyName() {
    _key = storage as String;
    assert(_key != null);
    storage = null;
  }

  @override
  JsonListener objectEnd() {
    return parent.childListenerFinish(result);
  }

  @override
  void propertyValue() {
    _key = null;
  }
}
