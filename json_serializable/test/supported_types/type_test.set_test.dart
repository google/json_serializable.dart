// ignore_for_file: prefer_const_declarations

import 'package:test/test.dart';

import '../test_utils.dart';
import 'input.type_set.dart';

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

final _defaultValue = [42, true, false, null];
final _altValue = [43, false];

final _emptyInput = <String, dynamic>{
  'nullable': _defaultValue,
};

final _defaultOutput = {
  'value': null,
  'nullable': _defaultValue,
  'withDefault': _defaultValue,
};

final _nonDefaultJson = {
  'value': null,
  'nullable': _altValue,
  'withDefault': _altValue,
};
