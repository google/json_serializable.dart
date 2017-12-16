import 'base_listener.dart';
import 'json_listener.dart';

JsonListener anyValueListener() => new _AnyValueListener(null);

class _AnyValueListener extends BaseListener<Object> {
  _AnyValueListener(BaseListener parent) : super(parent);

  @override
  Object get result => storage;
}
