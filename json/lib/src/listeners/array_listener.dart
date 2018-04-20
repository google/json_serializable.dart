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

class StringConvertArrayListener<T> extends ContainerListener<List<T>> {
  final T Function(String) convert;

  StringConvertArrayListener(this.convert, BaseListener parent)
      : super(<T>[], parent);

  @override
  void handleString(String value) {
    result.add(convert(value));
  }

  @override
  void handleNull() {
    result.add(null);
  }

  @override
  void arrayElement() {
    assert(storage == null);
  }

  @override
  JsonListener arrayEnd() => parent.childListenerFinish(result);
}
