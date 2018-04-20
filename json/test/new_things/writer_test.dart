import 'dart:convert' as sdk;
import 'package:json/json.dart';
import 'package:test/test.dart';

import 'fun_class.dart';
import 'new_values.dart';

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
    if (object.child != null) {
      writer.writeKeyValue('child', object.child);
    }
    if (object.innerFun != null) {
      writer.writeKeyValue('innerFun', object.innerFun);
    }
    if (object.dates != null) {
      writer.writeKeyValue('dates', object.dates);
    }
    writer.endMap();
    return true;
  }

  if (object is Iterable) {
    writer.startList();
    for (var item in object) {
      writer.writeListValue(item);
    }
    writer.endList();
    return true;
  }

  if (object is DateTime) {
    writer.writeObject(object.toIso8601String());
    return true;
  }

  return false;
}

main() {
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

          newTestItems.forEach((k, v) {
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
