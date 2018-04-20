import 'fun_class.dart';

final _empty = new Fun(),
    _oneField = new Fun(a: 41),
    _simple = new Fun(a: 42, b: 'hello', c: true);
final _withDates = new Fun(dates: [new DateTime(1979), null]);

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

final newTestItems = {
  'empty': _empty,
  'one field': _oneField,
  'simple': _simple,
  'with child': new Fun(child: _empty),
  'nested': new Fun(a: 3, innerFun: [_empty, _oneField, _simple]),
  'json values': _complexJson,
  'with dates': _withDates,
};
