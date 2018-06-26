// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

enum Category { top, bottom, strange, charmed, up, down }

Duration durationFromInt(int ms) => new Duration(milliseconds: ms);
int durationToInt(Duration duration) => duration.inMilliseconds;

DateTime dateTimeFromEpochUs(int us) =>
    new DateTime.fromMicrosecondsSinceEpoch(us);
int dateTimeToEpochUs(DateTime dateTime) => dateTime.microsecondsSinceEpoch;

bool deepEquals(a, b) => const DeepCollectionEquality().equals(a, b);

class Platform {
  final String description;

  static const Platform foo = const Platform._('foo');
  static const Platform undefined = const Platform._('undefined');
  const Platform._(this.description);

  factory Platform.fromJson(String value) {
    switch (value) {
      case 'foo':
        return foo;
      case 'undefined':
        return undefined;
      default:
        throw new ArgumentError.value(value, 'value', 'Not a supported value.');
    }
  }

  String toJson() => description;
}

abstract class ItemCore {
  final int price;

  ItemCore(this.price);
}
