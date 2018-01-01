class Fun {
  final int a;
  final String b;
  final bool c;
  final List<Fun> innerFun;
  final Set<DateTime> dates;

  const Fun({this.a, this.b, this.c, this.innerFun, this.dates});

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
    if (dates != null) {
      values['dates'] = dates.map((dt) => dt?.toIso8601String()).toList();
    }
    return values;
  }
}

final _empty = const Fun(),
    _oneField = const Fun(a: 41),
    _simple = const Fun(a: 42, b: 'hello', c: true),
    _withDates =
        new Fun(dates: new Set<DateTime>.from([new DateTime(1979), null]));

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
  'nested': new Fun(a: 3, innerFun: [_empty, _oneField, _simple]),
  'json values': _complexJson,
  'with dates': _withDates,
};
