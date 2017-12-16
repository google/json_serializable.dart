import 'base_listener.dart';

class ContainerListener<T> extends BaseListener<T> {
  @override
  final T result;

  ContainerListener(this.result, BaseListener parent) : super(parent);
}
