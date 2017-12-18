import 'base_listener.dart';
import 'container_listener.dart';
import 'json_listener.dart';

class ObjectListener extends ContainerListener<Map<String, dynamic>> {
  String _key;

  ObjectListener(BaseListener parent) : super(<String, dynamic>{}, parent);

  @override
  void propertyName() {
    _key = storage as String;
    assert(_key != null);
  }

  @override
  void propertyValue() {
    result[_key] = storage;
  }

  @override
  JsonListener objectEnd() => parent.childListenerFinish(result);
}
