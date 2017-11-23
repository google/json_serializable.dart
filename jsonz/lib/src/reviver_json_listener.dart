import 'build_json_listener.dart';

typedef Reviver(dynamic key, dynamic value);

class ReviverJsonListener extends BuildJsonListener {
  final Reviver reviver;
  ReviverJsonListener(this.reviver);

  @override
  void arrayElement() {
    List list = currentContainer;
    value = reviver(list.length, value);
    super.arrayElement();
  }

  @override
  void propertyValue() {
    value = reviver(key, value);
    super.propertyValue();
  }

  @override
  get result {
    return reviver(null, value);
  }
}
