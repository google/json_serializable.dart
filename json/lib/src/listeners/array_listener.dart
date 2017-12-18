import 'base_listener.dart';
import 'container_listener.dart';
import 'json_listener.dart';

class ArrayListener<T> extends ContainerListener<List<T>> {
  ArrayListener(BaseListener parent) : super(<T>[], parent);

  @override
  void arrayElement() {
    result.add(storage as T);
  }

  @override
  JsonListener arrayEnd() => parent.childListenerFinish(result);
}
