import 'dart:convert' as sdk;
import 'package:json/json.dart';
import 'package:test/test.dart';

import 'package:json/src/listeners/base_listener.dart';
import 'package:json/src/listeners/json_listener.dart';
import 'package:json/src/listeners/array_listener.dart';
import 'package:json/src/listeners/custom_object_listener_root.dart';

import 'fun_class.dart';
import 'new_values.dart';

class _FunListener extends CustomObjectListenerBase<Fun> {
  static CustomObjectListenerRoot<Fun> create() =>
      new CustomObjectListenerRoot<Fun>((parent) => new _FunListener(parent));

  _FunListener(ListenerParent parent) : super(parent);

  int _a;
  String _b;
  bool _c;
  Fun _child;
  List<Fun> _innerFun;
  List<DateTime> _dates;

  @override
  void handleNumber(num value) {
    switch (key) {
      case 'a':
        _a = value as int;
        storage = null;
        return;
    }
    super.handleNumber(value);
  }

  @override
  void handleString(String value) {
    switch (key) {
      case 'b':
        _b = value;
        storage = null;
        return;
    }
    super.handleString(value);
  }

  @override
  void handleBool(bool value) {
    switch (key) {
      case 'c':
        _c = value;
        storage = null;
        return;
    }
    super.handleBool(value);
  }

  @override
  void propertyValue() {
    switch (key) {
      case 'child':
        _child = storage as Fun;
        break;
      case 'innerFun':
        _innerFun = storage as List<Fun>;
        break;
      case 'dates':
        _dates = storage as List<DateTime>;
        break;
      case 'a':
      case 'b':
      case 'c':
        // handled closer to the supported type
        break;
      default:
      // throw? We have properties that are not supported
    }
    super.propertyValue();
  }

  @override
  JsonListener objectStart() {
    switch (key) {
      case 'child':
        return new _FunListener(this);
    }
    return super.objectStart();
  }

  @override
  JsonListener arrayStart() {
    switch (key) {
      case 'dates':
        return new StringConvertArrayListener<DateTime>(DateTime.parse, this);
    }
    return super.arrayStart();
  }

  @override
  Fun get result => new Fun(
      a: _a, b: _b, c: _c, innerFun: _innerFun, child: _child, dates: _dates);
}

main() {
  newTestItems.forEach((k, v) {
    if (v is! Fun) {
      return;
    }
    final sdkString = sdk.json.encode(v);
    test(k, () {
      final decodedObject =
          parseJsonExperimental(sdkString, _FunListener.create());

      final reEncodedString = sdk.json.encode(decodedObject);
      expect(reEncodedString, sdkString);
    });
  });
}
