class Fun {
  final int a;
  final String b;
  final bool c;
  final Fun child;
  final List<Fun> innerFun;
  final List<DateTime> dates;

  const Fun({this.a, this.b, this.c, this.innerFun, this.dates, this.child});

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
    if (child != null) {
      values['child'] = child.toJson();
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

const _empty = const Fun(),
    _oneField = const Fun(a: 41),
    _simple = const Fun(a: 42, b: 'hello', c: true);
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
  'with child': const Fun(child: _empty),
  'nested': const Fun(a: 3, innerFun: const [_empty, _oneField, _simple]),
  'json values': _complexJson,
  'with dates': _withDates,
};
