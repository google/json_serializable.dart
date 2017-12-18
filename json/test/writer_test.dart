import 'dart:convert' as sdk;
import 'package:json/json.dart';
import 'package:test/test.dart';

class Fun {
  final int a;
  final String b;
  final bool c;
  final List<Fun> innerFun;

  const Fun({this.a, this.b, this.c, this.innerFun});

  Object toJson() {
    var values = <String, dynamic>{};
    if (a != null) {
      values['a'] = a;
    }
    if (b != null) {
      values['b'] = b;
    }
    if (c != null) {
      values['c'] = c;
    }
    if (innerFun != null) {
      values['innerFun'] = innerFun;
    }
    return values;
  }
}

bool _writer(Object object, JsonWriter writer) {
  if (object is Fun) {
    writer.startMap();
    if (object.a != null) {
      writer.writeKeyValue('a', object.a);
    }
    if (object.b != null) {
      writer.writeKeyValue('b', object.b);
    }
    if (object.c != null) {
      writer.writeKeyValue('c', object.c);
    }
    if (object.innerFun != null) {
      writer.writeKeyValue('innerFun', object.innerFun);
    }
    writer.endMap();
    return true;
  }
  return false;
}

final _complexJson = const [
  const {
    'list': const [
      const {'map': const {}}
    ],
    'map': const {
      'another map': const {
        'list': const [const {}]
      }
    }
  },
  const {
    'list': const [
      const [const {}]
    ],
    'map': const {
      'another map': const {
        'list': const [const {}]
      }
    }
  },
];

main() {
  var empty = const Fun(),
      oneField = const Fun(a: 41),
      simple = const Fun(a: 42, b: 'hello', c: true);

  final _items = {
    'empty': empty,
    'one field': oneField,
    'simple': simple,
    'nested': new Fun(a: 3, innerFun: [empty, oneField, simple]),
    'json values': _complexJson
  };

  for (var withBytes in [false, true]) {
    Converter wrap(Converter<Object, String> source) {
      if (withBytes) {
        return source.fuse(const Utf8Encoder());
      }
      return source;
    }

    group(withBytes ? 'JsonUtf8Encoder' : 'JsonEncoder', () {
      for (var pretty in [false, true]) {
        final indent = pretty ? ' ' : null;

        group(pretty ? 'pretty' : 'flat', () {
          final sdkToJson = wrap(new sdk.JsonEncoder.withIndent(indent));
          final encoderToJson = wrap(new JsonEncoder(indent: indent));
          final encoderWriter =
              wrap(new JsonEncoder(indent: indent, writer: _writer));

          _items.forEach((k, v) {
            test(k, () {
              final sdkValue = sdkToJson.convert(v);
              final expected = encoderToJson.convert(v);
              expect(expected, sdkValue);

              expect(encoderWriter.convert(v), expected);
            });
          });
        });
      }
    });
  }
}
