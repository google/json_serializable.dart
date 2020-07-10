// ignore_for_file: prefer_const_declarations

import 'package:test/test.dart';

import '../test_utils.dart';
import 'input.type_datetime.dart';

void main() {
  test('round trip', () {
    final object = SimpleClass.fromJson(_emptyInput);
    expect(loudEncode(object), loudEncode(_defaultOutput));
  });

  test('round trip alternate values', () {
    final object = SimpleClass.fromJson(_nonDefaultJson);
    expect(loudEncode(object), loudEncode(_nonDefaultJson));
    expect(loudEncode(object), isNot(loudEncode(_defaultOutput)));
  });
}

final _defaultValue = '2020-01-01T00:00:00.000';
final _altValue = '2018-01-01T00:00:00.000';

final _emptyInput = <String, dynamic>{
  'nullable': _defaultValue,
};

final _defaultOutput = {
  'value': null,
  'nullable': _defaultValue,
};

final _nonDefaultJson = {
  'value': null,
  'nullable': _altValue,
};
