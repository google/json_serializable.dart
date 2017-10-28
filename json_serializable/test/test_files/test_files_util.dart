// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'kitchen_sink.dart';

//TODO(kevmoo) - finish this...
bool sinkEquals(KitchenSink a, Object other) =>
    other is KitchenSink &&
    a.dateTime == other.dateTime &&
    _deepEquals(a.iterable, other.iterable) &&
    _deepEquals(a.dynamicIterable, other.dynamicIterable) &&
    _deepEquals(a.dateTimeIterable, other.dateTimeIterable) &&
    _deepEquals(a.dateTimeList, other.dateTimeList) &&
    _deepEquals(a.stringDateTimeMap, other.stringDateTimeMap) &&
    _deepEquals(a.crazyComplex, other.crazyComplex);

bool _deepEquals(Object a, Object b) =>
    const DeepCollectionEquality().equals(a, b);
