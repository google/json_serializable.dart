import 'dart:convert';

import 'package:test/test.dart';

import 'field_matrix_test.field_matrix.dart';

void main() {
  test('test', () {
    final result = Map.fromEntries(fromJsonFactories.map((e) {
      final instance = e({'field': 42});
      return MapEntry(instance.toString(), {
        'with': instance,
        'without': e({}),
      });
    }));

    expect(jsonDecode(jsonEncode(result)), _expectedResult);
  });
}

const _expectedResult = {
  'ToJsonNullFromJsonNullPublic: field: 42': {
    'with': {'aField': null, 'field': 42, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonNullFromJsonTruePublic: field: 42': {
    'with': {'aField': null, 'field': 42, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonNullFromJsonFalsePublic: field: null': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  },
  'ToJsonTrueFromJsonNullPublic: field: 42': {
    'with': {'aField': null, 'field': 42, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonTrueFromJsonTruePublic: field: 42': {
    'with': {'aField': null, 'field': 42, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonTrueFromJsonFalsePublic: field: null': {
    'with': {'aField': null, 'field': null, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonFalseFromJsonNullPublic: field: 42': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  },
  'ToJsonFalseFromJsonTruePublic: field: 42': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  },
  'ToJsonFalseFromJsonFalsePublic: field: null': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  },
  'ToJsonNullFromJsonNullPrivate: _field: null': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  },
  'ToJsonNullFromJsonTruePrivate: _field: 42': {
    'with': {'aField': null, 'field': 42, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonNullFromJsonFalsePrivate: _field: null': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  },
  'ToJsonTrueFromJsonNullPrivate: _field: null': {
    'with': {'aField': null, 'field': null, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonTrueFromJsonTruePrivate: _field: 42': {
    'with': {'aField': null, 'field': 42, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonTrueFromJsonFalsePrivate: _field: null': {
    'with': {'aField': null, 'field': null, 'zField': null},
    'without': {'aField': null, 'field': null, 'zField': null}
  },
  'ToJsonFalseFromJsonNullPrivate: _field: null': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  },
  'ToJsonFalseFromJsonTruePrivate: _field: 42': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  },
  'ToJsonFalseFromJsonFalsePrivate: _field: null': {
    'with': {'aField': null, 'zField': null},
    'without': {'aField': null, 'zField': null}
  }
};
