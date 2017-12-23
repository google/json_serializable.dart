import 'dart:convert' as sdk;
import 'package:json/json.dart';
import 'package:test/test.dart';

import 'package:json/src/listeners/base_listener.dart';
import 'package:json/src/listeners/json_listener.dart';

import 'new_values.dart';

typedef JsonListener<T> Thing<T>(ListenerParent<T> parent);

class _CustomObjectListener<T> extends JsonListener<T>
    implements ListenerParent<T> {
  final Thing<T> _thing;

  T _value;

  _CustomObjectListener(this._thing);

  @override
  JsonListener objectStart() => _thing(this);

  @override
  JsonListener childListenerFinish(T value) {
    _value = value;
    return this;
  }

  @override
  T get result => _value;
}

class _FunListener extends BaseListener<Fun> {
  _FunListener(ListenerParent<Fun> parent) : super(parent);

  String _key;

  int _a;
  String _b;
  bool _c;
  List<Fun> _innerFun;

  @override
  void handleString(String value) {
    switch (_key) {
      case 'b':
        _b = value;
        return;
    }
    storage = value;
  }

  @override
  void handleBool(bool value) {
    switch (_key) {
      case 'c':
        _c = value;
        return;
    }
    storage = value;
  }

  @override
  void propertyName() {
    _key = storage as String;
    assert(_key != null);
  }

  @override
  void propertyValue() {
    switch (_key) {
      case 'a':
        _a = storage as int;
        return;
    }
    _key = null;
  }

  @override
  JsonListener objectEnd() => parent
      .childListenerFinish(new Fun(a: _a, b: _b, c: _c, innerFun: _innerFun));

  @override
  Fun get result => throw new UnsupportedError('sorry');
}

main() {
  newTestItems.forEach((k, v) {
    if (v is! Fun) {
      return;
    }
    final sdkString = sdk.json.encode(v);
    test(k, () {
      final decodedObject = parseJsonExperimental(sdkString,
          new _CustomObjectListener<Fun>((parent) => new _FunListener(parent)));

      final reEncodedString = sdk.json.encode(decodedObject);
      expect(reEncodedString, sdkString);
    });
  });
}
