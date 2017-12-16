import 'package:json/json.dart';

main() {
  final values = [
    null,
    true,
    false,
    0,
    1,
    3.14,
    'pi',
    {'a': 'b'},
    [1, null, true, false, 'pi']
  ];

  for (var value in values) {
    final encoded = json.encode(value);

    final roundTrip = json.decode(encoded);
    final encoded2 = json.encode(roundTrip);

    print(encoded);
    print(encoded2);
  }
}
