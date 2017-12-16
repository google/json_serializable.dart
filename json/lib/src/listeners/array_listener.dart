import 'base_listener.dart';
import 'container_listener.dart';
import 'json_listener.dart';

class ArrayListener extends ContainerListener<List> {
  ArrayListener(BaseListener parent) : super([], parent);

  @override
  void arrayElement() {
    result.add(storage);
    storage = null;
  }

  @override
  JsonListener arrayEnd() => parent.finish(result);
}
