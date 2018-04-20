import 'dart:convert' as sdk;
import 'package:json/json.dart';
import 'package:test/test.dart';

import 'package:json/src/listeners/base_listener.dart';
import 'package:json/src/listeners/json_listener.dart';
import 'package:json/src/listeners/array_listener.dart';

//import 'package:stack_trace/stack_trace.dart';

import 'new_values.dart';

typedef JsonListener<T> Thing<T>(ListenerParent<T> parent);

class _CustomObjectListener<T> extends JsonListener<T>
    implements ListenerParent<T> {
  final Thing<T> _thing;

  T _value;

  _CustomObjectListener(this._thing) {
    _log('starting');
  }

  @override
  JsonListener objectStart() => _thing(this);

  @override
  JsonListener childListenerFinish(T value) {
    _value = value;
    _log(value);
    return this;
  }

  @override
  T get result => _value;
}

void _log(value) {
//  print(
//      [new Trace.from(StackTrace.current).frames[1].member, value].join('\t'));
}

class _FunListener extends BaseListener<Fun> {
  static _CustomObjectListener<Fun> create() =>
      new _CustomObjectListener<Fun>((parent) => new _FunListener(parent));

  _FunListener(ListenerParent parent) : super(parent);

  String _key;

  int _a;
  String _b;
  bool _c;
  Fun _child;
  List<Fun> _innerFun;
  List<DateTime> _dates;

  @override
  void handleNumber(num value) {
    switch (_key) {
      case 'a':
        _a = value as int;
        storage = null;
        return;
    }
    super.handleNumber(value);
  }

  @override
  void handleString(String value) {
    switch (_key) {
      case 'b':
        _b = value;
        storage = null;
        return;
    }
    super.handleString(value);
  }

  @override
  void handleBool(bool value) {
    switch (_key) {
      case 'c':
        _c = value;
        storage = null;
        return;
    }
    super.handleBool(value);
  }

  @override
  void propertyName() {
    _log(storage);
    _key = storage as String;
    assert(_key != null);
    storage = null;
  }

  @override
  void propertyValue() {
    switch (_key) {
      case 'child':
        _child = storage as Fun;
        break;
      case 'innerFun':
        _innerFun = storage as List<Fun>;
        break;
      case 'dates':
        _dates = storage as List<DateTime>;
        break;
      default:
        if (storage != null) {
          _log('Missed!');
        }
    }
    _log('$_key - $storage');
    _key = null;
  }

  @override
  JsonListener objectStart() {
    _log(_key);
    switch (_key) {
      case 'child':
        return new _FunListener(this);
    }
    return super.objectStart();
  }

  @override
  JsonListener arrayStart() {
    switch (_key) {
      case 'dates':
        return new StringConvertArrayListener<DateTime>(DateTime.parse, this);
    }
    _log('$_key - might could return a custom thing here');
    return super.arrayStart();
  }

  @override
  JsonListener objectEnd() {
    _log(storage);
    return parent.childListenerFinish(result);
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
